# ------- module/outputs.tf
output "public_ip" {
  value = aws_instance.app_server.public_ip
  }

output "ec2_name" {
  value = aws_instance.app_server.public_ip
  }