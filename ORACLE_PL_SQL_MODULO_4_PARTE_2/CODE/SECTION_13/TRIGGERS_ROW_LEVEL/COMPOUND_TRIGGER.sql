CREATE OR REPLACE TRIGGER log_emps
    FOR UPDATE OF salary ON copy_employees 
    COMPOUND TRIGGER
        
        TYPE t_log_emp IS TABLE OF log_table%ROWTYPE
        INDEX BY BINARY_INTEGER
        
        log_emp_tab t_log_emp;
        v_index BINARY_INTEGER := 0;
    
    AFTER EACH ROW IS 
    BEGIN
        
        v_index := v_index + 1;
        log_emp_tab(v_index).employee_id := :OLD.employee_id;
        log_emp_tab(v_index).change_date := SYSDATE;
        log_emp_tab(v_index).salary := :NEW.salary;
    
    END AFTER EACH ROW;
    
    AFTER STATEMENT IS 
    BEGIN   
        
        FORALL I IN log_emp_tab.FIRST .. log_emp_tab.LAST
        INSERT INTO log_table VALUES log_emp_tab(i);
    
    END AFTER STATEMENT;
END log_emps;