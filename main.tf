provider "aws" {
  region     = "us-east-1"
  access_key = "mi-access-key"
  secret_key = "mi-secret-key"
}
resource "aws_s3_bucket" "platzi_backend" {
  bucket = var.bucket_name
  acl    = var.acl
  tags   = var.tags
}