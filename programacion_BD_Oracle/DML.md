
# **DML**

# Sentencia INSERT
---------------

**Objetivos:**
- Explicar la importancia de poder modificar los datos de una base de datos.
- Construir y ejecutar sentencias INSERT que insertan una única fila con una cláusula VALUES.
- Construir y ejecutar sentencias INSERT que utilizan valores especiales, valores nulos y valores de fecha.
- Construir y ejecutar sentencias INSERT que copian filas de una tabla a otra mediante una subconsulta.
---------------------

- En las empresas, las bases de datos son dinámicas.
- Están constantemente en el proceso de inserción, actualización y supresión de datos.
- Si no se realizaran cambios, la base de datos perdería rápidamente su utilidad.
- En esta lección, comenzará a utilizar sentencias de lengua de manipulación de datos (DML) para realizar cambios en una base de datos.
### **Copias de Tablas antes de la Inserción**
- Las copias de tablas no heredarán las reglas de integridad de clave primaria a clave ajena asociadas (restricciones de relación) de las tablas originales.
- Sin embargo, los tipos de datos de columna se heredan de las tablas copias.
### Sintaxis para Crea una Copia de una Tabla

```
CREATE TABLE copy_employees
AS (SELECT * FROM employees);
```

- Para verificar y ver la copia de la tabla, utilice las siguientes sentencias DESCRIBE y SELECT:
```
DESCRIBE copy_employees;
SELECT * FROM copy_employees;
```
### **INSERT**
- La sentencia INSERT se utiliza para agregar una nueva fila a una tabla. La sentencia necesita tres valores:
	- El nombre de la tabla.
	- Los nombres de las columnas de la tabla que se va a rellenar.
	- Los valores correspondientes para cada columna.

- Las sentencias INSERT deben mostrar explícitamente cada columna tal y como aparece en la tabla.
- Los valores para cada columna se muestran en el mismo orden.
- Tenga en cuenta que los valore de número de están entre comillas simples.

```
INSERT INTO copy_departments (department_id, department_name, manager_id, location_id)
VALUES (200, 'Human Resources', 205, 1500);
```

- **Otra forma de insertar valores en una tabla es agregarlos implícitamente omitiendo los nombres de columna.**
- Los valores de cada columna deben coincidir exactamente con el orden por defecto en el que aparecen en la tabla (como se muestra en una sentencia DESCRIBE) y se debe proporcionar un valor para cada columna.
- Sin embargo, para mayor claridad, es mejor utilizar los nombres de columna en una cláusula INSERT.

```
ISNERT INTO copy_departments VALUES (210, 'State Management', 102, 1700);
```
### Comprobación de la Tabla en Primer Lugar
- Antes de insertar datos en una tabla, debe comprobar varios detalles de la tabla.
- La sentencia de nombre de tabla DESCRIBE devolverá una descripción de la estructura de la tabla y el gráfico de resumen de la tabla.
- El resumen de la tabla proporciona información sobre cada columna de la tabla, como:
	- Permiso de valores duplicados.
	- Tipo de dato permitido.
	- Cantidad de datos permitida.
	- Permiso de valores NULL.
### Resumen de la Tabla
- Para los tipos de datos Number, los paréntesis especifican la precisión y la escala.
- La precisión es el número total de dígitos y la escala es el número de dígitos a la derecha de la posición decimal.
### Inserción de Filas con Valores Nulos
- La sentencia INSERT no necesita especificar todas las columnas: se pueden excluir las columnas con valores nulos.
- Si a todas las columnas que necesitan un valor se les asigna un valor, la inserción funciona.
- Si no se agrega valores a un campo que está definido como NOT NULL, se generará un error.

- Una inserción implícita insertará automáticamente un valor nulo en las columnas que permiten valores nulos.
- Para agregar explícitamente un valor nulo a una columna que permite valores nulos, utilice la palabra clave NULL en la lista de VALUES.
- **Para especificar cadenas vacías y fechas que faltan, utilice comillas simples vacías para los datos que falten.**
### Inserción de Valores de Fecha Específicos
- Los valores especiales como SYSDATE y USER se pueden introducir en la lista VALUES de una sentencia INSERT.
- El modelo de formato por defecto para tipos de datos de fecha es DD-Mes-AAAA.
- Con este formato de fecha, la hora por defecto de medianoche (00:00:00) también se incluye.

