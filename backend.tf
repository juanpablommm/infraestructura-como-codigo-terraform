terraform {
  backend "s3" {
    bucket     = "backend-terraform-platzi-terraform-curse-juan-pablo-mo"
    key        = "dev"
    region     = "us-east-1"
    access_key = "mi-access-key"
    secret_key = "mi-secret-key"
    encrypt    = true
    kms_key_id = "arn:aws:kms:us-east-1:975428265677:key/f0cce839-18bd-4b8d-bb4b-ed49529f39ac"
  }
}