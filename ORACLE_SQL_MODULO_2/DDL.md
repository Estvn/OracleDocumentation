
# **DDL**

# Creación de Tablas
--------------

**Objetivos:**
- Enumerar y clasificar los principales objetos de una base de datos
- Revisar la estructura de una tabla
- Describir como la base de datos Oracle utiliza los objetos de esquema
- Crear una tabla mediante el tipo de dato adecuado para cada columna
- Explicar el uso de tablas externas
- Consultar el diccionario de datos para obtener los nombres y otros atributos de objetos de la base de datos

Como un DBA, se espera que también sepa cómo crear tablas. En esta lección, conocerá los objetos de base de datos que más se utilizan, cómo mirar la estructura de la tabla y cómo crear nuevas tablas.

- Las tablas serán pequeñas en comparación con las tablas que contienen millones de filas y cientos de columnas, pero la creación de una tabla pequeña implica las mismas sentencias SQL y sintaxis que la creación de una muy grande.
- También aprenderá sobre las tablas externas, tablas que son similares en cuanto a estructura a las tablas de base de datos Oracle normales, pero las filas de datos reales se almacenan de forma externa un archivo plano y solo se accede a ellas cuando es necesario.
### Objetos de Esquema de la Base de Datos
- Una base de datos Oracle puede contener muchos tipos distintos de objetos.
- Los principales tipos de objetos de base de datos son:
	- Tabla 
	- Índice de
	- Restricción
	- Vista
	- Secuencia
	- Sinónimo
- Algunos de estos tipos de objetos pueden existir de forma independiente y otros no pueden.
- **Algunos de los tipos de objetos ocupan espacio, lo que se denomina almacenamiento, en la base de datos y otros no.**

- Los objetos de la base de datos que ocupan mucho espacio de almacenamiento se denominan segmentos.
- Las tablas y los índices son ejemplos de segmentos, ya que los valores almacenados en las columnas de cada fila ocupan mucho espacio en el disco físico.
- Las vistas, restricciones, secuencias y sinónimos también son objetos, pero el único espacio que necesitan en la base de datos está en la definición del objeto: ninguno de ellos tiene filas de datos asociadas.

- La base de datos almacena las definiciones de todos los objetos de base de datos en el **diccionario de datos** y estas definiciones están accesibles para todos los usuarios de la base de datos así como la base de datos en sí.

- ¿Se ha preguntado alguna vez cómo sabe Oracle qué columnas devolver de una consulta?
- Por ejemplo, si especifica SELECT * FROM jobs en lugar de SELECT job_id, job_title FROM jobs, ¿Cómo sabe Oracle qué columnas devolver?
- La base de datos busca la definición de la tabla utilizada la consulta, traduce el "\*" en la lista completa de columnas, y devuelve el resultado.

- **La base de datos utiliza el diccionario de datos para todas las sentencias que emita, incluso aunque enumere los nombre de columna en lugar de utilizar "\*".**
- Comprueba que las tablas a las que hace referencia en la sentencia existen en la base de datos, comprueba que los nombres de columna sean correctos, comprueba si tiene privilegios correctos para realizar la acción que está solicitando y, finalmente, utiliza el diccionario de datos para decidir el plan de ejecución, cómo realizará en realidad la solicitud.

> [!NOTA]
> Todos los usuarios de la base de datos pueden consultar el diccionario de datos.
> DESC table;
### **Creación de una Tabla**
- Todos los datos de una base de datos relacional se almacena en tablas.
- Al crear una nueva tabla, utilice las siguientes reglas para los nombres de tabla y columnas:
	- Deben empezar con una letra
	- Deben tener entre 1 y 30 caracteres
	- Deben contener A-Z, a-z, 0-9, _, $ y #
	- No deben ser duplicado de otro nombre de otro objeto propiedad del mismo usuario.
	- No deben ser una palabra reservada de Oracle Server
