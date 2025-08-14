
# JOINS - PARTE 2

# Unión Igualitaria y Producto Cartesiano de Oracle
-------------------------

**Objetivos**
- Crear y ejecutar una sentencia SELECT que da como resultado un producto cartesiano.
- Crear y ejecutar sentencias SELECT para acceder a los datos desde más de una tabla utilizando una unión igualitaria.
- Crear y ejecutar sentencias SELECT que agregan condiciones de búsqueda usando el operador AND.
- Aplicar la regla para utilizar alias de tabla en una sentencia de unión.
### Comandos de Unión
- Los dos juegos de comandos o sintaxis que se puede utilizar para realizar conexiones entre las tablas de una base de datos:
	- Uniones propiedad de Oracle.
	- Uniones estándar compatibles con ANSI/ISO SQL:99
### Comparación de Unión
- Producto cartesiano
	- CROSS JOIN
- Unión igualitaria
	- NATURAL JOIN
	- JOIN USING
	- JOIN ON (comparador de igualdad)
- Unión no igualitaria
	- JOIN ON (comparación de desigualdad)
### Uniones Propiedad de Oracle
- Para consultar datos de más de una tablas con sintaxis propiedad de Oracle, utilice una condición de unión en la cláusula WHERE

```
SELECT table1.column, table2.column
FROM table1, table2
WHERE table1.column1 = table2.column2
```

- **Para que sea más fácil entender una sentencia JOIN y acelerar al acceso a las base de datos, es una buena práctica agregar el nombre de una tabla antes del nombre de la columna**
- A esto se le denomina "cualificar sus columnas".
- La combinación del nombre de la tabla y el nombre de la columna ayuda a eliminar nombres ambiguos cuando dos tablas contienen una columna con el mismo nombre de columna.
- **Si aparece el mismo nombre de columna en ambas tablas, el nombre de columna debe ir precediendo del nombre de la tabla.**
### **Unión Igualitaria**
- A veces denominada unión "simple" o "interna", una unión igualitaria es una unión de tabla que combina filas con los mismos valores para las columnas especificadas.
- Una unión igualitaria es equivalente a ANSI:
	- NATURAL JOIN
	- JOIN USING
	- JOIN ON (comparador de igualdad)

- La cláusula SELECT especifica los nombres de columna que se van a mostrar.
- La cláusula FROM especifica las tablas a las que debe acceder la base de datos separada por comas.
- La cláusula WHERE especifica cómo se van a unir las tablas.
- Una unión igualitaria utiliza el operador "igual que" para especificar la condición de unión.

```
SELECT e.last_name, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id;
```
### Alias
- Trabajar con nombres de tabla y columna largos puede ser complicado.
- Afortunadamente, hay una forma de acortar la sintaxis utilizando alias.
- Para distinguir las columnas que tienen nombres idénticos, pero que residen en tablas diferentes, utilice alias de tabla.
- Cuando los nombres de columna no está duplicados en dos tablas, no tiene que agregar el alias o nombre de la tabla al nombre de la columna.

```
SELECT last_name, e.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id AND department_id = 80;
```

- Si se utiliza un alias de tabla en la cláusula FROM, el alias de tabla se deberá sustituir por el nombre tablas mediante la sentencia SELECT.
### Unión de Producto Cartesiano
- Si en la cláusula WHERE de dos tablas de una consulta de unión no se ha especificado ninguna condición de unión o la condición de unión no es válida, Oracle Server devuelve el producto cartesiano de las dos tablas.
- Esta es una combinación de cada fila de una tabla con cada fila de la otra.
- Un producto cartesiano es equivalente a un ANSI CROSS JOIN

# Uniones no Igualitarias y Uniones Externas de Oracle
-----------------------------------------

**Objetivos**
- Crear y ejecutar una sentencia SELECT para acceder a los datos desde más de una tabla utilizando una unión no igualitaria.
- Crear y ejecutar una sentencia SELECT para acceder a los datos desde más de una tabla utilizando una unión externa de Oracle.
- En ocasiones, desea que se devuelvan todos los datos de una de las tablas, incluso aunque no haya datos coincidentes en la otra tabla.
### **Unión no Igualitaria**
- Ya que no hay ninguna coincidencia exacta entre las dos columnas de cada tablas, el operador de igualdad "=" no se puede usar.
- Aunque se pueden usar las condiciones de comparación como <= y >=, BETWEEN ... AND es una forma efectiva de ejecutar una unión no igualitaria.
- Una unión igualitaria es equivalente a ANSI JOIN ON (comparadores no igualitarios)

```
SELECT last_name, salary, grade_level, lowest_sal, highest_say
FROM employees, job_grades
WHERE salary BETWEEN lowest_sal AND highest_sal;
```
### **Unión Externa**
- Una unión externa se utiliza para ver las filas que tengan un valor correspondiente en otra tabla, más aquellas filas de una de las tablas que no tengan ningún valor coincidente en la otra tabla.
- Para indicar qué tabla puede tener datos que faltan mediante la sintaxis de unión de Oracle, agregue un signo más (+) después del nombre de columna de la tabla en la cláusula WHERE de la consulta.

```
SELECT e.last_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.departmen_id(+); -- LEFT OUTER JOIN

SELECT e.last_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = d.departmen_id; -- RIGHT OUTER JOIN
```

- No es posible tener el equivalente de FULL OUTER JOIN mediante la adición de un signo (+) a ambas columnas de la condición de unión. Si se intenta realizar esto, se produce un error.



































































