
**Objetivos:**

- Definir una función almacenada
- Crear un bloque PL/SQL que contiene una función
- Listar formas en las que una función puede ser invocada.
- Crear bloques PL/SQL que invocan una función que tiene parámetros
- Listar los pasos de desarrollo para crear una función
- Describir las diferencias entre los procedimientos y las funciones

- En esta lección aprenderá a crear e invocar funciones
- **Una función es un subprograma nombrado que debe retornar exactamente un valor y debe ser llamado en una expresión SQL o PL/SQL.**
- Una función es una parte integral de un código modular.
- Está almacenada en la base de datos como objeto del esquema para ejecuciones repetidas.
- **Las funciones promueven reusabilidad y mantenibilidad**

# ¿Qué es una Función Almacenada?

- Una función es un bloque PL/SQL nombrado que puede aceptar parámetros **IN** opcionales y debe retornar exactamente un valor.
- **Las funciones deben ser llamadas como parte de expresiones SQL o PL/SQL**
- En las expresiones SQL, una función debe obedecer reglas específicas de control

**Evite lo siguiente dentro de las funciones:**
1. Cualquier tipo de DML o DDL
2. COMMIT o ROLLBACK
3. Alterar variables globales

- Ciertos tipos de retorno (booleano) impiden que se llame a una función como parte de una SELECT.
- Las expresiones en PL/SQL, el identificador de función actúa como una variable cuyo valor depende de los parámetros que se le pasen.

- **Una función debe tener un RETURN en el encabezado y al menos una instrucción RETURN en la sección ejecutable.**

# Sintaxis para la Creación de Funciones

El encabezado de las funciones es como el encabezado de un procedimiento, pero con dos diferencias:
1. El modo de parámetro solo puede ser IN
2. La cláusula de RETURN es usada en lugar del modo OUT

```
CREATE [OR REPLACE] FUNCTION function_name
	[(parameter1 [model1] datatype1, ...)]
RETURN datatype IS | AS
	[local_variable_declarations; ...]
BEGIN
	-- actions;
	RETURN expression;
END [function_name];
```

- Una función debe retornar un solo valor
- Debes proveer una declaración RETURN para retornar un valor con un tipo de dato que sea consistente con el tipo de declaración de función.

- Puedes crear nuevas funciones usando la declaración CREATE [OR REPLACE] FUNCTION la cual puede declarar una lista de parámetros, que debe retornar exactamente un valor, y debe definir la acción configurada en el bloque PL/SQL.

# Funciones Almacenadas con Parámetro: Ejemplo

Creación de una función:

```
CREATE OR REPLACE FUNCTION get_sal(
	p_id IN employees.employee_id%TYPE)
RETURN NUMBER IS
	v_sal employees.salary%TYPE := 0;
BEGIN
	SELECT salary INTO v_sal FROM employees
	WHERE employee_id = p_id;

	RETURN v_sal;
END get_sal;
```

Invoque la función como una expresión o como un valor de parámetro

```
... v_salary := get_sal(100);
```

# Usando RETURN

- Puedes usar RETURN desde la sección ejecutable o desde la sección de EXCEPTION

Creando una función:

```
CREATE OR REPLACE FUNCTION get_sal(
	p_id IN employees.employee_id%TYPE)
RETURN NUMBER IS 
	v_sal employees.salary%TYPE := 0;
BEGIN
	SELECT salary INTO v_sal FROM employees WHERE employee_id = p_id;
	RETURN v_sal;
EXCEPTION
	WHEN NO_DATA_FOUND THEN 
		RETURN NULL;
END get_sal;


... v_salary := get_sal(999);
```

# Formas de Invocar (o ejecutar) Funciones con Parámetros

Las funciones pueden ser invocada de las siguientes formas:

- **Como parte de expresiones PL/SQL** - Use una variable local en un bloque anónimo para manejar el valor retornado desde una función
- **Como un parámetro de otro subprograma** - Pasa funciones entre los subprogramas
- **Como una expresión en una declaración SQL** - Invoque funciones como otra fila en una declaración SQL

# Invocando una Función como parte de una Expresión PL/SQL

- Cuando invoque una función como parte de una expresión PL/SQL, puedes usar una variable local para almacenar el resultado retornado.

```
DECLARE v_sal employees.salary%TYPE;
BEGIN
	v_sal := get_sal(100);
END;
```

- También puedes invocar una función como parámetro a otro subprograma

```
... DBMS_OUTPUT.PUT_LINE(get_sal(100));
```

# Invocando una Función en una Expresión en una Declaración SQL

- **También puedes invocar una función como una expresión en una declaración SQL.**

