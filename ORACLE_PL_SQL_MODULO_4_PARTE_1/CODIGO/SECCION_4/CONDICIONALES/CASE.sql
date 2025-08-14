DECLARE
    v_num NUMBER := 77;
    v_txt VARCHAR(50);
BEGIN
    CASE v_num
        WHEN 20 THEN v_txt := 'Number equals 20';
        WHEN 30 THEN v_txt := 'Number equals 30';
        WHEN 40 THEN v_txt := 'Number equals 40';
        WHEN 55 THEN v_txt := 'Number equals 55';
        WHEN 67 THEN v_txt := 'Number equals 67';
        WHEN 77 THEN v_txt := 'Number equals 77';
        ELSE v_txt := 'The number isnt here';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_txt);
END;
    