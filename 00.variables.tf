### VARIABLES
# Variables are used to parameterize the Terraform configuration

variable "region" {
  description = "The AWS region"
  default     = "us-east-1"
}

variable "ami" {
  description = "The AMI ID"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "The instance type"
  default     = "t2.micro"
}

variable "public_key" {
  description = "The public key"
  default     = file("~/.ssh/id_rsa.pub")
}

variable "vpc_id" {
  description = "The VPC ID"
  default     = "vpc-0c1b3b7b1b3b7b1b3"
}

variable "server_name" {
  description = "The server name"
  default     = "nginx-server"
}
