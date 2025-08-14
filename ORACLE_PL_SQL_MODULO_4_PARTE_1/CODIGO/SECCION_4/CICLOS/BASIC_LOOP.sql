DECLARE 
	v_number NUMBER(1) := 1;
BEGIN
	LOOP
		v_number := v_number + 1;
		EXIT WHEN v_number > 5;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_number);
END;


DECLARE 
	v_number NUMBER(2) := 1;
BEGIN
	LOOP
		v_number := v_number + 1;
        DBMS_OUTPUT.PUT_LINE(v_number);
		IF v_number >= 10 THEN 
            EXIT;
        END IF;
    END LOOP;
END;


