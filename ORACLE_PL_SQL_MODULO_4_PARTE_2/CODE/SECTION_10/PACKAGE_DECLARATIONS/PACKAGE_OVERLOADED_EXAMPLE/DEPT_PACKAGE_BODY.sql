CREATE OR REPLACE PACKAGE BODY dept_pkg IS
	
	PROCEDURE add_department(p_deptno NUMBER,
		p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700)
	IS
	BEGIN
		INSERT INTO departments(department_id, department_name, location_id)
		VALUES (p_deptno, p_name, p_loc);
	END add_department;
	
	PROCEDURE add_department(p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700)
	IS
	BEGIN
		INSERT INTO departments(department_id, department_name, location_id)
		VALUES (departments_seq.NEXTVAL, p_name, p_loc);
	END add_department;
END dept_pkg;