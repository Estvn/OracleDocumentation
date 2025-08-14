DECLARE
    CURSOR cur_emps_dept IS
        SELECT first_name, last_name, department_name
        FROM employees e, departments d
        WHERE e.department_id = d.department_id;
    
    v_emp_dept_record cur_emps_dept%ROWTYPE;
BEGIN
    OPEN cur_emps_dept;
    <<ciclo_cursor>>
    LOOP
        FETCH cur_emps_dept INTO v_emp_dept_record;
        EXIT WHEN cur_emps_dept%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
        v_emp_dept_record.first_name || ' ' ||
        v_emp_dept_record.last_name || ' - ' ||
        v_emp_dept_record.department_name
        );
    END LOOP ciclo_cursor;
    CLOSE cur_emps_dept;
END;