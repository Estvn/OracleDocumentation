
**Objetivos:**

- Explicar la necesidad de usar cursores múltiples para producir múltiples niveles de reportes.
- Crear código PL/SQL para declarar y manipular cursores múltiples dentro de LOOPS anidados.
- Crear código PL/SQL para declarar y manipular cursores múltiples usando parámetros.

# Propósito

- Los programas en la vida real a veces necesitan declarar y usar dos o más cursores en el mismo bloque PL/SQL.
- A veces estos cursores están relacionados el uno al otro por medio de parámetros
- Un ejemplo común es la necesidad de los reportes multinivel, usando filas de un cursor diferente.
- En esta lección mostramos usos más poderosos de los conceptos y sintaxis ya conocidos.

# Ejemplo del Enunciado del Problema

- Necesita producir un reporte que liste cada departamento como un encabezado, inmediatamente seguido de una lista de empleados de cada departamento, seguido del siguiente departamento, y así sucesivamente.
- Necesita dos cursores, uno para cada tabla
- El cursor basado en los empleados es abierto varias veces, una vez por cada departamento.

## Solución : paso 1

- Declare dos cursores, uno para cada tabla, y asocie una estructura RECORD para cada cursor.

```
DECLARE
	CURSOR cur_depts IS
		SELECT department_id, department_name 
		FROM departments
		ORDER BY department_name
		FOR UPDATE NOWAIT;
	
	CURSOR cur_emp (p_deptid NUMBER) IS
		SELECT first_name, last_name 
		FROM employees
		WHERE department_id = p_deptid
		ORDER BY last_name
		FOR UPDATE NOWAIT;

	v_dept_rec cur_depts%ROWTYPE;
	v_emp_rec cur_emp%ROWTYPE;
```

## Solución: paso 2

- Abra el cur_dept cursor y fetchee y muestre las filas de DEPARTMENTS de la forma usual.

```
DECLARE
	CURSOR cur_dept IS ...;
	CURSOR cur_emp (p_deptid NUMBER) IS ...;

	v_dept_rec cur_dept%ROWTYPE;
	v_emp_rec cur_emp%ROWTYPE;
BEGIN 
	OPEN cur_dept;
	LOOP
		FETCH cur_dept INTO v_dept_rec;
		EXIT WHEN cur_dept%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_dept_rec.department_name);
	END LOOP;
	CLOSE cur_dept;
END;
```

## Solución: paso 3

- Después de que cada fila de DEPARTMENTS ha sido fetcheada y mostrada, necesita hacer fetch y mostrar los EMPLOYEES en el departamento.
- Para hacer esto, abra el cursor EMPLOYEES, haga fetch y muestre los filas en un ciclo anidado, y cierre el cursor.
- Luego, se hará lo mismo con el siguiente departamento y así sucesivamente.

```
DECLARE 
	CURSOR cur_dept IS ...;
	CURSOR cur_emp (p_dept_id NUMBER) IS ...;

	v_dept_rec cur_dept%ROWTYPE;
	v_emp_rec cur_emp%ROWTYPE;
BEGIN

	OPEN cur_dept;
	LOOP
		FETCH cur_dept INTO v_dept_rec;
		EXIT WHEN cur_dept%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_dept_rec.department_id);

		OPEN cur_emp (v_dept_rec.department_id);
		LOOP
			FETCH cur_emp INTO v_emp_rec;
			EXIT WHEN cur_emp%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(v_emp_rec.last_name || ' ' || 
								v_emp_rec.first_name);
		END LOOP;
		CLOSE cur_emp;
	END LOOP;
	CLOSE cur_dept;
END;
```

# Using FOR Loops with Multiple Cursors

- Puede usar FOR loops (y otras técnicas para cursores como FOR UPDATE) con múltiples cursores.

```
DECLARE
	CURSOR cur_log IS SELECT * FROM locations FOR UPDATE NOWAIT;
	CURSOR cur_dept (p_locid NUMBER) IS
		SELECT * FROM departments WHERE location_id = p_locid;
BEGIN
	FOR v_locrec IN cur_loc LOOP
		DBMS_OUPUT.PUT_LINE(v_locrec.city);
		FOR v_deptrec IN cur_dept (v_loc_rec.location_id) LOOP
			DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
		END LOOP;
	END LOOP;
END;
```


























































