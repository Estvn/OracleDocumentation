DECLARE
    e_invalid_deparment EXCEPTION;
    v_name VARCHAR2(20) := 'Accounting';
    v_deptno NUMBER := 27;
BEGIN
    UPDATE departments
        SET department_name = v_name 
        WHERE department_id = v_deptno;
    
    IF SQL%NOTFOUND THEN
        RAISE e_invalid_deparment;
    END IF;
    
EXCEPTION
    WHEN e_invalid_deparment THEN
        DBMS_OUTPUT.PUT_LINE('No such department id.');
END;

SET SERVEROUTPUT ON;
    