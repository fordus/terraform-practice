// CREATE PLAN FILE WITH terraform plan -out=plan
// APPLY PLAN FILE WITH terraform apply plan

### TFSTATE 
terraform {
  backend "s3" {
    bucket = "terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

### MODULES. WE NEED TO USE terraform init TO DOWNLOAD THE MODULES EACH TIME WE CREATE A NEW MODULE
module "nginx_server_dev" {
  source        = "./nginx_server_module"
  region        = "us-east-1"
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  public_key    = "~/.ssh/id_rsa.pub"
  vpc_id        = "vpc-0c1b3b7b1b3b7b1b3"
  server_name   = "nginx-server"
}

module "nginx_server_prod" {
  source        = "./nginx_server_module"
  region        = "us-east-1"
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  public_key    = "~/.ssh/id_rsa.pub"
  vpc_id        = "vpc-0c1b3b7b1b3b7b1b3"
  server_name   = "nginx-server"

}

### OUTPUTS MUST BE DEFINED IN THE MAIN.TF FILE TO BE ABLE TO ACCESS THEM
output "nginx_dev_public_ip" {
  value       = module.nginx_server_dev.public_ip
  description = "The public IP of the nginx server in the Dev environment"
}

output "nginx_dev_dns" {
  value       = module.nginx_server_dev.public_dns
  description = "The public DNS of the nginx server in the Dev environment"
}

output "nginx_prod_public_ip" {
  value       = module.nginx_server_prod.public_ip
  description = "The public IP of the nginx server in the Prod environment"
}

output "nginx_prod_dns" {
  value       = module.nginx_server_prod.public_dns
  description = "The public DNS of the nginx server in the Prod environment"
}