-- If trying to insert on employees table in weekend days
-- will be raised an error, and the insert will not happen

CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON employees
BEGIN
	IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
		RAISE_APPLICATION_ERROR(-20500,
		'Yout may insert into EMPLOYEES table only during bussiness hours');
	END IF;
END;

INSERT INTO employees (
    employee_id,
    last_name,
    email,
    hire_date,
    job_id
) VALUES (
    106,
    'Garcia',
    'garcia@email.com',
    SYSDATE,
    'IT_PROG'
);