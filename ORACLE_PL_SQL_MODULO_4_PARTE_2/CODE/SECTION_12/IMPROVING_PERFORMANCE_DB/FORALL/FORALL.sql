-- Works like BULK COLLECT
-- Make insertions massively with one query
-- We can use it for all de DML queries
CREATE OR REPLACE PROCEDURE insert_emps 
IS
	TYPE t_emps IS TABLE OF employees%ROWTYPE 
	INDEX BY BINARY_INTEGER;
	
	v_emptab t_emps;
BEGIN
	
	FORALL i IN v_emptab.FIRST .. v_emptab.LAST
	INSERT INTO employees VALUES v_emptab(i);
END insert_emps;