CREATE OR REPLACE PACKAGE BODY check_emp_pkg 
IS

	PROCEDURE chk_hiredate
		(p_date IN employees.hire_date%TYPE)
		IS BEGIN
			IF MONTHS_BETWEEN(SYSDATE, p_date) > 
			g_max_length_of_service * 12 THEN
				RAISE_APPLICATION_ERROR(-20200, 'Invalid Hiredate');
				END IF;
	END chk_hiredate;
	
	PROCEDURE chk_dept_mgr
		(
			p_empid IN employees.employee_id%TYPE,
			p_mgr   IN employees.manager_id%TYPE
		)
		IS BEGIN ...
	END chk_dept_mgr;
	END check_emp_pfg;