### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 9, ***Terraform, creacion d eun archivo de deficnion para crear una instancia ec2 aws***
* devemos de crear nuestro archivo denominado main.tf no es necesario que se llame main, solo por comvencion, simplemente vasta con tener la extension .tf par que terraform lo pueda interpretar.
* Terraform maneja su propio lenguaje que es desarrollado por Hashicorp, que se llama **HCL => Hashicorp Configuration Language** para la definicion de estos archivos
```tf
/*lo primero que tendremos que hacer es declara el provider al que nos vamos a conectar, es decir nuetro provedor de nube que en este caso sera aws, detro de este se coloca atributos como la region a la que nos estamos conectando, en este caso virginia, y las credenciales, en caso de no estar como vaaraibles de entorno*/
provider "aws" {
  region = "us-east-1"
  access_key = "mi-access-key"
  secret_key = "mi-secret-key"
}

/*una vez definido el provider al que nos conectaremos, la region y credenciales, procederemos a indicar el tipo de recurso que crearemos, recordando que cada provider tiene su dieferen froma de nombrer sus recurcos y demas...
en este caso decimos que crearemos una instancia de aws y seguido va el identificador de dicha instanica o nombre, abrimos llaves, e indicamos los parametros que usaremos la creacion de dicha instancia*/

resource "aws_instance" "platzi-instance-desde-terraform" {

    /*inicamos que crearemos la isntancia desde una ami que tengamos, para ello al paramtro ami, le definimos el id de nustra ami desde la cual crearemos la instanica*/
  ami = "ami-0ca0c67309196175e"

  /*mecionamos el tipo de instanica que estaremos creando, en este caso una t2-micro*/
  instance_type = "t2.micro"

  /*y podemos proceder asignarles tags, para la instanica, como pueden ser variables este parametro sera un objeto, donde dentro de el, definimos las diferentes tag, bajo clave valor*/
  tags = {
    Name = "practica1-terraform"
    Enviroment = "Dev"
  }
}
```
* Una vez que tengamos creado el archivo de defincion, o en especial que allamos especificado el provider al cual nos conectaremos, tenemos que correr el comando ```terraform init``` el cual nos permitirá inicializar nuestro entorno, es decir que dependiento del provider colocago, descargara los plugin necesarios
* Podemos proceder a escribir el comando ```terraform validate``` para validar que nuestra sintaxis en nuestro archivo de defincion esta correctamente bien para la creacion de la ifracestrutura como codigo que estamos creando **lac**
* ```terrafomr plan``` este comando lo que nos permitira es hechar un vistaso a la infraestructura que estamos creando
* tambien podremos palicar un formateo a nuestro codigo en el archivo de definicion que estanos creando con terrafom, utlizando el comando ```terraform ftm```
* ```terraform apply``` y finalmente para nosotros proceder a crear la infraestrutura que emos definido en nuestro archivo de deficnicion de terrraform aplicamos este comando y con esto habremos creado nuestra instancia ec2 en este caso por medio del archivo de definicion de terraform
![image](https://user-images.githubusercontent.com/62717509/200144558-f17f3683-16dd-4859-a2f8-4ec3ddfb40e4.png)