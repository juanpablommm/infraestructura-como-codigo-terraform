### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 11, **interpolacon, condiciones y ciclos***
* siguiendo el metodo de darle valores a nuestra varibles definidas mediante el uso de un archivo .tfvars podemos tener varios archivos con diferentes valores para dichas varibles, como por ejemplo tener un archivo .tfvars con x valores para el ambiente de produccion y tener otros archivos .tfvars para los otros diferentes ambientes, como uno mas para stage y otro para desarrollo.
donde simplemente nosotros al momento de ejecutar el **terrafomr apply** o demas, le pasamos por la bandera **--var-file** y la ruta, el archivo .tfvars del ambiente correspondiente que queramos manejar
* **importante:** tambien podemos tener un archivo en el cual se tomen los valores para nuestras varibles de manerar automatica, esto lo podemos ahcer agregando la extension .auto.tfvars y ejecutariamos el comando ```terrafomr apply``` o demas sin tener la necesidad de espcifcar el arhivo a utilizar, sino que simplemente tomara automaticamente el valor para nuestras varibles que se encuentre en el archivo que contenga la estencion .auto.tfvars
**De esta manera nosostros podemos tener los valores para las varibles que no van a cambiar en el archivo .auto.tfvars y los valores para las varibles que si cambiaran en otro archivo dependiendo del ambiente o demas**

**por defecto en aws todos los puertos estan cerrados hacia las maquinas que estamos creando, entonces si nosotros queremos dentra via ssh, tenemos que agregar un aws_security_group, que nos permita con el puerto que iniquemos poder acceder**
```tf
/*creamos nuestro recurso securty group, y le damos un nombr, el cual pertenece al recurso, a la funcion por decirlo asi...*/

resource "aws_security_group" "ssh_conection" {
  #y este es el nombre del objeto que estamos creando
  name = var.sg_name

  # en el ingress vamos a colocar las reglas que nosotros queremos configurar
  /* ahora con la nueva version de terraform podemos en un mismo security grpu tener varias
  reglas de ingress pero tenemos que colocar otro bloque para la otroa regla, lo cual no es muy escalable, pero ahora podemos hacer algo que se llama dynamic. donde simplemnte utilizamos la plabra reservada dynamic y especificamos el recurso o el segmento que queremos crear, en este caso el ingress, y dentro de esa seccin de codigo podemos iterar sobre un objeto, por lo cual nosotros podemos enviar ya como parametro una lista y terraform lo va a interpretar y va armar el bloque completo.
  para interar sobre los elementos utilizamos un for_each y le asignamos la varible sobre la cual va a iterar, despues debemos colocar el content que seria el contenido que debe tener la varibale sobre la que va a iterar, en este caso, decimos que va a tener el puerto por el que ingresa, el puerto al que va, el protocolo y el cidr desde donde se esta conectando, cada uno de esto lo devemos igualar, sobre el elemento que se esta iterando, en este caso ingress concatenamos con la palabra reservada value y concatenamos con el valor de la key en el mapa que vamos a manejar desde un archivo de defincion para las varibles, esto para todos los contenido del content, de est manera podemos enviar n reglas de ingreseo, sin tener que colocar un bloque como el siguiente para cada una de las reglas de ingreso que queramos definir;
  ingress = {
    from_port = 443
    to_port = 443
    protocol = "-1"
    cidr_blocks = # cfrfrmo
  }
  */

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }dynamic "ingress" {
    for_each
  }
  
}
```
**nota:** podemos configurar las reglas de ingresos **ingress** o las reglas de salida **egress**
Para la creacion de las varibles del security_group en el archivo de definicion, de estas quedarina de la siguiente manera:
```tf
variable "sg_name" {
  type        = string
  description = "varible que especifica el nombre del grupo de segiridad creado para la conexcion a la instancia "
}

variable "ingress_rules" {
  type        = list(any)
  description = "grupo de relgas de ingreso para la instancia"
}
```
y al momento de asignarles un valor en el arhivo de definicion dado el ambiente que queramos, quedarian de la siguiente manera:
```tf
sg_name = "grupo_seguridad_platzy"
/* nuesta variable ingress_rules, ira entre corchetes dado que sera una lista, donde
definiremos los distintos bloques de ingress para establecer la conexion*/
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
    /*el cidr_blocks es un rango de direcciones ip, de alguna sub-red en especifico, por lo debera ir entre corchetes, lo recomendable es que tener una red--privada para la conexion,
    ahora con "0.0.0.0/0 le decimos que cualquier ip puede dentrar con esta regla"*/
    cidr_blocks = ["0.0.0.0/0"]
  }
]
```
* Una vez tengamos definido nuestro security_group, procedemos asignarloceloa nuestra instancia que hemos definido, con la propiedad security_groups, que siendo una lista, tambien acepta mas de una regla, como nostros ya la creamos, procedemos a llamar, por el tipo de recuerso concatenado con el nombre del recurso que le dimos, y concatenamos directamente al atributo name de nuestro security grup que creamos
```tf
resource "aws_instance" "terraform-platzi-instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  tags            = var.tags
  security_groups = [aws_security_group.ssh_conection.name]
}
```

**archivo output.tf** podemos crear un archivo denominado output.tf que nos servira para poder definir las salidas por conola al momento de que se cree **laC**,
haciendo uso de la palabra reservada output, le damos un nombre de la varible que vamos a utlizar, este objeto tendra un atributo denominado valor, en el cual definimos que queremos que muestre, en este caso **colocamos el tipo de recurso, lo llamamos por el nombre que le dimos y el valor que queremos que muestre, en este caso queremos que muestre la ip, "public_ip" y como pueden ser mas de una ip, utlizamos el * para ser visulizadas**
```tf
output "instance_ip" {
  value = aws_instance.terraform-platzi-instance.*.public_ip
}
```
**nota:** una vez que apliquemos el comando ```terraform apply``` se noes mostrara por consola el output que confiuramos, es decir se noes mostrara la o las ip de las instancias creadas, y podemos aplicar la conexcion por ssh, teniendola llave, por ejemplo
````shell
ssh -i /.ruta-llave usuario-so-instancia@ip-de-instancia
```` 