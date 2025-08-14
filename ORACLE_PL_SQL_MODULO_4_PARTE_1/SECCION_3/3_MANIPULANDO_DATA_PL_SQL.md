
**Objetivos:**
- Construir y ejecutar declaraciones PL/SQL que manipulan data con las declaraciones DML.
- **Describir cuando usar cursores implícitos o explícitos en PL/SQL.**
- Crear código PL/SQL para usar cursores implícitos.

- **Ya aprendiste que puedes incluir declaraciones SELECT que retornan una sola fila en un bloque PL/SQL.**
- La data recuperada debe ser guardada en variables usando la cláusula INTO
- En esta lección aprenderás como incluir declaraciones DML, tal como INSERT, UPDATE, DELETE y MERGE en bloques PL/SQL.
- **Las declaraciones DMLM le ayudarán a manejar una tarea en más de una simple fila.**

# Crear una Copia Original de una Tabla

- Si necesita modificar la data de una tabla, pero necesita mantener los datos de la tabla original intactos, puede hacer una copia de la tabla de la siguiente forma:

```
CREATE TABLE copy_emp AS SELECT * FROM employees;
```

# Manipulando Data Usando PL/SQL

Puedes hacer cambios en la data usando comandos DML en su bloque PL/SQL:
- INSERT
- UPDATE
- DELETE
- MERGE

- La sentencia MERGE selecciona filas de una tabla para actualizar o insertar en otra tabla.
- La decisión de Actualizar o insertar en la tabla destino está basado en la condición de la cláusula ON.

- **MERGE es una sentencia determinista; es decir, no se puede actualizar la misma fila de la tabla destino varias veces en la misma sentencia MERGE.**
- Debe tener privilegios de objeto INSERT y UPDATE en la tabla de destino y el privilegio SELECT en la tabla de origen.

# INSERT DATA

- La declaración INSERT agrega nuevas filas en una tabla.

```
BEGIN 
	INSERT INTO copy_emp
		(employee_id, first_name, last_name, email, hire_date, job_id, salary)
	VALUES (99, 'Ruth', 'Cores', 'RCORES', SYSDATE, 'AD_ASST', 4000);
END;
```

# UPDATE DATA

- Update modifica una fila existente en una tabla.

```
DECLARE
    v_sal_increase copy_emp.salary%TYPE := 1000;
BEGIN
    UPDATE copy_emp
        SET salary = salary + v_sal_increase
    WHERE job_id = 'ST_CLERK';
END;
```

# DELETE DATA

```
DECLARE 
    v_deptno copy_emp.department_id%TYPE := 10;
BEGIN
    DELETE FROM copy_emp
        WHERE department_id = v_deptno;
END;
```

# MERGING ROWS

- La declaración MERGE selecciona filas de una tabla para actualizarlas o insertarlas en otra tabla

```
BEGIN
	MERGE INTO copy_emp c USING employees e
		ON (e.employee_id = c.employee_id)
	WHEN MATCHED THEN
		UPDATE SET
			c.first_name = e.first_name,
			c.last_name = e.last_name,
			c.email = e.email,
			...
	WHEN NOT MATCHED THEN
		INSERT VALUES(e.employee_id, e.first_name, .... e.department_id);
END;
```

# Obteniendo Información de un Cursor

Mira esta declaración DELETE en el bloque PL/SQL:

```
DECLARE
	V_deptno employees.department_id%TYPE := 10;
BEGIN 
	DELETE FROM copy_emp
		WHERE department_id = v_deptno;
END;
```

 - Sería útil saber cuántas filas fueron borraras con esta declaración.
 - Para obtener esta información, necesitamos saber que son los cursores.

# **¿Qué es un Cursor?**
-------------------

- Cada vez que una declaración SQL está por se ejecutada, el servidor de Oracle aloja un área de memoria privada para almacenar las declaraciones SQL y la data que usa.
- **Esta memoria es conocida como un cursor implícito.**
- Porque esta memoria es manejada automáticamente por el servidor Oracle, usted no tiene control directo sobre ella.

- **Sin embargo, puede usar variables PL/SQL predefinidas que llaman a atributos de los cursores implícitos, así puede saber cuántas filas son procesadas por una declaración SQL.**

# Cursores Implícitos y Explícitos

### Cursores Implícitos

- Definidos automáticamente por Oracle para la manipulación de declaraciones de datos en SQL, y para consultas que retornan solo una fila.
- Un cursor implícito es automáticamente llamado SQL.

### Cursores Explícitos

- Definidos por el programador en PL/SQL para consultas que retornan más de una fila.

# Atributos de cursos para cursores implícitos

- Los atributos del cursor son automáticamente declarados variables que le permiten evaluar que pasó cuando un cursor fue usado la última vez.
- Los atributos de los cursores implícitos son predefinidos como "SQL".
- **Use estos atributos en las declaraciones PL/SQL pero no en las declaraciones SQL.**

> [!NOTA]
> Usar atributos de cursor puede testear la salida de las declaraciones SQL.

# Atributos de cursor para cursores implícitos

| Atributo     | Descripción                                                                                                 |
| ------------ | ----------------------------------------------------------------------------------------------------------- |
| SQL%FOUND    | Un valor booleano que evalúa en TRUE si la más reciente declaración SQL ha retornado al menos una fila.     |
| SQL%NOTFOUND | Un valor booleano que retorna TRUE si la más reciente declaración SQL no ha retornado ni siquiera una fila. |
| SQL%ROWCOUNT | Un INTEGER valor que representa el número de filas afectadas por la más reciente declaración SQL.           |

# Usando Atributos de Cursores Implícitos: Ejemplo 1

- Borre las filas que tienen específicamente el employee_id de la tabla copy_emp
- Imprima el número de las filas borradas

```

```


































































