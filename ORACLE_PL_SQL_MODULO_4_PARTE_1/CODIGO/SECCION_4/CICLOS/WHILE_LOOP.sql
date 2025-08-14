/*
SELECT MAX(location_id) from locations
where country_id = 2;
*/

DECLARE
	v_loc_id locations.location_id%TYPE;
	v_counter NUMBER := 1;
BEGIN
	SELECT MAX(location_id) INTO v_loc_id FROM locations
		WHERE country_id = 2;

	WHILE v_counter <= 3 LOOP
		INSERT INTO locations(location_id, city, country_id)
		VALUES((v_loc_id + v_counter), 'Montreal', 2);

		v_counter := v_counter +1;
	END LOOP;
END;