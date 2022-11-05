provider "aws" {
  region     = "us-east-1"
  access_key = "mi-access-key"
  secret_key = "mi-secret-key"
}
resource "aws_instance" "terraform-platzi-instance" {
  ami           = "ami-0ca0c67309196175e"
  instance_type = "t2.micro"
  tags = {
    Name       = "practica1-terraform-ultima-version"
    Enviroment = "Dev"
  }
}