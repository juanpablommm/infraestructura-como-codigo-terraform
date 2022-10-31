### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 6, **Creacion de un archivo de definicion en packer para crear un AMi en aws**

**packer =>** packer es una herramienta open source que permite la creacion de imagenes de 
maquinas identicas para varias plataformas a partir de una unica plantilla de origin.

1. creamos el archivo de definicion de packer, el cual sera en formato json "aws-ami.json"
```js 
{
    /*en los builders, podemos crear mas de uno al mismo tiempo; por lo que este objeto sera igual
    a un array en donde se crear un objeto por cada uno de los builders que queramos crear
    */
    "builders": [
        {
            /*tenemos que definir que tipo de builder vamos a tulizar, ese lo hacemos con el atributo
            type y en este caso sera "amazon-ebs que es el mas facil de configurar segun la documentacion
            de packer, dado que le complemento de amazon viene con multiples constructores segun la estrategia
            que se desee utlizar para la construccion de la AMI.
            amazon-ebs => permite la creacion de AMI respaldadas por EBS lanzando una AMI de origin y 
            volviendola a empaquetar en una nueva AMI despues del aprovisionamiento. En caso de duda,
            o para principiantes se usa este contructor que es el mas facil para comenzar"*/
            "type": "amazon-ebs", 
            //necesitamos el access y secret key del usuario para la conexion
            "access_key": "AKIA6GHAOE3GYPD6YAWF",
            "secret_key": "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",
            /*tenemos que definir la region de donde nostros vamos a salir con la imagen base
            que vamos a utlizar, es decir de donde tenemos la imagen base desde la cual
            crearemos nuestra AMI, en este caso la region es virginia*/
            "region": "us-east-1",
            /*el source ami, de donde vamos a salir, es decir el "ID AMI" de la imagen base
            que estamos utlizando para la creacionde al AMI, en este caso es una imi, con
            SO, de LINUx Amazon*/
            "source_ami": "ami-0d5506239dbeafc6b",
            /*mediante source_ami_filter, aplicamos los filtros que necesitamos, para celecionar
            nuestra imagen base, por ejemplo el owners, que equivale a el numero del propietario 
            de la imagen en aws, y el parametro most_recent que seria unvalor boolean para espcificar
            que obtengamos la version mas reciente de esa imagem base*/
            "source_ami_filter": {
                "owners": ["975428265677"],
                "most_recent": true
            },

            /*creamos un builders en donde estaremos diciendo que tipo de maquina se constuira en la
            AMI que estamos creando;
            donde le decimos que el instance__type: sera una t2.micro de aws*/
            "instance_type": "t2.micro",
            /*atraves de atributo ssh_username decimos el suario para esa instance, de acuerdo al SO
            de la imagen base que tenmos, en esta caso ec2-user para SO Linux Amazon*/
            "ssh_username": "ec2-user",
            /*y por ultimo para la AMI que estampos creando le damos un nombre con el atributo ami_name*/
            "ami_name": "packer-demo-segunda"
        }
    ],
    /*los provisioners es basicmente donde nosotros meteremos todas nuesras configuraciones,
    para poder configurar o aprovicionar nuestro servidor o en este caso nuetra AMi como nosotros 
    la queremos, de igual manera como nostros podemos configurar varios provisioners este
    sera igual a un array en donde configuraremos cada uno*/
    "provisioners": [
        {
            /*vamos a configurar en este provisioners, el setear, colocar un archivo
            en el AMI, que estamos creando
            *especificamos el tipo de provisioners con type: en donde decimos que sera un archivo*/
            "type": "file",
            /*especificamos la ruta de donde tenemoes ese archivo que vasmoa a aprovisionar en nuestra
            AMI, en este caso es una llave SSH, que creamos y que tenemos en esta misma carpta del curso,
            y que se utlizara para la conexion mas adelante*/
            "source": "scripts/packer_key.pub",
            /*con el atributo destination, definimos la ruta en donde queremos colocar este archivo, en el
            aproviionamiento de la AMI, en este caso estamos coloando la key en la carpta ssh de la maquina*/
            "destination": "~/.ssh/"
        },
        {
            /*creamos otro provisioners, para crear la llave, decimes que este provisioners sera
            de tipo shell, es decir vamos a ejecutar un comando en la consola de la maquina*/
            "type": "shell",
            /*decimos que esa llave la agrege a authorized_key para que se nos brinde authorizacion con esa llave,
            para poderse autenticar*/
            "inline": ["cat ~/.ssh/packer_key.pub >> ~/.ssh/authorized_keys"]
        },
        {
            /*creamos otro provisioners, que tambie sera otro shell, pero este en vez de ser inline,
            donde ejecutamos un comando o mas por consola, utlizamos un scrip: en donde podremos correr
            un script que tengamos en un archivo, para correrlo*/
            "type": "shell",
            "script": "scripts/instalar-docker.sh"
        }

    ]
}
```
2. una vez tengamos el archivo de defincion para la creacion del AMI, lo que haremos es validar
que este correctamente definido con packer, ejecutanto:
```shell
packer validate ./aws-ami.json
```
3. si la validacion es correcta, se encuntra vien definido, podemos proceder a la construccion de la AMI con nustro archico, ejecutando el comando:
```shell
packer build ./aws-ami.json
```
Lo que creara correctamente a AMI, en aws, con los parovisionamientos que se configuraron, en este caso, la colocacion de la llave ssh, y la instalacion de docker mediante el scrip
![image](https://user-images.githubusercontent.com/62717509/199103437-cc940e47-b6f0-4c28-8ed8-3d3b5ae71430.png)