
**Objetivos:**

- Distinguir entre un cursos implícito y explícito.
- Describir cuando y por qué usar un cursor explícito en el código PL/SQL
- Listar dos o más lineamientos para declaración y controlamiento de cursores explícitos.
- Crear código PL/SQL para abrir satisfactoriamente un cursos y tomar una pieza de datos en una variable

- **¿Qué pasaría si quiere escribir un SELECT que retorna más de una fila?**
- Para retornar más de una fila, debería declarar y usar un cursor explícito.

# Áreas de Contexto y Cursores

- El servicio de Oracle aloja una memoria privada llamada "context area" para almacenar la data procesada por una declaración SQL.
- Cada áreas de contexto (y cada declaración SQL) tiene un cursor asociado a ella.

- **Puede pensar que el cursor es una etiqueta hacia el área de contexto o un puntero hacia el área de contexto.**
- El cursor es ambos elementos.

# Cursores Implícitos y Explícitos

Cursores implícitos
- Definidos automáticamente por Oracle para todas las declaraciones SQL que retornan solo una fila

Cursores explícitos
- Declarados por el programador para consultas que retornan más de una fila
- **Puede declarar cursores explícitos para dirigirse a un área de contexto y acceder a su data.**

# Limitaciones de los Cursores Implícitos

- Si declara una consulta SQL que retorna más de una fila e intenta imprimir sus resultados creyendo que solo ha traído una fila, causará un error.

```
DECLARE
	v_salary employees.salary%TYPE;
BEGIN
	SELECT salary INTO v_salary	FROM employees;
	DBMS_OUTPUT.PUT_LINE(' Salary is : '||v_salary);
END;
```

- Para limitar que el SELECT solo retorne una fila, debe asegurarse de usar la sentencia WHERE y definir un valor único, como una llave primaria.
- O usar una función que retorna un solo valor, como SUM() o COUNT(*)

# Cursores Explícitos

- Con un cursor explícito, puedes obtener múltiples filas de una tabla de la base de datos, tener un puntero por cada fila que es recibida, y trabajar las filas una a la vez.

## Razones para usar un cursor explícito

- **Es la única manera en la que PL/SQL puede recibir más de una fila de una tabla.**
- Cada fila es traída por una declaración separada del programa, dando al programador más control sobre el procesamiento de las filas.

# Ejemplo de un Cursor Explícito

El siguiente ejemplo usa un cursor explícito para mostrar cada fila de la tabla de departamentos

```
DECLARE 
    CURSOR CUR_DEPTS IS
        SELECT department_id, department_name FROM departments;
    
    v_department_id departments.department_id%TYPE;
    v_department_name departments.department_name%TYPE;
BEGIN
    OPEN CUR_DEPTS;
    <<depts_loop>>
    LOOP
        FETCH CUR_DEPTS INTO v_department_id, v_department_name;
        EXIT WHEN CUR_DEPTS%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_department_id || ' - ' || v_department_name);
    END LOOP depts_loop;
    CLOSE CUR_DEPTS;
END;
```

# Operaciones de un Cursor Explícito

- El  conjunto de filas devuelto por una consulta de varias filas se denomina **Conjunto Activo** y se almacena en el área de contexto.
- Su tamaño es el número de filas que concuerda con los criterios de la consulta.

- Piensa en el área de contexto como una caja, y los sets activos son el contenido de la caja.
- Para obtener la data, tiene que abrir la caja y tomar cada fila de la caja, una a la vez.
- Cuando termine, debe cerrar la caja.

![[Pasted image 20250708214603.png]]

Primero declara el cursor y lo abre, toma lo datos, cuando termine cierra el cursor.

![[Pasted image 20250708214638.png]]

# Pasos para Usar Cursores Explícitos

1. DECLARE cursor
	- **Esto llenará el conjunto activo del cursor con los resultados de la instrucción SELECT en la definición del cursor.**
	- Declare el cursor en la sección declarativa, nombrelo y asocie una consulta SELECT SQL a él.
2. OPEN the cursor
	- La declaración de la apertura del cursor posiciona el puntero del cursor en la primera fila

3. FETCH cada fila del set activo y cargar la data en las variables
	- Después de cada FETCH, la declaración EXIT WHEN chequea si el FETCH ha alcanzado el final de los sets activos.
	- Si esto pasa, el NOTFOUND se podrá en TRUE.
	- Si el final de los sets activos es alcanzado, el LOOP termina

4. CLOSE the cursor
	- La declaración CLOSE despliega el set activo de filas.
	- Ahora es posible reabrir el cursor para establecer un set activo fresco usando una nueva declaración OPEN.

# Declarando el Cursor

- No incluya la cláusula INTO en la declaración del cursor porque debe ponerse después en la declaración de FECTH.
- Si el procesamiento de una fila en una secuencia específica es requerida, entonces use ORDER BY en la consulta.
- El cursor puede ser cualquier declaración SQL SELECT válida, incluyendo JOINS, subconsultas y demás.
- Si la declaración de un cursor referencia cualquier variable PL/SQL, estas variables deben estar declaradas antes de la declaración del cursor.

