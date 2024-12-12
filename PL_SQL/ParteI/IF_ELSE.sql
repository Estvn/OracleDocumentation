DECLARE
--NOMBRE_VAR VARCHAR2(100) := '';
--NOMBRE_VAR2 VARCHAR2(100) := 'Hola que tal est�';
RESULTADO NUMBER(10,2); -- 10 d�gitos y 2 de ellos son decimales.
PARAMETRO NUMBER(1) := 2; -- Solo un d�gito.
PORCENTAJE NUMBER; -- Por defecto se pueden ingresar 38 d�gitos.
SALARIO NUMBER(10,2) := 12000;

BEGIN

DBMS_OUTPUT.PUT_LINE('El aumento para un empleado es: ');

IF(PARAMETRO = 1) THEN
    PORCENTAJE := 0.05;
    RESULTADO := PORCENTAJE * SALARIO;        
ELSIF (PARAMETRO = 2) THEN
    PORCENTAJE := 0.15;
    RESULTADO := PORCENTAJE * SALARIO;  
ELSE
    DBMS_OUTPUT.PUT_LINE('No se puede calcular el aumento con los datos proporcionados.');
END IF;

DBMS_OUTPUT.PUT_LINE(RESULTADO);
--DBMS_OUTPUT.PUT_LINE('Y el aumento sumado al salario es de: ' || TO_CHAR(SALARIO+RESULTADO, 9999,99));

END;

set serveroutput on;

