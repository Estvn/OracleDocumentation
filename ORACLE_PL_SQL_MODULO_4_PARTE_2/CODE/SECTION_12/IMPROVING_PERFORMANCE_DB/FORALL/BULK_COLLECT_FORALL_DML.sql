CREATE OR REPLACE PROCEDURE update_emps 
IS
	TYPE t_emp_id IS TABLE OF employees.employee_id%TYPE
	INDEX BY BINARY_INTEGER;
	
	v_emp_id_tab t_emp_id;
BEGIN
	
	SELECT employee_id BULK COLLECT INTO v_emp_id_tab
	FROM employees;
	
	FORALL i IN v_emp_id_tab.FIRST .. v_emp_id_tab.LAST
	UPDATE new_employees
	SET salary = salary * 1.05
	WHERE employee_id = v_emp_id_tab(i);
END update_emps;