
# FUNCIONES DE GRUPO - PARTE 2

# Uso de las Cláusulas Group By y Having
--------------------------

**Objetivos**
- Crear y ejecutar una consulta SQL usando GROUP BY ... HAVING
- Crear y ejecutar GROUP BY en más de una columna.
- Anidar  funciones en grupo.

- Para simplificar codificación de agrupaciones se utilizan las cláusulas GROUP BY y HAVING.
### Uso de **GROUP BY** 
- Utilice la cláusula GROUP BY para dividir las filas de una tabla en grupos más pequeños.

```
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id 
ORDER BY department_id;
```

- ¿Qué sucedería si deseara saber el salario máximo de los empleados de cada departamento?
- Usamos la cláusula GROUP BY que indica qué columna utilizar para agrupas las filas.

```
SELECT department_id ,MAX(salary) 
FROM employees
GROUP BY department_id
ORDER BY department_id;
```
### COUNT
- Recuerde que las funciones de grupo ignoran los valores nulos, por lo que si algún país no tiene un nombre de país, no se incluirá en el valor COUNT.

```
SELECT COUNT(country_name), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;
```

- Esto es poco probable, pero al crear sentencias SQL tenemos que pensar en todas las posibilidades
- Sería mejor escribir la consulta utilizando COUNT(\*).
- Esto contaría todas las filas de cada grupo de regiones, sin tener que comprobar las columnas que contuviesen valores NULL.
### Cláusula WHERE
- También podemos utilizar una cláusula WHERE para excluir las filas antes de que las filas restantes formen grupos.

```
SELECT department_id, MAX(salary)
FROM employees
WHERE last_name != 'King'
GROUP BY department_id;
```
### Directrices de GROUP BY
- Si incluye una función de grupo (AVG, SUM, COUNT, MAX, MIN, STDDEV, VARIANCE) en una cláusula SELECT junto con cualquier otra columna individual, cada columna individual también debe aparecer en la cláusula GROUP BY.
- No puede utilizar un alias de columna en la cláusula GROUP BY.
- La cláusula WHERE excluye las filas antes de que se dividan en grupos.
### Grupos dentro de GRUPOS
- A veces tiene que dividir los grupos en grupos más pequeños. 
- Puede agrupas  todos los empleados por departamento, y dentro de cada departamento agruparlos por trabajo
- **Puede crear grupos anidados**
- **Solo puede anidar funciones de grupo en 2 niveles si usa GROUP BY**

```
SELECT department_id, job_id, COUNT(*)
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id;

-- Solo puede anidar funciones de grupo en 2 niveles si usa GROUP BY
SELECT MAX(AVG(salary)) FROM employees GROUP BY department_id;
```

> [!NOTA]
> Las funciones de agrupamiento se pueden anidar en una profundidad de dos cuando se utiliza GROUP BY
### **HAVING**
- De la misma forma que usa WHERE para restringir las filas que seleccionó, puede usar la cláusula HAVING para restringir en los grupos.
- En una consulta con una cláusula GROUP BY y HAVING, primero agrupa las filas, se aplican las funciones de grupo y, a continuación, solo se muestran los grupos que coincidan con la cláusula HAVING.
- **HAVING para GROUP BY, es como WHERE para SELECT.**
- Suponga que desea buscar el salario máximo en cada departamento, pero solo para aquellos departamentos que tengan más de un empleado.

```
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1
ORDER BY department_id; -- ORDER BY SIEMPRE SE USA DE ÚLTIMO
```

# Uso de las Operaciones ROLLUP, CUBE y GROUPING SETS
--------------------------------

**Objetivos:**
- Utilizar ROLLUP para generar valores subtotales.
- Utilizar CUBE para generar valores de tabulación cruzada.
- Utilizar GROUPING SETS para generar un juego de resultados único.
- Utilizar la función GROUPING para identificar los valores de fila adicionales creados por una operación ROLLUP o CUBE.

- Para solucionar los problemas de grupos podría realizar la escritura de una sentencia que contenga las cláusulas GROUP BY y HAVING.
- ¿Qué ocurre si, una vez que haya seleccionado sus grupos y calculado los valores agregados en esos grupos, también deseara los subtotales por grupo y una suma total de todas las filas seleccionadas?
- Podría utilizar algunas de las extensiones de la cláusula GROUP BY, creadas específicamente para este fin: **ROLLUP, CUBE y GROUPING SETS**
- Al utilizar estas extensiones se necesita menos trabajo por su parte. Además, todas ellas tienen un uso muy eficaz, desde el punto de vista de las bases de datos.
### **ROLLUP**
- En las consultas GROUP BY, a menudo se deben producir subtotales y totales, y la operación ROLLUP puede realizar esta acción por usted.
- ROLLUP crea subtotales que se acumulan desde el nivel más detallado hasta la suma total, siguiendo la lista de agrupamiento especificada en la cláusula GROUP BY.

- La acción ROLLUP es directa: Crea subtotales que se acumulan desde el nivel más detallado hasta la suma total.
- ROLLUP utiliza una lista ordenada de las columnas del agrupamiento en su lista de argumentos.
- En primer lugar, calcula los valores de agregación estándar especificados en la cláusula GROUP BY.
- A continuación, crea subtotales de nivel superior de forma progresiva, de derecha a izquierda a través de la lista de columnas del agrupamiento.
- Por último. crea una suma total.

```
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP (department_id, job_id);
```

