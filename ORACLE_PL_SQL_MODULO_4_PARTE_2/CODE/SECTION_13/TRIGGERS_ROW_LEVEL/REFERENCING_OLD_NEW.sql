CREATE OR REPLACE TRIGGER log_emps 
	AFTER UPDATE OF salary ON old
	REFERENCING OLD as former NEW as latter 
	FOR EACH ROW
BEGIN
	INSERT INTO log_emp_table
	(who, when, which_employee, old_salary, new_salary)
	VALUES
	(USER, SYSDATE, :former.employee_id, :former.salary, :latter.salary);
END;