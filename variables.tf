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

variable "tags" {
  type        = map(any)
  description = "asignacion de las tags"
  default     = { Environment = "Dev", CreateBy = "terraform" }
}