DECLARE
    CURSOR cur_emp IS
        SELECT * FROM employees WHERE department_id = 10;
    v_emp_record cur_emp%ROWTYPE;
    
BEGIN
    OPEN cur_emp;
    LOOP
        FETCH cur_emp INTO v_emp_record;
        EXIT WHEN cur_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_record.employee_id || ' - ' || v_emp_record.last_name);
    END LOOP;
    CLOSE cur_emp;
END;

SET SERVEROUTPUT ON;