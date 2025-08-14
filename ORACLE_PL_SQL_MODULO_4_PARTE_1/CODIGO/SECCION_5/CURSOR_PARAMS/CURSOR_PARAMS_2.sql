DECLARE 
    CURSOR cur_emps (p_deptid NUMBER) IS
        SELECT employee_id, salary
        FROM employees
        WHERE department_id = p_deptid;
    
    v_deptid employees.department_id%TYPE;    
    v_emp_rec cur_emps%ROWTYPE;
BEGIN
    SELECT MAX(department_id) INTO v_deptid
        FROM employees;
    
    OPEN cur_emps(v_deptid);
    LOOP
        FETCH cur_emps INTO v_emp_rec;
        EXIT WHEN cur_emps%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_rec.employee_id || ' ' ||
                            v_emp_rec.salary);
    END LOOP;
    CLOSE cur_emps;
END;
    
