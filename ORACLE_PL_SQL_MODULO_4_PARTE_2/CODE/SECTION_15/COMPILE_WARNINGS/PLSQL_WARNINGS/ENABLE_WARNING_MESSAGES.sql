-- A warning occurs when the code compiles successfully, but it could be coded better
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:ALL';

CREATE OR REPLACE PROCEDURE unreachable 
IS
	c_const CONSTANT BOOLEAN := TRUE;
BEGIN
	IF c_const THEN
		DBMS_OUTPUT.PUT_LINE('TRUE');
	ELSE
		DBMS_OUTPUT.PUT_LINE('NOT TRUE');	
	END IF;
END unreachable;

SELECT line, position, text, attribute FROM USER_ERRORS
WHERE name = 'UNREACHABLE';