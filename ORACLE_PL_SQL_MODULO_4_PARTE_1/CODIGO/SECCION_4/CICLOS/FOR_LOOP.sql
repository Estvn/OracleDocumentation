/*
SELECT MAX(location_id) from locations
where country_id = 2;
*/

DECLARE
	v_loc_id locations.location_id%TYPE;
BEGIN
	SELECT MAX(location_id) INTO v_loc_id FROM locations
		WHERE country_id = 2;

    FOR i IN 1 .. 3 LOOP
		INSERT INTO locations(location_id, city, country_id)
		VALUES((v_loc_id + i), 'Montreal', 2);
    END LOOP;
END;