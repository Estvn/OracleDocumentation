CREATE OR REPLACE TRIGGER check_sal_trigg
BEFORE UPDATE OF job_id ON employees
FOR EACH ROW 
DECLARE
	v_job_count INTEGER;
BEGIN
	SELECT COUNT(*) INTO v_job_count
	FROM job_history
	WHERE employee_id = :OLD.employee_id 
	AND job_id = :NEW.job_id;
	
	IF v_job_count > 0 THEN
		RAISE_APPLICATION_ERROR
		(-20201, 'This employee has already done this job');
	END IF;
END; 