DECLARE
    v_country_name countries.country_name%TYPE := 'Korea, South';
    v_elevation countries.highest_elevation%TYPE;
BEGIN
    SELECT highest_elevation
    INTO v_elevation
    FROM countries
    WHERE country_name = v_country_name;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Country name, '||v_country_name||' cannot be found.');
END;
    
    