provider "aws" {
  region     = "us-east-1"
  access_key = "mi_access_key"
  secret_key = "mi-secret_key"
}
resource "aws_instance" "terraform-platzi-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags           = var.tags
}