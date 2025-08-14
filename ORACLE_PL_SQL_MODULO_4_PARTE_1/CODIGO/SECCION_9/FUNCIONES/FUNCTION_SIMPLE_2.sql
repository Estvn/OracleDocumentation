CREATE OR REPLACE FUNCTION valid_dept(
    p_dept_no departments.department_id%TYPE)
RETURN BOOLEAN
IS 
    v_valid VARCHAR2(1);
BEGIN
    select 'x' INTO v_valid 
        FROM departments
        WHERE department_id = p_dept_no;
    RETURN (true);
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN (false);
    WHEN OTHERS THEN NULL;
END;
