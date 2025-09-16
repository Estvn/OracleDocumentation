/*
PLSQL_CCFLAGS allows you to set values for variables,
and then test those variables in your PL/SQL program

You define the variables and assign values to them
using PLSQL_CCFLAGS
*/

ALTER SESSION SET PLSQL_CCFLAGS = 'debug_true'

CREATE OR REPLACE PROCEDURE testproc IS BEGIN
...
	IF $$debug $THEN
		DBMS_OUTPUT.PUT_LINE('This code was executed');
	$END
...
END testproc;