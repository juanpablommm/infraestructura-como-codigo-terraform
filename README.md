### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 7, **Conceptos claves de Dcoker**
Docker nos permite crear infraestructura inmutable, nos permite encapsular y portar nuestras aplicaciones, en una misma imagen de docker nostros podemos tener definido un sistema operativo, los paquestes y nuestra aplicacion, de tal forma que la construimos una vez y la podemos instanciar n veces.
* **imagen=>** una imagen de docker basicamente es una capa creada a partir de un archivo denominado docker file, en el cual creamos todas nuestra definiciones, instalamos todos los paquetes, se crea todo el directorio, todo en un archivo denominado docker file, luego apartir de el docker file se crea una imagen con todas las definiciones que se pusieron en este.
* **container=>** es una instanica o son instanicas de imagenes de docker, donde podemos instanciar n veces una imagen, los container no tienen estado, se puden crear y destruir, no deverian guardar ninguna informacion porque son volatiles, no tienen ningun estado.
ejemplo de un docker file:
```
# Super simple example of Dockerfile
#
FROM ubuntu:latest
MANTAiNER Juan Pablo "juanpablomontoya618@gamil.com"
RUN apt-get update
RUN apt-get install -y python-pip wget
RUN pip install Flask

ADD hello.py /home/hello.py

WORDIR /home

ENTRYPOINT ["/home/hello.py"]

```

* lo primero es indicar de donde o de que imagen vamos salir con **FROM**, en este caso estamos saliendo de una imagen de ubuntu con la ultima version.
* lo segundo a especificar es el **MANTAINER** donde se meciona nombre o correo electronico para hacer referencia a quien le da maneteimiento a dicha imagen, este es opcional
* tambien tenemos **RUN** con esta plabra reservado vamos a configurar todo, porque nos sirve para ejecutar comandos, comandos para instalar, para crear, para compartir, todos los comando que necesitemos para nuestra aplicacion
* el comando **ADD** lo podemos usar para copiar archivos desde nustra maquina local hacia la imagen docker que estamos creando
* el **WORDIR** con este comando le mandamos el path de donde nosotros queremos que levante la aplicacion
* el **ENTRYPOINT** nos permitira colocar lo que nosotros queremos que haga cuando el container se levante, regularmente lo que queremos que haga cuando el container se levante es que levante nuestra apliacacion, lo podemos enviar por comando, enviar un script que nos diga que hacer, etc..