DECLARE
    CURSOR cur_countries(p_region_id NUMBER, p_population NUMBER) IS
        SELECT country_id, country_name, population
            FROM countries
            WHERE region_id = p_region_id 
            OR population > p_population;
BEGIN

    FOR v_country_record IN cur_countries(145, 10000000) LOOP
        DBMS_OUTPUT.PUT_LINE(v_country_record.country_id || ' ' ||
                            v_country_record.country_name || ' ' ||
                            v_country_record.population);
    END LOOP;
END;