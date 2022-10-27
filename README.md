### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 4, **¿que es terraform?**
es una herramienta open source, creada por Hashicorp, desrarrollada en Go, con el fin de crear y administrar infracestructura cono codigo.
Es un binario que se descarga para cada SO, y se consume, en ese binario se conecta a la ip de los provedores de nuebe, aws, Azure, y tambien para nuebes privada como open stack, una vez de conecta al provedor de nube, este sabe que recursos tiene disponible para crear en ese provedor.
````
    provider "aws" {
        region = "us-west-2"
    }
    resource "ws_instance" "web" {
        ami
    }
    "${data.aws_ami.ubuntu.id}"
        instance_type = "t2.micro"

        tags = {
            Name = "HelloWorld"
        }
````

a grozo modo, para ir conociento, nosotros podemos definir un **provider** para identificar cual es el provedor de nube que utilizaremos, teniedo varios cloud provider que soporta terraform.
Tenemos **resource** que hace referencia a un recurso de una instancia en aws, podiendo ver todos los elementos que nosotros podemos enviar a una instancia, esto dependera del api o recurso que nos estemos conectando