- Si deseamos insertar una fila con un formato que no sea el formato por defecto para una columna de fecha, debemos utilizar la función TO_DATE para convertir el valor de fecha (cadena de caracteres) en una fecha.

```
TO_DATE('July 8, 2017', 'Month fmdd, yyyy')
```
### **Uso de una Subconsulta para Copiar Filas**
- Cada sentencia INSERT que hemos visto hasta el momento solo agrega una fila a la tabla.
- Sin embargo, suponga que deseamos copiar 100 filas de una tabla a otra. 
- No queremos tener que escribir y ejecutar 100 sentencias INSERT independientes, una tras otra.
- Afortunadamente, SQL nos permite utilizar una subconsulta dentro de una sentencia INSERT.

- Todos los resultados de la subconsulta se insertan en la tabla.
- Por lo tanto podamos copiar 100 filas con una subconsulta de varias filas en INSERT.
- **Como era de esperar, no necesita una cláusula VALUES al utilizar una subconsulta para copiar filas porque los valores insertados serán exactamente los valores devueltos por la subconsulta.**

```
INSERT INTO sales_reps(id, name, salary, commission_pct)
		SELECT employee_id, last_name, salary,commission_pct
	FROM employees
	WHERE job_id LIKE '%REP%';
```

- El número de columnas y sus tipos de dato de la lista de columnas de la cláusula INSERT deben coincidir con el número de columnas y sus tipos de datos de la subconsulta.
- La subconsulta no está incluida entre paréntesis como se hace con las subconsultas en la cláusula WHERE de una sentencia SELECT.


- Si deseamos copiar todos los datos: todas las filas y todas las columnas: la sintaxis es aún más sencilla.
- Para seleccionar todas las filas de la tabla EMPLEADOS e insertarlos en la tabla SALES_REPS, la sentencia se escribe de la siguiente forma:

```
INSERT INTO sales_reps
SELECT * FROM employees;
```
- Esto solo funcionará si ambas tablas tienen el mismo número de columnas que coincida con los tipos de datos y que estén en el mismo orden.

# Actualización de Valores de Columna y Supresión de Filas
--------------------

**Objetivos:**
- Construir y ejecutar una sentencia UPDATE.
- Crear y ejecutar una sentencia DELETE.
- Crear y ejecutar una consulta que utilice una subconsulta para actualizar y suprimir datos de una tabla.
- Crear y ejecutar una consulta que utilice una subconsulta correlacionada para actualizar y suprimir datos de una tabla.
- Explicar cómo las restricciones de integridad de clave ajena y clave primaria afectan a las sentencias UPDATE y DELETE.
- Explicar el objetivo de la cláusula FOR UPDATE en una sentencia SELECT.

- **En las bases de datos, no hay nada permanente excepto el cambio.**
- La actualización, inserción, supresión y gestión de los datos es un trabajo del administrador de bases de datos (DBA).
- En esta lección, se convertirá en el DBA de su propio esquema y aprenderá a gestionar la base de datos.
### **UPDATE**
- Se utiliza para modificar filas existentes de una tabla.
- UPDATE necesita cuatro valores:
	- El nombre de la tabla.
	- El nombre de las columnas cuyos valores se van a modificar.
	- Un nuevo valor para cada una de las columnas que se están modificando.
	- Una condición que identifique las filas de la tabla que se van a modificar.

- El nuevo valor para una columna puede ser el resultado de una subconsulta de una sola fila.
- **Se recomienda que la sentencia UPDATE aparezca sola en una sola línea.**

```
UPDATE copy_employees
SET phone_number = '123456'
WHERE employee_id = 303;
```

- [ ]**Podemos cambiar varias columnas o varias filas en una sentencia UPDATE.**
- En este ejemplo, se cambia el número de teléfono y el apellido de dos empleados.

```
UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'
WHERE employee_id >= 303;
```

> [!WARNING]
> Tenga cuidado al actualizar los valores de columna.
> Si la cláusula WHERE se omite, todas las filas de la tabla se actualizarán.
### Actualización de una Columna con un Valor de una Subconsulta
- Podemos usar el resultado de una subconsulta de una sola fila para proporcionar el valor nuevo para una columna actualizada.

