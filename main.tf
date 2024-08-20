### TERRAFORM BASIC COMMANDS
# terraform init // Initialize the working directory containing Terraform configuration files
# terraform plan // Create an execution plan
# terraform apply // Apply the changes required to reach the desired state of the configuration
# terraform destroy // Destroy the Terraform-managed infrastructure


provider "aws" {
  region = "us-east-1" // Change this to your desired region
}

resource "aws_instance" "nginx-server" {
  ami           = "ami-0c55b159cbfafe1f0" // AMI: Amazon Machine Image which is a template that provides the information required to launch an instance
  instance_type = "t2.micro"

  // user_data is used to run commands on the instance at launch time
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Welcome to Terraform</h1>" > /var/www/html/index.html
              EOF

  // link the key pair to the instance
  key_name = aws_key_pair.nginx-key.key_name

  // link the security group to the instance
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
}

// ssh key pair
resource "aws_key_pair" "nginx-key" {
  key_name   = "nginx-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


// security group
resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = "vpc-0c1b3b7b1b3b7b1b3"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}