provider "aws" {
  region = "us-east-1"
  access_key = "AKIA6GHAOE3G2SY335KS"
  secret_key = "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"
}
resource "aws_s3_bucket" "platzi_backend" {
  bucket = var.bucket_name
  acl = var.acl
  tags = var.tags
}