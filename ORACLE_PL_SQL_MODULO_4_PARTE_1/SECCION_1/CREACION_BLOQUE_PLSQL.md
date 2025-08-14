
# CREACIÓN DE BLOQUES PL/SLQ

**Objetivos:**

- Describir la estructura de un bloque PL/SQL
- Identificar los diferentes tipos de bloques PL/SQL
- Identificar los entornos de programación de PL/SQL
- Crear y ejecutar bloques anónimos PL/SQL
- Mensajes de salida de PL/SQL

## Propósito

- Aquí va a aprender la estructura de un bloque PL/SQL y a crear un tipo de bloque: El bloque anónimo.
- Más tarde va a aprender a crear procedimientos, funciones y paquetes usando la estructura básica de los bloques anónimos.

## Estructura de un bloque PL/SQL

**Un bloque PL/SQL consiste de tres secciones:**

| Sección                          | Descripción                                                                                                                                                                                                        |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Declarativo (opcional)           | La sección declarativa empieza con la palabra DECLARE y termina la sección ejecutable empieza.                                                                                                                     |
| Ejecutable (obligatorio)         | La sección ejecutable empieza con BEGIN y termina con END. Observe que END termina con una semicolumna. La sección ejecutable de un bloque PL/SQL puede incluir cualquier número de anidaciones de bloques PL/SQL. |
| Manejo de excepciones (opcional) | La sección de excepciones está anidada dentro de la sección ejecutable. Esta sección empieza con la palabra EXCEPCTION.                                                                                            |

| Sección                     | Descripción                                                                                                                                                                     | Inclusión   |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| Declarativa (DECLARE)       | Contiene declaraciones de todas las variables, constantes, cursores, y excepciones definidas por el usuario que son referenciadas en las secciones de excepciones y ejecutable. | Opcional    |
| Ejecutable (BEGIN ... END;) | Contiene declaraciones SQL para recuperar datos de la base de datos y declaraciones PL/SQL para manipular los datos en el bloque. Debería contener al menos una declaración.    | Obligatoria |
| Excepción (EXCEPTION)       | Especifica la acción a realizar cuando errores y condiciones anormales surgen en la sección ejecutable.                                                                         | Opcional    |

## Bloques Anónimos

**Características de un bloque anónimo:**

- Bloque sin nombre
- No se almacena en la base de datos
- Declarado en línea, en el punto de una aplicación donde está ejecutado
- Se compila cada vez que la aplicación se ejecuta
- Pasado al motor PL/SQL para su ejecución en tiempo de ejecución.
- **No puede ser llamado porque no tienen un nombre y no existe después de ser ejecutado.**

**Estructura básica de un bloque anónimo:**

```
[DECLARE]

BEGIN 
	-- STATEMENTS

[EXCEPTION]

END;
```

- Las secciones de declaración y excepción son opcionales.

```
SET SERVEROUTPUT ON;

DECLARE 
     F_NAME VARCHAR(30);
     L_NAME VARCHAR(30);
     
BEGIN
    SELECT FIRST_NAME, LAST_NAME INTO F_NAME, L_NAME
    FROM EMPLOYEES
    WHERE LAST_NAME = 'King';
    
    DBMS_OUTPUT.PUT_LINE('EL EMPLEADO DEL MES ES: ' || F_NAME || ' ' || L_NAME);
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('EL CÓDIGO ESCRITO NO SOPORTA TANTAS FILAS.');
END;
```

## El compilador PL/SQL

- Los bloques anónimos son compilados automáticamente cuando son ejecutados.
- Si el código tiene errores previo a ser compilado, no será ejecutado, pero retornará el primer error de compilación que detecte.

- Cada programa escrito en un lenguaje de programación de alto nivel debe ser chequeado y traducido a código binario antes de ser ejecutado.
- El software que hace las revisiones y traducciones se llama compilador.
- El compilador PL/SQL ejecuta automáticamente cuando sea necesario.

- **Este no solo revisa que cada comando haya sido escrito de forma correcta, sino también cada referencia del objeto de la base de datos, y que el usuario tenga los privilegios necesarios para acceder a ellos.**

## Subprogramas

- Son llamado bloques PL/SQL
- Están almacenados en la base de datos
- Pueden ser invocados siempre que quieras, dependiendo de la aplicación.

- **Pueden ser declarados como procedimientos o funciones.**
- Procedure: Realiza una acción.
- Function: Computa y retorna un valor.

**Sintáxis de un procedimiento:**

```
PROCEDURE NAME 
IS 
	-- VARIABLE DECLARATIONS
BEGIN
	-- STATEMENTS
	
[EXCEPCION]
END;
```

**Sintáxis de una función:**

```
FUNCTION NAME
RETURN DATATYPE IS
	-- VARIABLE DECLARATION (S)
BEGIN
	STATEMENTS
	RETURN VALUE;

[EXCEPTION]
END;
```

```
CREATE OR REPLACE PROCEDURE PRINT_DATE IS
	V_DATE VARCHAR(30);
BEGIN
	SELECT TO_CHAR(SYSDATE, 'Mon DD, YYYY')
	INTO V_DATE
	FROM DUAL;

	DBMS_OUTPUT.PUT_LINE(V_DATE);
END;

BEGIN
	PRINT_DATE;
END;
```

```
CREATE OR REPLACE FUNCTION TOMORROW (P_TODAY IN DATE)
RETURN DATE IS
	TOMORROW DATE;
BEGIN
	SELECT P_TODAY + 1 INTO TOMORROW
	FROM DUAL;
	
	RETURN TOMORROW;
END;
```

**Las funciones pueden ser invocadas de dos formas:**

- Por medio de un SELECT:

```
SELECT TOMORROW(SYSDATE) AS "FECHA DE MAÑANA" FROM DUAL;
```

- Por medio de un bloque anónimo:

```
BEGIN
	DBMS_OUTPUT.PUT_LINE('LA FECHA DE MAÑANA ES:' || TOMORROW(SYSDATE));
END
```

## Comandos SQL

- Puedes usar comandos SQL para correr una sola declaración SQL.
- También puedes usar comandos SQL para ingresar y correr en un solo bloque PL/SQL.

```
DECLARE
	TODAY DATE := SYSDATE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('HOY ES: ' || TODAY);
END;
```

## Scripts SQL

- Los Scripts SQL pueden contener uno o más declaraciones SQL y/o bloques PL/SQL.
- Puedes usar scripts SQL para ingresar y correr scripts de múltiples declaraciones.
- **En los scripts SQL, los bloques anónimos PL/SQL deben estar entre plecas.**

```
SELECT COUNT(*) FROM EMPLOYEES;
/
DECLARE 
	V_COUNT NUMBER(6,0);
BEGIN
	SELECT COUNT(*) INTO V_COUNT FROM EMPLOYEES;
	DBMS_OUTPUT.PUT_LINE(V_COUNT || ' EMPLEADOS');
END
/
SELECT SYSDATE FROM DUAL;
```

## Usando DBMS_OUTPUT.PUT_LINE

- Permite mostrar resultados que puedes revisar de tu bloque, y si está trabajando correctamente.
- Te permite ver una cadena de caracteres a la vez, aunque se puede concatenar.

```
SET SERVEROUTPUT ON;

DECLARE
	V_EMPLOYEES_COUNT NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE("PL/SQL ES FÁCIL DE USAR");

	SELECT COUNT(*) INTO V_EMEPLOYEES_COUNT FROM EMPLOYEES;
	DBMS_OUTPUT.PUT_LINE("HAY " || V_EMPLOYEES_COUNT || " EMPLEADOS");
END;
```





















