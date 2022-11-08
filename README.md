### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 15, **Encriptacion de nuestro backend, archivos de estado terraform**
* para poder encryptar la informacion de nuestro archivo de estado para el backen de teraform, en este caso un bucket s3 de aws que estamos utlizando, primero debmos crear un nuevo recurso adicional, el cual permite crear y administrar llaves, **kms** para poder encryptar la informacion
```tf
resource "aws_kms_key" "myKey" {
  description             = "key state file "
  # con este parametro especificamos la cantidad de dias en que se rotaran las llaves
  deletion_window_in_days = 10
}
```
* despues de crear el recurso de de **kms** procedemos a agregarloa al **bucket s3**
```tf
resource "aws_s3_bucket" "platzi_backend" {
  bucket = var.bucket_name
  acl    = var.acl
  tags   = var.tags
  #activamos el versionamiento en el bucket
  versioning {
      neabled = true
    }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        # necesitamos darle el id del kms creado, el cual se encutra en el atributo arn
        kms_master_key_id = aws_kms_key.myKey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
```
* una vez creado el recurso de kms y agregado al bucket procedmos a crear la infraestructura con el comando ```terraform apply``` donde basicmanete estaremos agregando la key creada en el recurso kms al bucket s3 para encryptar la informacion
* ahora como siguiente paso es agregar del lado del bloque de backend la encryptacion para el archivo de estado, donde simplemente tendremos que agregar el atributo **encrypt** dandole como valor true, y agregar el atributo de **kms_key_id** donde se le dara el valor del arn arojada en la creacionde del kms, una vez configurado el backend, saviendo que el archivo de estado lo maneja el comando ```terraform init``` automaticamente actulizara el archivo de estado, y lo estara encryptando al momento de subirlo al bucket s3, no siendo visble para usuarios que solo tengan prmisos **ReadOnly**.
Ahora teeraform podra perfectamente manejar la informacion del archivo de estado sin ningun inconveniente dado que en el bloque de configuracion del backend se esta especificando cual es la key que se esta utilizando para encryptar esa informacion, siendo inacezible para inaccessible para los usuarios de cloud provider que solo tengan permiso de lectura
![image](https://user-images.githubusercontent.com/62717509/200674826-f958dd3c-9102-4fbb-a126-c30489e18664.png)