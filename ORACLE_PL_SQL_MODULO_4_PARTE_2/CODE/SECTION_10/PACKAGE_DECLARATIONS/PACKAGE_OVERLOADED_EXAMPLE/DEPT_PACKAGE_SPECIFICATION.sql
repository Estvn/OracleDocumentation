CREATE OR REPLACE PACKAGE dept_pkg IS

	PROCEDURE add_department(p_deptno NUMBER,
		p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700);
		
	PROCEDURE add_department(
		p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700);
END dept_pkg;