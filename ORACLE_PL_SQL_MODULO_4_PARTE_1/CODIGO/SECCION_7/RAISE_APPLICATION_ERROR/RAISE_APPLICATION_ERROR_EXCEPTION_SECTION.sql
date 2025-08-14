DECLARE
    v_mgr PLS_INTEGER := 27;
    v_employee_id employees.employee_id%TYPE;
    
BEGIN   
    SELECT employee_id INTO v_employee_id 
    FROM employees
    WHERE manager_id = v_mgr;
    
    DBMS_OUTPUT.PUT_LINE('Employee #' || v_employee_id || ' works for manager #' || v_mgr);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20201, 'This manager has no employees');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20202, 'Too many employees were found');
END;