#### Reglas de Nomenclatura
- Es mejor utilizar nombres descriptivos para las tablas y otros objetos de la base de datos.
- Los nombres de las tablas no son sensibles a mayúsculas/minúsculas.
- Por ejemplo, ALUMNOS se trata igual que AlUmNoS o alumnos
- Los nombres de las tablas deben ser en plural
- **La creación de tablas forma parte del lenguaje de definición de datos (DDL) SQL.**
- En las sentencias DDL que se utilizan para configurar, cambiar y eliminar estructuras de datos de tablas, se incluye ALTER, DROP, RENAME Y TRUNCATE.

- Para crear una nueva tabla, debe tener el privilegio CREATE TABLE y un área de almacenamiento para él.
- El administrador de la base de datos utiliza sentencias de lenguaje de control de datos (DCL) para otorgar este privilegio a los usuarios y asignar un área de almacenamiento.
- Las tablas que pertenecen a otros usuarios no se incluyen en su esquema.

- Si desea utilizar una tabla que no está en su esquema, utilice el nombre del propietario de la tabla como el prefijo para el nombre de tabla:

```
SELECT * FROM user.table;
```
### Sintaxis de **CREATE TABLE**

```
CREATE TABLE my_cd_collection
(cd_number NUMBER(3),
title VARCHAR2(20),
artist VARCHAR2(20),
purchase_date DATE DEFAULT SYSDATE);
```
### Tablas Externas
- Oracle también soporta otro tipo de tabla: tabla externa
- En una tabla externa, las filas de datos no están en los archivos de la base de datos, sino que en su lugar se encuentran en un archivo plano, almacenado de forma externa a la base de datos.
- Normalmente, una tabla externa se utiliza para almacenar datos migrados de versiones anteriores de las bases de datos utilizadas por una compañía.

- Cuando una compañía implanta una nueva aplicación y base de datos, suele tener que importar la mayoría de los datos de los sistemas antiguos al nuevo sistema para el acceso de lectura y escritura normal, pero puede haber algunos datos que no se utilicen con frecuencia y, por lo tanto, solo se tenga que acceder a ellos para la lectura.
- Este tipo de dato podría alojarse en una tabla externa.

- Una de las principales ventajas de Oracle es que solo se tiene que hacer una copia de seguridad una vez de los datos alojados en tablas externas y, a continuación, nunca más o menos que el contenido del archivo cambie.
- **La sintaxis para crear una tabla externa es similar a las de crear una tabla estándar, excepto por el hecho de que tiene una sintaxis adicional al final.**
### Tablas Externas
- La nueva sintaxis no se utiliza en sentencias SQL estándar para la creación de las tablas.

- **ORGANIZATION EXTERNAL:** Indica a Oracle que cree una nueva tabla externa.
- **TYPE ORACLE LOADER:** De tipo Oracle Loader (Producto Oracle).
- **DEFAULT DIRECTORY def_dir1:** Nombre del directorio para el archivo.
- **ACCESS PARAMETERS:** Cómo leer el archivo.
- **RECORDS DELIMITED BY NEWLINE:** Cómo identificar el principio de una nueva fila.
- **FIELDS:** Especificaciones de nombre de campo y tipo de dato.
- **LOCATION:** Nombre del archivo real que contiene los datos.

```
CREATE TABLE emp_load(
	employee_number CHAR(5),
	employee_dob CHAR(20),
	employee_last_name CHAR(20),
	employee_first_name CHAR(15),
	employee_middle_name CHAR(15),
	employee_hire_date DATE
)	
ORGANIZATION EXTERNAL(
	TYPE ORACLE LOADER
	DEFAULT DIRECTORY def_dir1
	ACCESS PARAMETERS(
		RECORDS DELIMITED BY NEWLINE
		FIELDS(
			employee_number CHAR(2),
			employee_dob CHAR(20),
			employee_last_name CHAR(18),
			employee_first_name CHAR(11),
			employee_middle_name CHAR(11),
			employee_hire_date CHAR(10) date_format DATE mask "mm/dd/yyy"
		)
	)
	LOCATION ('info.dat')
);
```
### Data Dictionary
- Existen dos tipos de tablas en una base de datos Oracle: tablas de usuario y tablas de diccionario de datos.
- Se pueden emitir sentencias SQL para acceder a ambos tipos de tablas: puede seleccionar, insertar, actualizar y suprimir datos de las tablas de usuario y puede seleccionar datos de la tabla de diccionario de datos.

