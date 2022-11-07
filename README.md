### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 12, **¿Como Gestiona terraform el estado de la infraestructura?**
Terraform sabe que infraestructura crea, por lo tanto es mas facil cuando hacemos cambios en los archivos de configuracion, pues terraform sabe si tiene que modifcar algo, agregar algo o destruir algo.
Esto lo sabe, porque utliza un archivo de estado c donde lamacena todas estas configuraciones, este archivo de estado se llama **terraform.tfstate**
podemos manejar este archivo de forma local o tambien de forma remota, este arhivo guarda toda la informacion, por jemplo el ami que nostros creamos en el curso,la region deonde se creo la instancia, infromacion de la misma intancia, **si nosotros usamos credenciales tambien las almacena** por lo qu este archivo es algo delicado, dada la informacion sencible, si utlizamos este archivo de forma local no esta encryptado, ahy una forma de manejarlo de forma remota y encryptada para no exponer la informacion delicada.
**Ahora nosotros podemos perfectamente eliminar este archivo y hacemos que terraform olvide completamente la infraestructura que creo**
ejemplo de como se ve una archivo terraform.tfstates
```tf
{
  "version": 4,
  "terraform_version": "1.3.3",
  "serial": 53,
  "lineage": "708b891f-ed73-e933-7758-448a75792244",
  "outputs": {
    "instance_ip": {
      "value": [
        "54.89.145.92"
      ],
      "type": [
        "tuple",
        [
          "string"
        ]
      ]
    }
  },
  "resources": [
```
cuando terraform ejecuta los comando, crea una carpta denominada **.terraform** en esta lamacena todos los plugins que descarga para conectaerce a un cloud-provider y tambien crea el archivo **terraform.tfstates**

**Resumiendo ¿Como Gestiona terraform el estado de la infraestructura?**
* El directorio **.terraform** es creado cuando ejecutamos por primera vez el comando ```terraform init```.
* El archivo **terraform.tfstate** es creado cuando ejecutamos por primera vez el comando ```terraform apply``` y guarda el estado de la infraestructura creada, ahora cuando el archivo ya existe y actulizamos la infraestructura con el comando ```terraform apply``` o ```terraform destroy```  el archivo guarada el ultimo estado sustituyendo al anterior.
* El archivo **terraform.tfstate.backup** es creado cuando tenemos un primer estado **terraform.tfstate** y aplicamos una modificacion con **apply** o **destroy** entonces el estado que estaba en **terraform.tfstate** se combierte en **terraform.tfstate.backup**.
* Ahora cada vez que nosotros apliquemos una cambios de configuracion estos pasaran a estar en el **terraform.tfstate** y el anterior estado que este tenia pasara a estar en **terraform.tfstate.backup**

**importante:** lo que se hace abitualmente en ambiestes de trabajo es que al archivo terraform.tfstate.backup se sube a un bucket s3