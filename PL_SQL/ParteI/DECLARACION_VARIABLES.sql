DECLARE
/*
NUM1 NUMBER(10) := 1234567890;
NUM2 NUMBER(10, 2) := 10000000.99;
NUM3 NUMBER := 123;
NUM4 NUMBER(5,0) := 45761;4*/

FECHA1 DATE := sysdate; -- A UNA VARIABLE TIPO DATE, LA FECHA ACTUAL SE ASIGNA CON LA FUNCI�N TIPO "sysdate".
FECHA2 date := sysdate; -- A UN DATO TIPO TIMESTAMP, LA FECHA ACTUAL SE ASIGNA CON LA FUNCI�N "systimestamp".

/*
VAR1 VARCHAR(15 CHAR) := '�Mej�a!'; -- AQUI SE ACEPTA 15 CARACTERES SIN IMPORTAR SI ESTOS NECESITAN M�S DE 1 BYTE PARA PODER SER REPRESENTADOS.
VAR3 VARCHAR(15 BYTE) := 'Hola que tal'; -- CADA CARACTER ABARCA UN ESPACIO DE 1 BYTE. AQU� SOLO SE ACEPTA 15 CARACTERES QUE NO SON ESPECIALES (SOLO SE NECESITA 1 BYTE PARA REPRESENTARLO).
VAR2 VARCHAR(15) := 'hla '; -- ESTO ES LO MISMO QUE ASIGNAR 15 BYTES A LA VARIABLE.

CHAR(5) := 'HOLA!'; -- SE ACEPTAN 5 CARACTERES SIN IMPORTAR SI NECESITAN M�S DE 1 BYTE PARA SER REPRESENTADOS.
BYTE(5) := 'hola1 '; -- EXACTAMENTE 5 BYTES (20 BITS).
*/

BEGIN
-- dbms_output.put_line('El n�mero que tiene un l�mite de 10 d�gitos es: ' || NUM1);

dbms_output.put_line(FECHA2);

END;

set serveroutput on;