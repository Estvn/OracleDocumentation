
# SECUENCIAS Y SINÓNIMOS

# Trabajar Con Secuencias
-----------------

**Objetivos:**
- Enumerar al menos tres características útiles de una secuencia.
- Escribir y ejecutar una sentencia SQL que crea una secuencia.
- Consultar del diccionario de datos mediante USER_SEQUENCES para confirmar la definición de una secuencia.
- Aplicar las reglas para utilizar NEXTVAL a fin de generar números únicos secuenciales en una tabla.
- Enumerar las ventajas y desventajas del almacenamiento en caché de los valores de secuencia.
- Nombrar tres motivos por lo que se pueden producir intervalos en una secuencia.

- **SQL tiene un proceso para generar automáticamente números únicos que elimina la preocupación por los detalles de números duplicados.**
- **El proceso de numeración se maneja a través de un objeto de base de datos denominado SEQUENCE.**
### Objeto **SEQUENCE**

- Ya sabe como crear dos tipos de objetos de base de datos, TABLE y VIEW. Un tercer objeto de la base de datos es SEQUENCE.
- **SEQUENCE es un objeto que se puede compartir utilizado para generar automáticamente números únicos.**
- Varios usuarios pueden acceder a un objeto SEQUENCE.
- Normalmente, se utilizan secuencias para crear un valor de la clave primaria.

- Como recordará, claves primarias deben ser únicas para cada fila. La secuencia se genera y aumenta (o disminuye) mediante una rutina interna de Oracle.
- Este objeto ahorra tiempo porque reduce la cantidad de código que tiene que escribir.

- **Los números de secuencia se almacenan y generan independientemente de las tablas.**
- Por lo tanto, la misma secuencia se puede utilizar para varias tablas.

Sintaxis de la SECUENCIA:
```
CREATE SEQUENCE sequence
{INCREMENT BY n}
{START WITH n}
{MAXVALUE n | NOMAXVALUE}
{MINVALUE n | NOMINVALUE}
{CYCLE | NOCYCLE}
{CACHE n | NOCACHE};
```

> [!NOTA]
>{CACHE | NOCACHE}: Especifica cuántos valores asigna previamente y mantiene Oracle Server en la memoria (Por defecto, Oracle Server almacena en caché 20 valores). Si el sistema falla, los valores se pierden.
### **Creación de Secuencias**

```
CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NOCACHE
NOCYCLE;
```

- La opción NOCACHE evita que los valores de SEQUENCE se almacenen en la caché de la memoria, con lo que, en caso de fallo del sistema, se evitaría que se perdieran los números asignados previamente y retenidos en la memoria.
- No utilice la opción **CYCLE** si la secuencia se utiliza para generar valores de clave primaria, a menos que disponga de un mecanismo fiable que suprima las filas antiguas más rápido de lo que se agregan las nuevas.
### Confirmación de Secuencias

- Para verificar que la secuencia se ha creado, consulte el diccionario de datos USER_OBJECTS-
- Para ver toda la configuración de SEQUENCE, consulte el diccionario de datos USER_SEQUENCES.

```
SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;
```
### **Pseudocolumnas NEXTVAL y CURRVAL**

- La pseudocolumna NEXTVAL se utiliza para extraer números de secuencia sucesivos de una secuencia especificada.
- Debe cualificar a NEXTVAL con el nombre de la columna.
- **Al hacer referencia a sequence.NEXTVAL, se genera un nuevo número de secuencia y el actual se sustituye a CURRVAL.**

```
INSERT INTO employees (employee_id, department_id, ...)
VALUES (employees_seq.NEXTVAL, dept_deptid_seq.CURRVAL, ...);
```

- **NEXTVAL** se debe utilizar para generar un número de secuencia en la sesión del usuario actual antes de que se pueda hacer referencia a CURRVAL.
- Se debe cualificar a **CURRVAL** con el nombre de la secuencia.
### **Uso de una Secuencia**

