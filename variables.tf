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
  type        = map(any)
  description = "esta son las etiquestas definidas para la instancia"
}