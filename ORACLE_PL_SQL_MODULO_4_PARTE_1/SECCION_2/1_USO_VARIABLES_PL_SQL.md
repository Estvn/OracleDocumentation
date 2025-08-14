
**Objetivos**

- Listar los usos de las variables en PL/SQL
- Identificar la sintaxis de las variables en PL/SQL
- Declarar e inicializar variables en PL/SQL
- Asignar nuevos valores a las variables en PL/SQL

# Propósito 

- Aprenderás como declarar e inicializar variables en la sección del bloque declarativo PL/SQL.
- Con PL/SQL puedes declarar variables y usarlas en SQL o las estructuras procedimentales.
- **Las variables son una especie de almacenamiento que contiene algo y se usa cuando se necesita.**

# Uso de las Variables

- Las variables son unas expresiones que contienen un valor.
- Cuando defines una variable en la sección de declaración de PL/SQL, etiquetas una localización de memoria, asignas un tipo de datos y, si es necesario, asignas un valor de inicio de la variable.

- Una variable puede representar a un número, cadena de caracteres, booleano y otros tipos de datos.
- A través del código PL/SQL, los valores de las variables pueden cambiar por medio de la asignación del operador (:=)

**Usa variables para:**

- Almacenamiento temporal de datos
- Manipulación de data almacenada
- Reusabilidad

# Manejo de las variables en PL/SQL

La variables son:
- Declaradas e inicializadas en la sección declarativa
- Usadas y asignadas a nuevos valores en la sección ejecutable

Las variables pueden ser:
- Pasadas como parámetros a subprogramas PL/SQL
- Asignadas para contener la salida de un subprograma PL/SQL

# Declaración de variables

- **Todas las variables de PL/SQL deben ser declaradas en la sección de declaración antes de referenciarlas en el bloque PL/SQL.**
- El propósito de la declaración es asignar espacio de almacenamiento para un valor, especificar el tipo de dato, y nombrar la localización en memoria para poder referenciarla.
- **Puedes declarar variables en la sección declarativa, o cualquier bloque PL/SQL, subprograma o paquete.**

# Sintaxis de las Variables

```
NOMBRE [CONSTANT] DATATYPE [NOT NULL] [:= EXPR | DEFAULT EXPR];
```

# Inicialización de las Variables

- Las variables son asignadas a un espacio de memoria dentro de la sección de declaración.
- Las variables pueden ser iniciadas y referenciadas a un valor al mismo tiempo.
- El valor de una variable también puede ser modificada y reiniciada en la sección ejecutable.

```
DECLARE
	v_counter INTEGER := 0;
BEGIN
	v_counter := v_counter +1;
	DBMS_OUTPU.PUT_LINE(v_counter);
END
```


El siguiente ejemplo muestra la declaración de varias variables de varios tipos de datos usando sintaxis que pone restricciones, valores por defecto e inicialización de valores.

```
DECLARE
    FAM_BIRTHDATE DATE;
    FAM_SIZE NUMBER(2) NOT NULL := 10;
    FAM_LOCATION VARCHAR(13) := 'Florida';
    FAM_BANK CONSTANT NUMBER := 5000;
    FAM_POPULATION INTEGER;
    FAM_NAME VARCHAR(20) DEFAULT 'Roberts';
    FAM_PARTY_SIZE CONSTANT PLS_INTEGER := 20;
    
    RANGO PLS_INTEGER DEFAULT 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(FAM_NAME);
    DBMS_OUTPUT.PUT_LINE(RANGO);
END;
```

- Después que las variables son declaradas, puedes usarlas en la sección ejecutable del bloque PL/SQL.
- **Puede acceder a la variable en la sección de ejecución del mismo bloque.**

```
DECLARE
    V_MYNAME VARCHAR2(20) NOT NULL := 'ESTIVEN EMJIA';
    
BEGIN
    V_MYNAME := 'ESTIVEN';
    V_MYNAME := CONCAT(CONCAT(V_MYNAME, ' ') ,'MEJÍA');
    DBMS_OUTPUT.PUT_LINE(V_MYNAME);
END;

```

# Pasando Variables como Parámetros en PL/SQL
 
- Los parámetros son valores pasados a un subprograma por el usuario o por otro programa.
- El subprograma usa el valor en el parámetro cuando el código se ejecuta.
- El subprograma puede retornar un parámetro al entorno de llamada. En PL/SQL, **los subprogramas son generalmente conocidos como procedimientos o funciones.**

En este ejemplo, el parámetros v_date está siendo pasado al procedimiento PUT_LINE, que es parte del paquete DBMS_OUTPUT

```
DECLARE
	V_DATE VARCHAR2(30);
BEGIN
	SELECT TO_CHAR(SYSDATE) INTO V_DATE FROM DUAL;
	DBMS_OUTPUT.PUT_LINE(V_DATE);
END;
```


Asignando variables a un subprograma de salida PL/SQL

```
CREATE OR REPLACE FUNCTION FN_NUM_CHARACTERS(P_STRING IN VARCHAR2)
RETURN INTEGER IS
	V_NUM_CHARACTERS INTEGER NOT NULL;
BEGIN
	-- SELECT LENGTH(P_STRING) INTO V_NUM_CHARACTERS FROM DUAL;
	V_NUM_CHARACTERS := LENGTH(P_STRING);
	RETURN V_NUM_CHARACTERS;
END;

DECLARE 
	v_lenght_of_string INTEGER;
BEGIN
	v_lengh_of_string := FN_NUM_CHARACTERS('Oracle Corporation');
	DBMS_OUTPUT.PUT_LINE(v_length_of_string);
END;
```


# Resumen 

- Listar el uso de las variables en PL/SQL
- Identificar la sintaxis de las variables en PL/SQL
- Declarar e inicializar variables en PL/SQL
- Asignar nuevos valores a las variables en PL/SQL



