- Las tablas de diccionario de datos son propiedad de un usuario de Oracle especial llamado SYS y solo se deben utilizar sentencias SELECT al trabajar con cualquiera de estas tablas.
- Para proteger a estas tablas del acceso accidental de usuario, todas tienen vistas creadas a través de las que los usuarios de la base de datos acceden al diccionario de datos.

- Si cualquier usuario de Oracle intenta realizar inserciones, actualizaciones o supresiones en una de las tablas de diccionario de datos, no se permite la operación ya que puede poner en peligro la integridad de toda la base de datos.
- **Al utilizar las vistas del diccionario de datos en la interfaz SQL Commands, debe saber los nombres de las vistas del diccionario con las que está trabajando.**

```
SELECT table_name, status
FROM USER_TABLES;

SELECT table_name, status
FROM ALL_TABLES;

SELECT * FROM user_objects
WHERE object_type = 'SEQUENCE';

SELECT * FROM user_indexes;
```

> [!NOTA]
> - Es posible crear una tabla usando subconsultas.
> - Las tablas externas creadas se pueden acceder con sentencias SQL normales

# Uso de Tipos de Datos
-----------------

- Crear una tabla utilizando los tipos de datos de columna TIMESTAMP y TIMESTAMP WITH TIME ZONE.
- Crear una tabla utilizando los tipos de dato de columna INTERVAL YEAR TO MONTH e INTERVAL DAY TO SECOND.
- Dar ejemplos de organizaciones y situaciones personales en las que es importante conocer a que zona horaria se refiere una valor de fecha y hora.
- Enumerar y dar ejemplo de cada uno de los tipos de dato de número, fecha y carácter.

- Los distintos tipos de dato tienen tipos diferentes de características, cuyo objetivo es almacenar de manera eficaz los datos.
### Visión General de Tipo de Dato
- Cada valor manipulado por Oracle tiene un tipo de dato
- El tipo de dato de un valor asocia un juego fijo de propiedades al valor.
- Estas propiedades hacen que la base de datos trate los valores de un tipo de dato de forma diferente a valores de otro tipo de dato.

- Los distintos tipos de dato ofrecen varias ventajas:
	- Las columnas de un solo tipo producen resultados consistentes.
	- Las columnas del tipo de dato DATE siempre producen valores de fecha.
	- No se puede insertar el tipo de dato incorrecto en una columna. Por ejemplo, las columnas del tipo de dato DATE impedirán que se inserten datos de tipo NUMBER.
- Por este motivo, cada columna de una base de datos relacional solo puede contener un tipo de dato.
- No puede combinar tipos de datos en una columna.
### Tipos de Dato Comunes
- A continuación se muestran los tipos de dato de columna más utilizados para los valores de carácter y número.
- Para carácter:
	- CHAR(tamaño fijo, máximo de 2000 caracteres)
	- VARCHAR2(tamaño variable, máximo 32,767 caracteres)
	- CLOB(tamaño variable, máximo de 128 terabytes)
- Para valores de número:
	- NUMBER(tamaño variable, precisión máxima de 38 dígitos)
- Para valores de fecha y hora:
	- DATE
	- TIMESTAMP
	- INTERVAL
- Para valores binarios(p. ej., multimedia: JPG, WAV, MP3, etc.):
	- RAW(tamaño variable, máximo de 2000 bytes)
	- BLOB(tamaño variable, máximo de 128 terabytes)