- ROLLUP devuelve los subtotales de los agrupamientos hechos con GROUP BY
- En la consulta anterior, se muestran dos columnas en la lista de argumentos de ROLLUP y, por lo tanto, verá que ese generan tres valores automáticamente.

![[Pasted image 20241103120131.png]]
### Fórmula de Resultado de ROLLUP
- El número de columnas o expresiones que aparecen en la lista de argumentos de ROLLUP determina el número de agrupamientos.
- La fórmula es (número de columnas) + 1, donde el número de columnas es el número de columnas que se indica en la lista de argumentos de ROLLUP.
### **CUBE**
- Al igual que ROLLUP, es una extensión de la cláusula GROUP BY.
- Genera informes de tabulación cruzada
- Se puede aplicar a todas las funciones de agregación, incluidas: AVG, SUM, MIN, MAX y COUNT.
- Las columnas que se muestran en la cláusula GROUP BY están incluidas en referencias cruzadas para crear un superjuego de grupos.
- Las funciones de agregación especificadas en la lista SELECT se aplican a estos grupos para crear valores de resumen para las filas superagregadas adicionales.

- Todas las combinaciones posibles de filas se agregan con CUBE.
- **Si tiene n columnas en la cláusula GROUP BY, habrá 2n posibles combinaciones de superagregados.**
- Matemáticamente, estas combinaciones forman un cubo de n dimensiones, que es de donde procede el nombre de n operador.

- CUBE se utiliza a menudo en las consultas que utilizan columnas de tablas independientes, en lugar de distintas columnas de una sola tabla.
- Un informe de tabulación cruzada normalmente solicitado podría incluir subtotales para todas las combinaciones posibles de las ventas de un mes, región y producto.

```
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id 50
GROUP BY CUBE (department_id, job_id);
```

![[Pasted image 20241103125940.png]]
### **GROUPING SETS**
- Es otra extensión de GROUP BY.
- Se utiliza para especificar varias columnas de datos.
- **Esto le proporciona la funcionalidad de tener varias cláusulas GROUP BY en la misma sentencia SELECT, lo cual no está permitido en la sintaxis normal.**
- Reduce la cantidad de filas que se solicitan en una consulta.
- Por lo tanto, el uso de GROUPING SETS es mucho más eficiente al escribir informes complejos.

```
SELECT department_id, job_id, manager_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY GROUPING SETS 
(
	(job_id, manager_id),
	(department_id, job_id),
	(department_id, manager_id)
);
```

![[Pasted image 20241103130722.png]]
### **Funciones GROUPING**
- Al utilizar ROLLUP o CUBE para crear informes con subtotales, muy a menudo también tiene que poder saber que filas de la salida son filas reales devueltas de la base de datos y que filas son filas del subtotal calculado resultantes de las operaciones ROLLUP o CUBE.
- Utilizando una sola columna de la consulta como argumento, la función GROUPING devolverá un 1 para una fila agregada (calculada) y un 0 para una fila no agregada (devuelta).
- La sintaxis de GROUPING es simplemente GROUPING (nombre_columna)
- Solo se utiliza en la cláusula SELECT y solo acepta una expresión de columna como argumento.

```
SELECT department_id, job_id, SUM(salary)
	GROUPING (department_id) AS "Dept sub total",
	GROUPING (job_id) AS "Job sub total"
FROM employees
WHERE department_id < 50
GROUP BY CUBE (department_id, job_id);
```

# Uso de los Operadores SET
----------------

**Objetivos:**
- Definir y explicar el objetivo de los operadores SET.
- Utilizar el operador SET para combinar varias consultas en una sola.
- Controlar el orden de las filas devueltas al utilizar los operadores SET.
### Operadores SET
- **Se utilizan para combinar los resultados de diferentes sentencias SELECT en una sola salida de resultado.**
- A veces desea una sola salida de más de una tabla.

- Si una las tablas, se devuelven las filas que cumplen con los criterios de unión, pero ¿qué sucede si una unión devuelve un juego de resultados que no responde a sus necesidades?
- Aquí es donde entran los operadores SET.
- Pueden devolver las filas que se han encontrado en varias sentencias SELECT, las filas que estén en una tabla y no en otra, o bien las filas comunes en ambas sentencias.
### Reglas que Recordar
Existen algunas reglas que se deben tener en cuenta al utilizar los operadores SET:
- El número de columnas y los tipos de dato de las columnas de ser idéntico en todas las sentencias SELECT utilizadas en la consulta.
- No es necesario que los nombres de las columnas sean idénticos.

- Los nombres de columna de la salida se toman de los nombres de columnas de la primera sentencia SELECT.
- Por lo tanto, los alias de columna se deben introducir en la primera sentencia, ya que desearía verlos en el informe terminado.
### **UNION**
- El operador UNION devuelve todas las filas de ambas tablas, después de eliminar los duplicados.

```
SELECT a_id FROM a
UNION
SELECT b_id FROM b;
```
### **UNION ALL**
- Devuelve todas las filas de ambas tablas, sin eliminar los duplicados.

```
SELECT a_id FROM a
UNION ALL
SELECT b_id FROM b;
```
### **INTERSECT**
- El operador INSERSECT devuelve todas las filas comunes a ambas tablas, eliminando duplicados.

```
SELECT a_id FROM a
INTERSECT
SELECT b_id FROM b;
```
### **MINUS**
- Devuelve todas las filas encontradas solo en una tabla, es decir que no devuelve los datos en común en ambas tablas

```
SELECT a_id FROM a
MINUS
SELECT b_id FROM b; -- Devuelve solo los datos de a
```













































































