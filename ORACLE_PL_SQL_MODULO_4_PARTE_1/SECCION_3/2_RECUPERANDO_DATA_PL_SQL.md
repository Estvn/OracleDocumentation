
**Objetivos:**

- Reconocer las declaraciones SQL que pueden incluirse directamente en los bloque ejecutables PL/SQL.
- Construya y ejecute una cláusula INTO para almacenar los valores devueltos por una instrucción SQL SELECT en una sola fila.
- Construya declaraciones para recuperar data que siga buenas prácticas.
- Construya declaraciones para aplicar buenas practicas en el nombramiento de las variables.

- Aprenderá como embeber estados SQL SELECT estándar en los bloques PL/SQL.
- Vas a aprender la importancia  de seguir el uso de los lineamientos y convenciones de lineamientos cuando se recupere data.
- Los bloques pueden ser un buen método para organizar tu código.
- Cuando revisar código escrito por alguien más, es más fácil leer piezas de un programa que leer un programa largo y continuo.

# Estados SQL en PL/SQL

Puedes usar los siguientes tipos de estados SQL en PL/SQL:
- Declaraciones SELECT para recuperar data de la base de datos.
- Declaraciones DML, tal como INSERT, UPDATE y DELETE para hacer cambios en la base de datos.
- Declaraciones de control de transacciones como COMMIT y ROLLBACK o SAVEPOINT, para hacer cambios permanentes en la base de datos o deshacerlos.

# Limitaciones DDL/DCL en PL/SQL

- No puedes usar DDL y DCL directamente en PL/SQL

| Handle Style | Description                           |     |
| ------------ | ------------------------------------- | --- |
| DDL          | CREATE TABLE, ALTER TABLE, DROP TABLE |     |
| DCL          | GRANT, REVOKE                         |     |

- PL/SQL no soporta directamente declaraciones DDL, como CREATE, ALTER o DROP TABLE, o declaraciones DCL tal como GRANT y REVOKE.

- No puedes directamente ejecutar declaraciones DDL y DCL porque esto se construye y se ejecuta en tiempo de ejecución, es dinámico
- Hay tiempos donde necesitas correr DDL o DCL dentro de PL/SQL.
- La forma recomendada de trabajar con DDL y DCL en PL/SQL es usar SQL dinámico con la instrucción **EXECUTE IMMEDIATE.**

# Declaraciones SELECT en PL/SQL

- Recuperar data de la base de datos en variables PL/SQL con una declaración SELECT 

```
SELECT select_list
	INTO {variable_name [, variable_name]...
	| record_name}
FROM table
	[WHERE condition];
```

# Usando la Cláusula INTO

```
DECLARE
	v_emp_lname employees.last_name%TYPE;
BEGIN
	SELECT last_name 
		INTO v_emp_name
	FROM employees
		WHERE employee_id = 100;

	DBMS_OUTPUT.PUT_LINE('His last name is ' || v_emp_lname);
END;
```

# Recuperando Data en un Ejemplo PL/SQL

- Debes especificar una variable por cada item seleccionado, y el orden de las variables deben corresponder con el orden de los items seleccionados.

```
DECLARE
    v_emp_hiredate employees.hire_date%TYPE;
    v_emp_salary employees.salary%TYPE;
BEGIN
    SELECT hire_date, salary
        INTO v_emp_hiredate, v_emp_salary
    FROM employees
        WHERE employee_id = 100;
        
    DBMS_OUTPUT.PUT_LINE('Hiredate: ' || v_emp_hiredate);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_emp_salary);
END;
```

# Regla Embebida para Recuperar Data en PL/SQL 

- Las sentencias SELECT dentro de un bloque PL/SQL se incluyen en la clasificación ANSI de SQL integrado, para la cual se aplica la siguiente regla: las consultas integradas deben devolver exactamente una fila.

> [!DANGER]
> - **Las consultas integradas deben devolver exactamente una fila.**
> - Una consulta que retorna más de una fila o ninguna genera un error.
> 
> 

Esta consulta genera error porque retorna más de una fila:

```
DECLARE
	v_salary employees.salary%TYPE;
BEGIN
	SELECT salary INTO v_salary
		FROM employees;

	DBMS_OUTPUT.PUT_LINE('El salario es: ' || v_salary);
END;
```

# Lineamientos para Recuperar Data en PL/SQL

- Terminar cada declaración SQL con un ;
- Cada valor retornado debe ser almacenado en una variable usando la cláusula INTO.
- La cláusula WHERE es opcional y puede contener variables, constantes, literales o expresiones PL/SQL.
- **Solo se debe obtener una fila y, por lo tanto, el uso de la cláusula WHERE es necesaria en casi todos los casos.**

- Asegurese que las columnas y variables están en la misma posición y sus tipos de datos son compatibles.
- Para asegurarse que el tipo de datos de las variables y las columnas de las tablas son iguales, use el %TYPE.

> [!DANGER]
 **Evite el uso de los nombres de las columnas como identificadores de las variables.**

- Los errores pueden ocurrir durante ejecución porque PL/SQL revisa primero la base de datos para ver una columna en una tabla.



















































