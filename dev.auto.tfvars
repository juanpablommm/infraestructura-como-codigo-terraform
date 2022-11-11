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

egress_rules = [
  {
    /* no sabmemos desde que puerto hacia que puerto especificamente nos queremos conectar en interet, 
    por lo que para indicar que sea todo, entonces coloco el valor de 0 */
    from_port = 0
    to_port   = 0
    /*al colocar -1 como valor, de protocolo indicamos que nos vamos a conectar con cualquier ptorotcolo*/
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
key_path = "./scripts/terraform-platzi.pem"