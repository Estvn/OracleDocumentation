# Relaciones Transferibles

**Objetivos:**
- Describir y dar un ejemplo de relación transferible.
- Comprender la diferencia entre relaciones transferibles y nos transferibles.
- Ilustrar las relaciones transferibles en un ERD.

**Relaciones transferibles**
- **Transferible:** p. ej. Un ALUMNO al que se le permite cambiar de un GRUPO de estudio a otro.
- Debe haber una relación entre alumno y grupo de estudio que es transferibles.
- **Las relaciones transferibles dan cierta flexibilidad a las relaciones entre tablas, para que una instancia de una tabla no esté estrictamente relacionada a la instancia de otra tabla.**
- **Existen casos donde una instancia de una tabla deberá ser cambiada a la instancia de otra tabla.**

- **No transferible:** p. ej. A un ALUMNO se le puede emitir un RECIBO de pago de matricula. Una vez emitido el RECIBO, no puede ser transferido a otro ALUMNO.
- Si se emitió por error, se tendrá que cancelar y se tendrá que redactar otro recibo.
- ***Una relación no transferible se representa con un rombo en la relación.***
- **Las relaciones no transferibles son opcionales, se agregan dependiendo de las reglas de negocio.**
- Debe reconocer los casos donde las relaciones pueden ser transferibles o no.
 
 - Otro ejemplo de relación no transferible es la propiedad de un POEMA a su AUTOR. La autoría es una relación que no se puede mover a otra persona.

![[Captura desde 2024-05-09 09-50-54.png]]

**Terminología:**
- No transferible.
- Transferible.

# Tipos de Relaciones

**Objetivos:**
- Reconocer y dar ejemplos de relación de uno a uno.
- Reconocer y dar ejemplos de relación de uno a varios.
- Reconocer y dar ejemplos de relación de varios a varios.
- Reconocer relaciones redundantes y eliminarlas del ERD.

- A medida que acotamos y mejoramos nuestro modelo, queremos asegurarnos de que nuestras relaciones de entidad modelan correctamente nuestras reglas de negocio.
- Recuerde que puede evitar futuros errores costosos pensando en los detalles con anticipación.

**Relaciones uno a varios y varios a varios**
1. Relaciones 1:M son los más comunes en un modelo de ER.
2. Relaciones M:M
	- Los distintos tipos de relaciones M:M son comunes, especialmente en una primera versión de un modelo de ER.
	- En etapas posteriores del proceso de modelado, todas las relaciones M:M se resolverán y desaparecerán.
	- Las relaciones varios a varios no se deben dejar en el modelo.

**Relaciones uno a uno para roles**
- Por lo general encontrará solo pocos de los distintos tipos de relaciones 1:1 en cada modelo de ER. 
- Obligatorio en un extremo de la relación 1:1 se suele producir cuando se han modelado los roles.

**Relaciones uno a uno para procesos**
- Las relaciones 1:1 también se pueden producir cuando algunas de las entidades representan las distintas etapas de un proceso.

**Relaciones redundantes**
- Una relación redundante se puede derivar de otra relación del modelo.
- Tenga cuidado a la hora de concluir que una relación es redundante basándose solo en la estructura.
- Lea las relaciones para comprobar si es redundante.

Esta es una relación redundante
![[Captura desde 2024-05-09 10-09-06.png]]

Esta no es una relación redundante
![[Captura desde 2024-05-09 10-11-24.png]]

**Terminología**
- Varios a varios.
- Uno a varios.
- Uno a uno.
- Redundante.

# Resolución de las relaciones de muchos a muchos

**Objetivos**
- Identificar los atributos que pertenecen a relaciones de varios a varios.
- Mostrar los pasos para resolver de una relación de varios a varios mediante una entidad de intersección.
- Identificar el UID de una entidad de intersección y representarlo en el diagrama de relación de entidad (ERD).
- Esta unidad le ayudará a definir el ámbito de su modelo de datos: solo modela lo que es importante para el negocio.

**Relación que oculta un atributo**
- En un centro educativo, un ALUMNO puede estudiar una o varias ASIGNATURAs.
- Cada ASIGNATURA puede ser estudiada por uno o varios ALUMNOs.
- Cuando un alumno se matricula en una signatura, deseamos poder registrar la nota que logre para esa asignatura.
	- ¿A que entidad pertenece el atributo nota?
	- Si ponemos nota en la entidad ALUMNO, ¿cómo sabemos para que asignatura es?
	- Si ponemos nota en la entidad ASIGNATURA, ¿cómo sabemos que ALUMNO obtuvo esa nota?
