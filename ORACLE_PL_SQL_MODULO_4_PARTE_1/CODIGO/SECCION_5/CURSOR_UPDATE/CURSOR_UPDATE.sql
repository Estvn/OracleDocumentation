DECLARE
    CURSOR cur_emps IS
        SELECT employee_id, salary FROM copy_emp
        WHERE salary <= 20000
        FOR UPDATE NOWAIT;
    v_emp_rec cur_emps%ROWTYPE;
BEGIN
    OPEN cur_emps;
    LOOP
        FETCH cur_emps INTO v_emp_rec;
        EXIT WHEN cur_emps%NOTFOUND;
        
        UPDATE copy_emp
            SET salary = v_emp_rec.salary*1.1
            WHERE CURRENT OF cur_emps;
    END LOOP;
    CLOSE cur_emps;
END;
    
    