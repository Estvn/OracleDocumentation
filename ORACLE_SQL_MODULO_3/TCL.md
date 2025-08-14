
# TCL

# Transacciones de Base de Datos
---------------------------

**Objetivos:**
- Definir los términos COMMIT, ROLLBACK y SAVEPOINT y su relación con las transacciones de datos.
- Enumerar tres ventajas de las sentencias COMMIT, ROLLBACK y SAVEPOINT.
- Explicar por qué es importante, desde una perspectiva de negocio, poder controlar el flujo de procesamiento de transacciones.
- Aprenderá cómo se gestiona el proceso de cambio de datos y cómo se confirman o cancelan los cambios en una base de datos.
### **Transacciones**
- Son un concepto fundamental de todos los sistemas de bases de datos.
- Las transacciones permiten a los usuarios realizar cambios en los datos y, a continuación, decidir si desean guardar o desechar el trabajo.

Una transacción consiste en una de las siguiente opciones:
- Sentencias DML que constituyen un cambio consistente de los datos.
- Las sentencias DML incluyen INSERT, UPDATE, DELETE y **MERGE**.
- Una sentencia DDL como CREATE, ALTER, DROP, RENAME o TRUNCATE.
- Una sentencia DCL como GRANT o REVOKE.
### Analogía de una Transacción
**Una transacción se produce completamente o no se produce en absoluto.**
Las transacciones se controlan mediante las siguientes sentencias:
###### COMMIT: 
- representa el punto en el tiempo en el que el usuario ha realizado todos los cambios que quería para agruparlos lógicamente y, puesto que no se ha cometido ningún error, el usuario está lista para guardar el estado.
- Cuando se emite una sentencia COMMIT, la transacción actual finaliza haciendo que todos los cambios pendientes sean permanentes.
###### ROLLBACK:
- Permite al usuario desechar los cambios realizados en la base de datos.
- Cuando se emite una sentencia ROLLBACK, se desechan todos los cambios pendientes.
###### SAVEPOINT
- Crea un marcador en una transacción, que divide la transacción en varias partes más pequeñas.
###### ROLLBACK TO SAVEPOINT
- Permite al usuario realizar un rollback de la transacción actual hasta un punto de grabación especificado.
- Si se ha cometido un error, el usuario puede emitir una sentencia ROLLBACK TO SAVEPOINT desechando solo los cambios realizados después de establecer SAVEPOINT.
### ¿Cuándo Empieza y Termina una Transacción?

Una transacción empieza con la primera sentencia DML (INSERT, UPDATE, DELETE o MERGE).
Una transacción termina cuando se produce una de las siguientes situaciones:
- Se emite una sentencia COMMIT o ROLLBACK
- Se emite una sentencia DDL (CREATE, ALTER, DROP, RENAME o TRUNCATE)
- Se emite una sentencia DCL (GRANT o REVOKE)
- Un usuario sale normalmente de la utilidad de la base de datos Oracle, por lo que hace que la transacción actual se confirme de forma implícita.

- Tras la finalización de una transacción, la siguiente sentencia SQL ejecutable inicia automáticamente la próxima transacción.
- Se confirma automáticamente una nueva sentencia DDL o DCL y, por lo tanto, finaliza de forma implícita una transacción.
- Todos los cambios de datos realizados durante una transacción son temporales hasta que se confirma la transacción.
### Consistencia de los Datos
- Para evitar interrupciones o conflictos y permitir que varios usuarios accedan a la base de datos al mismo tiempo, los sistemas de bases de datos utilizan una implantación automática denominada "consistencia de lectura".
#####  Consistencia de Lectura
- La consistencia de lectura garantiza una vista consistente de los datos para todos los usuarios en todo momento.
- Que los lectores no visualicen datos en proceso de cambio.
- Que los escritores tengan garantizado que los cambios en la base de datos se realizarán de forma consistente.
- Que los cambios realizados por un escritor no destruyan ni entren en conflicto con los cambios que esté realizando otro escritor.

- La consistencia de lectura es una implementación automática. 
- Una copia parcial de la base de datos se mantiene en segmentos de deshacer. Cuando el usuario A emite una operación de inserción, actualización o supresión en la base de datos, Oracle Server toma una instantánea (copia) de los datos antes de cambiarlos y los escribe en un segmento de deshacer (rollback).
- El usuario B sigue viendo la base de datos como existía antes de que se iniciaran los cambios; ve la instantánea de los datos del segmento a deshacer.

- Antes de confirmar los cambios en la base de datos, solo el usuario que está cambiando los datos ve los cambios; todos los demás ven la instantánea en el segmento a deshacer.
- Esto garantiza que los lectores de los datos vean los datos consistentes en los que no se esté realizando actualmente ningún cambio.
##### Cambios Visibles
- Cuando se conforma una sentencia DML, cualquiera que ejecute la sentencia SELECT puede ver el cambio realizado
- Si se realiza un ROLLBACK de la transacción, los cambios se deshacen:
	- La versión original anterior de los datos del segmento de deshacer se vuelve a escribir en la tabla.
	- Todos los usuarios ven la base de datos como existía antes de comenzar la transacción.
### **COMMIT, ROLLBACK y SAVEPOINT**
- COMMIT y ROLLBACK garantizan la consistencia de los datos, posibilitando obtener una vista previa de los cambios en los datos antes de hacer que los cambios sean permanentes y para agrupar lógicamente operaciones relacionadas.
- SAVEPOINT crea un punto en una transacción al que puede realizar un ROLLBACK son tener que deshacer toda la transacción.
- **COMMIT, ROLLBACK y SAVEPOINT se denominan lenguaje de control de transacciones o TCL.**

- Si un usuario emite una sentencia ROLLBACK sin una sentencia ROLLBACK TO SAVEPOINT, se finaliza toda la transacción y se desechan todos los cambios de datos pendientes.
### Procesamiento de Transacciones Implícitas
La confirmación automática de cambios en los datos se produce en las siguiente circunstancias:
- Se emite una sentencia DDL
- Se emite una sentencia DCL
- Un usuario sale normalmente de la utilidad de la base de datos Oracle, lo que hace que la transacción actual se confirme de forma implícita.
- Se emite explícitamente sentencias COMMIT o ROLLBACK.

- El ROLLBACK automático se produce tras una terminación anormal de la utilidad de base de datos Oracle o cuando ocurre un fallo en el sistema.
- Esto evita que cualquier error en los datos provoque cambios no deseados en las tablas subyacentes.
- Por lo tanto, la integridad de los datos está protegida.
### Bloqueo
- Es importante evitar que más de un usuario cambie los datos a la vez.
- Oracle utiliza bloqueos para evitar una interacción destructiva entre transacciones que acceden al mismo recurso, tanto objetos de usuarios (tablas o filas) como objetos del sistema no visibles para los usuarios (estructuras de datos compartidos y filas de diccionario de datos).

- **El bloqueo de Oracle se realiza automáticamente y no necesita ninguna acción del usuario.**
- El bloqueo implícito se produce para sentencias SQL según sea necesario, según la acción solicitada.
- El bloqueo implícito se produce para todas las sentencias SQL excepto SELECT.
- Los usuarios también pueden bloquear los datos de forma manual, lo que se denomina como bloque explícito.
- Cuando se emite una sentencia COMMIT o ROLLBACK, se liberan los bloqueos en las filas afectadas.





























































































































