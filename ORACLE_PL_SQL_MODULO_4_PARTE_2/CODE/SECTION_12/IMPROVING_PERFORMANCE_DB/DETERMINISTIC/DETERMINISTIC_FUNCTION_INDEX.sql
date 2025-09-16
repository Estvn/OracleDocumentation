-- Deterministic function promise to Oracle that
-- the output of the function always will be the same
-- for the input value

CREATE OR REPLACE FUNCTION twicenum (p_number IN NUMBER)
RETURN NUMBER DETERMINISTIC
IS
BEGIN
	RETURN p_number * 2;
END twicenum;

CREATE INDEX emp_twicesal_idx
	ON employees(twicenum(salary));