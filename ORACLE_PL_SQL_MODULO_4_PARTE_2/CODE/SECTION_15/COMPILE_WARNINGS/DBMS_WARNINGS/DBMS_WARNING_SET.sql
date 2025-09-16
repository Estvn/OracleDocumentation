BEGIN
	DBMS_WARNING.SET_WARNING_SETTING_STRING
	('ENABLE:SEVERE', 'SESSION');
END;

-- This disables all warning categories, then enables the SEVERE category
-- This has exactly the same effect as:
ALTER SESSION SET PLSQL_WARNINGS = 'DISABLE:ALL', 'ENABLE:SEVERE';