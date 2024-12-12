
# SUBCONSULTAS

# Conceptos Fundamentales de las Subconsultas
---------------

- En SQL, las subconsultas nos permiten buscar la información que necesitamos para que podamos obtener la información que deseamos.
- Las subconsultas son consultas anidadas, una consulta dentro de otra.
- **La subconsulta se ejecuta para buscar información que no conoce.**
- La consulta externa utiliza esa información para averiguar lo que debe saber 

- Puede ser muy útil ser capaz de combinar dos consultas en una cuando necesite seleccionar filas de una tabla con una condición que dependa de los datos de la propia tabla.
### Visión General de las Subconsultas
- Una subconsulta es una sentencia SELECT que está embebida en una cláusula de otra sentencia SELECT.
- **Una subconsulta se ejecuta una vez antes de la consulta principal.**
- La consulta principal o externa utiliza el resultado de la subconsulta.

```
SELECT select_list
FROM table
WHERE expression operator (SELECT select_list FROM table);
```

- Las subconsultas se pueden colocar en una serie de cláusulas SQL, incluida la cláusula WHERE, la cláusula HAVING y la cláusula FROM.
### Instrucciones para el uso de Subconsultas
- La subconsulta se incluye entre paréntesis.
- La subconsulta se coloca a la derecha de la condición de comparación.
- La consultas externas e internas puede obtener datos de diferentes tablas.
- Sólo se puede usar la cláusula ORDER BY para una sentencia SELECT: si se utiliza, debe ser la última cláusula de la consulta externa.
- Una subconsulta no puede tener su propia cláusula ORDER BY.
- El único límite en el número de subconsultas es el tamaño del buffer que utiliza la consulta.
### Dos Tipos de Subconsultas
- Subconsultas de una sola fila que utilizan operadores de una sola fila (>, =, >=, <, <>, <=) y solo devuelven una fila de la consulta interna.
- Subconsultas de varias filas que utilizan operadores de varias filas **(EN, ANY, ALL)** y devuelven más de una fila de la consulta interna.

```
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >
(SELECT hire_date FROM employees WHERE last_name = 'Vargas');
```

- Si una subconsulta devuelve un valor nulo o ninguna fila, la consulta externa toma los resultados de la subconsulta (nulos) y utiliza este resultado en su cláusula WHERE.
# Subconsultas de Una Sola Fila
---------------------------

**Objetivos**
- Crear y ejecutar una subconsulta de una sola fila en la cláusula WHERE o en la cláusula HAVING.
- Crear y ejecutar una sentencia SELECT mediante más de una subconsulta.
- Crear y ejecutar una sentencia SELECT mediante una función de grupo en una subconsulta.

- Como probablemente se habrá dado cuenta, las subconsultas se parecen mucho a los motores de búsqueda de internet. Son buenas para localizar información necesaria para realizar otra tarea.
- **Tenga en cuenta que las subconsultas ahorran tiempo en lo que respecta a que pueda realizar dos tareas en una sentencia.**
### Hechos sobre las Subconsultas de una Sola Fila
Estas subconsultas:
- Devuelven una sola fila.
- Utilizan operadores de comparación de una sola fila (=, >, >=, <, <=, <>).
Siempre:
- Incluya la subconsulta entre paréntesis.
- Coloque la subconsulta a la derecha de la condición de comparación.

Solo se puede utilizar una cláusula ORDER BY para una sentencia SELECT; si se especifica, debe ser la última cláusula de la sentencia SELECT principal.
### Subconsultas de Diferentes Tablas
- Las consultas externas e internas pueden obtener datos de diferentes tablas.

```
SELECT last_name, job_id, department_id
FROM employees
WHERE department_id =
	(SELECT department_id
	FROM departments
	WHERE department_name = 'Marketing')
ORDER BY job_id;

SELECT last_name, job_id, salary, department_id
FROM employees
WHERE job_id =
	(SELECT job_id
	FROM employees
	WHERE employee_id = 141)
AND
	(SELECT department_id
	FROM departments
	WHERE location_id = 1500);
```
### Funciones en Grupo en Subconsultas
- Las funciones en grupo se pueden usar en subconsultas.
- Una función de grupo sin ninguna cláusula GROUP BY en la subconsulta devuelve una única fila.

```
SELECT last_name, salary
FROM employees
WHERE salary < 
	(SELECT AVG(salary) FROM employees);
```
### Subconsultas en la cláusula HAVING
- Recuerde que la cláusula HAVING es similar a la cláusula WHERE, excepto por el hecho de que la cláusula HAVING se utiliza para restringir grupos y siempre incluye una función de grupo como, por ejemplo, MIN, MAX o AVG.

