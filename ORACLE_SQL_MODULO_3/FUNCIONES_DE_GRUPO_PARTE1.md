
# FUNCIONES DE GRUPO - PARTE 1

# Funciones de Grupo
--------------

**Objetivos**
- Definir y proporcionar un ejemplo de las siente funciones de grupo: SUM, AVG, COUNT, MIN, MAX, STDDEV y VARIANCE.
- Crear y ejecutar una consulta SQL utilizando funciones de grupo.
- Crear y ejecutar funciones de grupo que solo funcionan con tipos de datos numéricos.
### Funciones de Grupo
- En SQL, las siguientes funciones de grupo se pueden utilizar en una tabla completa o en un grupo específico de filas. Cada función devuelve un resultado.
- Funciones de grupo:
	- AVG(col)
		- Calcula la media de columna numérica
	- COUNT
		- Devuelve el número de filas
	- MIN(col)
		- Se usa en columnas de cualquier tipo de dato.
	- MAX(col)
		- Se usa en columnas de cualquier tipo de dato.
	- SUM(col) 
		- Se usan en columna de numero y suma todos los valores
	- VARIANCE
		- Devuelve la varianza de valores de la columna.
	- STDDEV
		- Desviación estándar mide la difusión de los datos.

- Las funciones de grupo ignoran los valores nulos.
- Las funciones de grupo no se pueden utilizar en la cláusula WHERE.

# COUNT, DISTINCT, NVL
------------------------------

COUNT
- Devuelve un número de valores no nulos de la columna de expresión.
- COUNT(columna) ignora los valores nulos de la columna indicada.
- COUNT(\*) no ignora los valores nulos de la columna, entonces devuelve en número real de columnas de la tabla.

DISTINCT
- Se usa para devolver los valores no duplicados o combinaciones de valores no duplicados en una consulta.
- La palabra DISTINCT se puede usar con todas las funciones de grupo.

```
SELECT SUM(DISTINCT salary) FROM employees;
SELECT COUNT(DISTINCT job_id) FROM employees;
```

NVL
- A veces es preferible incluir valores nulos en funciones de grupo.

```
SELECT AVG(NVL(customer_orders, 0)) FROM employees;
```













































