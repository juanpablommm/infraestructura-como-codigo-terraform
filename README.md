### CURSO DE INFRACESTRUCTURA COMO CODIGO TERRAFORM

* Clase 2 **Tipos de herramientas para implementar infracestructura como codigo**
1. **Herramientas para definicion de infracestrutura**
Este tipo de herramientas permiten especificar que elementos o recurso de infracestructura deseamos crear y como deben crearse.
**herramientas para definir infracestructura**
* Terraform => una solucion a la infracesctura como codigo multi-cloud
* Cloud formation => unicaemnte para cloud de aws
* Open stack heat => unicamente para open stack

2. **Herramientas para la configuracion de servidores** 
Estas nos permiten configurar los servidores con el estado deseado, luego de que estos yan han sido creados con las herramientas para la definicion de infracestrcutura; => por ejemplo luego de que creamos una maquina virtual, nosotros necesitamos instalar ciertas dependencia de la aplicacion que queremos ejecutar, es aqui donde este tipo de herramientas nos sirve para especificar el estado de esa infracesctructura; que paquetes necesita, que directorios se quiere crear, los usuarios, permisos, todod eso que va en la capa de la plataforma.
2.1 **aprovisionamiento** es el proceso que permite que un elemento este listo para utilizarce, porjemplo tener todas las dependiencias de una palicacion ya listas, unicamente para el despliegue de la palicacion.
2.2 **Enfoques para la gestion de servidores**
* Configuracion de servidores => manejar las configuraciones de los servidores desde un archivo de definicion
* Empaquetar plantillas de servidores => por ejemplo al hablar de maquinas virtuales, podemos decir que es una herramienta que nos permite tomar Snashot de las maquinas virtuales para generar plantillas
* Ejecutar comandos en los servidores => herramientas que nos permiten ejecutar comandos de forma remota en los srvidores
* Configuracion desde un registro central => herramintas que nos permiten tener las configuraciones centralizadas, en donde simplemnte las maquinas se conectan y de esta manera obtienen sus configuraciones
2.3 **Objectivos de la gestion automatizada de servidores**
* un servidor puede ser aprovisionado bajo demanda cuando sea necesario
* Un nuevo servidor pude ser aprovisionado sin intervencion humana
* cada cambio pude ser aplicado a un conjunto de servidores
