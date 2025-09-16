-- EXECUTES ONLY ONE TIME
-- WHEN THE EVENT OCCURS

-- This trigger will execute his body one time
-- always when is maked an insert on employees

CREATE OR REPLACE TRIGGER log_emp
AFTER INSERT ON employees
BEGIN
	INSERT INTO log_emp_table (who, when)
	VALUES (USER, SYSDATE);
END;