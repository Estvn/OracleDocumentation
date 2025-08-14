DECLARE
    v_lname employees.last_name%TYPE;
BEGIN
    SELECT last_name INTO v_lname
    FROM employees WHERE job_id = 'ST_CLERK';
    
    DBMS_OUTPUT.PUT_LINE('The last name of the ST_CLERK is ' || v_lname);
EXCEPTION 
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('The last statement retrieved multiple rows. Consider using a cursor');
END;