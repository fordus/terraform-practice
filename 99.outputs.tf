### OUTPUTS ARE USED TO EXPOSE THE RESOURCES CREATED BY TERRAFORM
### COMMAND: terraform output [output_name]
output "public_ip" {
  description = "The public IP of the nginx server"
  value       = aws_instance.nginx-server.public_ip
}

output "public_dns" {
  description = "The public DNS of the nginx server"
  value       = aws_instance.nginx-server.public_dns
}