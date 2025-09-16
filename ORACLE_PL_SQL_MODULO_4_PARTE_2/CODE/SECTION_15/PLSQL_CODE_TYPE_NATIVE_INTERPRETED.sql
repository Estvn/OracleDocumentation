ALTER SESSION SET PLSQL_CODE_TYPE = NATIVE;

ALTER SESSION SET PLSQL_CODE_TYPE = INTERPRETED;


CREATE OR REPLACE PROCEDURE longproc 
IS
    v_number PLS_INTEGER;
BEGIN
    FOR i IN 1 .. 50000000 LOOP
        v_number := v_number * 2;
        v_number := v_number / 2;
    END LOOP;
END longproc;

-- In this example, NATIVE ocmpilation is faster
BEGIN
    longproc;
END;