- Para valores de caracteres, normalmente es mejor utilizar VARCHAR2 O CLOB que CHAR, porque se ahorra espacio.
- Los valores de número pueden ser negativos, así como positivos.
### Tipos de Dato DATE-TIME
- El tipo de dato **DATE** almacena un valor de siglos hasta segundos enteros, pero no se pueden almacenar las fracciones de un segundo.
- El tipo de dato **TIMESTAMP** es una extensión del tipo de dato DATE que permite fracciones de segundo.
- Por ejemplo, TIMESTAMP(3) permite 3 dígitos después de los segundos completos, lo que permite almacenar valores de hasta milisegundos.

```
CREATE TABLE time_ex1 
(exact_time TIMESTAMP);

INSERT INTO time_ex1
VALUES ('10-Jun-2017 10:52:29.123456'); --> GUARDA MILISEGUNDOS

INSERT INTO time_ex1
VALUES (SYSDATE); --> NO GUARDA MILISEGUNDOS.

INSERT INTO time_ex1
VALUES (SYSTIMESTAMP); --> GUARDA MILISEGUNDOS
```
### TIMESTAMP ... With [LOCAL] Time Zone
- En las organizaciones globalizadas actuales que operan en muchos países distintos, es importante saber a qué zona horaria hacer referencia un valor de fecha-hora.
##### TIMESTAMP WITH TIME ZONE
- TIMESTAMP WITH TIME ZONE almacena un valor de zona horaria como un desplazamiento de la Hora Universal Coordinada o UCT(también conocida como Hora Media de Greenwich o GMT).
- **Un valor "21-Aug-2003 08:00:00 -5:00" significa 8:00 a.m. 5 horas debajo de UTC**
- **Esta es la hora oficial Orientas de EE. UU. (EST).**

```
CREATE TABLE time_ex2
(time_with_offset TIMESTAMP WITH TIME ZONE);

INSERT INTO time_ex2
VALUES (SYSTIMESTAMP);

INSERT INTO time_ex2
VALUES ('10-Jun-2017 10:52:59.123456 AM +2:00');
```
##### TIMESTAMP WITH LOCAL TIME ZONE
- TIMESTAMP WITH LOCAL TIME ZONE es similar, pero con una diferencia: si esta columna se selecciona en una sentencia SQL, la hora se convierte automáticamente a la zona horaria del usuario que realiza la selección.

```
CREATE TABLE time_ex3
(first_column TIMESTAMP WITH TIME ZONE,
second_column TIMESTAMP WITH LOCAL TIME ZONE);

INSERT INTO time_ex3
	(first_column, second_column)
VALUES
	('15-Jul-2017 08:00:00 AM -07:00','15-Nov-2007 08:00:00');
```
### Tipos de Dato Interval
- Estos almacenan el tiempo o intervalo de tiempo transcurrido entre dos valores de fecha y hora.
- **INTERVAL YEAR TO MONTH almacena un período de tiempo medido en años y meses.**
- **INTERVAL DAY TO SECOND almacena un período de tiempo medido en días, horas, minutos y segundos.**

```
CREATE TABLE time_ex4(
loan_duration INTERVAL YEAR(3) TO MONTH,
loan_duration INTERVAL YEAR(2) TO MONTH
);

INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (INTERVAL '120' MONTH(3), INTERVAL '3-6' YEAR TO MONTH);
```

# Modificación en una Tabla
------------------------

**Objetivos:**
- Explicar por qué es importante poder modificar una tabla.
- Explicar y proporcionar un ejemplo para cada una de las sentencias DDL (ALTER, DROP, RENAME y TRUNCATE) y el efecto que tiene cada una en las tablas y columnas.
- Construir una consulta y ejecutar los comandos ADD, MODIFY y DROP de ALTER TABLE.
- Explicar y ejecutar FLASHBACK QUERY en una tabla.
- Explicar y realizar operaciones FLASHBACK table.

