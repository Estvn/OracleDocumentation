
# JOINS - PARTE 1

# Uniones Cruzadas y Uniones Naturales
--------------------------

**Objetivos:**
- Creación de unión natural y cruzada utilizando la sintaxis de unión ANSI-SQL-99
- Explicar la importancia de tener un estándar para SQL definido por ANSI.

- El modelado de datos que separar los datos en tablas individuales y ser capaz de asociar las tablas entre sí forma parte de la base del diseño de bases de datos.
- **SQL proporciona las condiciones de unión que permiten consultar la información de distintas tablas y combinarlas en un informe.**
### Comandos de Unión
- Hay dos juegos de comandos o sintaxis que se pueden utilizar para realizar conexiones entre las tablas de una base de datos:
	- Uniones propiedad de Oracle
	- Uniones estándar compatibles con el ANSI/ISO SQL 99
### ANSI
- American National Standards Institute (ANSI).
- La misión del instituto es mejorar tanto la competitividad global de negocios de EE.UU como la calidad de vida de EE.UU al proporcionar y el facilitar los estándares de conformidad voluntaria y los sistemas de evaluación de conformidad, así como al proteger su integridad.
### SQL
- Structured Query Languaje (SQL) es el lenguaje de estándar del sector de procesamiento de información de los sistemas de gestión de bases de datos relacionales (RDBMS).
- El idioma fue diseñado originalmente por IBM a mediados de 1970, tuvo un uso generalizado a primeros de 1980, y se convirtió en el estándar del sector en 1986, cuando fue adoptado por ANSI.
- Hasta ahora, ha habido tres estandarizaciones de SQL de ANSI, cada una de ellas basadas en la anterior.
- Se denomina con el nombre del año en el que se propusieron por primera vez y son ampliamente conocidos por sus abreviaturas:
	- ANSI-96
	- ANSI-92
	- ANSI-99
### **NATURAL JOIN**
- **Una cláusula de unión SQL combina campos de dos o más tablas en una base de datos relacional.**
- Una unión natural se basa en todas las columnas de dos tablas que tengan el mismo nombre y selecciona las filas de las dos tablas que tengan valores equivalentes en todas las columnas coincidentes.
- En el código, cuando se utiliza una unión natural, es posible unir las tablas sin tener que especificar de forma explícita las columnas de la tabla correspondiente. Sin embargo, los nombres y los tipos de dato de ambas columnas deben ser los mismos.
- La columna de la unión natural no tiene que aparecer en la cláusula SELECT.

```
SELECT first_name, last_name, job_id, job_title 
FROM employees NATURAL JOIN jobs
WHERE department_id > 80;
```
### **CROSS JOIN**
- El valor CROSS JOUN SQL de ANSI/ISO SQL-99: Une cada fila de una tabla a cada fila de otra tabla.
- El juego de resultados representa todas las posibles combinaciones de filas de las dos tablas.
- Si ejecuta CROSS JOIN en una tabla de 20 filas con una tabla de 100 filas, la consulta devolverá 2000 filas.

```
SELECT last_name, department_name 
FROM employees CROSS JOIN departments;
```

# Cláusulas JOIN
---------------------------------

**Objetivos:**
- Crear y ejecutar una unión con la cláusula ANSI-99 USING
- Crear y ejecutar una unión con la cláusula ANSI-99 ON
- Crear y ejecutar una consulta ANSI-99 que une tres tablas.

- Al agregar más comandos al vocabulario de la base de datos, estará mejor preparado para diseñar consultas que devuelvan el resultado deseado.
- El objetivo de una unión es enlazar los datos entre tablas, sin repetir todos los datos en todas las tablas.
### Cláusula **USING**
- En una unión natural, si las tablas tienen columnas con los mismos nombres, pero diferentes tipos de dato, la unión provocará un error.
- Para evitar esta situación, la cláusula de unión se puede modificar con una cláusula USING.
- La cláusula USING especifica las columnas que se deben utilizar para la unión.
- **Las columnas a las que hace referencia en la cláusula USING no deben tener un cualificador (nombre o alias de la tabla) en ninguna ubicación de la sentencia SQL.**

```
SELECT first_name, last_name, department_id, department_name 
FROM employees JOIN departments USING (department_id);
```

- La clásula USING nos permite utilizar WHERE para limitar las filas de una o de ambas tablas
```
SELECT first_name, last_name, department_id, department_name 
FROM employees JOIN departments USING (department_id)
WHERE last_name = 'Higgins';
```

