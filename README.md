### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 14, **Creacion bucket s3 y configuracion de este como backend terrafomr**
* creamos nuestro archivo de deficnion de infraestrutura en terraform, con su repetivo provider de aws, y como recurso especificamos que vamos a crear un bucket s3, con **aws_s3_bucket** le definimos un nombre, y procedeos a darle los argumentos minimos para la creacion de l bucket.
```tf
provider "aws" {
  region = "us-east-1"
  access_key = "mi_key"
  secret_key = "mi_secret"
}

resource "aws_s3_bucket" "platzi_backend" {
  # el atributo bucket, especifica el nombre que tendra nuestro s3 en aws
  bucket = var.bucket_name
  # el acle, es basicamente el tipo de permiso que va a tener el s3, en este caso sera privado
  acl = var.acl
  # le asignamos algunos tags
  tags = var.tags
}
```
* para la creacion de las varibles utilizadas es; se le asgina un valor por default para evitar la asingacion del valor por otro archivo o demas...:
```tf
variable "bucket_name" {
    type = string
    description = "este es el nombre del bucket s3"
    default = "backend-terraform-platzi-terraform-curse-juan-pablo-m"
}

variable "acl" {
  type = string
  description = "representacion del permiso que tendra el bucket, sera privado"
  default = "private"
}

variable "tags" {
    type = map
    description = "asignacion de las tags"
    default = {Environment = "Dev", CreateBy = "terraform"}
}
```
* validamos y creamos infraestructura con ```terraform validate``` ```terraform apply```
* una vez tengamos creado nuestro recurso, el bucket s3 en este caso, procedemos a configurarlo como backend, podemos realizarlo en el archivo man, en el que hallamos creado la infraestructura antes, o podemos realizarlo en un nuevo arhivo de terrafomr como es el caso:
* tenemos que tener el bucket previamente creado dado en el bloque de banckend tendremos que referenciar es mimo bucket s3
```tf
terraform {
  backend "s3" {
    # mencionamos cual es el bucket, colcando el nombre del que creamos
    bucket = "backend-terraform-platzi-terraform-curse-juan-pablo-m"
    # con le key, especificamos el path, con el nombre donde queremos que guarde el archivo en el bucket
    key = "dev"
    # especificamos la region, tiene que estar en al misma region el bucket
    region = "us-east-1"
    # credenciales
    access_key = "mi-access"
    secret_key = "mi-secret"
  }
}
```
* una vez configuremos el backend en nuestro archivo de defincion, procederemos a ejecutar el comando ```terraform init``` nuevamente, para que se configure automaticamente se configure el backend, y si ya hemos creado infraestructura anteriomente, en este caso la de la creacion al bucket, se nos preguntara si queremos copiar el estado exitente para no perder el estado la infraestructura creada.
```shell
Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes
```
**y finalmente con esto ya habremos creado nuestro backend, es decir con esto ya no hemos asegurado de que terraform maneje el estado de una forma remota, guardando el archivo en el bucket de s3, ahora podemos configurarlo mas adelante, para que no guarde el arhcivo como texto palano**