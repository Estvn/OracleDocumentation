
**Objetivos:**

- Definir la estructura de un RECORD para un CURSOR usando el atributo %ROWTYPE
- Crear código PL/SQL para procesar las filas de un active set usando RECORD en cursores
- Recuperar información sobre el estado de un cursor explícito usando atributos de cursor

- **Una de las razones para usar cursores explícitos es que le pueden dar un mayor control de programación para el manejo de la data.**
- Esta lección discute sobre técnicas para usar los cursores explícitos de forma más efectiva.

> [!WARNING]
> - CURSOR RECORDS le permiten declarar en una sola variable todas las columnas definidas en el cursor.
> - Los atributos de cursor le permiten recuperar información sobre el estado de un cursor explícito.

# Cursores y Records

- ¿Qué pasa si quiere obtener 20 columnas de una tabla?
- **Con un RECORD puede obtener todas las columnas que obtiene su cursor.**

```
DECLARE 
	CURSOR cur_emps IS 
		SELECT * FROM employees 
			WHERE department_id = 30;

	v_emp_record cur_emps%ROWTYPE;
BEGIN
	OPEN cur_emps;
	LOOP
		FETCH cur_emps INTO v_emp_record;
	...
```

- **Use %ROWTYPE para declarar una estructura de record basada en el cursor.**
- Un CURSOR es un tipo de dato compuesto disponibles en PL/SQL.
- V_EMP_RECORD incluirá todas las columnas encontradas en la tabla EMPLOYEES.

# Estructura de un RECORD PL/SQL

- Un RECORD es un tipo de dato compuesto, que consiste en un número de campos, cada uno con su propio nombre y tipo de dato.
- **Se hace referencia a cada campo, anteponiendo un punto a su nombres de campo con el nombre del registro.**
- %ROWTYPE declara un RECORD con los mismos campos definidos en el SELECT relacionado con el cursor.

```
DECLARE 
	CURSOR cur_emps IS
		SELECT employee_id, last_name, salary FROM employees
			WHERE department_id = 30;

	v_emp_record cur_emps%ROWTYPE
```

Estructura del RECORD definido:

| v_emp_record.employee_id | v_emp_record.last_name | v_emp_record.salary |
| ------------------------ | ---------------------- | ------------------- |
| 100                      | King                   | 24000               |

- Todos los datos del RECORD son accedidos con el nombre del RECORD.
- Para referencias un campo individual, use la notación de punto mostrada en la tabla.

> [!NOTA]
> %ROWTYPE es conveniente para procesar las filas de un active set, porque puede simplificar el FETCH con el RECORD.

# Cursor y %ROWTYPE

```
DECLARE
    CURSOR cur_emp IS
        SELECT * FROM employees WHERE department_id = 10;
    v_emp_record cur_emp%ROWTYPE;
    
BEGIN
    OPEN cur_emp;
    LOOP
        FETCH cur_emp INTO v_emp_record;
        EXIT WHEN cur_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id || ' - ' || v_emp_record.last_name);
    END LOOP;
    CLOSE cur_emp;
END;

SET SERVEROUTPUT ON;
```

# Atributos de Cursores Explícitos

- Igual que los cursores implícitos, los cursores explícitos tienen varios atributos para obtener estado e información sobre el cursor explícito.
- **Cuando añade nombre de variable al cursor, hay varios atributos que pueden retornar información útil sobre el estado de manipulación de la ejecución del cursor.**

| Atributo  | Tipo    | Descripción                                                  |
| --------- | ------- | ------------------------------------------------------------ |
| %ISOPEN   | boolean | Retorna TRUE si el cursor está abierto                       |
| %NOTFOUND | boolean | Retorna TRUE si el FETCH más reciente no retornó ni una fila |
| %FOUND    | boolean | Retorna TRUE si el FETCH más reciente retornó una fila       |
| %ROWCOUNT | nunber  | Retorna el total de filas obtenidas mediante el FETCH        |

# Atributo %ISOPEN

- Usted puede obtener filas con el FETCH si el cursor está abierto.
- Use %ISOPEN para manejar el FETCH y probar si el cursor está abierto.
- %ISOPEN retorna el estado del cursor: TRUE si está abierto, y FALSE si no

```
IF NOT cur_emps%ISOPEN THEN
	OPEN cur_emps;
END IF;

LOOP
	FETCH cur_emps; 
	...
```

# Atributos %ROWCOUNT y %NOTFOUND

- Comúnmente %ROWCOUNT y %NOTFOUND son usando en el LOOP para determinar cuando salir del LOOP.

Use %ROWCOUNT para lo siguiente:
- Para procesar el número exacto de filas
- Para contar el número de filas Fetcheadas en el LOPP o determinar cuando salir del LOOP.

Use %NOTFOUND para lo siguiente:
- Determinar si la consulta encontró cualquier fila que cumpla con sus criterios.
- Para determinar cuándo salir del LOOP.

Ejemplo:

```
DECLARE
	CURSOR cur_emps IS
		SELECT employee_id, last_name FROM employees;
	
	v_emp_record cur_emps%ROWTYPE;
BEGIN

	IF NOT cur_emps%ISOPEN THEN
		OPEN cur_emps;
	END IF;

    <<cursor_loop>>
	LOOP
		FETCH cur_emps INTO v_emp_record;
		EXIT WHEN cur_emps%ROWCOUNT > 10 OR cur_emps%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(
        v_emp_record.employee_id || ' ' || v_emp_record.last_name
        );
    END LOOP cursor_loop;
    CLOSE cur_emps;
END;
```

# Atributos de Cursores Explícitos en Declaraciones SQL

> [!NOTA]
> - Puede usar atributos de cursores explícitos en sentencias SQL.
> - Las sentencias SQL pueden estar dentro del LOOP donde se hace FECTH para poder usar los atributos.
> - Puede usar los atributos en sentencias SQL fuera del LOOP, pero no tiene que cerrar el CURSOR
> - Puede usar los datos de los atributos para llevar bitácoras de las acciones realizadas.













































