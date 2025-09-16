-- create table emp as (select * from employees);
CREATE OR REPLACE PROCEDURE insert_emps 
IS 
    TYPE t_emps IS TABLE OF employees%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    v_emptab t_emps;
BEGIN
    
    SELECT * BULK COLLECT INTO v_emptab FROM employees;
    
    FORALL i IN v_emptab.FIRST .. v_emptab.LAST
    INSERT INTO emp VALUES v_emptab(i);
    
    FOR i IN v_emptab.FIRST .. v_emptab.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Inserted: '
        || i || ' ' || SQL%BULK_ROWCOUNT(i) || ' rows'
        );
    END LOOP;
END insert_emps;
    
    
BEGIN 
    insert_emps();
END;