- Seguimiento de los cambios en los datos a lo largo del tiempo.
- Explicas los motivos para utilizar TRUNCATE frente a DELETE en las tablas.
- Agregar un comentario a una tabla utilizando el comando COMMENT ON TABLE.
- Enumerar los cambios que se pueden y no se pueden realizar en una tabla.
- Explicar cuándo y por qué la sentencia SET UNUSED es ventajosa.
### ALTER TABLE: Agregación de una Columna
Las sentencias ALTER TABLE se usan para:
- Agregar una nueva columna
- Modificar una columna existente
- Definir un valor DEFAULT para una columna
- Borrar una columna

- Puede agregar o modificar una columna en una tabla, pero no puede especificar donde aparece la columna.
- Una columna recién agregar siempre se convierte en la última columna de la tabla.
- Si una columna ya tiene filas de datos y agrega una nueva columna a la tabla, la nueva columna inicialmente será nula para todas las filas ya existentes.

```
ALTER TABLE my_cd_collection
ADD (release_date DATE DEFAULT SYSDATE);
```
### ALTER TABLE: Modificación de una Columna
La modificación de una columna puede incluir cambios en el tipo de dato, tamaño y valor DEAFULT de una columna.

Las reglas y las restricciones al modificar una columna son las siguientes:
- Puede aumentar el ancho o la precisión de una columna numérica.
- Puede aumentar el ancho de una columna de caracteres.
- Puede reducir el ancho de una columna NUMBER si la columna contiene únicamente valores nulos o si las tabla no tiene filas.
- Para tipos VARCHAR, puede reducir el ancho hasta el mayos valor incluido en la columna.

- Puede cambiar el tipo de dato si la columna contiene valores nulos.
- Solo puede convertir una columna CHAR a VARCHAR2 y viceversa si la columna contiene valores nulos, o bien si no cambia el tamaño a algo más pequeño que cualquier valor de la columna.
- El cambio del valor DEFAULT de una columna solo afecta a las inserciones posteriores en la tabla.

```
ALTER TABLE mod_emp
MODIFY (last_name VARCHAR(30));

ALTER TABLE mod_emp
MODIFY (salary NUMBER(8,2) DEFAULT 50);
```
### ALTER TABLE: Borrado de una Columna
Al borrar una columna se aplican las siguientes reglas:
- Se puede borrar una columna que contenga datos
- Solo se puede borrar una columna a la vez
- No puede borrar todas las columnas de una tabla; debe permanecer al menos una columna.
- Una vez borrada la columna, los valores de datos de esta no se pueden recuperar.

```
ALTER TABLE my_cd_collection
DROP COLUMN release_date;
```
### **SET UNUSED para Columnas**
- Borrar una columna de una tabla grande puede llevar mucho tiempo.
- Una alternativa más rápida es marcar la columna como no utilizable.
- Los valores de la columna permanecen en la base de datos, pero no se puede acceder a ellos de ninguna forma, por lo que el efecto es el mismo que borrar la columna.
- De hecho, **puede agregar una nueva columna a la base de datos con el mismo nombre que la columna no utilizada.**
- Las columnas no utilizadas existen, pero son invisibles.

```
ALTER TABLE copy_employees
SET UNUSED (email);
```

 - **DROP UNUSED COLUMNS** elimina todas las columnas marcadas actualmente como no utilizadas.
 - Utilice esta sentencia cuando desee reclamar el espacio en disco adicional de las columnas no utilizadas en una tabla 

```
ALTER TABLE copy_employees
DROP UNUSED COLUMNS;
```
### **DROP TABLE**

- Elimina la definición de una tabla.
- La base de datos pierde todos los datos de la tabla y los índices asociados a los mismos.
- Cuando se emite una sentencia DROP TABLE:
	- Se suprimen todos los datos de la tabla.
	- Se elimina la descripción de la tabla del diccionario de datos.
- Oracle Server no cuestiona la decisión, y elimina la tabla inmediatamente.

- Solo el creador de la tabla o un usuario con el privilegio DROP ANY TABLE (normalmente solo el DBA) puede eliminar una tabla

