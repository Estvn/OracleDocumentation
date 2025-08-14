DECLARE
    TYPE t_hire_date IS TABLE OF employees.hire_date%TYPE
    INDEX BY BINARY_INTEGER;
    
    v_hire_date_tab t_hire_date;
BEGIN
    FOR emp_rec IN (SELECT employee_id, hire_date FROM employees)
    LOOP
        v_hire_date_tab(emp_rec.employee_id) := emp_rec.hire_date;
    END LOOP;
    -- DBMS_OUTPUT.PUT_LINE(v_hire_date_tab);
END;

SET SERVEROUTPUT ON;