```
UPDATE copy_employees
SET salary = (SELECT salary
				FROM employees
				WHERE employee_id = 100)
WHERE employee_id = 101;
```
### Actualización de dos Columnas 
- Para actualizar varias columnas en una sentencia UPDATE, es posible escribir varias subconsultas de una sola fila, una para cada columna.

```
UPDATE copy_employees
SET salary = (SELECT salary
				FROM copy_employees
				WHERE employee_id = 205),
	job_id = (SELECT job_id
				FROM copy_employees
				WHERE employee_id = 205)
WHERE employee_id = 206;
```
### Actualización de Filas Basada en Otra Tabla
- Como puede que se espere, la subconsulta puede recuperar información de una tabla que, a continuación, se utiliza para actualizar otra tabla.

```
UPDATE copy_employees
SET salary = (SELECT salary
				FROM employees
				WHERE employee_id = 205)
WHERE employee_id = 202;
```
### Actualización de Filas con Subconsulta Correlacionada
- Las subconsultas pueden ser independientes o correlacionadas.
- En una subconsulta correlacionada, actualiza una fila de una tabla según una selección de la misma tabla.

- A continuación, los datos de la tabla de departamentos original se ha recuperado, copiado y utilizado para rellenar la copia de la columna en la tabla copy_employees

```
UPDATE copy_employees e
SET e.department_name = (SELECT d.department_name
						FROM department d
						WHERE e.department_id = d.department_id);
```
### **DELETE**
- Se usa para eliminar filas existentes de una tabla.
- La sentencia necesita dos valores:
	- El nombre de la tabla.
	- La condición que identifica las filas que se van a suprimir.

```
DELETE FROM copy_employees
WHERE employee_id = 303;
```

> [!WARNING]
> Se suprimen todas las filas de la tabla si omite la cláusula WHERE.

- Las subconsultas también se pueden usar en las sentencias DELETE.
- En el siguiente ejemplo, se suprimen las filas de la tabla de empleados para todos los empleados que trabajan en el departamento de envíos. Es posible que el departamento haya cambiado de nombre o se haya cerrado.

```
DELETE FROM copy_employees
WHERE department_id = 
					(SELECT department_id
					FROM departments
					WHERE department_name = 'Shipping'
					);
```

- El ejemplo siguiente elimina las filas de todos los empleados que trabajan para un gerente que administra menos de dos empleados:

```
DELETE FROM copy_employees e
WHERE e.manager_id IN 
	(SELECT d.manager_id
	FROM employees d
	HAVING COUNT(d.department_id) < 2
	GROUP BY d.manager_id);
```
### Errores de Restricción de Integridad
- Las restricciones de integridad garantizan que los datos se ajusten a un juego anidado de reglas.
- **Las restricciones se comprueban automáticamente cada vez que se ejecuta una sentencia DML que puede romper las reglas.**
- Si se rompe una regla, la tabla no se actualiza y se devuelve un error.

- Al modificar las copias de las tablas, es posible que vea errores de restricción de valor no nulo, pero no verá ningún error de restricción de PK ajena.
- El motivo es que la sentencia CREATE TABLE ... AS  (SELECT ...) que se utiliza para crear la copia de la tabla, copia las filas y las restricciones de valores no nulos, pero no copia las restricciones de PK ajena.
- Por tanto, no existe ninguna restricción de clase PK ajena en ninguna de las tablas copiadas.
### **Cláusula FOR UPDATE en una Sentencia SELECT**
- Cuando se emite una sentencia SELECT en una tabla de base de datos, no se emite ningún bloqueo en la base de datos en las filas devueltas por la consulta que está emitiendo.
- La mayoría de las veces, esta es así como desea que se comporte la base de datos, para mantener el número de bloqueos emitidas en un mínimo.
- Sin embargo, **a veces desea asegurarse de que nadie más pueda suprimir o actualizar los registros que la consulta está devolviendo mientras trabaja en esos registros.**

- Entonces es cuando se utiliza la cláusula FOR UPDATE.
- **En cuanto se ejecuta una consulta, la base de datos emitirá automáticamente bloqueos de nivel de fila exclusivos en todas las filas devueltas por la sentencia SELECT, que se mantendrán hasta que se mita un comando COMMIT o ROLLBACK.**

