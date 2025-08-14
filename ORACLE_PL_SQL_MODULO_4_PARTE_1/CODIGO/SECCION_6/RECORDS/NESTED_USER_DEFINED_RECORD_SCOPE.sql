DECLARE -- outer block
	TYPE employee_type IS RECORD(
		first_name employees.first_name%TYPE := 'Amy'
	);
	v_emp_rec_outer employee_type;
BEGIN
	DBMS_OUTPUT.PUT_LINE(v_emp_rec_outer.first_name);
	
	DECLARE -- inner block
		v_emp_rec_inner employee_type;
	BEGIN
		v_emp_rec_outer.first_name := 'Clara';
		DBMS_OUTPUT.PUT_LINE(
			v_emp_rec_outer.first_name || ' and ' ||
			v_emp_rec_inner.first_name);
	END;
	DBMS_OUTPUT.PUT_LINE(v_emp_rec_outer.first_name);
END;