```
DROP TABLE copy_employees;
```
### **FLASHBACK TABLE**
- Si borra una tabla por error, puede recuperar esa tabla y sus datos.
- Cada usuario de la base de datos tiene su propia papelera de reciclaje a la que se mueven los objetos borrados y que se pueden recuperar de aquí con el comando FLASHBACK TABLE.
- Este comando se puede usar para restaurar una tabla, una vista o un índice que se haya borrado por error.

```
FLASHBACK TABLE copy_employees TO BEFORE DROP;
```

- Como propietario de una tabla, puede emitir el comando de FLASHBACK y si la tabla que está restaurando tenía índices, estos también se restaurarán.
- **Es posible ver los objetos que se pueden restaurar consultando la vista del diccionario de datos USER_RECYCLEBIN**

Se puede consultar la vista USER_RECYCLEBIN como todas las demás vistas del diccionario de datos:
```
SELECT original_name, operation, droptime FROM user_recyclebin;
```

- Una vez restaurada una tabla con el comando FLASHBACK TABLE, ya no está visible en la vista USER_RECYCLEBIN.
- Cualquier índice que se borrara con la tabla original también se restaurará.

- Puede que sea necesario (por motivos de seguridad) borrar una tabla completamente, omitiendo la papelera de reciclaje.
- **Esto se puede hacer agregando la palabra clave PURGE:**

```
DROP TABLE copy_employees PURGE;
```
### **RENAME**
- Para cambiar el nombre de una tabla, utilice la sentencia RENAME.
- Esto solo lo puede hacer el propietario del objeto o el DBA.

```
RENAME old_name TO new_name;
RENAME my_cd_collection TO my_music;
```
### **TRUNCATE**
- Al truncar una tabla, se eliminan todas las filas de una tabla y se libera el espacio de almacenamiento utilizado por dicha tabla.
- Al utilizar la sentencia TRUNCATE TABLE:
	- No se puede realizar ROLLBACK de la eliminación de filas.
	- Debe ser el propietario de la tabla o tener privilegios de sistema DROP ANY TABLE.

```
TRUNCATE TABLE tablename;
```

- Con la sentencia DELETE también se eliminan todas las filas de una tabla, pero no se libera el espacio de almacenamiento.
- TRUNCATE es más rápido que DELETE porque no genera información de ROLLBACK.
### COMMENT ON TABLE
Puede agregar un comentario de hasta 2,000 caracteres sobre una columna, tabla o vista mediante la sentencia COMMENT.

```
-- CREAR UN COMENTARIO
COMMENT ON TABLE employees IS 'Western Region Only';

-- VER EL COMENTARIO DE UNA TABLA
SELECT table_name, comments FROM user_tab_comments;

-- ELIMINAR EL COMENTARIO DE UNA TABLA
COMMENT ON TABLE employees IS '';
```
### FLASHBACK QUERY 
- Puede que detecte que los datos en una tabla se han cambiado, de algún modo, de forma incorrecta.
- Oracle tiene la función que permite ver los datos de fila en momentos concretos en el tiempo, por lo que puede comparar diferentes versiones de una fila a lo largo del tiempo.
- Esta función es muy útil.

- Puede usar las función FLASHBACK QUERY para examinar que aspecto tenían las filas ANTES de que se aplicaran esos cambios.
- Cuando Oracle cambia datos, siempre mantiene una copia del aspecto de los datos corregidos antes de que se realizara cualquier cambio.
- Por lo que mantiene una copia del valor anterior de la columna para una actualización de columna, mantiene toda la fila para una supresión y no mantiene nada para una sentencia de inserción.

- Estas copias antiguas se mantienen en un lugar especial denominado tablespace UNDO.
- Los usuarios pueden acceder a esta zona especial de la base de datos mediante una consulta de flashback.
- Puede consultar las versiones anteriores de los datos utilizando la cláusula VERSIONS en una sentencia SELECT.

![[Pasted image 20241108094815.png]]










































































































































