
**Objetivos:**

- Construya declaraciones de variables precisas en PL/SQL
- Construya declaraciones precisas usando **built-in** funciones SQL en PL/SQL
- Diferenciar entre conversiones de tipos de datos implícitas y explícitas.
- Describir cuando las conversiones implícitas de datos toman lugar.
- Listar las desventajas de las conversiones implícitas de los tipos de datos.
- Construir declaraciones explícitas usando funciones para convertir tipos de datos explícitos.
- Construya declaraciones usando operadores en PL/SQL.

- Las variables pueden ser literales o valores retornados por una función.
- SQL provee un número de funciones predefinidas que puede usar en declaraciones SQL.
- La mayoría de las funciones son expresiones válidas en PL/SQL.

# Asignación de nuevos valores a variables

- Los caracteres y datos literales deben ser encerrados en comillas simples.
- Los números pueden ser simples valores o notación científica (2E5 es el significado de 2*10 y elevado a 5 = 200,000)

```
v_name := 'Henderson';
v_start_date := '12-Dec-2005';

v_my_integer := 100;
v_my_sci_not := 2E5;
```

# Funciones SQL en PL/SQL

- Puede usar las funciones comúnmente usadas en SQL dentro de bloques PL/SQL.

```
DECLARE
    V_LAST_DAY DATE;
BEGIN
    V_LAST_DAY := LAST_DAY(SYSDATE);
    DBMS_OUTPUT.PUT_LINE(V_LAST_DAY);
END;
```

Las funciones son disponibles en los bloques PL/SQL:
- caracteres de una fila
- numeros de una fila
- date
- conversion de tipo de dato
- funciones misceláneas

Las funciones que no están disponibles en los bloques PL/SQL:
- DECODE (CASE es usado a cambio)
- GROUP Functions (AVG, MIN, MAX, etc. Solo pueden ser usados dentro de declaraciones SQL).

**Las funciones SQL te ayudan a manipular data; está en las siguientes categorías:**
- Character
- Number
- Date
- Conversion
- Miscellaneous

# Funciones de Caracteres

- Las funciones de caracteres PL/SQL incluye

| ASCII   | LENGTH  | RPAD   |
| ------- | ------- | ------ |
| CHR     | LOWER   | RTRIM  |
| CONCAT  | LPAD    | SUBSTR |
| INITCAP | LTRIM   | TRIM   |
| INTSTR  | REPLACE | UPPER  |

# Funciones Numéricas

- Las funciones válidas en bloques PL/SQL incluye:

| ABS  | EXP   | ROUND |
| ---- | ----- | ----- |
| ACOS | LN    | SIGN  |
| ASIN | LOG   | SIN   |
| ATAN | MOD   | TAN   |
| COS  | POWER | TRUNC |

# Funciones de fecha

- Las funciones válidas de fecha en pl/sql incluye:

| ADD_MONTHS        | MONTHS_BETWEEN |
| ----------------- | -------------- |
| CURRENT_DATE      | ROUNF          |
| CURRENT_TIMESTAMP | SYSDATE        |
| LAST_DAY          | TRUNC          |

# Conversión de tipos de datos

- En cualquier lenguaje de programación, la conversión de un tipo de datos a otro es un requerimiento común.
- PL/SQL can handle such conversions with scalar data types.
- Las conversiones de los tipos de datos son de dos tipos:
	- Conversiones implícitas
	- Conversiones explícitas

## Conversiones Implícitas

- En las conversiones implícitas, PL/SQL intentar convertir los tipos de datos dinámicamente si se mezclan en una declaración.
- Las conversiones implícitas pueden ocurrir entre muchos tipos de PL/SQL.

```
DECLARE
	VAR1 NUMBER(6) := 6000;
	VAR2 VARCHAR2(5) := '1000';
	VAR3 VAR2%TYPE; 
BEGIN
	VAR3 := VAR1 + VAR2;
	DBMS_OUTPUT.PUT_LINE(VAR3);
```

## Desventajas de las Conversiones Implícitas

- Pueden ser lentas
- Pierdes control sobre tu programa, porque estás haciendo suposiciones sobre cómo Oracle maneja los datos.
- Si Oracle cambia sus reglas de manejo de conversiones, tu código puede salir afectado.
- El código que usar conversiones implícitas es más difícil de leer y entender.

- Las reglas de conversiones implícitas dependen del entorno donde corres tu código.
- Es fuertemente recomendado que evites permitir que PL/SQL y SQL haga las conversiones implícitas.
- **Debes usar funciones de conversión para garantizar que se están haciendo las conversiones correctas.**

# Conversiones Explícitas

- Las conversiones explícitas convierten valores de un tipo de dato a otro usando built-in functions.

| TO_NUMBER()   | ROWIDTONCHAR() |
| ------------- | -------------- |
| TO_CHAR()     | HEXTORAW()     |
| TO_CLOB()     | RAWTOHEX()     |
| CHARTOROWID() | RAWTONHEX()    |
| ROWIDTOCHAR() | TO_DATE()      |

```
DECLARE
    V_DATE_OF_JOINING DATE := '02-FEB-2014';
    V_DATE_OF DATE := 'FEBRUARY 02, 2014';
    V_DATE DATE := TO_DATE('FEBRUARY 02, 2014', 'Month DD, YYYY');

BEGIN 
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'Month YYYY'));
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_DATE('April-1999', 'Month-YYYY'));
END;

DECLARE
    VA VARCHAR(10) := '-123456';
    VB VARCHAR(10) := '+987654';
    VC PLS_INTEGER;
BEGIN
    VC := TO_NUMBER(VA) + TO_NUMBER(VB);
    DBMS_OUTPUT.PUT_LINE(VC);
END;
```

# Operadores en PL/SQL

- Las operaciones dentro de una expresión se realizan en un orden determinado según su precedencia (prioridad).

Operadores
- Lógicos
- Aritméticos
- Concatenación
- Paréntesis para controlar el orden de las operaciones
- Operadores exponenciales (**)

| Operador                                                    | Operación                             |
| ----------------------------------------------------------- | ------------------------------------- |
| **                                                          | Exponenciación                        |
| +, -                                                        | Identity, negation                    |
| *, /                                                        | Multiplication, disivion              |
| =, <, >, <=, >=, <>, !=, ~=, ^=, IS NULL, LIKE, BETWEEN, IN | Comparison                            |
| NOT                                                         | Logical negation                      |
| AND                                                         | Conjunction                           |
| OR                                                          | Inclusion                             |
| +, -, \|\|                                                  | Adittion, substraction, concatenation |

# Ejemplos de Operaciones en PL/SQL

Incrementar el ciclo de un contador

`v_loop_count := v_loop_count + 1;`

Poner el valor en una flag booleana

`v_good_sal := v_sal BETWEEN 5000 AND 150000;`

Validar si el número de un empleado contiene un valor

`v_valid := (v_empno is not null);`
































































































