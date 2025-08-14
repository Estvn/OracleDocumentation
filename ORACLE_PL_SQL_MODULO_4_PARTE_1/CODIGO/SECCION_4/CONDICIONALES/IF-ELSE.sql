DECLARE 
	v_myage NUMBER(2) := 23;
BEGIN
	IF v_myage < 11 THEN
		DBMS_OUTPUT.PUT_LINE('Tengo ' || v_myage);
	ELSE 
		DBMS_OUTPUT.PUT_LINE('xd');
	END IF;
END;

DECLARE 
	v_myage NUMBER(2) := 23;
BEGIN
	IF v_myage < 18 THEN
		DBMS_OUTPUT.PUT_LINE('Niño');
	ELSIF v_myage >= 18 AND v_myage <65 THEN
		DBMS_OUTPUT.PUT_LINE('Adulto');
	ELSE
		DBMS_OUTPUT.PUT_LINE('xd');
    END IF;
END;