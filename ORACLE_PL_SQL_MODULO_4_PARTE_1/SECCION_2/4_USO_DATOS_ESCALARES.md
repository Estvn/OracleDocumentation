
**Objetivos:**

- Declarar y usar los tipos de datos escalares en PL/SQL
- Definir e inicializar variables en PL/SQL
- Identificar los beneficios de anclaje de los tipos de datos con el atributo %TYPE

- La mayoría de las variables que defines y usas en PL/SQL tienen tipos de datos escalares.
- Una variable puede tener un tipo de datos explícito, tal como VARCHAR2, o puede tener automáticamente el mismo tipo de datos de una columna de una tabla en la base de datos.
- **Hay ventajas en basar algunas variables con los tipos de datos de columnas de tablas**

# Declarando Variables Character

- Todas las variables deben ser declaradas.
- Columnas que pueden exceder de 32,767 caracteres (es el límite de VARCHAR2), puede usar el tipo de dato LONG pero debería usar CLOB.

```
DECLARE
	CARACTER CHAR(2);
	PALABRA VARCHAR(20);
	ORACION LONG;
	PARRAFO CLOB;
BEGIN
```

# Declarando Variables Numéricas

- Los tipos de datos numéricos incluye NUMBER, INTENGER, PLS_INTEGER, BINARY, \_FLOAT entre otros.
- **Cuando agregar la palabra de restricción CONSTANT en la variable, es un valor que no puede cambiar.**
- La constante debe ser inicializada.

```
DECLARE
    NUMERO NUMBER(6,0);
    ENTERO INTEGER;
    ENTERO PLS_INTEGER;
    NUMERO BINARY;
    FLOTANTE CONSTANT FLOAT := 33.4;
BEGIN
```

# Declarando Variables de Fecha

- Los tipos de datos de fecha incluyen DATE, TIMESTAMP y TIMESTAMP WITH TIMEZONE
- Elegir entre DATE y TIMESTAMP es determinado en que datos necesita saber en el futuro.

```
DECLARE
    V_DATE1 DATE := '05-APR-2015';
    V_DATE2 DATE := V_DATE1 + 7;
    V_DATE3 TIMESTAMP := SYSDATE;
    V_DATE4 TIMESTAMP WITH TIME ZONE := SYSDATE;
BEGIN
```

# Declarar Variables BOOLEAN

- BOOLEAN es un tipo de datos que almacena tres tipos de posibles valores usados para cálculos lógicos: TRUE, FALSE or NULL.

```
DECLARE
    VVALID1 BOOLEAN := TRUE;
    VVALID2 BOOLEAN; -- NULL
    VVALID2 BOOLEAN NOT NULL := FALSE; 
BEGIN 

    IF VVALID1 THEN
        DBMS_OUTPUT.PUT_LINE('Es V');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Es F');
    END IF;
END;
```

# Uso de Variables BOOLEAN

- Los valores TRUE, FALSE y NULL son asignados a la variable BOOLEAN.
- Las expresiones condicionales se usan con los operadores lógicos AND y OR, y el operador NOT para ver los valores.
- Puedes usar aritmética, caracteres y expresiones de datos para retornar un valor Booleano.

# Estándares para Declarar Variables en PL/SQL

- Use nombres apropiados con significado
- Siga la convención de los nombres
- Use `v_name` para representar a una variable y `c_name` para representar a una constante.
- Declare una variable por línea para mejor legibilidad, mantenimiento de código y mejor documentación.
- Use la restricción `NOT NULL` cuando la variable debe tener un valor.
- Use la restricción `CONSTANT` cuando la variable no deba cambiar de valor.
 - **Agregue valores iniciales para Booleans y números.**
 - Evite usar los nombres de columnas como identificadores.

# Definir Variables con el Atributo %TYPE

- Las variables definidas con el campo de la base de datos debería estar definida por el atributo `%TYPE`, esto tiene muchas ventajas.
- Por ejemplo, en la tabla EMPLOYEES, la columna first_name es definida como VARCHAR(20)
- En un bloque PL/SQL puedes definir el tipo de dato en cada variable.

```
DECLARE
    V_FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO V_FIRST_NAME 
    FROM EMPLOYEES WHERE LAST_NAME = 'Vargas';
    
    DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME);
END;
```

- **A veces es lo ideal agregar relacionar los tipos de datos de las variables con los de los campos de una tabla, porque si se cambia el tipo de dato de la tabla, será cambiado en la tabla y en la variable del procedimiento o función en uso.**

El atributo %TYPE
- Es usado para dar automáticamente a la variable el mismo tipo de datos que:
	- Una columna de base de datos
	- Otra variable declarada

- Tienen como prefijo cualquiera de los siguientes:
	- El nombre de la tabla de base de datos y nombre de columna
	- El nombre de otra variable declarada,

```
identifier table_name.colum_name%type;
identifier identifier%type;
```

```
DECLARE
    v_first_name employees.first_name%TYPE;
    v_salary employees.salary%TYPE;
    v_old_salary v_salary%TYPE;
    v_new_salary v_salary%TYPE;
    v_balance NUMBER(10,2);
    v_min_balance v_balance%TYPE := 1000;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_min_balance);
END;
```

# Ventajas del uso del Atributo %TYPE

- Puedes evitar errores causados por el cambio de los tipos de datos o precisión errónea.
- No necesitas cambiar el tipo de datos de la variable cuando el campo de la tabla cambie.
- PL/SQL determina el tipo de dato y el tamaño de la variable cuando el bloque es compilado.
- Esto asegura que la variable siempre sea compatible con la columna a la que está relacionada











































































































































