BEGIN
	dept_pkg.add_department(980, 'Education', 2500);
END;

SELECT * FROM departments WHERE department_id = 980;

BEGIN
	dept_pkg.add_department('Training', 2500);
END;

SELECT * FROM departments WHERE department_name = 'Training';