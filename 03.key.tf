// ssh key pair
resource "aws_key_pair" "nginx-key" {
  key_name   = "${var.server_name}-key"
  public_key = var.public_key

  tags = {
    Name        = "${var.server_name}-key"
    Environment = "Dev"
    Owner       = "tres@duck.com"
    Team        = "DevOps"
    Project     = "Terraform"
  }
}