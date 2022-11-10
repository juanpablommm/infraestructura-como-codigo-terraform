### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 17, **uso de modulos remotos**,terraform nos provee de un mecanismos para no solo trabajar los modulosde de manera local, sino que por el contrario realizarlo de manera remota, a traves de los sitemas de control de versiones remotos, en este caso por ejemplo con el uso de GitHub, la gran diferencia radica en el atributo source del bloque module, donde estamos realizando la importancion de los modulos que necesitemos, en este caso solo se cambia la ruta de la maquina local que se tenia, por ela url del repositorio en gitHub donde se encuentra el modulo, mas la tura de la carpeta donde se encuentran los archivos de definicion de infraestructura mas el archivo de definicion de las varibles, quedando el bloque module de la siguiente manera
```tf
module "instance" {
  source        = "github.com/juanpablommm/modulo-instance-ec2-aws-curos-teeraform-paltzi/instance"
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}
```
* Despues de esto aplicaremos el comando ```terraform init``` lo que aparte de traer todo lo necesario para el cloud provider que estemos utilizando, nos traera el modulo que estamos importando de gitHub descargandolo en la carpeta .terraform en una subcarpeta denominada modules
