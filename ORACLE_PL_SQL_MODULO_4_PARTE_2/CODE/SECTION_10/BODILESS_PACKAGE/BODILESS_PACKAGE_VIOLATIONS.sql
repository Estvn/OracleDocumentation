CREATE OR REPLACE PACKAGE our_exceptions IS
	
	e_cons_vliolation EXCEPTION;
	PRAGMA EXCEPTION_INIT (e_cons_violation, -2292);
	e_value_too_large EXCEPTION;
	PRAGMA EXCEPTION_INIT (e_value_too_large, 1438);
    
END our_exceptions;

GRANT EXECUTE ON our_exceptions TO PUBLIC;