### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 8, **creacion de una imagen de docker a partir de un archivo de defincion de docker file**,
vamos a utilizar una configuracion de gninx, con una imegen del mismo, para subirlo en el container, un archivo de configuracion de nuestra aplicacion como tal, en donde se especifican cosa como la ruta, donde encontrar la palicacion que vamos a correr, la cual es un simple arhivo html, con un texto e imagen.
```
FROM nginx
/*primero indicamos de que imagen va a salir, una imagen base, la cula en este caso
es nginx*/

COPY nginx.conf /etc/nginx/nginx.conf
/*vamos a copiar el archivo de configuraciones que tenemos de nginx y lo vamos a sobreescribir al archivo de conifguraciones de nfinx, que se ecnutnra en la ruta especificada*/

COPY hello-world.conf /etc/nginx/conf.d/hello-world.conf
/*copiamos el archivo de configuracion de nuestra aplicacion y lo colocamos dentro de la imagen en la ruta especificada*/

RUN mkdir -p /usr/share/nginx/public/hello
/*creamos una carpeta donde vamos a colocar nuestro index.html, mandamos las intruccion de crear la carpeta con el argumento -p para en caso de que la capeta de la ruta que estamos especificando ya exite solo ignore el error*/

COPY index.html /usr/share/nginx/html/hello/index.html
/*copiamos nuestor index.html en la carpta que acabos de crear par nuestra aplicacion*/

EXPOSE 80
/*finalemnte esponemos el puerto para que lo podeamos utliar en nuestra maquina, por lo regular el puerto en el que correr nginx es el 80, por ende lo utlizamos*/

```

despues de tener el archivo Docker file, construiremos nuestra imagen a parti de ese mismo archiv, con el comando ```docker build -t hello-platzi:v1 --no-cache .```
con el argumento -t le enviamos el nombre de la imagen que queremos construir, le podemos colocar tag de versiones, simplemnte con los :v1 para darle el versionamiento a nuestra imagen.
con el parametro de --no-cache, lo que haremos es que si ya yo intente previamente crear esa imagem , pues ignore las cpas previas que se hallan creado y lo haga desde cero.
el ultimo comando que le mandamos al momento de constuir la imagen es la ruta donde se encuentra el Dockerfile, en este caso como se encuentra en el mismo path simplemtne utlizamos el .

* una vez creada la imagen de docker a partir de nuestro Dockerfile, podemos proceder a crear nuestro contenedor, con el comando ```docker create -p 3000:80 nombre_imagen```
donde lo estamos creando indicando el puerto por el que va acorrer en nuestra maquina, y el puerto que definos en el que iva a correr la aplicacion en el archivo DockerFile
* para ccorrer el container ```docker start id_contiaer o nombre_container```
* para para detener el contener ```docker stop id_contiaer o nombre_container```
* para para elimar el container ```docker rm id_contiaer o nombre_container```
* para para ver los contianers ```docker ps -a```
* subir la imagen de docker a dockerhub, para esto debemos logearlos en la consola, con el comando ```docker login``` por lo que nos pedira el username y password, posterior a esto para subir la imagen a nuestra cuenta de dockerhub, simplmente jecutamos el comando ```dcoker push nombre-imagen```