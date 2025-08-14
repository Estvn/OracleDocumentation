DECLARE
    v_num NUMBER := 77;
    v_txt VARCHAR(50);
BEGIN
    v_txt := 
    CASE
        WHEN v_num < 20 THEN 'Number is minus that 20'
        WHEN v_num = 30 THEN  'Number equals 30'
        WHEN v_num > 40 THEN  'Number is more that 40'
        ELSE 'The number isnt here'
    END;
    DBMS_OUTPUT.PUT_LINE(v_txt);
END;
    