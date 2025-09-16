ALTER SESSION SET PLSQL_CCFLAGS = 
	'firstflag:1, secondflag:false';
	
CREATE OR REPLACE PROCEDURE testproc 
IS
BEGIN
...
	$IF $$firstflag > 0 AND NOT $$secondflag $THEN
		DBMS_OUTPUT.PUT_LINE('Testing both variables');
	$ELSIF
		DBMS_OUTPUT.PUT_LINE('Testing one variable');
	$END
...
END testproc;