DECLARE

    TYPE t_hire_date IS TABLE OF employees.hire_date%TYPE
    INDEX BY BINARY_INTEGER;
    
    v_hire_date_tab t_hire_date;
    v_count BINARY_INTEGER := 0;
BEGIN
    FOR emp_rec IN (SELECT hire_date FROM employees) LOOP
        v_count := v_count+1;
        v_hire_date_tab (v_count) := emp_rec.hire_date;
    END LOOP;
END;