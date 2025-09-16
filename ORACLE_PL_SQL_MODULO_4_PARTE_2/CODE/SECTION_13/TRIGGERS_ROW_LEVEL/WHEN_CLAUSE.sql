-- Instead of making an IF to execute the body code
-- Put an IF in the headers of the TRIGGER to evaluate the data that comes
CREATE OR REPLACE TRIGGER restrict_salary
	AFTER UPDATE of salary ON copy_employees 
	FOR EACH ROW
	WHEN (NEW.salary > OLD.salary)
BEGIN
	INSERT INTO log_emp_table
	(who, when, which_employee, old_salary, new_salary)
	VALUES
	(USER, SYSDATE, :OLD.employee_id, :OLD.salary, :NEW.salary);
END;