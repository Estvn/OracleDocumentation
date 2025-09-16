CREATE OR REPLACE FUNCTION total_sal 
(p_dept_id IN employees.department_id%TYPE)
RETURN NUMBER DETERMINISTIC
IS
	v_total_sal NUMBER;
BEGIN
	SELECT SUM(salary) INTO v_total_sal 
	FROM employees
	WHERE department_id = p_dept_id;
	
	RETURN v_total_sal;
END total_sal; 