- **Es necesaria una tercera entidad para resolver la relación M:M.**
- **Esta se denomina entidad de "intersección".**

**Entidad de Intersección**
- Se ha agregado una entidad de intersección (INSCRIPCION), que incluye el atributo nota.
- La relación M:M original se ha convertido en dos relaciones 1:M.
- ¿Cuál será el UID de la entidad de intersección?

**Relaciones Excluidas**
- El identificador único (UID) de la entidad de intersección a menudo proviene de las relaciones de origen, y está representado por las barras.
- En este caso, las relaciones de las entidades de origen con la entidad de intersección se denominan relaciones "excluidas".
- Las relaciones de las entidades de intersección suelen participar en el UID, por lo que las relaciones suelen excluirse.

![[Captura desde 2024-05-09 10-32-32.png]]

![[Captura desde 2024-05-09 10-34-13.png]]

**Terminología**
- Relación excluida.
- Entidad de intersección.

# Descripción de los Requisitos de CRUD

**Objetivos**
- Crear modelos de ER que reflejen todas las reglas de negocio recopiladas durante el proceso de entrevista.
- Identificar los requisitos de creación, recuperación, actualización y supresión (CRUD) del negocio.
- Validar el modelo de ER mediante la realización de un análisis de CRUD.

**Introducción**
- A partir de los casos de negocio que desarrolle y la lista de las reglas de negocio que identifique durante la entrevista con el cliente, creará el ERD.
- El ERD es la herramienta de conversación entre el asesor y el cliente, y también es el plano para el DBA que finalmente creará la base de datos.
- Necesita una forma de comprobar que no le falta ninguna entidad ni relación en el modelo de datos.
- También desea asegurarse de que no ha modelado nada que el negocio no necesite.
- El análisis CRUD le ayudará a hacerlo.

**Análisis de CRUD**
- Una buena forma de validar el ERD es realizar un análisis CRUD en él.
- CRUD es el acrónimo en inglés de crear, recuperar, actualizar y suprimir.
- Estas son las cuatro funciones (u operaciones) básicas que permite una base de datos.
- Parte de la comprobación de si un modelo de datos está completo y es preciso es asegurarse de que todas las funciones CRUD especificadas por el caso de negocio y las reglas de negocio están representadas en el ERD.

**Análisis CRUD: Función Crear**
- Durante una entrevista con el cliente y al escribir los casos y reglas de negocio, busque palabras clave como:
	- Entrada, introducir, cargar, importar, registrar y crear.
- Todas ellas indican que se crea un registro en la base de datos en este momento.
- Revise los requisitos de las palabras clave.
- ¿Su modelo de datos tiene en cuenta todas estas funciones?

**Análisis CRUD: Función Recuperar**
- Durante la entrevista con el cliente y al escribir los casos y reglas de negocio, busque palabras clave como:
	- Ver, informe, mostrar, imprimir, buscar, leer y consultar.
- Todas estas palabras apuntan a la recuperación de información de la base de datos.
- Revise los requisitos de estas palabras clave.
- ¿Su modelo de datos tiene en cuenta todas estas funciones?

**Análisis CRUD: Función Actualizar**
- Durante la entrevista con el cliente y al escribir los casos y reglas de negocio, busque palabras clave como:
	- Cambiar, modificar, alterar y actualizar.
- Todas estas palabras apuntan a la actualización de información que ya está en la base de datos.
- Revise los requisitos de estas palabras clave.
- ¿Su modelo de datos tiene en cuenta todas estas funciones?

**Análisis CRUD: Función Suprimir**
- Durante la entrevista con el cliente y al escribir los casos y reglas de negocio, busque palabras clave como:
	- Desechar, eliminar, papelera, depurar y suprimir.
- Todas estas palabras apuntan a la supresión de información que ya está en la base de datos.
- Revise los requisitos de estas palabras clave.
- ¿Su modelo de datos tiene en cuenta todas estas funciones?

**Validación de CRUD**
- La realización de un análisis de CRUD en el modelo de datos le ayuda a comprobar el ámbito y si está completo.
- Si tiene una regla de negocio que no tiene ninguna entidad para el análisis CRUD, el modelo de datos puede estar incompleto.
- Asimismo, si tiene entidades en el ERD que no toca ninguna función de CRUD, puede que no necesite esa entidad en el modelo.

**Terminología**
- Asesor.
- Análisis de CRUD.
- Funciones.
