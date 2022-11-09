### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 16, **creacion de modulos locales en e terraform**
Podemos crear modulos retulizables con terraform, para mandar a llamar el modulo que quiero utlizar, utilizo un boque module, donde le asignamos el nombre que le queremos dar al modulo que estamoa importanto, y en el atributo source debemos colocar el path absoluto o relativo en donde se encuntra el moudulo que queremos importar, solo hasta la carpeta en la que se cuentra, no el archivo, ejemplo
```tf
module "instance" {
  source = "./modules/instance" 
}
```
* ahora si nuestro mudulo que estamos importanto tiene un archivo de definicion para las variables, demos pasarle los valores a dichas varibles, esto lo hacemos dentro del mismo bloque mudule que estamos definiendo, colocando el mimos nombre de las varibles que utliza el mudlo y asignandoles un valor, bien sea un valor quemado, o con otro archivo de definicion para las variables a nivel del modulo padre que esta haciendo la invocacion, para ser pasados los valores por enviroments o por comando o con un archivo .tf dependiento del ambiente. basicamente los archivos que contiene los valores de las varibles estaran en donde nostros estemos invocando los modulos, es decir en el modulo padre...
```tf
module "instance" {
  source        = "./modules/instance"
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}
```
* Al momento de querer imprimir mensajes por consola podemos,  con los output, se maneja una estructura de similar a la de definicion de varibales para los modulos, donde basicamente contamos con
**un archivo para los uotputs a manejar en el modulo hijo, con su bloque output imprmiendo lo que se desea ver de la creacion de los recursos que este realizando ese modulo**
```tf
output "arn" {
  value = aws_kms_key.myKey.arn

}
```
**y tendremos que tener otro archivo para la salida, en el modulo que esta realizando la importacion,con su bloque output de igual maneara, y entre su atributo value que mostrara el valor a imprimir por consola, simplemente, nos apoyamos de la plabra reservada "module", para mandar a llamar al bloque output que etsablecimos en el module hijo con el nombre que se le asigno, y de esta manera estaremos imprmiendo el output de modulo importado**
```tf
output "instance_ip" {
  value       = module.instance.instance_ip
  description = "esta es la salida por conola para ver la ip de la instancia ec2 creada con terraform"
}
output "arn" {
  value       = module.bucket.arn
  description = "esta es la salida por consola para ver la arn al momento de la creacion del kms con terraform"
}
```

* **importante:** cuando creamos un modulo tenemos que tener en cuenta que debemos tener en su mayoria de casos dos archivos de defincion, el archivo de definicion de infraestructura como tal y el arhivo de definicion de las varibles que va a recibir, independientemente del nombre que le demos teerraform sabra como interpretarlos, y en cuanto a los archivos **de los valores de las varibles deben estar en donde estemos invocando a los modulos**


* asi quedaria la estructura del projecto en este caso, con la definicion de la infraestructura separa por modulos.
![image](https://user-images.githubusercontent.com/62717509/200879426-9184730a-df4b-4c98-b13e-ee3eb6539652.png)