provider "aws" {
  region     = "us-east-1"
  access_key = "mi-access-key"
  secret_key = "mi-secret-key"
}

resource "aws_kms_key" "myKey" {
  description             = "key state file "
  deletion_window_in_days = 10


}

resource "aws_s3_bucket" "platzi_backend" {
  bucket = var.bucket_name
  acl    = var.acl
  tags   = var.tags
  versioning {
    neabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.myKey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}