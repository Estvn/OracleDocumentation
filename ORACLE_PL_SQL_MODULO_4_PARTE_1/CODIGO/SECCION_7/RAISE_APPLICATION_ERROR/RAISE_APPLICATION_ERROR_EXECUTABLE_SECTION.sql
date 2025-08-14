DECLARE
    v_mgr PLS_INTEGER := 123;
BEGIN
    DELETE FROM employees
        WHERE manager_id = v_mgr;
    
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'This is nos a valid manager');
    END IF;
END;