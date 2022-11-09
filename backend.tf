terraform {
  backend "s3" {
    bucket     = "backend-terraform-platzi-terraform-curse-juan-pablo-mo"
    key        = "dev"
    region     = "us-east-1"
    access_key = ""
    secret_key = ""
    encrypt    = true
    kms_key_id = "arn:aws:kms:us-east-1:975428265677:key/0a1e7b0a-1552-4acc-b2e3-a1761d30818c"
  }
}