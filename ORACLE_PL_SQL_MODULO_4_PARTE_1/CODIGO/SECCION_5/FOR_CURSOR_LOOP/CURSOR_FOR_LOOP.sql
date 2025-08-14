DECLARE 
	CURSOR cur_emps IS
		SELECT employee_id, last_name FROM employees
		WHERE department_id = 50;
BEGIN
	FOR v_emp_record IN cur_emps LOOP
		DBMS_OUTPUT.PUT_LINE(
		v_emp_record.employee_id || ' ' || v_emp_record.last_name
		);
	END LOOP;
END;