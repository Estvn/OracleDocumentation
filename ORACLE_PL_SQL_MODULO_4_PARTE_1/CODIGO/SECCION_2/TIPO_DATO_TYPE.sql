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

DECLARE 
    V_FIRST_NAME EMPLOYEES.LAST_NAME%TYPE := 'HOLA';
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME);
END;

DECLARE
    V_FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO V_FIRST_NAME 
    FROM EMPLOYEES WHERE LAST_NAME = 'Vargas';
    
    DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME);
END;