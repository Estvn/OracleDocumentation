
# VISTAS

# Creación de Vistas
----------------------

**Objetivos:**
- Enumerar tres usos de las vistas desde el punto de vista de un administrador de bases de datos.
- Explicar, desde una perspectiva empresarial, por qué es importante tener la capacidad de crear y utilizar subjuegos lógicos de datos derivados de una o más tablas.
- Crear una vista con o sin alias de columna en la subconsulta utilizando una única tabla base.

- Crear una vista compleja que contenga funciones de grupo para visualizar valores de dos tablas.
- Recuperación de datos de una vista.

**Objetivo**
- ¿Deben tener los empleados acceso a todos los datos de la compañía?
- ¿Cómo ejecutarán comandos que necesitan condiciones de unión?
- ¿Es conveniente permitir la entrada de datos de todos?
- Estas son las preguntas que como administrador de bases de datos tiene que saber responder.

En esta sección aprenderá a crear vistas: representaciones virtuales de tablas personalizadas para cumplir los requisitos de usuario específicos.
### **Vistas**

- Una vista, como una tabla, es un objeto de base de datos.
- Sin embargo, las vistas no son tablas "reales".
- Son representaciones lógicas de tablas existentes o de otra vista.
- Las vistas no contienen datos propios.
- Funcionan como una ventana por la que se puede ver o cambiar los datos de las tablas.

- **Las tablas en las que se basa la vista de denominan tablas "base".**
- La vista es una consulta almacenada como una sentencia SELECT en el diccionario de datos.

```
CREATE VIEW view_employees
AS SELECT employee_id, first_name, last_name, email
FROM employees 
WHERE employee_id BETWEEN 100 AND 124;

SELECT * FROM view_employees;
```
### ¿Por qué utilizar vistas?
- Las vistas restringen el acceso a la tabla base porque la vista puede mostrar las columnas selectivas de la tabla.
- Las vistas se pueden utilizar para reducir la complejidad de la ejecución de las consultas basadas en sentencias SELECT complicadas.
- Por ejemplo, el creador de la vista puede construir sentencias de unión que recuperan datos de varias tablas.
- El usuario de la vista no ve el código subyacente ni cómo crearlo.
- El usuario, mediante la vista interactúa con la base de datos con consultas simples.

- Las vistas se pueden utilizar para recuperar datos de varias tablas, proporcionando independencia de datos a los usuarios.
- Los usuarios pueden ver los mismos datos de distintas formas.
- Las vistas proporcionan a los grupos de usuarios acceso a los datos según unos permisos o criterios concretos.
### Creación de Vistas

Para crear una vista, embeba una subconsulta en la sentencia CREATE VIEW
```
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view 
[(alias [, alias] ...)] AS subquery
[WITH CHECK OPTION [CONSTRAINT constraint]]
[WITH READ ONLY [CONSTRAINT constraint]];
```

> [!NOTA]
> - **OR REPLACE:** Vuelve a crear la vista si ya existe.
> - **FORCE:** Crea la vista independientemente de si existen o no las tablas base.
> - **NOFORCE:** Crea la vista solo si existe la tabla base (opción por defecto).
> - **view_name:** Nombre de la vista.
> - **alias:** Especifica un nombre por cada expresión seleccionada por la consulta de la vista.
> - **subconsulta:** Sentencia SELECT completa.
> - **WITH CHECK OPTION:** Especifica que las filas siguen estando accesibles para la vista después de las operaciones se inserción o actualización.
> - **CONSTRAINT:** Es el nombre asignado a la restricción CHECK OPTION.
> - **WITH READ ONLY:** Garantiza que no se pueda realizar ninguna operación DML en esta vista.

```
CREATE O REPLACE VIEW view_euro_countries
AS SELECT country_id, region_id, country_name, capital
FROM wf_countries
WHERE locacion LIKE '%Europe%';

SELECT * FROM view_euro_countries
ORDER BY country_name;
```
### Instrucciones para la Creación de Vistas
- La subconsulta que define la vista no puede contener ninguna sintaxis SELECT compleja.
- Por razones de rendimiento, la subconsulta que define la vista no debe contener ninguna cláusula ORDER BY. **La cláusula ORDER BY mejor se especifica al recuperar datos de la vista.**
- Puede utilizar la opción OR REPLACE para cambiar la definición de la vista sin tener que borrarla o sin necesidad de volver a otorgarle los privilegios de objeto otorgados previamente.
- Se puede utilizar alias para los nombres de columna en la subconsulta.
### **Vista Simple**

- La vista que se muestra a continuación es un ejemplo de una vista simple.
- **La subconsulta deriva datos a partir de una única tabla y no contiene ninguna función de unión ni ninguna función de grupo.**
- Puesto que es una vista simple, las operaciones INSERT, UPDATE, DELETE y MERGE que afectan a la tabla base se podrían realizar en la vista.

