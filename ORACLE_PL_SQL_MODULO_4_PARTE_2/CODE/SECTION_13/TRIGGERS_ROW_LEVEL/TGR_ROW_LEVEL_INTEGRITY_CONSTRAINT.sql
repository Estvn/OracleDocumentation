-- If an exception of NO_DATA_FOUND is throwed, 

CREATE OR REPLACE TRIGGER employee_dept_fk_trg
BEFORE UPDATE OF department_id ON employees 
FOR EACH ROW
DECLARE
	v_dept_id departments.department_id%TYPE;
BEGIN
	SELECT department_id INTO v_dept_id FROM departments
	WHERE department_id = :NEW.department_id;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		INSERT INTO departments
		VALUES(:NEW.department_id, 'Dept ' || :NEW.department_id, NULL, NULL);
END;

UPDATE employees
SET department_id = 1000
WHERE employee_id = 124;

select * from departments;
select * from employees where employee_id =  124;