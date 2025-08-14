DECLARE
    CURSOR cur_dept IS SELECT * FROM my_departments;
    CURSOR cur_emp (p_dept_id NUMBER) IS
        SELECT * FROM my_employees WHERE department_id = p_dept_id
        FOR UPDATE NOWAIT;
BEGIN
    FOR v_deptrec IN cur_dept LOOP
        DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
        FOR v_emprec IN cur_emp (v_deptrec.department_id) LOOP
            DBMS_OUTPUT.PUT_LINE(v_emprec.last_name);
            
            IF v_deptrec.location_id = 1700 AND v_emprec.salary < 1000 THEN
                UPDATE my_employees
                    SET salary = slary *1.1
                    WHERE CURRENT OF cur_emp;
            END IF;
        END LOOP;
    END LOOP;
END;