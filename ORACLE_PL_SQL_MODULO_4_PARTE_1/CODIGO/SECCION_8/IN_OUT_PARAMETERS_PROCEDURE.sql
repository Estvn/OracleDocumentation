CREATE OR REPLACE PROCEDURE format_phone(
	p_phone_no IN OUT VARCHAR2) IS
BEGIN
	p_phone_no := '(' || SUBSTR(p_phone_no, 1, 3) ||
					')' || SUBSTR(p_phone_no, 4, 3) ||
					'-' || SUBSTR(p_phone_no, 7);
END format_phone;

DECLARE
	a_phone_no VARCHAR2(13);
BEGIN
	a_phone_no := '8006330575';
	format_phone(a_phone_no);
	DBMS_OUTPUT.PUT_LINE('El formato del número es: ' || a_phone_no);
END;
