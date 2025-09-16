CREATE OR REPLACE TRIGGER restrict_salary
	BEFORE INSERT OR UPDATE OF salary ON employees
	FOR EACH ROW
BEGIN
	IF NOT (:NEW.job_id IN ('AD_PRES', 'AD_VP'))
	AND :NEW.salary > 15000 THEN
		RAISE_APPLICATION_ERROR 
		(-20202, 'Employee cannot eran more than $1500.');
	END IF;
END;

UPDATE employees
SET salary = 15500
WHERE last_name IN ('King','Davies');