DECLARE
    v_first_name VARCHAR2(20);
    v_last_name VARCHAR2(20);
BEGIN
    BEGIN 
        v_first_name := 'Carmen';
        v_last_name := 'Miranda';
        
        DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' || v_last_name);        
    END;
    DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' || v_last_name);
END;


DECLARE
v_first_name VARCHAR2(20);
BEGIN
DECLARE
v_last_name VARCHAR2(20);
BEGIN
v_first_name := 'Carmen';
v_last_name := 'Miranda';
DBMS_OUTPUT.PUT_LINE
(v_first_name || ' ' || v_last_name);
END;
DBMS_OUTPUT.PUT_LINE
(v_first_name || ' ' || v_last_name);
END;