El siguiente ejemplo muestra como puedes usar una función como una fila en una declaración SQL:

```
SELECT job_id, get_sal(employee_id) FROM employees;
```

- Si las funciones son creadas pensativamente, pueden ser construcciones poderosas.

# Invocando una Función como una Expresión en una Declaración SQL

- En las expresiones SQL, una función debe cumplir reglas específicas para control de efectos secundarios.
- Si quieres llamar una función almacenada de una declaración SELECT, la función almacenada no está permitida para manejar alguna declaración DML antes de retornar las declaraciones de esa función.

- Cuando una función es usada en una declaración SQL, se ejecuta una por cada fila que es procesada por declaración.
- Como una función retorna un valor cuando es invocada, la llamada a esta tener tener un mecanismo preparado para recibir el valor retornado de la función.

Si necesita una función para verificar la validación de un número de departamento por empleado, debe desarrollar la siguiente función:

```
CREATE OR REPLACE FUNCTION valid_dept(
    p_dept_no departments.department_id%TYPE)
RETURN BOOLEAN
IS 
    v_valid VARCHAR2(1);
BEGIN
    select 'x' INTO v_valid 
        FROM departments
        WHERE department_id = p_dept_no;
    RETURN (true);
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN (false);
    WHEN OTHERS THEN NULL;
END;
```

> [!WARNING]
> Esta función no puede ser llamada desde una declaración SQL porque retorna un valor Booleano, pero puede ser usada en otro bloques PL/SQL.

# Invocando Funciones Sin Parámetros 

- La mayoría de las funciones tienen parámetros, pero alguna no.
- Por ejemplo, la función del sistema USER y SYSDATE no tienen parámetros.
- Invoca como una parte de la expresión PL/SQL, usando una variable local para obtener el resultado.

```
DECLARE v_today DATE;
BEGIN v_today := SYSDATE; ...
END;
```

Use las funciones como parámetro para otro subprograma

```
... DBMS_OUTPUT.PUT_LIINE(USER);
```

Uselas en declaraciones SQL (sujetas a restricciones):

```
SELECT job_id, SYSDATE-hire_date FROM employees;
```

# Diferencia de Sintaxis Entre Procedimientos y Funciones

**Procedimientos:**

```
CREATE [OR REPLACE] PROCEDURE name [parameters] IS | AS (Mandatory)
Variables, cursors, etc. (Optional)
BEGIN (Mandatory)
	SQL and PL/SQL Statements;
EXCEPTION (Opcional)
	WHEN exception-handling actions;
END [name]; (Mandatory)
```

**Funciones:**

```
CREATE [OR REPLACE] FUNCTION name [parameters] (Mandatory)
RETURN datatype IS | AS
Variables, cursors, etc. (Optional)
BEGIN (Mandatory)
	SQL and PL/SQL statements;
	RETURN ...; (One Mandatory, more optional)
EXCEPTION (Optional)
	WHEN exception-handling actions;
END [name]; (Mandatory)
```

# Diferencias y Similitudes Entre Procedimientos y Funciones

| Procedimientos                                                                 | Funciones                                          |
| ------------------------------------------------------------------------------ | -------------------------------------------------- |
| Se ejecuta como una declaración PL/SQL                                         | invocado como parte de una expresión               |
| No contiene una cláusula RETURN en el encabezado                               | Debe contener una cláusula RETURN en el encabezado |
| Puede retornar valores si se requiere con parámetros IN OUTPUT (no requeridos) | Debe retornar un solo valor                        |
| Puede contener una declaración RETURN sin un valor                             | Debe contener al menos una declaración RETURN      |
- Ambos pueden tener cero o más parámetros IN que pueden se pasados desde un llamado de declaración
- Ambos pueden tener una estructura de bloque estándar, incluyendo el manejo de excepciones.

# Diferencias Entre los Procedimientos y las Funciones

**Procedimientos:**

- Puedes crear un procedimiento para crear una serie de acciones para luego ejecutarlas.
- Un procedimiento no tiene un valor de retorno
- Un procedimiento puede llamar a una función para asistir con sus acciones
- **Un procedimiento que contiene  un solo parámetro OUT puede ser mejor reescrito como una función que retorna un valor.**

**Funciones:**

- Puedes crear una función cuando quieres computar un valor que debe ser retornado al entorno donde se ha llamado la función.
- La funciones solo retornan un valor, **y el valor es retornado a través de una declaración RETURN.**
- Las funciones usadas en las declaraciones SQL no pueden usar los modos OUT o IN OUT 

- Aunque una función que utiliza OUT puede invocarse desde un procedimiento PL/SQL o un bloque anónimo, no puede utilizarse en sentencias SQL.



































































































































