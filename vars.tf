variable "ami_id" {
  default     = ""
  description = "esta varaible es el ide del ami"
  type        = string
}

variable "instance_type" {
  type        = string
  description = "este es el tipo de instancia a crear"
}

variable "tags" {
  type        = map(string)
  description = "esta son las etiquestas definidas para la instancia"
}

variable "sg_name" {
  type        = string
  description = "varible que especifica el nombre del grupo de segiridad creado para la conexcion a la instancia "
}

variable "ingress_rules" {
  type        = list(any)
  description = "grupo de relgas de ingreso para la instancia"
}

variable "bucket_name" {
  type        = string
  description = "este es el nombre del bucket s3"
  default     = "backend-terraform-platzi-terraform-curse-juan-pablo-mo"
}

variable "acl" {
  type        = string
  description = "representacion del permiso que tendra el bucket, sera privado"
  default     = "private"
}
