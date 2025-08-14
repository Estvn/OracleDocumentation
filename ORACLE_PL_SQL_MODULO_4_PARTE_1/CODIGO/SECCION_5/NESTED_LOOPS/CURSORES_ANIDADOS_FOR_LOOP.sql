DECLARE
	CURSOR cur_log IS SELECT * FROM locations FOR UPDATE NOWAIT;
	CURSOR cur_dept (p_locid NUMBER) IS
		SELECT * FROM departments WHERE location_id = p_locid;
BEGIN
	FOR v_locrec IN cur_loc LOOP
		DBMS_OUPUT.PUT_LINE(v_locrec.city);
		FOR v_deptrec IN cur_dept (v_loc_rec.location_id) LOOP
			DBMS_OUTPUT.PUT_LINE(v_deptrec.department_name);
		END LOOP;
	END LOOP;
END;