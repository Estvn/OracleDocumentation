BEGIN
    FOR v_emp_record IN (
        SELECT employee_id, last_name 
        FROM employees WHERE department_id = 50)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            v_emp_record.employee_id  || ' ' ||
            v_emp_record.last_name
        );
    END LOOP;
END;