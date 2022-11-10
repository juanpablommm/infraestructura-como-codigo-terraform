provider "aws" {
  access_key = "mi-access_key"
  secret_key = "mi-secret_key"
  region     = "us-east-1"
}
module "instance" {
  source        = "github.com/juanpablommm/modulo-instance-ec2-aws-curos-teeraform-paltzi/instance"
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}