```
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
	(SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50);
```

- **Las subconsultas se pueden usar para obtener una o varias filas mediante todos los operadores de comparación. También se pueden usar dentro del HAVING de un GROUP BY.**

# Subconsultas de Varias Filas
----------------

**Objetivos:**
- Utilizar correctamente los operadores de comparación IN, ANY, ALL en subconsultas de varias filas.
- Crear y ejecutar una consulta de varias filas en la cláusula WHERE o en la cláusula HAVING.
- Describir qué sucede si una subconsulta de varias filas devuelve un valor nulo.
- Comprender cuándo se deben utilizar subconsultas de varias filas y cuándo es seguro usar una subconsulta de una sola fila.

- Una subconsulta se diseña para buscar información que no conoce y así poder encontrar la información que desea conocer.
- Las subconsultas de varias filas utilizan los tres operadores de comparación: IN, ANY y ALL.
### Comparación de Consultas
- **Una sentencia SQL que tiene una subconsulta y devuelve varias filas si se usa el comparador "=" producirá un error.**
- El problema es el signo igual (=) en la cláusula WHERE de la consulta externa.
- Para ello se usan los comparadores IN, ANY y ALL.
### **IN, ANY y ALL**
- Las subconsultas que devuelven más de un valor se denominan subconsultas de varias filas.
- Puesto que no podemos utilizar operadores de comparación de una sola fila (=, <, etc.), necesitamos operadores de comparación diferentes para subconsultas de varias filas.
- El operador **NOT** se puede utilizar en cualquiera de estos tres operadores.
### **IN**
- El operador IN se utiliza en la cláusula WHERE de la consulta externa para seleccionar solo las filas que están En la lista de valores devueltos de la consulta interna.

```
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
	FROM employees
	WHERE department_id = 90);
```

- Esta consulta interna devolverá una lista de los años en los que se contrataron empleados del departamento 90.
- A continuación, la consulta externa devolverá cualquier empleado contratado el mismo año que cualquier año de la lista de la consulta interna.
### **ANY**
- Se utiliza cuando deseamos que la cláusula WHERE de la consulta externa seleccione las filas que coinciden con los criterios (<, >, =, etc.) de al menos un valor en el juego de resultados de la subconsulta.

```
SELECT last_name, hire_date 
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY
	(SELECT EXTRACT(YEAR FROM hire_date)
	FROM employees
	WHERE department_id = 90);
```

### **ALL**
- El operador ALL se utiliza cuando deseamos que la cláusula WHERE de la consulta externa seleccione las filas que coinciden con los criterios (<, >, =, etc.) de todos los valores en el juego de resultados de la subconsulta.
- El operador ALL compara un valor con todos los valores devueltos por la consulta interna.

```
SELECT last_name, hire_date
FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) < ALL
	(SELECT EXTRACT(YEAR FROM hire_date)
	FROM employees
	WHERE department_id = 90);
```

> [!NOTA]
> - **`IN`**: Comprueba si el valor se encuentra en el conjunto de resultados de la subconsulta.
> - **`ANY`**: Verifica si la condición es verdadera para al menos un valor de la subconsulta.
> - **`ALL`**: Verifica si la condición es verdadera para todos los valores de la subconsulta
### Valores NULL
- Suponga que uno de los valores devueltos por una subconsulta de varias filas es nulo, pero otros valores no lo son. 
- Si se utiliza IN o ANY, la consulta externa devolverá filas que coinciden con los valores no nulos.
- Si utiliza ALL, la consulta externa no devuelve ninguna fila porque ALL compara la consulta externa con cada valor devuelvo por la subconsulta, incluidos valores nulos.
- Y la comparación de cualquier cosa con un valor nulo de como resultado un valor nulo.
### GROUP BY y HAVING
- La cláusula GROUP BY y HAVING también se puede utilizar con subconsultas de varias filas.

```
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
	(SELECT salary
	FROM employees
	WHERE department_id IN (10, 20))
ORDER BY department_id;
```
### Subconsultas de Varias Columnas 
- Las subconsultas pueden usar una o más columnas.
- Si utilizan más de una columna, se denominan subconsultas de varias columnas.
- Una subconsulta de varias columnas pueden ser comparaciones pareadas o no pareadas.

```
SELECT employee_id, manager_id, department_id
FROM employees
WHERE (manager_id, department_id) IN 
	(SELECT manager_id, department_id
	FROM employees
	WHERE employee_id IN(149, 174))
AND employee_id IN (149, 174);
```

- La subconsulta de varias columnas pareada también utiliza más de una columna en la subconsulta, pero las compara de una en una, por lo que las comparaciones se producen en distintas subconsultas.

