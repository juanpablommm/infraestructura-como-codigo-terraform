terraform {
  backend "s3" {
    bucket = "backend-terraform-platzi-terraform-curse-juan-pablo-m"
    key = "dev"
    region = "us-east-1"
    access_key = "AKIA6GHAOE3G2SY335KS"
    secret_key = "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"
  }
}