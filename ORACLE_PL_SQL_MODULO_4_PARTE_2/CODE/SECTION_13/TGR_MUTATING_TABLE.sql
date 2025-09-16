-- In a trigger does´s permit to make a SELECT in the table used in the Trigger
-- This causes inconsistent in the data.

-- This Trigger will cause an error
CREATE OR REPLACE TRIGGER check_salary
    BEFORE INSERT OR UPDATE OF salary, job_id ON employees
    FOR EACH ROW
DECLARE
    v_minsalary employees.salary%TYPE;
    v_maxsalary employees.salary%TYPE;
BEGIN
    SELECT MIN(salary), MAX(salary) INTO v_minsalary, v_maxsalary
    FROM employees
    WHERE job_id = :NEW.job_id;
    
    IF :NEW.salary < v_minsalary OR :NEW.salary > v_maxsalary THEN
        RAISE_APPLICATION_ERROR(-20505, 'Out of range');
    END IF;
END;