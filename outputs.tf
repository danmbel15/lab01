output "instance_hostname" {
  value       = aws_instance.app_server.public_dns
  description = "The public DNS of the EC2 instance"
}

output "instance_ip" {
  value       = aws_instance.app_server.public_ip
  description = "The public IP of the EC2 instance"
}