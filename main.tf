### TERRAFORM BASIC COMMANDS
# terraform init // Initialize the working directory containing Terraform configuration files
# terraform plan // Create an execution plan
# terraform apply // Apply the changes required to reach the desired state of the configuration
# terraform destroy // Destroy the Terraform-managed infrastructure


provider "aws" {
  region = "us-east-1" // Change this to your desired region
}

resource "aws_instance" "nginx-server" {
  ami = "ami-0c55b159cbfafe1f0" // AMI: Amazon Machine Image which is a template that provides the information required to launch an instance
  instance_type = "t2.micro"
}