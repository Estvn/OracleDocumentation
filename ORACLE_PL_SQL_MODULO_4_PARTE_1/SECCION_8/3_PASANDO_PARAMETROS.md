
**Objetivos:**

- Listar los tipos de modos de parámetros
- Crear un procedimiento que pase parámetros
- Identificar tres métodos de paso de parámetros
- Describir la opción DEFAULT de los parámetros

- Para hacer los procedimientos más flexibles, es importante que varíe la data ya sea calculada o pasada en procedimientos usando parámetros tipo input.
- **Los resultados calculados pueden ser retornados al llamado de un procedimiento usando parámetros OUT o IN OUT.**

# Modos de Parámetros Procedurales

- Los modos del parámetros son especificados en la declaración del parámetro formal, después del nombre del parámetro y antes del tipo de dato.

**Modos de paso de parámetros:**
- Un parámetro **IN** provee valores de un subprograma a procesar
- Un parámetro **OUT** retorna un valor al llamado
- Un parámetro **IN OUT** primero obtiene un valor, el cuál después puede ser modificado y retornar un nuevo valor.

# Default Mode: IN

- **IN** es el modo DEFAULT si no hay otro modo especificado.
- Parámetros **IN** solo pueden ser leídos dentro de un procedimiento
- No pueden ser modificados

```
CREATE OR REPLACE PROCEDURE raise_salary (
    p_id IN copy_emp.employee_id%TYPE,
    p_percent IN NUMBER)
IS BEGIN
    UPDATE copy_emp
        SET salary = salary * (1 + p_percent/100)
        WHERE employee_id = p_id;
END raise_salary;
```

# Using OUT Parameters: Example

```
CREATE OR REPLACE PROCEDURE query_emp(
    p_id IN employees.employee_id%TYPE,
    p_name OUT employees.last_name%TYPE,
    p_salary employees.salary%TYPE)
IS BEGIN
    SELECT last_name, salary INTO p_name, p_salary
    FROM employees
    WHERE employee_id = p_id;
END query_emp;

DECLARE 
    a_emp_name copy_emp.salary%TYPE;
    a_emp_sal copy_emp.salary%TYPE;
BEGIN
    -- En las variables se guardan los resultados retornados
    query_emp(178, a_emp_name, a_emp_sal);
	DBMS_OUTPUT.PUT_LINE('Name: ' || a_emp_name);
	DBMS_OUTPUT.PUT_LINE('Salary: ' || a_emp_sal);
END;
```

- Se crea un procedimiento con parámetros OUT para retornar información sobre un empleado.
- **El procedimiento acepta el valor 178 para empleado ID y retorna el nombre y el salario del empleado con ID 178 dentro de los dos parámetros OUT**

- Asegurese que el tipo de dato de la variables del parámetro actual usado para retornar valores de los parámetros OUT tiene el tamaño suficiente para manejar los valores de los datos que están siendo retornados.

# Using IN OUT Parameters: Example

```
CREATE OR REPLACE PROCEDURE format_phone(
	p_phone_no IN OUT VARCHAR2) IS
BEGIN
	p_phone_no := '(' || SUBSTR(p_phone_no, 1, 3) ||
					')' || SUBSTR(p_phone_no, 4, 3) ||
					'-' || SUBSTR(p_phone_no, 7);
END format_phone;
```

- Usando un IN OUT parámetros, puedes pasar un valor en un procedimiento que puede ser actualizado durante el procedimiento.
- El valor real del parámetro proporcionado por el entorno de llamada puede volverse como uno de los siguientes:
	- El valor original sin cambios
	- Un nuevo valor establecido dentro del procedimiento

# Llamando a un Procedimiento con Parámetros IN OUT

```
DECLARE
	a_phone_no VARCHAR2(13);
BEGIN
	a_phone_no := '8006330575';
	format_phone(a_phone_no);
	DBMS_OUTPUT.PUT_LINE('El formato del número es: ' || a_phone_no);
END;
```