```
CREATE OR REPLACE VIEW view_euro_countries
AS SELECT country_id, country_name, capital
FROM wf_countries
WHERE location LIKE '%Europe%';
```

Tenga en cuenta que los alias también se pueden enumerar después de la sentencia CREATE VIEW y antes de subconsulta SELECT

```
CREATE OR REPLACE VIEW view_euro_countries("ID", "Country", "Capitol City")
AS SELECT country_id, country_name, capitol
FROM wf_countries
WHERE location LIKE '%Europe%';
```

- Es posible crear una vista independientemente de si existen o no las tablas base.
- Al agregar la palabra FORCE a la sentencia CREATE VIEW, se crea la vista.
- Como DBA, esta opción puede ser útil durante el desarrollo de una base de datos, especialmente si está esperando que en breve se le otorguen los privilegios necesarios para el objeto al que se hace referencia.
- La opción FORCE creará la vista a pesar de no ser válida.
- La opción NOFORCE es el valor por defecto al crear una vista.
### **Vista Compleja**

- **Las vistas complejas son vistas que pueden contener funciones en grupo y uniones.**
- El siguiente ejemplo crea una vista que deriva datos de dos tablas.

```
CREATE OR REPLACE VIEW view_euro_countries ("ID","Country","Capitol City","Region")
AS SELECT c.country_id, c.country_name, c.capitol, r.region_name
FROM wf_countries c JOIN wf_world_regions r
USING (region_id)
WHERE location LIKE '%Europe%';

SELECT * FROM view_euro_countries;
```
### Modificación de Vistas
- Para modificar una vista existente sin tener que borrarla y, a continuación, volver a crearla, utilice la opción OR REPLACE en la sentencia CREATE VIEW.
- La vista antigua se sustituye por la nueva versión.

# Operaciones DML y Vistas
----------------------------

**Objetivos:**
- Escribir y ejecutar una consulta que realice operaciones DML en una vista simple.
- Nombrar las condiciones que restringen la capacidad de modificar una vista mediante las operaciones DML.
- Escribir y ejecutar una consulta utilizando la cláusula WITH CHECK OPTION.

- Explicar el uso de WITH CHECK OPTION que se aplica a las restricciones de integridad y la validación de los datos.
- Aplicar la opción WITH READ ONLY a una vista para restringir las operaciones DML.

-------------------

- Las vistas simplifican el acceso de usuario a los datos incluidos en una o más tablas de la base de datos.
- Sin embargo, las vistas también permiten a los usuarios realizar cambios en las tablas subyacentes.
- Como DBA y persona cuyo trabajo es mantener la integridad de la base de datos, puede que desee poner restricciones en determinadas vistas de datos.
- En esta lección, aprenderá a permitir el acceso a datos y al mismo tiempo garantizar la seguridad de los datos.
### Sentencias DML y Vistas
- Las operaciones DML INSERT, UPDATE y DELETE se pueden realizar en vistas simples.
- Esta operaciones se pueden utilizar para cambiar los datos en las tablas base subyacentes.
- Si crea una vista que permita a los usuarios ver información restringida mediante la cláusula WHERE, los usuarios seguirán pudiendo realizar operaciones DML en todas las columnas de la vista.
### Control de Vistas
- Mediante la vista como se ha indicado, es posible INSERTAR, ACTUALIZAR Y SUPRIMIR información de todas las filas de la vista, incluso aunque el resultado sea que una fila ya no forme parte de la vista
- Puede que esto no sea lo que deseaba el DBA cuando se creó la vista.
- Para controlar el acceso a los datos, se pueden agregar dos opciones a la sentencia CREATE VIEW:
	- WITH CHECK OPTION
	- WITH READ ONLY
### Vistas **WITH CHECK OPTION**

- **LAS VISTAS CON WITH CHECK OPTION SOLO PERMITE MODIFICAR LOS DATOS, SIEMPRE QUE SE CUMPLAN LOS CRITERIOS DE LA VISTA.**
- **Es decir, si la vista solo obtiene datos con department_name = 'Atlántida', no se podrán hacer modificaciones de filas que no tengan el department_name que se ha mencionado.**
- Tampoco puede cambiarse el department_name de las filas que se encuentran en la vista.

El siguiente ejemplo no tiene WITH CHECK OPTION y permite modificación de valores
La actualización se realiza correctamente, aunque este empleado ahora no forma parte de la vista:
```
CREATE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name, salary
FROM copy_employees
WHERE department_id = 50;

UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 124;
```

- **WITH CHECK OPTION garantiza que las operaciones DML realizadas en la vista se mantengan en el dominio de la vista.**
- cualquier intento de cambiar el número de departamento de una fila de la vista fallará porque viola la restricción **WITH CHECK OPTION.**

