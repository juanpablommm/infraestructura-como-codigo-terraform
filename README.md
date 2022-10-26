### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 1.
¿Que es infracestructura como codigo?
es un enfoque para la automatizacion de infracestructura basado en las 
practicas de desarrollo de software
**Principios**
* Los sistemas se pueden reproducir facilmente => por ejemplo se puede crear una instancia Ec2 en aws, al crear una instancia podemos ir a la consola de aws, selecionamos que es lo que queremos y demas, pero si vamos a crear vas instanicas similares, al tenerlo definido en un archivo de codigo seria mucho mas facil crearlas solo con ejecutar el codigo.
* Los sitemas son desechables => si un sistema falla, lo podemos eliminar, y volverlo a construir
si tenemos definida en codigo cual es la estructura que deberia tener dicho sitema
*Los sitemas son consistentes => es decir tenemos un archivo, tenemos en codigo, lo que tiene el servidor, conciendolo mas facilmente
* Los sitemas son repetibles => done podemos escribir una definicion de codigo y utilizarla n cantidad de veces que necesitemos
* El diseño siempre esta cambiando => es mas facil al tener el diseño plasmado en un archivo de defininicion, porque sabremos los cambios que tendremos que hacer

**Infracestructura como codigo Practicas generales**
* Utilizar archivos de definicion => todas las herramientas de infracestructura como codigo tienen un formato propio para definir infracestructura
* Los procesos y los sitemas deben ser autodocumentados => al utlizar el enfoque de infracestrutura como codigo nos permite obviamnete reutilizar el codigo, por lo que si otras personas que pueden llegar a utlizar nuestro codigo, es importante que este este documentado para que las personas sepan, que es lo que esta haciendo el modulo que nosotros estamos creando
* versionar todas las cosas => lo cual nos permite trazar los cambios que se hacen, para al momento de realizar un cambio y que pueda salir mal, podamos regresar en el tiempo el archivo y regesarlo a cuando era estable.
* preferir cambios pequeños => realizar cambios pequeños con el fin de no impactar tanto
* mantener los servicios continuamente disponibles