output "instance_id" { value = aws_instance.vm.id }
output "public_ip" { value = aws_eip.eip.public_ip }
output "ssh_admin" { value = "ssh -i ~/.ssh/uapa_admin_ed25519 ubuntu@${aws_eip.eip.public_ip}" }