- Si usa una cláusula FOR UPDATE en una sentencia SELECT con varias tablas en ellas, todas las filas de todas las tablas se bloquearán.

```
SELECT e.employee_id, e.salary, d.department_name
FROM employees e JOIN deparments d USING (department_id)
WHERE job_id = 'ST_CLERK' AND location_id = 1500
FOR UPDATE
ORDER BY e.employee_id;
```

# Valores DEFAULT, MERGE e Inserciones en Varias Tablas
-------------------------------

**Objetivos:**
1. Comprender cuándo utilizar un valor DEFAULT
2. Crear y ejecutar una sentencia MERGE
3. Construir y ejecutar sentencias DML utilizando subconsultas
4. Construir y ejecutar inserciones en varias tablas

- Hasta ahora ha estado actualizando los datos mediante una única sentencia INSERT.
- Ha sido relativamente fácil agregar registros uno a uno, pero ¿y si la compañía es muy grande y utiliza datos de registros de ventas, de clientes, de nóminas, de contabilidad y de personal?
- En este caso, es probable que los datos procedan de varios orígenes y estén gestionados por varias personas.
- La gestión de datos registro a registro puede ser muy confuso y llevar mucho tiempo

- ¿Cómo determina lo que se ha insertado nuevo o que se ha cambiado recientemente?
- **En esta lección conocerá un método más eficaz para actualizar e insertar datos utilizando una secuencia de comandos INSERT y UPDATE condicionales en una única tabla de destino.**
- También aprenderá a recuperar datos de una única subconsultas e INSERTAR las filas devueltas en más de una tabla de destino.
- **A medida que amplíe sus conocimientos en SQL, apreciará formas eficaces para realizar su trabajo.**
### **DEFAULT**
- Cada columna de una tabla puede tener un valor por defecto especificado para él.
- **En el caso de que inserte una fila nueva y no haya ningún valor por defecto en lugar de un valor nulo.**
- El uso de los valores por defecto permite controlar dónde y cuándo se debe especificar el valor por defecto.

- El valor por defecto puede ser un valor literal, una expresión o una función SQL como SYSDATE o USER, pero el valor no puede ser el nombre de otra columna.
- **El valor por defecto debe coincidir con el tipo de dato de la columna.**
- Se puede especificar DEAFULT para una columna al crear o modificar la tabla.

```
CREATE TABLE my_employees)
	hire_date DATE DEFAULT SYSDATE,
	first_name VARCHAR2(15),
	last_name VARCHAR(15));
```
- Al agregar filas a esta tabla, SYSDATE se asignará a cualquier fila que no especifique explícitamente un valor en hire_date.
### Uso Implícito y Explícito de DEAFULT en INSERT
- Se puede utilizar valores por defecto explícitos en las sentencias INSERT y UPDATE.

Uso Explícito de DEFAULT:
```
INSERT INTO my_employees
	(hire_date, fisrt_name, last_name)
VALUES
	(DEFAULT, 'Angelina', 'Wright');
```

Uso Implícito de DEFAULT:
```
INSERT INTO my_employees
	(first_name, last_name)
VALUES
	('Angelina', 'Wright');
```
### DEFAULT Explícito con UPDATE
- Se pueden utilizar valores por defecto explícitos en las sentencias INSERT y UPDATE.
- Si se especifica un valor por defecto para la columna hire_date, se asigna a la columna el valor por defecto.
- Sin embargo, si no se ha especificado ningún valor por defecto al crear la columna, se asigna un valor nulo.

```
UPDATE my_employees
SET hire_date = DEAFULT
WHERE last_name = 'Wright';
```

