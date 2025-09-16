CREATE OR REPLACE TRIGGER audit_emp_values 
    AFTER DELETE OR INSERT OR UPDATE ON EMPLOYEES 
    FOR EACH ROW
BEGIN
    
    INSERT INTO audit_emp
    (user_name, time_stamp, id, old_last_name,
    new_last_name, old_title, new_title, old_salary, new_salary)
    VALUES
    (USER, SYSDATE, :OLD.employee_id, :OLD.last_name,
    :NEW.last_name, :OLD.job_id, :NEW.job_id, :OLD.salary, :NEW.salary);
END;