CREATE OR REPLACE PROCEDURE insert_emps 
IS
    TYPE t_emps IS TABLE OF employees%ROWTYPE 
    INDEX BY BINARY_INTEGER;
    
    v_emptab t_emps;
BEGIN
    
    SELECT * BULK COLLECT INTO v_emptab FROM employees;
    FORALL i IN v_emptab.FIRST .. v_emptab.LAST SAVE EXCEPTIONS
    INSERT INTO employees VALUES v_emptab(1);
    
END insert_emps;