output "instance_ip" {
  value       = module.instance.instance_ip
  description = "esta es la salida por conola para ver la ip de la instancia ec2 creada con terraform"
}
output "arn" {
  value       = module.bucket.arn
  description = "esta es la salida por consola para ver la arn al momento de la creacion del kms con terraform"
}

