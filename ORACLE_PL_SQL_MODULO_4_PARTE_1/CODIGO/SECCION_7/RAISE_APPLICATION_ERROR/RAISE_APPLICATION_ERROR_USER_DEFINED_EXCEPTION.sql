DECLARE
    e_name EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_name, -20999);
    v_last_name employees.last_name%TYPE := 'Silly name';
    
BEGIN
    DELETE FROM employees 
    WHERE last_name = v_last_name;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20999, 'Invalida last name');
    ELSE    
        DBMS_OUTPUT.PUT_LINE(v_last_name || ' deleted');
    END IF;
EXCEPTION
    WHEN e_name THEN 
        DBMS_OUTPUT.PUT_LINE('Valid last names are: ');
        FOR c1 IN (SELECT DISTINCT last_name from employees) LOOP   
            DBMS_OUTPUT.PUT_LINE(c1.last_name);
        END LOOP;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting from employees');
END;