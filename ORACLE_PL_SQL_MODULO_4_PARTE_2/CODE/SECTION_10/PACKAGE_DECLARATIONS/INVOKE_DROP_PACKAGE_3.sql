DECLARE
	v_bool BOOLEAN;
	v_number NUMBER;
BEGIN
	salary_pkg.update_sal(100, 25000);
	update_sal(100, 25000);
	v_bool := salary_pkg.validate_raise(24000, 25000);
	v_number := salary_pkg.g_max_sal_raise;
	v_number := salary_pkg.v_old_salary;
END;
 
DROP PACKAGE package_name; -- DROP ALL
DROP PACKAGE BODY package_name; -- DROP ONLY BODY