# Resumen de los Modos de Parámetros

| IN                                                                                               | OUT                                          | IN OUT                                                      |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------- | ----------------------------------------------------------- |
| Default mode                                                                                     | Debe ser especificado                        | Debe ser especificado                                       |
| El valor es pasado dentro de un subprograma                                                      | Retornado en el entorno de llamado           | Pasado en un suprograma; retornado en el entorno de llamada |
| El parámetro formal actúa como una constante                                                     | Valor no inicializado                        | Inicializa la variable                                      |
| El parámetro actual puede ser un literal, constante, expresión, o inicializado como una variable | Debe ser una variable                        | Debe ser una variable                                       |
| Puede ser asignado como un valor default                                                         | No puede ser asignado a un valor por defecto | No puede ser asignado a un valor por defecto                |

# Sintaxis para Paso de Parámetros

Hay tres formas de pasar parámetros en el entorno de llamada:

1. **Posicional:** Lista el parámetro actual en el mismo orden que los parámetros formales.
2. **Nombrado:** Lista el parámetro actual en orden arbitrario y usa el operador asociado ('=>' el cual es igual y una flecha junta) para asociar un parámetro formal nombrado con un parámetro actual.
3. **Combinación:** Lista alguno de los parámetros actuales como posicionales y algunos como nombrados.

# Parameter Passing: Examples

```
CREATE OR REPLACE PROCEDURE add_dept(
	p_name IN my_depts.department_name%TYPE,
	p_loc IN my_depts.location_id%TYPE)
IS BEGIN 
	INSERT INTO my_depts (department_id, department_name, location_id)
	VALUES (departments_seq.NEXTVAL, p_name, p_loc);
END add_dept;
```

**Pasando por notación posicional:**

```
add_dept ('EDUCATION', 1400);
```

**Pasando por notación nombrada**

Los parámetros pueden estar en desorden, pero tiene que definir el nombre del parámetro junto con un argumento.

```
add_dept (p_loc=>1400, p_name=>'EDUCATION');
```

> [!DANGER]
> Si la combinación de notaciones es usada, los parámetros posicionales deben estar antes de los parámetros nombrados.

# Ejemplo de Paso de Parámetros

```
CREATE OR REPLACE PROCEDURE show_emps (
	p_emp_id IN NUMBER, p_department_id IN NUMBER, p_hiredate IN DATE)...
```

Notación posicional:

```
show_emps (101, 10, '01-dec-2006')
```

Notación nombrada:

```
show_emps(p_department_id => 10, p_hiredate => '01-dec-1007', p_emp_id => 101)
```

Notación de combinación:

```
show_emps(101, p_hiredate => '01-dec-2007', p_department_id => 10)
```

# Usando la Opción por Defecto de Parámetros IN

- Puedes asignar valores por defecto en parámetros formales **IN**.
- Esto provee flexibilidad cuando pasas parámetros

```
CREATE OR REPLACE PROCEDURE add_dept(
	p_name my_depts.department_name%TYPE := 'Unknown',
	p_loc my_depts.location_id%TYPE DEFAULT 1400)
IS BEGIN
	INSERT INTO my_depts (...)
	VALUES (departments_seq.NEXTVAL, p_name, p_loc);
END add_dept
```

- Usando la palabra clase DEFAULT hace más fácil identificar que un parámetro tiene un valor por defecto.

```
add_dept;
add_dept('ADVERTINSING', p_loc => 1400);
add_dept(p_loc => 1400);
```

# Lineamientos para usar la opción DEFAULT para los Parámetros

- No puede asignar valores por defecto a los parámetros OUT e IN OUT en el encabezado, pero puede hacerlo en el cuerpo del procedimiento.
- Usualmente, puede usar notaciones nombradas para sobre escribir los valores por defecto para los parámetros formales.

- Sin embargo, no puedes omitir la provisión de un parámetro real si no se proporciona un valor predeterminado para un parámetro formal.
- Un parámetro que hereda un valor predeterminado es diferente de NULL.


































