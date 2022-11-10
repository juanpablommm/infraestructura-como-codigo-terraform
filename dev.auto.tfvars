ami_id        = "ami-0ca0c67309196175e"
instance_type = "t2.micro"
tags = {
  Name       = "practica1-terraform-ultima-version"
  Enviroment = "Dev"
  CreateBy   = "terraform"
}
sg_name = "grupo_seguridad_platzy-segundo"
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

bucket_name = "backend-terraform-platzi-terraform-curse-juan-pablo-mo"
acl         = "private"