- Después de crear una secuencia, se generan números secuenciales para utilizarlos en las tablas. Haga referencia a los valores de secuencia mediante las pseudocolumnas NEXTVAL y CURRVAL.
- Se puede utilizar NEXTVAL y CURRVAL en los siguientes contextos:
	- La lista SELECT de una sentencia SELECT que no forme parte de la subconsulta.
	- La lista SELECT de una subconsulta de la sentencia INSERT.
	- La cláusula VALUES de la sentencia INSERT.
	- La cláusula SET de la sentencia UPDATE.

```
INSERT INTO runners
	(runner_id, first_name, last_name)
VALUES
	(runner_id_seq.NEXTVAL, 'Adam', 'Curtis');
```

- **Para ver el valor actual de la secuencia de usa CURRVAL.**
- Las secuencias almacenadas en la caché de la memoria permiten un acceso más rápido a los valores de secuencia.
- La caché se rellena la primera vez que se hace referencia a la secuencia.
- Las solicitudes del siguiente valor de secuencia se recuperan de la secuencia almacenada en la caché.
- Después de utilizar el último valor de la secuencia, la siguiente solicitud de la secuencia introduce otra caché de secuencias en la memoria.
- 20 es el número por defecto de los números de secuencia almacenados en la caché.
### Números no Secuenciales

- Aunque los generadores de secuencias emiten números secuenciales sin intervalos, esta acción se realiza independientemente de que se realice una confirmación o un rollback de la base de datos.
- Los intervalos (números no secuenciales) se puede generar:
	- Al realizar un rollback de una sentencia que contiene una secuencia, se pierde el número.
	- Un fallo en el sistema. Si la secuencia almacenada en la caché, los valores en la memoria y el sistema falla,  dichos valores se pierden.
	- El uso de la misma secuencia para varias tablas. Si lo hace así, cada tabla puede tener intervalos en los números secuenciales.
### Modificación de una Secuencia

- Al igual que con otros objetos de la base de datos que ha creado, SEQUENCE también se puede cambiar mediante la sentencia **ALTER SEQUENCE**.
- No puede ejecutar un nuevo valor MAXVALUE menor que el número de secuencia actual.
- La opción START WITH no se puede cambiar mediante ALTER SEQUENCE. La secuencia se debe borrar y volver a crear para reiniciar la secuencia en un número diferente.

```
ALTER SEQUENCE runner_id_seq
			INCREMENT BY 1
			MAX VALUE 999999
			NOCACHE
			NOCYCLE;
```
### Eliminación de Secuencias

Debe ser propietario de la secuencia o tener el privilegio DROP ANY SEQUENCE para eliminarla.
```
DROP SEQUENCE seq_name;
```

# índices y Sinónimos
--------------------

**Objetivos:**
- Definir un índice y su uso como un objeto de esquema.
- Nombrar las condiciones que causan que se cree un índice automáticamente.
- Crear y ejecutar una sentencia CREATE INDEX y DROP INDEX.
- Crear y ejecutar un índice basado en funciones.
- Creación de sinónimos Privados y Públicos.

- Para cada consulta, se produce una exploración de la tabla completa.
- No existe una forma para que la búsqueda de datos en una base de datos sea más eficaz.
- **Oracle utiliza un índice para acelerar la recuperación de filas.**
- Aprenderá cómo y cuándo crear un índice, además de cómo suprimir un índice.
- Aprenderá a crear nombres fáciles de recordar para los objetos de base de datos.
### **INDEX**
- **Un índice de Oracle Server es un objeto de esquema que puede acelerar la recuperación de filas mediante un puntero. Los índices se pueden crear explícita o automáticamente.**
- Si no hay un índice en la columna seleccionada, se produce una exploración de tabla completa.
- **Un índice proporciona acceso directo y rápido a las filas de una tabla.**
- Su finalidad es reducir la necesidad de E/S de disco mediante una ruta de acceso indexada para buscar datos de forma más rápida.

- El índice los utiliza y mantiene automáticamente Oracle Server. Una vez creado un índice, no será necesaria ninguna intervención directa por parte del usuario.
- Un ROWID es una representación de cadena en base 64 de la dirección de la fila que contiene el identificador de bloque, la ubicación de la fila en el bloque y el identificador de archivo de la base de datos.
- Los índices utilizan los ROWID porque son la forma más rápida para acceder a cualquier fila completa.

