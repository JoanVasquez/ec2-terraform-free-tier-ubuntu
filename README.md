# UAPA Software Libre - Multi-User Ubuntu Server

Terraform configuration to deploy a hardened Ubuntu 24.04 LTS server on AWS with multi-user SSH access for educational purposes.

## Overview

This project creates:
- **EC2 Instance**: Ubuntu 24.04 LTS (t2.micro for free tier)
- **Multi-User Setup**: Admin user + 5 student users with SSH key authentication
- **Security**: Hardened SSH configuration, encrypted storage, restricted access
- **Networking**: Default VPC with Elastic IP for stable connectivity

## Quick Start

1. **Clone and Setup**
   ```bash
   git clone <repository-url>
   cd uapa_software_libre_tareas
   cp terraform.tfvars.example terraform.tfvars
   cp variables.tf.example variables.tf
   ```

2. **Configure Variables**
   Edit `terraform.tfvars`:
   ```hcl
   aws_profile       = "your-aws-profile"
   ssh_ingress_cidrs = ["YOUR.IP.ADDRESS/32"]
   
   admin_ssh_public_key = "ssh-ed25519 AAAA... admin@machine"
   
   user_pubkeys = {
     alice = "ssh-ed25519 AAAA... alice@laptop"
     bob   = "ssh-ed25519 AAAA... bob@pc"
     # ... add 5 users total
   }
   ```

3. **Deploy**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

4. **Connect**
   ```bash
   # Admin access (full sudo)
   ssh -i ~/.ssh/your_key ubuntu@<public_ip>
   
   # Student access (limited sudo)
   ssh -i ~/.ssh/student_key alice@<public_ip>
   ```

## User Permissions

- **ubuntu**: Full admin access (`sudo` without password)
- **Students**: Limited `sudo` access for system updates and network configuration only

## Security Features

- SSH key authentication only (no passwords)
- Root login disabled
- Encrypted EBS storage
- Restricted security group (SSH from specified IPs only)
- Hardened SSH configuration

## Cost Optimization

- Uses t2.micro (AWS free tier eligible)
- GP3 storage for better price/performance
- Single AZ deployment

## Cleanup

```bash
terraform destroy
```

## Requirements

- Terraform >= 1.6.0
- AWS CLI configured
- SSH key pairs for admin and users