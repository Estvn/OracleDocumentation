CREATE PROCEDURE add_row (p_table VARCHAR2, p_id NUMBER, p_name VARCHAR2)
IS
	v_csr_id INTEGER;
	v_stmt VARCHAR2(200);
	v_rows_added NUMBER;
BEGIN
	v_stmt := 'INSERT INTO ' || p_table_name ||
			' VALUES(' || p_id || ', ''' || p_name || ''')';

	v_csr_id := DBMS_SQL.OPEN_CURSOR;

	DBMS_SQL.PARSE(v_csr_id, v_stmt, DBMS_SQL.NATIVE);

	v_rows_added := DBMS_SQL.EXECUTE(v_csr_id);

	DBMS_SQL.CLOSE_CURSOR(v_csr_id);
END;