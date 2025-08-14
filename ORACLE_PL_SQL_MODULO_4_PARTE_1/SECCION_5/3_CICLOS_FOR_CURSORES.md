
**Objetivos:**

- Listar y explicar los beneficios de usar ciclos FOR en los cursores
- Crear código PL/SQL para declarar un cursor y manipularlo en un ciclo FOR.
- Crear código PL/SQL que contenga un ciclo FOR para un cursor usando una subconsulta.

- Ya aprendió a declarar y usar un cursor explícito simple usando DECLARE, OPEN y FETCH en un LOOP, testear con %NOTFOUND y cerrar la declaración
- **¿No sería más fácil si pudiera hacer todo esto en una sola declaración?**
- Puede lograr todo esto usando FOR para los ciclos.

# CURSOR FOR LOOPS

- Un cursor FOR loop procesa filas en un cursor explícito
- Es un atajo porque se abre el cursor, se obtiene una fila por cada iteración del bucle, el bucle sale cuando se procesa la última fila y el cursor se cierra automáticamente.
- El bucle en sí finaliza automáticamente al final de la iteración cuando se obtiene la última fila.

Sintaxis:

```
FOR record_name IN cursor_name LOOP
	statement1;
	statement2;
END LOOP;
```

- Puede simplificar su código usando un CURSOR FOR LOOP en lugar de un OPEN, FETCH y declaración CLOSE.
- **Un CURSOR FOR LOOP de forma implícita declara el contador del LOOP como un registro que representa una fila extraída de la base de datos.**

un CURSOR FOR LOOP:
- Abre un cursor
- Obtiene repetidamente los valores de las filas del active set en los campos del RECORD.
- Cierra el cursor cuando todas las filas han sido procesadas.

```
DECLARE 
	CURSOR cur_emps IS
		SELECT employee_id, last_name FROM employees
		WHERE department_id = 50;
BEGIN
	FOR v_emp_record IN cur_emps LOOP
		DBMS_OUTPUT.PUT_LINE(
		v_emp_record.employee_id || ' ' || v_emp_record.last_name
		);
	END LOOP;
END;
```

> [!IMPORTANT]
> v_emp_record es el RECORD declarado implícitamente en el FOR.
> Puede acceder a la data fetcheada con este cursor implícito.

- No hay variables declaradas para manejar la data FETCHEADA y no hay clausulas INTO que se requieran.
- OPEN y CLOSE no son requeridos, ellos están agregados automáticamente en la sintaxis del FOR.

- Puede comparar los CURSOR FOR LOOPS y los ciclos simples para iterar el contenido de los cursores.
- **Hay dos formas del código que son lógicamente idénticas la una a la otra y producen exactamente el mismo resultado.**

- No es necesario declarar la variable **v_emp_rec** en la sección declarativa. La sintaxis "FOR v_emp_rec IN ..." define de forma implícita el cursor.
- Dentro del ciclo, puede acceder a la data FETCHEADA usando record_name.column_name (e.g. v_emp_rec.employee_id)

> [!important]
>  **El alcance del RECORD implícito es restringido en el LOOP, no puede referenciar la data FETCHEADA fuera del LOOP.**

```
DECLARE 
	CURSOR cur_emps IS
		SELECT employee_id, last_name
			FROM employees
			WHERE department_id = 50;
BEGIN
	FOR v_emp_rec IN cur_emps LOOP
		DBMS_OUPUT.PUT_LINE(...);
	END LOOP;
END;
```

# Lineamientos para los CURSOR FOR LOOPS

- No declare el RECORD que controla el ciclo porque es declarado implícitamente.
- El alcance del RECORD implícito es restringido por el LOOP, así que no puede referenciar el RECORD fuer del LOOP.
- Puede acceder a la data FETCHEAA usando record_name.column_name

# Testing Cursor Attributes

- Aún puede probar los atributos del cursor, con %ROWCOUNT
- En el siguiente ejemplo el ciclo termina después de 5 filas FETCHEADAS y procesadas.
- El cursor aún se cierra automáticamente

```
DECLARE 
	CURSOR cur_emps IS
		SELECT employee_id, last_name
			FROM employees;
BEGIN
	FOR v_emp_record IN cur_emps LOOP
		EXIT WHEN cur_emps%ROWCOUNT > 5;
		DBMS_OUTPUT.PUT_LINE(
			v_emp_record.employee_id || ' ' || 
			v_emp_record.last_name
		);
	END LOOP;
END;
```

# CURSOR FOR LOOP usando Subconsultas

- Puede ir un paso más allá. **¡No necesita declarar el cursor en ABSOLUTO!**
- En lugar de eso, puede especificar el SELECT que iba a relacionar al CURSOR directamente en el FOR LOOP
- La ventaja de esto es que la definición del CURSOR es contenida en un único FOR ... statement.
- **En un complejo código con un montón de cursores, esta simplificación hace el código más mantenible, fácil y rápido.**
- La parte mala es que no puedes hacer referencia a los atributos de cursores.

```
BEGIN
    FOR c_emp_rec IN (
        SELECT employee_id, last_name 
        FROM employees WHERE department_id = 50)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            v_emp_record.employee_id  || ' ' ||
            v_emp_record.last_name
        );
    END LOOP;
END;
```

¡Mira la diferencia!

![[Pasted image 20250709154342.png]]

- Lógicamente son idénticos, pero uno es mucho más resumido que el otro.
























