output "ubuntu_public_ip" {
  description = "Public IP address of the Ubuntu server"
  value       = aws_instance.ubuntu_server.public_ip
}

output "ubuntu_private_ip" {
  description = "Internal Private IP of the Ubuntu server"
  value       = aws_instance.ubuntu_server.private_ip
}

output "centos_public_ip" {
  description = "Public IP address of the CentOS server"
  value       = aws_instance.centos_server.public_ip
}
