CREATE OR REPLACE FUNCTION del_rows
(p_table_name VARCHAR2) RETURN NUMBER 
IS
	v_csr_id INTEGER;
	v_rows_del NUMBER;
BEGIN
	v_csr_id := DBMS_SQL.OPEN_CURSOR;
	
	DBMS_SQL.PARSE(v_csr_id, 'DELETE FROM '|| p_table_name, DBMS_SQL.NATIVE);
	
	v_rows_del := DBMS_SQL.EXECUTE(v_csr_id);
	
	DBMS_SQL.CLOSE_CURSOR(v_csr_id);
	
	RETURN v_rows_del;
END;