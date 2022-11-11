provider "aws" {
  access_key = "mi_access_key"
  secret_key = "mi_secret_key"
  region     = "us-east-1"
}
module "instance" {
  source        = "github.com/juanpablommm/modulo-instance-ec2-aws-curos-teeraform-paltzi?ref=clase-18-curso-laC-terraform/instance"
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
  key_path      = var.key_path
}