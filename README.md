### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 18, **"provisioners mas creacion de reglas de salida par que la maquina remota pueda salir a internet", aprovisioaremos la infraestructura creada, para correr imagen de docker creada en la cual se encuntra la aplicacion del indez.html que se encuentra en el docker.hub**
* **los provisioners** nos permite cconfugurar servidores despues de construirlos, lo que haremos enc ontinuacion con lo que se ha trbajado, es aprovisionar la instancia de aws creada con el archuiuvo de defincion que se ha estado trabajando, para que desde la instancia ec2 se pueda conectar docker.hub para descargar la imagen creada en nuestra cuenta, la cual se contruyo con una imagen de enginx y un archivo indeex.html que representaba un aplicacion, para lo cual se trenda que configurar las reglase de salida **egress rules** en el security goup creado junto con las intancia, con el fin de que la maquina pueda tener salida a internet, dadao que por defecto la instancia ec2 cuando se crea viene con todos los puerto cerrados, motivo por el cual tuvimos que crear una security goup anteriomente y configurar la reglas de ingreso **ingress rules** para conectanor via ssh a la maquina.
* Simplemte en nuestro security group tendrmoes que apoyarnos nuevamente del **dynamic** que nos birnda terraform para realizar iteracion sobre una lista, dado que puden haber ma de una regla de salida **egress rules** y es sobre esta que se tiene que iterar, y procedemos con la creacion de esta, condigurando los puertos, protocol,  
* **importante: este codigo se realizara en el repositorio privado que se llevoa cabo para la clase de modulos remotos, el cual tiene el archivo de definicon para la creacion de la instancia y el security group mas el archuivo de defincion de las varibles**
```tf
module "instance" {
  /*para relizar la indicacion de que rama descargar el modulo o de que tags, se utliza el maram-name ref diicando version de la tags, de ser el caso o nombre de la rama, tambien se puede relizar a un commit en eespecial, con el hash*/
  source        = "github.com/juanpablommm/modulo-instance-ec2-aws-curos-teeraform-paltzi?ref=clase-18-curso-laC-terraform/instance"
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
  ami_id        = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}
```
ahora al momento de definir la varible de las reglas de ingreso, como al conectarnos a internet es muy
dificil saber en que puerto corren las paginas o aplicaciones a las que queremos conectarnos, por endee devemos definir los puertos desde y ahcia donde se quiere establecer la conecion en 0, y no especificar un protocolo de conexion fijo, sino de igual menara colocarlos todos, esto lo hacemos definiendo el protoclo con -1, y logcamente para especificar la conexion hacia cualuier ip, dejamos el cidr_blocks con 0.0.0.0/0
```tf
egress_rules = [
  {
    /* no sabmemos desde que puerto hacia que puerto especificamente nos queremos conectar en interet, 
    por lo que para indicar que sea todo, entonces coloco el valor de 0 */
    from_port = 0
    to_port   = 0
    /*al colocar -1 como valor, de protocolo indicamos que nos vamos a conectar con cualquier ptorotcolo*/
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
```
* ahora una vez definido las reglas de salida, y configuradas, procederesmos  a configirar una aprovisionador en el bloque resource donde se esta definiendo la instanica, **un provisioners no es mas que el poder nosotros establecer una conexion hacia la maquina creada con el fin de , poder ejecutar comandos dentro de esta, pero el uso de provisioners no es muy recomendado por parte de la documentacion de terraform, se deben de tomar ya como ultima opcion para nuestro problema,puesto que ahy otras opciones para aprovisionar infraestructura al momento en que se crean los recurso, donde cada cloud provider tiene su manera de hacerlo**
* local-exec => este aprovisionador ejecuta coomandos en nuestra maquina local, manos en la maquina remota que se esta creando
* remote-exec => este aprovisionador es el que nos permitira ejecutar comandos en la maquina virtual que se esta creando en el cloud, para este aprovisionador es necesario el usu de credenciales para poder establecer la conexion con la maquina, utilizar un llave para la conexion ssh y un usuario mas la ip de la maquina
* file => este aprovisionador los que hara es colocar un archivo desde mi maquina local a la maquina que se esta creando en la infraestructura, especificando la ruta en la que se encuntra el archivo y la ruta a donde se quiere crear en la maquina remota
```tf
resource "aws_instance" "terraform-platzi-instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  tags            = var.tags
  security_groups = [aws_security_group.ssh_conection.name]
  provisioner "remote-exec" {
    connection {
      # tengo que especificar que tipo de conexion vamos a establecer
      type = "ssh"
      # con que usuario me vboy a conectar
      user = "ec2-user"
      # llave con la que nos queremos conectar, tenemos que especificar que sera un file
      private_key = file(var.key_path)
      /* el host, hace refencia a la ip de la maquina para establecer la conexion, ahora
      para hacer referencia a un atributo de bloque padre, con los provisioner, tenemos
      que hacer uso del objeto self concateneado ahora si al atributo del bloque padre
      que quremos acceder, que en este caso es la ip al momento de la creacion 
      de la instancia*/
      host = self.public_ip
    }
    /*con el atributo inline, es que surge l amagia de los provisioners, ya que es por medio de 
    este que pasamos una lista con los comandos a ejecutar ne nuestra maquina, estos se
    ejuctaran en el orden establecido*/
    inline = ["sudo yum install docker-ce docker-ce-cli containerd.io", 
    "sudo systemctl start docker", "docker run -it -d -p 80:80 juanpabloestudiante/hello-platzi:v1"
    ]
  
  }
}
```
**nota:** al tener infraestruturea ya creada, como por ejemplo la instancia, y agregarle un provisioners, al ejecutar el comando ```terraform plan``` no se nos mastrara que se realiza algun cambio ni nada por el estilo, dado que los provisioner son nada ms que comandos que se ejecutaran dentro de las inatancia, mas no son configuraciones que se van a tocar de la infraestrutura como tal, es mas un concepto de **gestionar configuraciones mas no de definir arquitectura**, por lo que tendremos que destruir la infraestructura ya creada con el comando ```terraform destroy``` y volverla a crear con ```terraform apply``` tenemos que tener en cuenta lo mecionado anetes **que los provisioner son la utlima oopcion a querer utlizar al momento de gestionar configuracion de las infraestructura con el mismo terraform, la opcion mas correcta es gestionar las condiguracions con una herramienta cuyo fin sea ese, por ejemplo con Ansible, o de hacerlo con terrafor utlizar las ocpiones que nos dan los cloud provider para al momento de crear servidoress condigurarlos en ese precisio momento, sin tener que uitlizar conexiones via ssh y demas posteriomente**
* Continuando con el ejmeplo, una vez el comando ```terraform apply``` y se ejcuten los comando definidos en el provisioners, que es la instalacion de docker en la maquina remota, mas la creacion del container pornerlo a correr este mismo en base  al aimagen creada en clases pasadas la cual esta en docker.hub, podremos acceder a la ip bublica de nuestra maquina remota y colocar el path definido para el visualizar el html de la aplicacion.
![image](https://user-images.githubusercontent.com/62717509/201266279-cf2375cc-e58c-4e26-a9d0-6a21495e1b3e.png)
