
**Objetivos:**
- Insertar data en una tabla 
- Actualizar data en una tabla
- Borrar data en una tabla
- Mezclar data en una tabla

- Cuando creas, cambiar o borrar un objeto en una base de datos, el lenguaje que estás usando es Data Definition Language (DDL)
- Cuando cambias la data de un objeto (insertar filas, borrar filas, cambiar los valores de columnas y de filas), estás usando Data Manipulation Language (DML).

# Data Manipulation Language (DML)

- Puede usar DML para agregar filas, borrar y modificar la data en una fila.
- **Los comandos DML son INSERT, UPDATE, DELETE y MERGE.**

- Cuando AUTOCOMMIT es desactivado, los comandos DML producen cambios permanentes solo cuando el comando COMMIT es producido en un bloque PL/SQL o el mismo.
- Si el usuario cierra sesión normalmente o cierra el navegador antes de ejecutar el comando COMMIT, los cambios se van a deshacer (ROLL BACK).

# INSERT

- Use INSERT para agregar nuevas filas a la tabla
- Requiere de dos valores
	- El nombre de la tabla
	- Los valores de cada columna en la tabla
	- (opcional) Los nombres de las columnas que van a recibir un valor 

- Cuando inserte una fila en la tabla, debe proporcionar un valor para cada columna que no puede ser NULL.
- Otra forma de insertar valores en una tabla es agregarlos todos sin listar los nombres de las columnas de la tabla

```
INSER INTO employees VALUES (305, xd, xd, xd, ..., xd);
```

# UPDATE

- Se usa para modificar filas existentes en una tabla
- Requiere tres valores:
	- El nombre de la tabla
	- El nombre de la columna que va a modificar
	- El valor de cada columna que va a ser modificado.
	- (opcional) La cláusula WHERE que identifica la fila o las filas a modificar
	- **Si la cláusula WHERE es omitida, todas las filas serán modificadas**

```
UPDATE employees
	SET salary = 11000, commission_pct = .3
	WHERE employee_id = 176;
```

# DELETE

- Use DELETE para remover filas existentes en una tabla.
- La delcaración requiere al menos un item
	- El nombres de la tabla
	- (opcional) una cláusula WHERE que identifica la fila o las filas que van a ser borradas
- **Si WHERE es omitido, todas las filas serán eliminadas.**
- Muy pocas situaciones requieren que DELETE se use sin WHERE.

```
DELETE FROM employees
	WHERE department_id = 80;
```

# MERGE

- Las instrucción insertará una nueva fila en la tabla destino o actualizará los datos existentes en una tabla de destino, basándose en una comparación de los datos en las dos tablas.
- La clausula WHEN determina que acción va a ser tomada.

- Por ejemplo, si una fila en específico existe en la table fuente, pero no hace match con ninguna de las filas en la tabla destino, la fila de la tabla fuente será insertada en la tabla destino
- Si una fila coincide en la tabla destino, pero alguna data es diferente en esta, la tabla destino puede actualizarse con esos valores diferentes.

## Ejemplo de MERGE

- Considere la situación donde necesitamos calcular los bonos anuales para los empleados que ganan menos de $10_000 USD

```
CREATE TABLE bonuses(
	employee_id NUMBER(6,0) NOT NULL,
	bonus NUMBER(8,2) DEFAULT 0
);
```

- Luego, completamos la tabla con los ID de todos los empleados con un salario inferior a $10_000 USD.

```
INSERT INTO bonuses(employee_id)
	(SELECT employee_id FROM employees
		WHERE salary < 10000);
```

- Cada empleados con un salario con menos de $10_000 va a recibir un bono de 5% en su salario
- Para usar la columna de salario de la tabla de empleados para calcular el monto de la bonificación y actualizar la columna de bonificación en la tabla de bonificaciones use el siguiente MERGE.

```
MERGE INTO bonuses b
	USING employees e
	ON (b.employee_id = e.employee_id)
	WHEN MATCHED THEN
		UPDATE SET b.bonus = e.salary * .05;
```









































