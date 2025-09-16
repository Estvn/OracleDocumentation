-- To use Bulk Collect we need to make a variable
-- to catch all the rows that will come.

CREATE OR REPLACE PROCEDURE fetch_all_emps IS
    
    TYPE t_emp IS TABLE OF employees%ROWTYPE INDEX BY BINARY_INTEGER;
    v_emptab t_emp;

BEGIN
    
    SELECT * BULK COLLECT INTO v_emptab FROM EMPLOYEES;
    
    FOR i IN v_emptab.FIRST .. v_emptab.LAST LOOP
        
        IF v_emptab.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE(v_emptab(i).last_name);
        END IF;
    END LOOP;
END fetch_all_emps;

BEGIN
    fetch_all_emps();
END;

set SERVEROUTPUT on;