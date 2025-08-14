DECLARE
    v_num NUMBER := 77;
    v_txt VARCHAR(50);
BEGIN
    CASE
        WHEN v_num < 20 THEN v_txt := 'Number is minus that 20';
        WHEN v_num = 30 THEN v_txt := 'Number equals 30';
        WHEN v_num > 40 THEN v_txt := 'Number is more that 40';
        ELSE v_txt := 'The number isnt here';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_txt);
END;
    
    
