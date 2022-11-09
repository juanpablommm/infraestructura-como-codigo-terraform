module "instance" {
  source        = "./modules/instance"
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}
module "bucket" {
  source      = "./modules/bucket"
  bucket_name = var.bucket_name
  acl         = var.acl
  tags        = var.tags
}