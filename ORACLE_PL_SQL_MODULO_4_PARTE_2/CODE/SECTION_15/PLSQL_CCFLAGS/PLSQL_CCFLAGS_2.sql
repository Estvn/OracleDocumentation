ALTER SESSION SET PLSQL_CCFLAGS = 'testflag:1';

CREATE OR REPLACE PROCEDURE testproc
IS 
BEGIN
...
	$IF $$testflag > 0 $THEN
		DBMS_OUTPUT.PUT_LINE('This code was executed');
	$END
...
END testproc;