# Sintaxis para la Declaración de un Cursor

- El set activo de un cursor es determinado por la declaración SELECT en la declaración del cursor.

```
CURSOR cursor_name IS
	select_statement;
```

cursor_name -> es un identificador PL/SQL
select_statement -> Es una declaración SELECT sin la cláusula INTO

# Declaración de un Cursor - Ejemplos

Un SELECT simple:

```
DECLARE
	CURSOR cur_emps IS
		SELECT employee_id, last_name FROM employees
		WHERE department_id = 30
...
```

Un SELECT con un ORDER BY:

```
DECLARE 
	CURSOR cur_depts IS
		SELECT * FROM departments
		WHERE location_id = 1700
		ORDER BY department_name;
...
```

Un SELECT con un JOIN, GROUP BY y subconsultas:

```
DECLARE 
	CURSOR cur_depts IS
		SELECT department_name, COUNT(*) AS how_many
			FROM departments d, employees e
		WHERE d.department_id = e.department_id
		GROUP BY d.department_name
		HAVING COUNT(*) > 1;
...
```

# Abriendo el Cursor

- La declaración OPEN ejecuta la consulta asociada con el cursor, identifica el set activo y posiciona el puntero del cursor en la primera fila.
- La declaración OPEN se incluye en la sección ejecutable del bloque PL/SQL

```
DECLARE
	CURSOR cur_emps IS
		SELECT employee_id, last_name FROM employees
		WHERE department_id = 30;
BEGIN
	OPEN cur_emps;
```

La apertura maneja las siguientes operaciones:
- Aloja memoria para el área de contexto (crear la caja para alojar la data)
- **Ejecuta la declaración SELECT en la declaración del cursor, retorna los resultado en el conjunto activo (llena la caja con los datos).**
- Posiciona el puntero en la primera fila del conjunto activo.

# Trayendo Data desde el Cursor

- La declaración FETCH obtiene las filas con el cursor, una a la vez.
- Después de un FETCH satisfactorio, el cursor avanza a la siguiente fila del conjunto activo.

Obteniendo el primero resultado del active set generado por el CURSOR:

```
DECLARE
	CURSOR emp_cursor IS
		SELECT employee_id, last_name, FROM employees
		WHERE department_id = 10;
	v_empno employees.employee_id%TYPE;
	v_lname employees.last_name%TYPE;
BEGIN
	OPEN emp_cursor;
	FETCH emp_cursor INTO v_empno, v_lname;
	DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_lname);
...
```

- Dos variables fueron declaradas para obtener los valores de cada FECTH hecho del CURSOR.
- **El código anterior solo obtuvo la primera fila del los resultados que trajo el cursor.**
- Si tu consulta retorna 50 filas, tienes que usar el ciclo para acceder y procesar cada fila.

# Obteniendo Data del CURSOR

```
DECLARE
	CURSOR cur_emps IS
		SELECT 
```

# Lineamientos para Obtener Data de un Cursor

- Incluya el mismo número de variables en la cláusula INTO de la declaración FETCH que las columnas que traerá la declaración SELECT y asegurese que los tipos de datos son compatibles.
- Relacione cada variable para que corresponda con la posición de columna de la definición del cursor.
- Use %TYPE para asegurarse que los tipos de datos son compatibles entre la variable y el campo de la tabla.

- Haga Tests para verificar cuántas filas va a retornar un cursor
- Si un FETCH no adquiere valores, entonces no hay filas en la active set y no habrán errores.
- Puede usar %NOTFOUND para testear por la condición de salida.

# Cerrando el Cursor

- La declaración CLOSE deshabilita el cursor, libera la context area, e indefine el active set.
- Debería cerrar el cursor después de completar el procesamiento de la declaración FETCH.

```
...
	LOOP
		FETCH cur_emps INTO v_empno, v_lname;
		EXIT WHEN cur_emps%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_lname);
	END LOOP;
	CLOSE cur_emps;
END
```

- **Puede reabrir el cursor más adelante si es necesario.**
- Piense que CLOSE es cerrar una caja vacía, donde no hay más contenido para obtener.

# Lineamientos Para el Cierre de Cursores

- **Un cursor puede ser reabierto solo si ya está cerrado.**
- Si intentas obtener data de un cursor que ya fue cerrado, entonces la excepción INVALID_CURSOR será lanzada.
- **Si después reabres el cursor, la declaración SELECT asociada es ejecutada y rellena el área de contexto con la data más reciente de la base de datos.**

# Un cursor completo

```
DECLARE
	CURSOR cur_depts IS 
		SELECT department_id, department_name FROM departments

	v_department_id departments.department_id%TYPE;
	v_department_name departments.department_name%TYPE;

BEGIN

	OPEN cur_depts;
	LOOP 
		FETCH cur_depts INTO v_department_id, v_department_name;
		EXIT WHEN cur_depts%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_department_id || ' ' || v_department_name);
	END LOOP;
	CLOSE cur_depts;
END;
```











































































