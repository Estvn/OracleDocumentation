
**Objetivos:**

- Listar los beneficios de usar parámetros con cursores
- Crear código PL/SQL para declarar y usar un cursor con un parámetro

- Considere un programa donde se declara un cursor para fetchear y procesar todos los empleados de un departamento dado, y el departamento es elegido en tiempo de ejecución.
- ¿Cómo podría hacer esta declaración en el cursor?

- Necesitamos crear varios cursores, uno por cada departamento, y cada uno con diferentes valores en la cláusula WHERE?
- **NO.** Necesitamos declarar solo un cursor para que maneje todos los departamentos, usando parámetros.

# Cursores con Parámetros

- Un parámetro es una variable que es usada en una declaración de cursor.
- **Cuando un cursor es abierto, el valor del parámetro es pasado a Oracle Server, el cual lo usa para decidir cuales filas retornar en el active set del cursor.**

- Esto significa que usted puede abrir y cerrar un cursor explícito varias veces en un bloque, o en diferentes ejecuciones del mismo bloque, retornando un diferentes **active set** en cada ocasión.
- Considere un ejemplo donde pasa el valor location_id a un cursor y retorna los nombres de los departamentos de esa localización.

```
DECLARE
    CURSOR cur_country (p_region_id NUMBER) IS
        SELECT country_id, country_name
            FROM countries
            WHERE region_id = p_region_id;
    
    v_country_record cur_country%ROWTYPE;
BEGIN
    OPEN cur_country(5);
    LOOP
        FETCH cur_country INTO v_country_record;
        EXIT WHEN cur_country%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            v_country_record.country_id || ' ' ||
            v_country_record.country_name
        );
    END LOOP;
    CLOSE cur_country;
END;
```

# Sintaxis de Definición de Cursores con Parámetros

- Cada parámetro nombrado en la declaración del cursor debería tener un valor correspondiente en la declaración OPEN.
- Los tipos de datos de parámetros son lo mismo que los tipos de datos escalares, pero no tienen tamaño definido.

- Los parámetros son usados en la cláusula WHERE de la declaración del cursor SELECT.

```
CURSOR cursor_name [(parameter_name datatype, ...)]
IS
	select_statement;
```

- cursor_name es el identificador PL/SQL para el cursor declarado.
- parameter_name es el nombre del parámetro
- datatype es el tipo de datos escalar del parámetro
- select_statement es la declaración SELECT sin la cláusula INTO

# Abriendo Cursor con Parámetros

La siguiente sintaxis muestra la apretura de un cursor con parámetros

```
OPEN cursor_name(parameter_value1, parameter_value2, ...);
```

- Pasa los valores de los parámetros cuando el cursor será abierto.
- De esta forma, puede abrir un cursor explícito varias veces y fetchear un active set cada vez.

```
DECLARE 
	CURSOR cur_countries (p_region_id NUMBER) IS
		SELECT country_id, country_name FROM countries
		WHERE region_id = p_region_id;

	v_ocuntry_record c_countries%ROWTYPE;
BEGIN
	OPEN cur_countries (5);
	...
	CLOSE cur_countries;
	OPEN cur_countries (145);
	...
```

Otro ejemplo de cursor con parámetros

```
DECLARE 
    CURSOR cur_emps (p_deptid NUMBER) IS
        SELECT employee_id, salary
        FROM employees
        WHERE department_id = p_deptid;
    
    v_deptid employees.department_id%TYPE;    
    v_emp_rec cur_emps%ROWTYPE;
BEGIN
    SELECT MAX(department_id) INTO v_deptid
        FROM employees;
    
    OPEN cur_emps(v_deptid);
    LOOP
        FETCH cur_emps INTO v_emp_rec;
        EXIT WHEN cur_emps%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_rec.employee_id || ' ' ||
                            v_emp_rec.salary);
    END LOOP;
    CLOSE cur_emps;
END;
```

# Cursor en FOR LOOP con Parámetros

Cuando usamos parámetros en un cursor con FOR LOOP necesitamos:
- Los parámetros deben ser puestos dentro de paréntesis seguido del cursor
- Las declaraciones FOR ... END LOOP le permiten ejecutar una secuencia de declaraciones múltiples veces.
- El cursor usará repetidamente nuevos valores que se pasan al parámetro.

```
DECLARE 
	CURSOR cur_emps (p_deptno NUMBER) IS
		SELECT employee_id, last_name
		FROM employees
		WHERE department_id = p_deptno;
BEGIN
	FOR v_emp_record IN cur_emps(10) LOOP
		...
	END LOOP;
END;
```

En el siguiente ejemplo un cursor es usado y se le pasan dos parámetros:

```
```





