```
SELECT employee_id, manager_id, department_id
FROM employees 
WHERE manager_id IN
	(SELECT manager_id
	FROM employees
	WHERE employee_id IN (149,174))
AND department_id IN
	(SELECT department_id
	FROM employees
	WHERE employee_id IN (149, 174))
AND employee_id NOT IN (149, 174);
```

- Algunas subconsultas pueden devolver una o varias filas, según los valores de datos de las filas.
- **Incluso, aunque existe la mínima posibilidad de devolver varias filas, asegúrese de escribir una subconsulta de varias filas.**

```
-- FORMA INCORRECTA
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id =
	(SELECT job_id
	FROM employees
	WHERE last_name = 'Ernst');

-- FORMA CORRECTA
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id IN
	(SELECT job_id
	FROM employees
	WHERE last_name = 'Ernst');

```

# Subconsultas Correlacionadas
-------------

**Objetivos:**
- Identificar cuando se necesitan subconsultas correlacionadas.
- Crear y ejecutar subconsultas correlacionadas.
- Crear una consulta con los operadores EXISTS y NOT EXISTS para probar las filas devueltas en una subconsulta.
- Crear y ejecutar subconsultas con nombre mediante la cláusula WITH.

- En ocasiones, puede que tenga que responder a más de una pregunta en una frase.
- Por lo tanto, en realidad, lo que parecería una pregunta simple, se puede convertir en cuatro preguntas para las que necesita respuestas antes de poder decir "Sí" o "No".
### Subconsulta Correlacionadas
- El servidor de Oracle realiza una subconsulta correlacionada cuando la subconsulta hace referencia a una columna de una tabla a la que se hace referencia en la sentencia principal.
- Una subconsulta correlacionada se evalúa una vez para cada fila procesada por la sentencia principal.
- La sentencia principal puede ser una sentencia SELECT, UPDATE o DELETE.

```
SELECT o.first_name, o.last_name, o.salary
FROM employees o
WHERE o.salary >
	(SELECT AVG(i.salary)
	FROM employees
	WHERE i.department_id = o.department_id);
```

- Cada subconsulta se ejecuta una vez para cada fila de la consulta externa.
- Con una subconsulta normal, la consulta SELECT interna se ejecuta en primer lugar y una vez, devolviendo valores que utilizará la consulta externa.

- Una subconsulta correlacionada se ejecuta una vez para cada fila considerara por la consulta externa.
- Es decir, la consulta interna está controlada por la consulta externa.
### **EXISTS y NOT EXISTS en Subconsultas**
- Son dos cláusulas que se pueden utilizar al comprobar coincidencias de subconsultas.
- EXISTS comprueba un resultado TRUE o coincidente en la subconsulta.

- En el siguiente ejemplo, la subconsulta selecciona los empleados que son jefes.
- A continuación, la consulta externa devuelve las filas de la tabla de empleados que NO EXISTEN en la subconsulta.

```
SELECT last_name AS "Not a Manager" FROM employees emp
WHERE NOT EXISTS
(SELECT * FROM employees mgr
WHERE mgr.manager_id = emp.employee_id);
```

> [!NOTA]
> En las subconsultas correlacionadas no debe usar NOT IN como alternativa de NOT EXISTS.

- Tenga cuidado con los valores NULL en las subconsultas al utilizar IN o NOT IN.
- Si no está seguro si una subconsulta incluirá un valor nulo, elimine el valor nulo mediante IS NOT NULL, **o use NOT EXISTS para obtener una respuesta más segura.**
### **Cláusula WITH - Common Table Expressions (CTE)** 
- Si tiene que escribir una consulta muy compleja con uniones y agregaciones utilizadas varias veces, puede escribir las distintas partes de la sentencia como bloques de consulta y, a continuación, utilizar esos mismos bloques de consulta en una sentencia SELECT.
- Oracle le permite escribir subconsultas con nombre en una sola sentencia, siempre que empiece su sentencia con la palabra clave WITH.
- La cláusula WITH recupera los resultados de uno o más bloques de consulta y almacena esos resultados para el usuario que ejecuta la consulta.

- La cláusula WITH mejora el rendimiento.
- La cláusula WITH hace que la consulta se pueda leer fácilmente.
- La sintaxis de la cláusula WITH es la siguiente: 

```
WITH subquery-name AS (subquery),
	subquery-name AS (subquery)
	SELECT column-list
	FROM {table | subquery-name | view}
	WHERE condition is true;
```

```
WITH managers AS
(SELECT DISTINCT manager_id
FROM employees
WHERE manager_id IS NOT NULL)

SELECT last_name AS "Not a manager"
FROM employees
WHERE employee_id NOT IN
	(SELECT * FROM managers);

```










































