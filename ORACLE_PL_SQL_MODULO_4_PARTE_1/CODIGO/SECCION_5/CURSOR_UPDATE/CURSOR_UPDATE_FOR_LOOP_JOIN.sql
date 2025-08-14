DECLARE 
    CURSOR cur_eds IS
        SELECT employee_id, salary, department_name 
            FROM copy_emp e, copy_dept d
            WHERE e.department_id = d.department_id
            FOR UPDATE OF salary NOWAIT;
BEGIN
    FOR v_eds_rec IN cur_eds LOOP   
        UPDATE copy_emp
            SET salary = v_eds_rec.salary * 1.1
            WHERE CURRENT OF cur_eds;
    END LOOP;
END;