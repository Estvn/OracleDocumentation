
# INTRODUCCIÓN A PL/SQL

**Objetivos:**

- Describir PL/SQL
- Diferencias entre SQL y PL/SQL
- Explicar la necesidad de PL/SQL

- PL/SQL es un lenguaje de programación procedimental de Oracle para bases de datos relacionales.
- Entender las limitaciones de SQL te ayudará a entender la necesidad del uso de PL/SQL.

### Descripción de PL/SQL

- Es una extensión del lenguaje procedimental para SQL.
- Parte de la 3era generación de los lenguajes de programación.
- Un lenguaje de programación propiedad de Oracle.
- **Combina lógica de programación y flujos de control con SQL.**

![[Pasted image 20250629211746.png]]

### Descripción de SQL

- Un lenguaje no procedimental.
- También conocido como un "lenguaje declarativo", que permite al programador enfocarse en la entrada y salida en lugar de los pasos de programación.
- Es un lenguaje de programación de la 4ta generación.
- Fue el primer lenguaje usado para modificar data en bases de datos relacionales.

### Constructores procedimentales

- Usas PL/SQL para escribir código procedimental y declaraciones SQL embebidas entre el código PL/SQL.
- El código procedimental incluye variables, constantes, cursores, lógica condicional e iteraciones.
- Los bloques de código PL/SQL pueden ser salvados y nombrados, luego ejecutados siempre que se necesiten.

### Características de PL/SQL

- Es un lenguaje de alta estructuración, legible y accesible.
- Es un lenguaje embebido y trabaja con SQL.
- Es un lenguaje altamente integrado con bases de datos.
- **Está basado en el lenguaje de programación Ada, y tiene muchas sintaxis similares.**

# BENEFICIOS DE PL/SQL

**Objetivos:**

- Listar y explicar los beneficios de PL/SQL
- Listas las diferentes entre PL/SQL y otros lenguajes de programación
- Dar ejemplos de como usar PL/SQL en otros productos de Oracle

## Beneficios de PL/SQL

#### Integración de construcciones procedimentales con SQL

- La primer ventaja de PL/SQL es la integración de construcciones procedimentales con SQL
- SQL es un lenguaje no procedimental
- PL/SQL integra declaraciones de control y condicionales con SQL.
- Cuando emites un comando SQL, tu comando le dice al servidor de bases de datos que hacer.
- Sin embargo, tu no puedes especificar como hacerlo, o como hacerlo con frecuencia.
- **PL/SQL integra estructuras de control y condicionales en SQL.**
#### Desarrollo de programas modularizados

- **La unidad más básica en un programa PL/SQL es el bloque.**
- **Todos los programas PL/SQL consisten de bloques.**
- Puedes pensar en estos bloques como módulos, puedes "modularizar" estos bloques en una secuencia, o anidarlos en otros bloques.
- Las buenas prácticas de programación usan programas modulares para romper control del programa en secciones que pueden ser más fáciles de entender y mantener.

- Puedes agrupar declaraciones relacionadas lógicamente entre bloques.
- Puedes anidar bloques dentro de bloques para hacer programas poderosos.
- Puedes compartir los bloques con otros programadores para acelerar el tiempo de desarrollo.
#### Rendimiento mejorado

- Permite combinar lógicamente múltiples declaraciones SQL como una sola unidad o bloque.
- La aplicación puede enviar un bloque entero a la base de datos en lugar de enviar una declaración SQL a la vez, haciendo el programa más rápido.
- Reduce significativamente el número de llamadas a la base de datos.

- Las variables PL/SQL se guardan en el mismo espacio binario que la base de datos, la conversión de los datos no es necesaria.
- PL/SQL es ejecutado en el mismo espacio de memoria que el servidor Oracle, por lo tanto no hay sobrecarga en la comunicación entre los dos programas.

- Las funciones PL/SQL pueden ser llamadas directamente desde SQL.
- Un tipo especial de procedimiento de PL/SQL, llamado Trigger, puede ser ejecutado automáticamente siempre que pase algo importante en la base de datos.
#### Integración con herramientas de Oracle

- PL/SQL está integrado con herramientas de Oracle, tal como Oracle Forms Developer, Oracle Report Builder y Application Express.
#### Portabilidad

- Los programas PL/SQL puede ser corrido en cualquier servidor Oracle, sin importar el sistema operativo y la plataforma.
- Los programas PL/SQL no necesitan ser hechos a medida para diferentes SO o plataformas.

- Puedes escribir paquetes de programas portables y crear librerías que pueden ser reusadas en bases de datos Oracle en diferentes entornos.
- Puedes incluso establecer la diferencias y establecer instrucciones para correr en un especifico tipo dado o un entorno específico.
#### Manejo de excepciones

- Una excepción es un error que ocurre cuando se accede a una base de datos.
- Los ejemplos de excepciones incluye:
	- Fallos de red o hardware
	- Errores de lógica de aplicación
	- Errores de integridad de datos
- Puedes preparar los errores escribiendo código de manejo de excepciones
- El manejo de excepciones te dice que hacer en el caso de una excepción.

- PL/SQL permite manejar excepciones de la base de datos y programa de forma más eficiente.
- Puedes definir bloques separados con excepciones definidas.
- De este modo, tu aplicación puede manejar errores, comunicar el problema al usuario sin causar rupturas en el sistema.






















































