DECLARE
    CURSOR cur_country (p_region_id NUMBER) IS
        SELECT country_id, country_name
            FROM countries
            WHERE region_id = p_region_id;
    
    v_country_record cur_country%ROWTYPE;
BEGIN
    OPEN cur_country(5);
    LOOP
        FETCH cur_country INTO v_country_record;
        EXIT WHEN cur_country%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            v_country_record.country_id || ' ' ||
            v_country_record.country_name
        );
    END LOOP;
    CLOSE cur_country;
END;