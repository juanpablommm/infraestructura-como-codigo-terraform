terraform {
  backend "s3" {
    bucket     = "backend-terraform-platzi-terraform-curse-juan-pablo-m"
    key        = "dev"
    region     = "us-east-1"
    access_key = "mi-access-key"
    secret_key = "mi-secret-key"
  }
}