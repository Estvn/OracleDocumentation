DECLARE 
	CURSOR cur_dept IS ...;
	CURSOR cur_emp (p_dept_id NUMBER) IS ...;

	v_dept_rec cur_dept%ROWTYPE;
	v_emp_rec cur_emp%ROWTYPE;
BEGIN

	OPEN cur_dept;
	LOOP
		FETCH cur_dept INTO v_dept_rec;
		EXIT WHEN cur_dept%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_dept_rec.department_id);

		OPEN cur_emp (v_dept_rec.department_id);
		LOOP
			FETCH cur_emp INTO v_emp_rec;
			EXIT WHEN cur_emp%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(v_emp_rec.last_name || ' ' || 
								v_emp_rec.first_name);
		END LOOP;
		CLOSE cur_emp;
	END LOOP;
	CLOSE cur_dept;
END;