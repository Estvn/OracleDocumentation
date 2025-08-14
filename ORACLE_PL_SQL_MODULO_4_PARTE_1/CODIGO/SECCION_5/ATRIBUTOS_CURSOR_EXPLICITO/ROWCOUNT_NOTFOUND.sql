DECLARE
	CURSOR cur_emps IS
		SELECT employee_id, last_name FROM employees;
	
	v_emp_record cur_emps%ROWTYPE;
BEGIN

	IF NOT cur_emps%ISOPEN THEN
		OPEN cur_emps;
	END IF;

    <<cursor_loop>>
	LOOP
		FETCH cur_emps INTO v_emp_record;
		EXIT WHEN cur_emps%ROWCOUNT > 10 OR cur_emps%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(
        v_emp_record.employee_id || ' ' || v_emp_record.last_name
        );
    END LOOP cursor_loop;
    CLOSE cur_emps;
END;