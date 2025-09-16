CREATE OR REPLACE TRIGGER secure_emp
BEFORE UPDATE ON employees
BEGIN
    
    IF UPDATING('SALARY') THEN
        
        IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
            RAISE_APPLICATION_ERROR(-20501, 'Cannot update salary on weekend');
        END IF;
    
    ELSIF UPDATING('JOB_ID') THEN
        
        IF TO_CHAR(SYSDATE, 'DY') = 'SUN' THEN
            RAISE_APPLICATION_ERROR(-20502, 'Cannot update JOB_ID on sunday');
        END IF;
    END IF;
END;
        