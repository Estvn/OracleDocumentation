CREATE OR REPLACE PACKAGE BODY salary_pkg 
IS
	
	FUNCTION validate_raise -- private function
		(
			p_old_salary employees.salary%TYPE,
			p_new_salary employees.salary%TYPE
		)
	RETURN BOOLEAN 
	IS
	BEGIN
		IF p_new_salary > 
		(p_old_salary * (1 + g_max_sal_raise)) THEN
			RETURN FALSE;
		ELSE
			RETURN TRUE;
		END IF;
	END validate_raise;
	
	PROCEDURE update_sal -- public procedure 
		(
			p_employee_id employees.employee_id%TYPE,
			p_new_salary  employees.salary%TYPE
		)
	IS 
		v_old_salary employees.salary%TYPE; -- local variable
	BEGIN
		SELECT salary INTO v_old_salary FROM employees
			WHERE employee_id = p_employee_id;
			
		IF validate_raise(v_old_salary, p_new_salary) THEN
			UPDATE employees
				SET salary = p_new_salary
				WHERE employee_id = p_employee_id;
		ELSE
			RAISE_APPLICATION_ERROR(-20210, 'Raise to high');
		END IF;
	END update_sal;
END salary_pkg;