### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 3, **beneficios de la infracestructura como codigo**
* Crear rapidamente y bajo demanda => como nosotrsos creamos un unico archivo de defincion de infracestructura, en donde almacenamos todas nuestras configuraciones, esto ahra que nuestro esfuerzo solo lo vamos a realizar al principio, puesto que podres crear n veces la infracestructura que necesitemos ya con nuerstro archivo de definicion
* Atomatizacion => una vez tegamos nuestro archivo de deifinicon, podremos utlizar herramintas dde **continuos integration** para automatizar la infracestructura
* Visibilidad y trazabilidad => al hacer uso del versionamiento en la infracestructura como codigo, nos permitira una vibilidad y trazabilidad dado que todos los cambio quedaran registrados
* Ambitnes homogeneos => podemos crear varios ambientes a partir de el mismo archivo de defincion que tengamos, solo cambiando algunos parametros
* Facil de testear => podemos aplicar las practicas de desarrollo de codigo, y testear nuestra infraesctructura al estar en archivos de defincion, con algunas herramientas como por ejemplo **[Terratest](https://terratest.gruntwork.io/)**