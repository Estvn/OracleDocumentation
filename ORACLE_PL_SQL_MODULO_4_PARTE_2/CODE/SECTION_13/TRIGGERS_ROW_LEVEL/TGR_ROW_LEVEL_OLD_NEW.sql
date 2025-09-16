CREATE OR REPLACE TRIGGER log_emps 
AFTER UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
	INSERT INTO log_emp_table
	(who, when, which_employee, old_salary, new_salary)
	VALUES 
	(USER, SYSDATE, :OLD.employee_id, :OLD.salary, :NEW.salary);
END;