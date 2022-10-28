### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 5, ***terraform vs otras herramientas de infraestructura como codigo**
* **gestion de configuraciones vs defincion de infraestrcutura**
Recordando que las harramientas para la gestion de configuraciones son las que nos permiten configurar el estado de la infraestructura una vez halla sido creada con las heeramientas de defincion de infraestrutura, es decir configurar el **aprovisionamiento**
Ahora bien algunas herramientas de gestion de configuraciones tambien definir infracestrura como por ejemplo Ansible, esta es una herramienta para gestion de configuraciones, la cual nos permite instalar paquetes, crear carpetas, crear archivos,  **nos permite manejar el estado de la infraestructura**; aunque esta herramienta tambien nos permita definir infraestrutura este no es su enfoque prinipal, dado que es una herramienta para gestionar configuraciones en la infraestrutura.
**Lo mejor es que utilicemos una herramienta para la definicion de infraestructuta como Terraform, y para configurar el estado de esta y aprovisionarla, utliicemos una herramienta para la gestion de configuraciones como por ejemplo Ansiable**

* **Infraestrutua mutable vs Infraestrututa Imutable**
* Infraestrutua mutable => esta hace referencia cuando nosotros estamos cambiando el estado o las configuraciones de la infraestrutura, por ejemplo si tenemos una intancia con el SO y la aplicacion como tal, y sale una nueva versionde la aplicacion, creamos una nueva carpeta con la nueva version y realizamos un lin sinbolico hacia esa nueva version, en caso de que la aplicacion no funcione con esa nueva version solo lo cambiaremos a la anterior y no pasa nada.
<img width="587" alt="image" src="https://user-images.githubusercontent.com/62717509/198468300-10ae999c-95af-4396-bb33-08275a577dea.png">

* Infraestrutura inmutable => esta consta basicamente de destruir un servidor y crear uno nuevo con los cambios que surgen en la nueva version, para este tipo de infraestructura tambien exiten herramientas que nos permiten crear plantillas para aplicar la infraestructua inmutable
* <img width="574" alt="image (1)" src="https://user-images.githubusercontent.com/62717509/198469928-81ba652a-8750-41c5-92e4-42f0255c9003.png">

* **lenguaje declarativo vs lenguaje procedural o imperativo**
* El lenguaje declarativo es cuando le decimos anuestras heramientas o lenguajes que hacer, sin importar el como hacerlo; terraform utliza la programacion declarativa

* El lengua imperativo o procedural, se centra en el como hacerlo; ansible utliza la programacion impetativa.