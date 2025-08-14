
**Objetivos:**

- Describir como los parámetros contribuyen en un procedimiento
- Definir un parámetro
- Crear un procedimiento usando un parámetro
- Invocar un procedimiento que tiene parámetros
- Diferenciar entre parámetros formales y actuales

- Mucho tiempo puede ser gastado durante la creación de un procedimiento
- Es importante crear un procedimiento de una forma flexible que puede ser usado, potencialmente, por más de un propósito o más de una pieza de datos.

- Para hacer procedimientos más flexibles, es importante que la variación de la data es o calculada o pasada en procedimientos usando parámetros.
- Los resultados calculados pueden ser retornados por medio de la llamada de un procedimiento usando parámetros.

# ¿Qué son los Parámetros?


- El paso de parámetros o comunicación de datos en la llamada de un subprograma.
- Puede pensar que los parámetros son una forma especial de una variable, los cuales los inputs son inicializados por el entorno de llamada cuando el subprograma es llamado, y los valores outpus son retornados en el entorno de llamada el subprograma retorna el control a el llamado.


```
PROCEDURE change_grade(p_student_id IN NUMBER, p_class_id IN NUMBER,
						p_grade IN VARCHAR2) IS
BEGIN
	...
	UPDATE grade_table
		SET grade = p_grade
		WHERE student_id = p_student_id AND class_id = p_class_id;
	...
END;
```

# ¿Qué son los argumentos?

- Los parámetros son comúnmente referenciados por los argumentos.
- Sin embargo, es más apropiado pensar en los argumentos como los valores reales asignados a las variables del parámetros cuando se llama el subprograma en tiempo de ejecución.3

- Incluso piense en los parámetros como un tipo de variables, parámetros **IN** son tratados como constantes dentro del subprograma y no pueden ser cambiados por el subprograma.

```
CREATE OR REPLACE PROCEDURE raise_salary
    (p_id IN copy_emp.employee_id%TYPE, p_percent IN NUMBER)
IS BEGIN    
    UPDATE copy_emp
        SET salary = salary * (1 + p_percent/100)
        WHERE employee_id = p_id;
END raise_salary;

BEGIN raise_salary(176, 10); END;

select * from copy_emp;
```

# Invocando Procedimientos con Parámetros

- Para invocar procedimientos, cree un bloque anónimo y use una llamada directa dentro de la sección ejecutable del bloque.
- Donde quiere llamar al nuevo procedimiento, ingrese el nombre del procedimiento y los valores de los parámetros (argumentos)

```
BEGIN
	raise_salary (176, 10);
END;
```

- **Debe invocar los argumentos en el mismo orden que sin declarados en el procedimiento.**

- Para invocar un procedimiento en otro procedimiento, usa el llamado directo dentro de la sección ejecutable del bloque.
- En la localización de la llamada del nuevo procedimiento, ingrese el nombre del procedimiento y los argumentos de los parámetros

```
CREATE OR REPLACE PROCEDURE process_employees
IS
	CURSOR emp IS 
		SELECT employee_id FROM my_employees;
BEGIN
	FOR v_emp_rec IN emp_cursor LOOP
		raise_salary(v_emp_rec.employee_id, 10);
	END LOOP;
END process_employees;
```

# Tipos de Parámetros

- Hay dos tipos de parámetros: **Formal y Actual**
- Un parámetro nombras y declarado en la cabeza del procedimiento es llamado un parámetro formal.
- El correspondiente parámetro nombrad en el ambiente de llamada es llamado un actual parameter.

## Parámetros Formales

- Los parámetros formales son variables que son declaradas en la lista de parámetros de la especificación del subprograma.

```
CREATE PROCEDURE raise_sal (p_id IN NUMBER, p_sal IN NUMBER) 
IS BEGIN
	...
END raise_sal;
```

> [!NOTA]
> Note que los tipos de datos de los parámetros formales no tienen tamaño

## Parámetros Actuales

- Los parámetros actuales pueden ser valores literales, variables o expresiones que son enviadas a la lista de parámetros de una llamada de subprograma.

```
a_emp_id := 100;
raise_sal (a_emp_id, 2000);
```

- Son asociados con parámetros formales durante la llamada del subprograma

































