- Los índices son lógica y físicamente independientes de la tabla que indexan.
- Esto significa que se pueden crear y borrar en cualquier momento sin que afecten a las tablas base o a otros índices.

> [!NOTA]
> Al borrar una tabla, se borran también los índices correspondientes
### Tipos de índices
Se pueden crear dos tipos de índices:
##### índice único
- **Oracle Server crea automáticamente este índice al definir una restricción de clave PRIMARY KEY o UNIQUE en una columna de tabla.**
- El nombre del índice es el nombre proporcionado a la restricción.
- Aunque puede crear manualmente un índice único, se recomienda crear una restricción única en la tabla, que implícitamente crea el índice único.
##### índice no único
- Es es un índice que un usuario puede crear para acelerar el acceso a las filas.
- **Por ejemplo, para optimizar las uniones, puede crear un índice en la columna FOREIGN KEY, que acelera la búsqueda de las filas coincidentes en la columna PRIMARY KEY.**
### **Creación de índices**
Para crear un índice en cualquier esquema, debe tener el privilegio CREATE ANY INDEX.

Para crear un índice en una o más columnas, emita la sentencia CREATE INDEX:
```
CREATE INDEX index_name
ON table_name(column1, column2, ...);
```

Para crear un índice en su esquema, debe cumplirse una de las siguiente condiciones:
- La tabla debe estar en su esquema.
- Debe tener el privilegio de objeto INDEX en la tabla que desea indexar.
- Debe tener el privilegio del sistema CREATE ANY INDEX.

Para mejorar la velocidad de acceso de consulta a la columna REGION_ID de la tabla WF_COUNTRIES:
```
CREATE INDEX wf_cont_reg_id_idx
ON wf_countries(region_id);
```
### **¿Cuándo Crear un índice?**
Se debe crear un índice solo si:
- La columna contiene una amplia cantidad de valores.
- Una columna contiene una gran cantidad de valores nulos.
- Una o más columnas se utilizan con frecuencia en conjunto en una cláusula WHERE o una condición de unión.
- La tabla es grande y se espera que la mayoría de las consultas recuperen menos del 2 al 4% de las filas.
### **Cuándo no Crear un índice**
- Cuando decida si crear un índice, más no siempre es mejor.
- Cada operaciones DML que se realiza en una tabla con índices implica la actualización de los índices.
- Cuanto mayor sea el número de índices asociados a una tabla, mayor será el esfuerzo para actualizar todos los índices después de cada operación DML.

Por lo general , no merece la pena crear un índice si:
- La tabla es pequeña.
- No se suelen utilizar las columnas como condición de consulta.
- Se espera que la mayoría de las consultas recuperen más del 2 al 4% en la tabla.
- La tabla se actualiza con frecuencia.
- Se hace referencia a las columnas indexadas como parte de una expresión.
### **índices Compuestos**
- Un índice compuesto (también denominado índice concatenado) es un índice creado en varias columnas de una tabla.
- Las columnas del índice compuesto pueden aparecer en cualquier orden y no es necesario que sean adyacentes a la tabla.
- Los índices compuestos pueden acelerar la recuperación de datos para las sentencias SELECT en las que la cláusula WHERE hace referencia a todas o a la parte inicial de las columnas del índice compuesto.

```
CREATE INDEX emps_name_idx
ON employees(first_name, last_name);
```

- Los valores nulos no se incluyen en el índice compuesto.
- **Para optimizar las uniones, puede crear un índice en la columna FOREIGN KEY, que acelera la búsqueda de las filas coincidentes en la columna PRIMARY KEY.**

> [!NOTA]
> El optimizador no utiliza un índice si la cláusula WHERE contiene la expresión IS NULL.
##### Confirmación de índices
- Confirme la existencia de los índices de la vista del diccionario de datos USER_INDEXES.
- También puede comprobar las columnas implicadas en un índice mediante la consulta de la vista USER_IND_COLUMNS.
### índices Basados en Funciones
- Un índice basado en funciones almacena valores indexados y utiliza el índice basado en una sentencia SELECT para recuperar los datos.
- Un índice basado en funciones es un índice basado en expresiones.
- La expresión del índice se genera a partir de las columnas de las tablas, restricciones, funciones SQL y funciones definidas por el usuario.

