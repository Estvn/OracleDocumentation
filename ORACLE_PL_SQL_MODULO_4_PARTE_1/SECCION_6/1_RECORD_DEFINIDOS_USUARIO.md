
**Objetivos:**

- Crear y manipular RECORDS PL/SQL definidos por el usuario

- Ya sabes como declarar y usar estructuras RECORD de PL/SQL que corresponden a la data FETCHED por un cursor, usando el atributo %ROWTYPE
- ¿Qué pasa si quieres crear y usar una variable con la estructura que corresponda a una fila entre en una tabla o vista, o un JOIN con varias tablas, en lugar de usar solo una o dos columnas?
- O quizás no necesitas una estructura RECORD que no corresponde con algún objeto de la base de datos.

# RECORDS PL/SQL

- un RECORD PL/SQL es un tipo de dato compuesto que consiste en un grupo de data relacionada almacenada en campos, casa uno con su propio nombre y tipo de dato.
- Puedes referencias el RECORD completo por su nombre y los campos individuales por sus nombres.

```
record_name table_name%ROWTYPE;
```

# Definición del Problema

- La tabla de empleados contiene 11 columnas
- Necesita hacer la consultas SELECT * INTO 
- ¿Cuántas variables e00scalares tiene que declarar para guardar los valores de columna?

- Esto es mucho código, y algunas tablas tienen más de 11 columnas.
- ¿Qué haría si una nueva columna es añadida a la tabla o si una columna es eliminada?

- **¿No sería más fácil declarar una variable en lugar de 11?**
- %ROWTYPE le permite declarar una variable como un RECORD basado en la estructura de una tabla
- Cada campo dentro del RECORD tendrá su propio nombre y tipo de datos en la estructura de la tabla.
- Puede referenciar el RECORD entero con su nombre y los campos individuales por sus nombres.

# Uso de un RECORD PL/SQL

- Es menos código para escribir y no hay problemas si una tabla se le añaden o borran columnas.

```
DECLARE
	v_emp_record employees%ROWTYPE;
BEGIN
		SELECT * INTO v_emp_record FROM employees
		WHERE employee_id = 100;
		DBMS_OUTPUT.PUT_LINE(
			v_emp_record.fisrt_name || ' ' ||
			v_emp_record.email
		);
END;
```

- Puede definir un record basándose en otro record

```
v_emp_record employees%ROWTYPE;
v_copy_emp_record v_emp_recor%ROWTYPE;
```

# Defina su Propio RECORD

- ¿Qué pasa si necesita datos de un JOIN con múltiples tablas?
- **Puede declarar su propia estructura de RECORD que contiene cualquier campo que desee.**

RECORDS PL/SQL:
- Debe contener uno o más componentes/campos de algún de dato compuesto o escalar.
- No son los mismo que las filas de las tablas de la base de datos.
- Puede asignar valores iniciales y pueden ser definidos como NOT NULL
- Pueden estar compuestos de otros RECORDS (RECORDS anidados)

# Sintaxis para RECORDS Definidos por el Usuario

- Empiece con la clave TYPE para definir la estructura del RECORD.
- Debería incluir al menos un campos y los campos deben ser definidos usando tipos de datos escalares tal como DATE, VARCHAR2 o NUMBER, o usar atributos tales como %TYPE y %ROWTYPE

```
TYPE type_name IS RECORD
	(field_declaration[, field_declaration]...);

identifier type_name;
```

# Ejemplo de un RECORD

```
DECLARE
    TYPE person_dept IS RECORD(
        first_name employees.first_name%TYPE,
        last_name employees.last_name%TYPE,
        department_name departments.department_name%TYPE
        );
    v_person_dept_rec person_dept;
BEGIN
    SELECT e.first_name, e.last_name, d.department_name
    INTO v_person_dept_rec
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE employee_id = 200;
    
    DBMS_OUTPUT.PUT_LINE(
        v_person_dept_rec.first_name || ' ' ||
        v_person_dept_rec.last_name || ' is in the ' ||
        v_person_dept_rec.department_name || ' department.');
END; 
```

# Nested User Defined RECORD

- Hay dos tipos de datos compuestos, uno anidado dentro de otro 

```
DECLARE
    TYPE dept_info_type IS RECORD(
        department_id departments.department_id%TYPE,
        department_name departments.department_name%TYPE
    );
    
    TYPE emp_dept_type IS RECORD(
        first_name employees.first_name%TYPE,
        last_name employees.last_name%TYPE,
        dept_info dept_info_type
    );
    
    v_emp_dept_rec emp_dept_type;
    
BEGIN
    ...
END;
```

# Declarando y Usando TYPES y RECORDS

- Los TYPES y RECORDS son estructuras compuestas que pueden ser declaradas en cualquier lugar donde puedan declarar variables escalares: bloques anónimos, procedimientos, funciones, package bodies, triggers, etc.
- Su alcance y visibilidad sigue las mismas reglas que las variables escalares.
- Puede declarar un tipo en un bloque externo y referenciarlo dentro de un bloque interno.

# Visibilidad y Alcance de los TYPES y RECORDS

- El TYPE y RECORD declarado en un bloque externo es visible en un bloque externo y un bloque interno.

```
DECLARE -- outer block
	TYPE employee_type IS RECORD(
		first_name employees.first_name%TYPE := 'Amy'
	);
	v_emp_rec_outer employee_type;
BEGIN
	DBMS_OUTPUT.PUT_LINE(v_emp_rec_outer.first_name);
	
	DECLARE -- inner block
		v_emp_rec_inner employee_type;
	BEGIN
		v_emp_rec_outer.first_name := 'Clara';
		DBMS_OUTPUT.PUT_LINE(
			v_emp_rec_outer.first_name || ' and ' ||
			v_emp_rec_inner.first_name);
	END;
	DBMS_OUTPUT.PUT_LINE(v_emp_rec_outer.first_name);
END;
```





























