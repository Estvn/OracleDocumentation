DECLARE
    CURSOR cur_emps IS
        SELECT employee_id, last_name FROM employees
            WHERE department_id = 50;
        
    v_empno employees.employee_id%TYPE;
    v_lname employees.last_name%TYPE;
    
BEGIN
    OPEN cur_emps; -- Pasan muchas cosas cuando esto se ejecuta...
    LOOP
        FETCH cur_emps INTO v_empno, v_lname;
        EXIT WHEN cur_emps%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_lname);
    END LOOP;
END;