- Los índices basados en funciones son útiles cuando no sabe en qué caso los datos se han almacenado en la base de datos.
- Por ejemplo, puede crear un índice basado en funciones que se pueda utilizar con una sentencia SELECT utilizando UPPER en la cláusula WHERE.

El índice se utilizará en esta búsqueda:
```
CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));

SELECT * FROM employees 
WHERE UPPER(last_name) = 'KING';
```

- Los índices basado en funciones definidos con las palabras clave UPPER(column_name) o LOWER(column_name) permiten realizar búsquedas no sensibles a mayúscula o minúsculas.
- Cuando se modifica una consulta mediante una expresión en la cláusula WHERE, el índice no se utilizará a menos que cree un índice basado en funciones para que coincida con la expresión

> [!NOTA]
> **Para garantizar que Oracle Server utiliza el índice en lugar de realizar una exploración de tabla completa, asegúrese de que el valor de la función no sea nulo en consultas posteriores.**

```
SELECT * FROM employees
WHERE UPPER(last_name) IS NOT NULL
ORDER BY UPPER(last_name);
```

- Las columnas marcadas como DESC se ordenan en orden descendente.
- Todos los ejemplos usan las funciones UPPER y LOWER, pero cabe señalar que, aunque estas dos se utilizan con mucha frecuencia en los índices basado en funciones, la base de datos Oracle no se liminar a ellos.
- Se puede utilizar cualquier función incorporada Oracle, por ejemplo, TO_CHAR

Una vez que creamos el siguiente índice basado en funciones, podemos ejecutar la misma consulta, pero esta vez evitando la costosa exploración de la tabla completa.
```
CREATE INDEX emp_hire_year_idx
ON employees (TO_CHAR(hire_date, 'yyyy'));

SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '1987';
```
### Eliminación de índices
- No puede modificar los índices
- **Para cambiar un índice, debe borrarlos y volver a crearlo.**
- Elimine una definición de índice del diccionario de datos mediante la sentencia DROP INDEX.

- Para borrar un índice, debe ser el propietario del mismo o tener el privilegio DROP ANY SEQUENCE.
- Si borra una tabla, los índices y las restricciones se borran automáticamente, pero permanecen las vistas y las secuencias.

```
DROP INDEX upper_last_name_idx;
```
### **SYNONYM**
- En SQL, como en el lenguaje, un sinónimo es una palabra o expresión que es un sustituto aceptado de otra palabra. 
- Los sinónimos se utilizan para simplificar el acceso a objetos creando otro nombre para el objeto.
- **Los sinónimos pueden hacer referencia a una tabla propiedad de otro usuario de forma más sencilla y reducir los nombres de los objetos.**

- Con la creación de un sinónimo se elimina la necesidad de cualificar el nombre del objeto con el esquema y se ofrecen nombres alternativos para las tablas, vistas, secuencias, procedimientos u otros objetos.

- **Este objeto es especialmente útil con nombres de objetos largos, como las vistas.**
- El administrador de la base de datos puede crear un sinónimo público accesible para todos los usuarios y puede otorgar específicamente el privilegio CREATE PUBLIC SYNONYM a cualquier usuario, y dicho usuario puede crear sinónimos públicos.

```
CREATE {PUBLIC} SYNONYM synonym FOR object; 
```

> [!NOTA]
> - PUBLIC: Crea un sinónimo al que pueden acceder todos los usuarios.
> - synonym: Es el nombre del sinónimo que se va a crear.
> - object: Identifica el objeto para el que se crea el sinónimo
###### Instrucciones
- No puede estar dentro de un paquete.
- Un nombre de sinónimo privado debe ser distinto de todos los demás objetos propiedad del mismo usuario.
- La existencia de sinónimos se puede confirmar consultando la vista del diccionario de datos USER_SYNONYMS.

```
DROP {PUBLIC} SYNONYM name_of_synonym;
```