Ahora, si intenta modificar una fila en la vista que la sacará del dominio de la vista, se devuelve un error:
```
CREATE OR REPLACE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name, salary
FROM copy_employees
WHERE department_id = 50;
WITH CHECK OPTION CONSTRAINT view_dept50_check;

-- ESTO DEVUELVE UN ERROR
UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 124;
```
### Vistas **WITH READ ONLY**

- La opción WITH READ ONLY garantiza que no se produce ninguna operación DML en la vista.
- Cualquier intento de ejecutar una sentencia INSERT, UPDATE o DELETE producirá un error de Oracle Server.

```
CREATE OR REPLACE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name, salary
FROM copy_employees
WHERE department_id = 50;
WITH READ ONLY;
```
### **Restricciones DML**

- La vistas simples y complejas difieren en su capacidad para permitir operaciones DML en una vista.
- Para las vistas simples, las operaciones DML se pueden realizar en la vista.
- Para las vistas complejas, las operaciones DML no siempre están permitidas.

Las tres reglas siguientes se deben tener en cuenta al realizar operaciones DML en las vistas:
1. No puede **eliminar** una fila desde una tabla base subyacente si la vista contiene algo de lo siguiente:
	1. Funciones de grupo
	2. Una cláusula GROUP BY
	3. La palabra clave DISTINCT
	4. La palabra clave ROWNUM de pseudocolumna

2. No puede **modificar** datos de una vista, si la vista contiene:
	1. Funciones de grupo
	2. Una cláusula GROUP BY
	3. La palabra clave DISTINCT
	4. La palabra clave ROWNUM de pseudocolumna
	5. Columnas definidas por expresiones

3.  No puede **agregar datos** en una vista si esta:
	1. Funciones de grupo
	2. Una cláusula GROUP BY
	3. La palabra clave DISTINCT
	4. La palabra clave ROWNUM de pseudocolumna
	5. Columnas definidas por expresiones
	6. No incluye columnas NOT NULL en las tablas base.

# Gestión de Vistas
----------------------

**Objetivos:**
- Crear y ejecutar una sentencia SQL que elimina una vista.
- Crear y ejecutar una consulta mediante una vista en línea.
- Crear y ejecutar una consulta para el análisis de N principales.

----------

- Aprender a crear y sustituir vistas no sería completo a menos que también supiera cómo eliminarlas.
- Las vistas se crean con fines específicos.
- Cuando la vista ya no es necesaria o se debe modificar, existen medios para realizar los cambios realizados.
- Si un empleado que ha tenido acceso a información financiera deja la compañía, es probable que no desee que su vista siga estando accesible.
- Aprenderá a suprimir una vista, crear una vista en línea y construir una sentencia SELECT para producir una lista ordenada de datos.
### **Supresión de una Vista**

- Puesto que una vista no contiene datos propios, su eliminación no afecta a los datos de las tablas subyacentes.
- Si la vista se ha utilizado para INSERTAR, ACTUALIZAR o SUPRIMIR datos en el pasado, esos cambios en las tablas base se mantienen.
- La supresión de una vista simplemente elimina la definición de vista de la base de datos.

- Recuerde que las vistas se almacenan como una sentencia SELECT en el diccionario de datos.
- Solo el creador o usuarios con el privilegio DROP ANY VIEW pueden eliminar una vista

```
DROP VIEW viwename;
```
### **Vistas en Línea**

- Las vistas en línea también se denominan subconsultas en la cláusula FROM.
- Inserte una subconsulta en la cláusula FROM como si la subconsulta fuera un nombre de la tabla.
- **Las vistas en línea se utilizan normalmente para simplificar las complejas consultas mediante la eliminación de operaciones de unión y la condensación de varias consultas en una sola.**

- Como se muestra en el siguiente ejemplo, la cláusula FROM contiene una sentencia SELECT que recupera datos como cualquier sentencia SELECT.
- A los datos devueltos por la subconsulta se les asigna un alias que, a continuación, se utiliza junto con la consulta principal para devolver columnas seleccionadas de ambos orígenes de consulta

```
SELECT e.last_name, e.salary, e.department_id, d.maxsal
FROM employees e, 
	(SELECT department_id, max(salary) maxsal
	FROM employees
	GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND e.salary = d.maxsal;
```
### **Análisis de N Principales**

- El análisis de N principales es una operación SQL utilizada para clasificar resultados.
- El uso de análisis de N principales resulta útil cuando desea recuperar los 5 registros principales o los n registros principales de un juego de resultado devuelto por la consulta.}

```
SELECT ROWNUM AS "Longest employed", last_name, hire_date
FROM employees
WHERE ROWNUM <= 5
ORDER BY hire_date;
```

- Puede utilizar ROWNUM en su consulta para asignar un número de fila al juego de resultados.
- La cláusula WHERE de la consulta externa se utiliza para restringir el número de filas devueltas y debe utilizar un operador < ó <=

> [!NOTA]
> Al borrar una tabla a la que hace referencia una vista, la vista no se borra automáticamente.
> 










































































