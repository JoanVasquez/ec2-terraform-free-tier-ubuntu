terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# --- Ubuntu 24.04 LTS (amd64) via flexible AMI FILTER ---
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name = "name"
    values = [
      "*ubuntu-noble-24.04-amd64-server-*",
      "ubuntu/images/*ubuntu-noble-24.04-amd64-server-*",
      "*ubuntu-24.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# --- Networking: ensure a default VPC exists (creates one if missing) ---
resource "aws_default_vpc" "default" {
  tags = { Name = "${var.name}-default-vpc" }
  lifecycle { prevent_destroy = true }
}

# Pick one default subnet in that default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

locals {
  subnet_id = data.aws_subnets.default.ids[0]
}

# --- SSH key for admin (ubuntu user) ---
resource "aws_key_pair" "admin" {
  key_name   = "${var.name}-admin-key"
  public_key = var.admin_ssh_public_key
}

# --- Security group: SSH only from allowed CIDRs ---
resource "aws_security_group" "ssh" {
  name        = "${var.name}-ssh"
  description = "SSH restricted"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress_cidrs
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-ssh" }
}

# --- EC2 instance ---
resource "aws_instance" "vm" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = local.subnet_id
  key_name                    = aws_key_pair.admin.key_name
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  associate_public_ip_address = true
  private_ip                  = var.private_ip

  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    admin_pubkey      = var.admin_ssh_public_key
    user_pubkeys_json = jsonencode(var.user_pubkeys)
  })

  # Use AMI's default root volume size (avoids snapshot-size mismatch)
  root_block_device {
    volume_type = "gp3"
    encrypted   = true
  }

  tags = { Name = var.name }
}

# --- Elastic IP for stable public address ---
resource "aws_eip" "eip" {
  domain   = "vpc"
  instance = aws_instance.vm.id
  tags     = { Name = "${var.name}-eip" }
}