- **Se usa USING, cuando el nombre de la columna elegida para la unión tiene el mismo nombre en ambas tablas.**
### Cláusula ON
- ¿Qué ocurre si las columnas que se van a unir tienen nombres diferentes, o bien si la unión utiliza operadores de comparación de distinto de, como <, > o BETWEEN?
- No podemos utilizar USING, por lo que en su lugar utilizamos una cláusula ON.
- **ON permite especificar una mayor variedad de condiciones de unión.**
- La cláusula ON también nos permite utilizar WHERE para limitar las filas de una o de ambas tablas.
- **ON, a diferencia de USING, si permite añadir alias a las tablas.**

```
SELECT last_name, job_title
FROM employees e 
JOIN jobs j ON (e.job.id = j.job_id);
```

- **Se necesita una cláusula ON cuando las columnas comunes tengan nombres diferentes en ambas tablas.**
- Al usar una cláusula ON en columnas con el mismo nombre en ambas tablas, debe agregar un calificador (ya sea el alias o el nombre de la tabla), de lo contrario se devolverá un error. 

```
SELECT last_name, job_title
FROM employees e 
JOIN jobs j ON (e.job.id = j.job_id)
WHERE last_name LIKE 'H%';
```
### Cláusula ON con Operador Distinto de
- En ocasiones puede que tenga que recuperar los datos de una tabla que no tenga ninguna columna correspondiente en otra tabla.
- **La cláusula ON con operador Distinto de, permite unir dos tablas que no tienen una columna con el mismo nombre ni el mismo dato.**

```
SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees
JOIN job_grades ON (salary BETWEEN lowest_sal AND highest_sal);
```
### **Unión de Tres Tablas**
- **Tanto USING como ON se puede utilizar para unir tres o más tablas.**

```
SELECT last_name, department_name AS "Department", city
FROM employees
JOIN departments USING (department_id)
JOIN locations USING (location_id);
```

- employees tiene la FK de departments, y departments tiene la FK de locations. employees no tiene la FK de las dos tablas, por lo tanto el orden de los JOIN ... USING debe ir desde la tabla que se relaciona con la tabla indicada en la consulta, y así de forma jerárquica.

```
SELECT employees.last_name, departments.department_name, locations.city
FROM employees 
JOIN departments ON departments.department_id = employees.department_id
JOIN locations ON locations.location_id = departments.location_id;
```

- En JOIN ... ON se debe tener clara como está formada la jerarquía de FK entre las tablas a relacionar, ya que en esta consulta de definen los nombres de las tablas y las columnas en común. Aquí se mira de forma más detallada como está hecha la jerarquía de las FK entre las tablas.

# Uniones Internas frente a Uniones Externas
-------------------------

**Objetivos:**
- Crear y ejecutar una consulta para utilizar una unión externa izquierda.
- Crear y ejecutar una consulta para utilizar una unión externa derecha.
- Crear y ejecutar una consulta para utilizar una unión externa completa.

- En ocasiones, deseamos recuperar tanto los datos que cumplan la condición de unión, como los datos que no cumplan la condición de unión.
- Las uniones externas ANSI-99 SQL permiten esta funcionalidad
### Uniones Externas e Internas
- En ANSI-99 SQL, una unión de dos o más tablas que devuelven solo las filas coincidentes se denomina **unión interna.**
- Cuando una unión devuelve filas no coincidentes, así como las filas coincidentes, se denomina **unión externa.**
- En la sintaxis de las uniones externas se utilizan los términos "RIGHT, LEFT y FULL".
- **Estos nombres están asociados con el orden de los nombres de las tablas en la cláusula FROM de la sentencia SELECT.**
### **Uniones Externas Izquierdas y Derechas**

```
SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
LEFT OUTER JOIN departments d ON (e.department_id = d.department_id);
```

- En el ejemplo mostrado de una unión externa izquierda, tenga en cuenta que al nombre de la tabla que aparece a la izquierda de las palabras "LEFT OUTER JOIN" se le hace referencia como "tabla izquierda".
- Esta consulta devolverá los apellidos de todos los empleados, tanto aquellos que estén asignados a un departamento como los que no

```
SELECT e.last_name, d.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;
```

- Esta unión externa derecha devolvería todos los ID de departamento y los nombres de departamento, tanto aquellos que tengan empleados asignados como los que no.
### Unión Externa Completa
- Se puede crear una condición de unión para recuperar todas las filas coincidentes y todas las filas no coincidentes de ambas tablas.
- Con una unión externa completa se resuelve este problema.
- **El juego de resultados de una unión externa completa incluye todas las filas de una unión externa izquierda y todas las filas de una unión externa derecha combinadas sin duplicación.**
### Ejemplo de **FULL OUTER JOIN**

```
SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
FULL OUTER JOIN departments d ON e.department_id = d.department_id;
```

# Autouniones de Consultas Jerárquicas
---------------------------------------

**Objetivos**
- Crear y ejecutar una sentencia SELECT para unir una tabla consigo misma mediante la autounión.
- Interpretar el código de una consulta jerárquica.
- Crear un informe con estructura de árbol.
- Aplicar formato a datos jerárquicos.
- Excluir ramas de la estructura de árbol.

