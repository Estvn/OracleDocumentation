/*
The compiled code of CALLINGPROC now contains the code of both subprograms,
as if it had been written as part of CALLINGPROC instead of as a separate subprogram.

CALLEDPROC also still exists as a separate subprogram
and can still be called from other places.
*/

CREATE OR REPLACE PROCEDURE calledproc IS BEGIN ... END calledproc;

ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 3;

CREATE OR REPLEACE PROCEDURE callingproc 
IS 
BEGIN
	...
	calledproc;
	...
END;
