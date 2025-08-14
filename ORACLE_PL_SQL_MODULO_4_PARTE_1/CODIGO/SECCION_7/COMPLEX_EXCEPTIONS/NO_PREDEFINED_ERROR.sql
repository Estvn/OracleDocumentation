DECLARE
	e_insert_except EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_insert_except, -01400);
BEGIN
	INSERT INTO departments (department_id, department_name)
	VALUES (280, NULL);
EXCEPTION
	WHEN e_insert_except THEN
		DBMS_OUTPUT.PUT_LINE('INSERT FAILED');
END;