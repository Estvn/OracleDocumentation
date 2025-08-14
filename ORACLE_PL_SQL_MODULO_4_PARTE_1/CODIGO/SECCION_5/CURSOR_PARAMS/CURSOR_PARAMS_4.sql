DECLARE 
    CURSOR cur_emps(p_job VARCHAR2, p_salary NUMBER) IS
        SELECT employee_id, last_name
        FROM employees
        WHERE job_id = p_job
        AND salary > p_salary;
BEGIN
    FOR v_emp_record IN cur_emps('IT_PROG', 1000) LOOP
        DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id || ' ' ||
                            v_emp_record.last_name);
    END LOOP;
END;