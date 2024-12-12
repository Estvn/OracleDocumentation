DECLARE 
    ITERACION NUMBER(3) := 0;
    FECHA TIMESTAMP:= SYSDATE;
    
BEGIN

-- DECLARANDO UN CICLO LOOP
/*
A diferencia que WHILE o DO - WHILE, que se realiza una iteraci�n mientras se cumpla una condici�n, 
el LOOP se ejecuta hasta que se cumpla una condici�n para detenerse (se define en EXIT WHEN).
*/
LOOP
    FECHA := SYSDATE + ITERACION;
    
    EXIT WHEN (ITERACION>3); 
    DBMS_OUTPUT.PUT_LINE('N�mero de iteraci�n: ' || ITERACION);
    DBMS_OUTPUT.PUT_LINE(FECHA);
    ITERACION := ITERACION +1;
END LOOP;
    DBMS_OUTPUT.PUT_LINE('La iteraci�n final fue: ' || ITERACION);
END;

SET SERVEROUTPUT ON;