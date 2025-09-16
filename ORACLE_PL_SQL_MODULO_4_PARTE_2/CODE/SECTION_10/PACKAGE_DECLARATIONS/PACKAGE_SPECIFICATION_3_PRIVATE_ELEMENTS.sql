CREATE OR REPLACE PACKAGE salary_pkg
IS
	g_max_sal_raise CONSTANT NUMBER := 0.20;
	
	PROCEDURE update_sal
		(
			p_employee_id employees.employee_id%TYPE,
			p_new_salary  employees.salary%TYPE
		);
END salary_pkg;