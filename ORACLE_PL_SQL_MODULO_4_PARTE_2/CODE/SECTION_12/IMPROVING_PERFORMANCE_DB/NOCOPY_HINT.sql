CREATE OR REPLACE PACKAGE emp_pkg 
IS
	TYPE t_emp IS TABLE OF employees%ROWTYPE 
	INDEX BY BINARY_INTEGER;
	
	PROCEDURE emp_proc(
		p_small_arg IN NUMBER,
		p_big_arg OUT NOCOPY t_emp
	);
END emp_pkg;