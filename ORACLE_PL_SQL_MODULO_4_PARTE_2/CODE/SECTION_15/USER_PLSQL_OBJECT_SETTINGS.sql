SELECT 
	name, type, plsql_code_type AS CODE_TYPE,
	plsql_optimize_level AS OPT_LVL 
FROM 
	USER_PLSQL_OBJECT_SETTING WHERE name = 'CALLEDPROC';