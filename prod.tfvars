ami_id        = "ami-0ca0c67309196175e"
instance_type = "t2.large"
tags = {
  Name       = "terraform-ultima-version"
  Enviroment = "Prod"
}
sg_name = "platzy"
ingress_rules = [
  {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

]