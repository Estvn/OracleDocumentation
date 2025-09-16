-- DBMS_WARNING.ADD
BEGIN
	DBMS_WARNING.ADD_WARNING_SETTING_CAT
	('PERFORMANCE', 'EANBLE', 'SESSION');
END;

-- This enables the PERFORMANCE warning category, leaving other category settings unchanged.
-- The third argument, 'SESSION' is required
-- This has exactly the same effect as:
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:PERFORMANCE';