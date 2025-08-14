
**Objetivos:**

- Crear un INDEX por tabla
- Crear un INDEX por tabla de RECORDS
- Describir la diferencia entre RECORDS, tablas y tablas de records.

- Ya aprendiste a guardar temporalmente un RECORD en una sola variable, o usando el %RWOTYPE o RECORD definido por el usuario.
- **Sin embargo, hay ocasiones en las que necesita almacenar muchas filas de manera temporal.**

# ¿Qué es una Colección?

- Una colección PL/SQL es un conjunto con nombres de muchas ocurrencias del mismo tipo de datos almacenados con una variable.
- **Una colección es una variable de tipo de dato compuesto, similar a los RECORDS definidos por el usuario.**

- En esta lección discutimos INDEX  BY tables y los INDEX BY tables of records.
- Hay otros tipos de colecciones de variables, por ejemplo, **tablas anidadas y Varrays,** pero están fuera del alcance de este curso.

**Verá dos tipos de colecciones en esta lección:**
- Una INDEX BY table, la cual está basada en un simple campo o columna; por ejemplo, la columna last_name de la tabla EMPLOYEES.
- Un INDEX BY table of record el cual está basado en un tipo de RECORD compuesto; por ejemplo, la estructura de filas de la tabla de DEPARTMENTS.

- Debido a que las colecciones son variables PL/SQL, estas son almacenadas en memoria, igual que otras variables PL/SQL.
- Estas no están almacenadas en el disco, como los datos de las tablas de la base de datos.

# Un INDEX BY Table tiene una Primary Key

- Necesitamos poder referenciar cada fila en un INDEX BY Table.
- Por lo tanto, cada INDEX BY Table debe tener una Primary Key la cual sirve como un índice en la tabla.
- La Primary Key es típicamente una BINARY_INTEGER, pero esta puede ser también una VARCHAR2.

# Declarando un INDEX BY Table 

- Como los RECORDS definidos por el usuarios, debe declarar un TYPE y después declarar la variable de ese TYPE.

```
TYPE type_name IS TABLE OF DATA_TYPE
	INDEX BY PRIMARY_KEY_DATA_TYPE;

identifier type_name;
```

- El siguiente ejemplo configura una INDEX BY Table para almacenar todas las fechas de contratación de la tabla EMPLOYEES

```
TYPE t_hire_date IS TABLE OF DATE
	INDEX BY BINARY_INTEGER;

v_hire_date_tab t_hire_date;
```

# Llenando un INDEX BY Table

La sintaxis para llenar un INDEX BY Table es:

```
DECLARE
	TYPE type_name IS TABLE OF DATA_TYPE
	INDEX BY PRIMARY_KEY_DATA_TYPE;
	identifier type_name;
BEGIN
	FOR record IN (SELECT column FROM table) LOOP
		identifier (primary_key) := record.column;
	END LOOP;
END;
```

- La Primary Key puede ser inicializadas usando una columna UNIQUE de la tabla seleccionada o integer incremental.

Este ejemplo llena un INDEX BY table con la fecha de contratación de los empleados, utilizando el ID del empleado como clave principal.

```
DECLARE
    TYPE t_hire_date IS TABLE OF employees.hire_date%TYPE
    INDEX BY BINARY_INTEGER;
    
    v_hire_date_tab t_hire_date;
BEGIN
    FOR emp_rec IN (SELECT employee_id, hire_date FROM employees)
    LOOP
        v_hire_date_tab(emp_rec.employee_id) := emp_rec.hire_date;
    END LOOP;
    -- DBMS_OUTPUT.PUT_LINE(v_hire_date_tab);
END;

SET SERVEROUTPUT ON; 
```

# Métodos de INDEX BY Table

- Puedes usar procedimientos y funciones creados para referenciar elementos individuales de las INDEX BY Table, o leer elementos sucesivos.

Los métodos disponibles son:

| EXISTS | PRIOR  |
| ------ | ------ |
| COUNT  | NEXT   |
| FIRST  | DELETE |
| LAST   | TRIM   |
# Usando Métodos de INDEX BY Table

Este ejemplo demuestra el uso del método COUNT

```
DECLARE
	TYPE t_hire_date IS TABLE OF employees.hire_date%TYPE
	INDEX BY BINARY_INTEGER;

	v_hire_date_tab t_hire_date;
	v_hire_date_count NUMBER(4);
BEGIN
	FOR emp_rec IN
	(SELECT employee_id, hire_date FROM employees)
	LOOP
		v_hire_date_tab(emp_rec.employee_id) := emp_rec.hire_date;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_hire_date_tab.COUNT);
END;
```

# INDEX BY TABLE OF RECORDS

- Incluso cuando un INDEX BY TABLE puede tener solo un campo en la data, ese campo puede ser un **tipo de dato compuesto** tal como un RECORD.
- Esto es un INDEX BY Table of Records.
- El Record puede ser un %ROWTYPE de un record definido por el usuario.

El ejemplo declara un INDEX BY Table para almacenar filas completas de la tabla de empleados:

```
DECLARE
	TYPE t_emp_rec IS TABLE OF employees%ROWTYPE
	INDEX BY BINARY_INTEGER;

	v_employees_tab t_emprec;
```

- Los campos individuales en una tabla de RECORDS puede ser referenciada agregando un valor INDEX en paréntesis después de la tabla de nombre de RECORDS.
- **Sintaxis: table(index).field**
- Ejemplo: v_employees_tab(index).hire_date

```
DECLARE
	TYPE t_emp_rec IS TABLE OF employees%ROWTYPE
	INDEX BY BINARY_INTEGER;
	v_emp_rec_tab t_emp_rec;
BEGIN
	FOR emp_rec IN (SELECT * FROM employees) LOOP
		v_emp_rec_tab(emp_rec.employee_id) := emp_rec;
		
		DBMS_OUTPUT.PUT_LINE(v_emp_rec_tab(emp_rec.employee_id).salary);
	END LOOP;
END;
```













































































