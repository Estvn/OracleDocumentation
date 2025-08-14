CREATE OR REPLACE PROCEDURE add_dept(
	p_name my_depts.department_name%TYPE := 'Unknown',
	p_loc my_depts.location_id%TYPE DEFAULT 1400)
IS BEGIN
	INSERT INTO my_depts (...)
	VALUES (departments_seq.NEXTVAL, p_name, p_loc);
END add_dept