resource "aws_instance" "nginx-server" {
  ami           = var.ami           // AMI: Amazon Machine Image which is a template that provides the information required to launch an instance
  instance_type = var.instance_type // The instance type

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

  tags = {
    Name        = var.server_name
    Environment = "Dev"
    Owner       = "tres@duck.com"
    Team        = "DevOps"
    Project     = "Terraform"
  }
}