- En el modelado de datos, a veces es necesario mostrar una entidad con una relación consigo misma.
- Por ejemplo, un empleado también puede ser un jefe.
- Mostraremos esto con la relación recursiva o de "oreja de cerdo".

![[Pasted image 20241031144355.png]]

- Una vez que tengamos una verdadera tabla de empleados, ,es necesario un tipo especial de unión denominada autounión para acceder a los datos.
- **Se utiliza una autounión para unir una tabla a sí misma como si se tratara de dos tablas.**

```
SELECT worker.last_name || ' works for' || manager.last_name
AS "Works for"
FROM employees worker 
JOIN employees manager ON worker.manager_id = manager.employee_id;
```
### **Autounion**
- Para unir una tabla a sí misma, a la tabla se le asignan dos nombres o alias. Esto hará que la base de datos "crea" que hay dos tablas.
###### Ejemplo de SELF-JOIN

```
SELECT worker.last_name, worker.manager_id,
manager.last_name AS "Manager name"
FROM employeees worker 
JOIN employees manager ON (worker.manager_id = manager.employee_id);
```
### Consultas Jerárquicas
- Estrechamente relacionadas con las autouniones se encuentran las consultas jerárquicas.
- En las páginas anteriores, ha visto como se puede utilizar las autouniones para ver al jefe directo de cada empleado.
- Con las consultas jerárquicas, también podemos ver para quien trabaja ese jefe, y así sucesivamente.
- Con este tipo de consulta, podemos crear un diagrama de organización que muestre la estructura de una compañía o departamento.

- Imagine un árbol familiar en el que los miembros más mayores de la familia se encuentran cerca de la base o el tronco del árbol y los más jóvenes representan las ramas del árbol.
- Las ramas pueden tener sus propias ramas y así sucesivamente.
### Uso de Consultas Jerárquicas
- Una consulta jerárquica en un método de creación de informes, con las ramas de un árbol en un determinado orden.
- Con las consultas jerárquicas se puede recuperar datos según la relación jerárquica natural entre las filas de una tabla.
- Una base de datos relacional no almacena registros de forma jerárquica.
- **Sin embargo, cuando existe una relación jerárquica entre las filas de una única tabla, un proceso denominado "recorrido del árbol" permite construir la jerarquía.**
### Palabras Clave en las Consultas Jerárquicas
- Las consultas jerárquicas tienen sus propias palabras clave nuevas:
	- START WITH
		- Identifica qué fila se va a utilizar como raíz del árbol que se está creando.
	- CONNECT BY PRIOR
		- Explica cómo realizar las uniones entre las filas
	- LEVEL
		- Específica cuántas ramas de profundidad recorrerá el árbol.
### Ejemplo de Palabras Clave en Consultas jerárquicas

```
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id

```
### Ejemplo de LEVEL en Consultas Jerárquicas
- LEVEL es una pesudocolumna que se utiliza con consultas jerárquicas y que cuenta el número de pasos que ha realizado desde la raíz del árbol.

```
SELECT LEVEL, last_name || 'reports to ' || PRIOR last_name AS "Walk top down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;
```
### Consulta Jerárquica de Abajo a Arriba

```
SELECT LPAD(last_name, LENGTH(last_name) + (LEVEL*2)-2, '_') AS org_chart
FROM employees
START WITH last_name = 'Grant'
CONNECT BY employee_id = PRIOR manager_id;
```

- Como puede ver en el resultado que aparece a continuación, en este ejemplo se muestra cómo crear una consulta jerárquica de abajo a arriba, moviendo la palabra clave PRIOR a la posición posterior al signo igual, y mediante el uso de 'Grant' en la cláusula START WITH.
### Depuración de Consultas Jerárquicas
- La depuración de ramas de árbol se puede realizar mediante la cláusula WHERE o la cláusula CONNECT BY PRIOR
- Si se utiliza la cláusula WHERE, solo se excluye la fila especificada en la sentencia; si se utiliza la cláusula CONNECT BY PRIOR, se excluye toda la rama.

- Por ejemplo, si desea excluir una única fila de su resultado, debería utilizar la cláusula WHERE para excluir esa fila; eso descarta visualización de un registro, pero no de la rama completa.

```
SELECT last_name
FROM employees
WHERE last_name != 'Higgins'
START WITH last_name = 'Kocchar'
CONNECT BY PRIOR employee_id = manager_id;
```

- Sin embargo, si deseara excluir una fila y todas las filas por debajo de ella, debería realizar la parte de exclusión de la sentencia CONNECT BY

```
SELECT last_name
FROM employees
START WITH last_name = 'Kocchar'
CONNECT BY PRIOR employee_id = manager_id
AND last_name != 'Higgins';
```


