> [!NOTA]
> - En INSERT se pueden agregar valores DEFAULT de forma implícita y explícita.
> - En UPDATE se pueden agregar los valores DEFAULT solo de forma explícita.
### **MERGE**
- El uso de la sentencia MERGE logra dos tareas al mismo tiempo. MERGE INSERTARÁ y ACTUALIZARÁ simultáneamente, Si falta un valor, se inserta uno nuevo.
- Si existe un valor pero se debe cambiar, MERGE lo actualizará.
- Para realizar estos tipos de cambios en tablas de base de datos, debe tener privilegios INSERT y UPDATE en la tabla de destino y privilegios SELECT en la tabla de origen.
- Los alias se pueden utilizar con la sentencia MERGE.
### Sintaxis de MERGE 
- Se lee una fila cada vez de la tabla de origen y se comprará con las filas de la tabla de  destino utilizando la condición de coincidencia.
- Si existe una fila coincidente en la tabla de destino, la fila de origen se utiliza para actualizar una o más columnas de la fila de destino coincidente.
- Si no existe una fila coincidente, los valores de la fila de origen se utilizan para insertar una nueva fila en la tabla de destino.

```
MERGE INTO destination-table USING source-table
	ON matching-condition
WHEN MATCHED THEN UPDATE
	SET ...
WHEN NOT MATCHED THEN INSERT
	VALUES (...);
```

En este ejemplo, se utiliza la tabla EMPLOYEES (alias e) como origen de datos para insertar y actualizar filas en una copia de tabla denominada COPY_EMP (alias c).

```
MERGE INTO copy_emp c USING employees e
	ON (c.employee_id = e.employee_id)
WHEN MATCHED THEN UPDATE
	SET c.last_name = e.last_name,
		c.department_id = e.department_id
WHEN NOT MATCHED THEN INSERT
	VALUES (e.employee_id, e.last_name, e.department_id);
```
### **Inserciones en Varias Tablas**
- **Las inserciones en varias tablas se utilizan cuando se debe insertar los datos de origen en más de una tabla de destino.**
- Esta funcionalidad resulta útil cuando trabaja en un entorno de almacén de datos donde es común mover con regularidad datos de los sistemas operativos a un almacén de datos para la generación de informes analíticos y análisis.
- La creación y la gestión de almacenes de datos es una forma de gestionar el a veces muy elevado número de filas insertadas en sistemas operativos durante un día laborable normal.

- Puede que tenga filas que se tengan que insertar en más de una tabla del almacén de datos, por lo que si simplemente tenemos que SELECCIONARLAS una vez y, a continuación, replicarlas, se mejorará el rendimiento.
- Las inserciones en varias pueden ser incondicionales o condicionales. En una inserción incondicional en varias tablas, Oracle insertará todas las filas devueltas por la subconsulta en todas las cláusulas de inserción de tablas encontradas en la sentencia.
- **En una inserción condicional en varias tablas, puede especificar ALL o FIRST.**
##### Especificación de ALL
- Si especifica ALL, valor por defecto, la base de datos evalúa cada cláusula WHEN independientemente de los resultados de la evaluación de cualquier otra cláusula WHEN.
- Para cada cláusula WHEN cuya condición se evalúe como true, la base de datos ejecuta la lista de cláusulas INTO correspondientes.

```
INSERT ALL INTO clause VALUES clause SUBQUERY
```

```
INSERT ALL 
	INTO my_employees
		VALUES (hire_date, first_name, last_name)
	INTO copy_my_employees
		VALUES (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;
```

```
INSERT ALL
	WHEN call_format IN ('tlk', 'txt', 'pic') THEN
		INTO all_calls 
				VALUES (caller_id, call_timestamp, call_duration, call_format)
	WHEN call_format IN ('tlk', 'txt') THEN
			INTO police_record_calls
				VALUES (caller_id, call_timestamp, recipient_caller)
SELECT caller_id, call_timestamp, call_duration, call_format, recipient_caller
FROM calls
WHERE TRUNC(call_timestamp) = TRUNC(SYSDATE);
```
##### Especificación de FIRST
- Si especifica FIRST, la base de datos evalúa cada cláusula WHEN en el orden en el que3 aparece en la sentencia.
- Para la primera cláusula WHEN que se evalúe como true, la base de datos ejecuta la cláusula INTO correspondiente y omite las cláusulas WHEN posteriores de la fila determinada.
##### Especificación de la cláusula ELSE
- Para una fila determinada, si la cláusula WHEN no se evalúa como true, la base de datos ejecuta la lista de cláusulas INTO asociada con la cláusula ELSE.
- Si no se especifica una cláusula ELSE, la base de datos no realiza ninguna acción para dicha fila.




























































































































































