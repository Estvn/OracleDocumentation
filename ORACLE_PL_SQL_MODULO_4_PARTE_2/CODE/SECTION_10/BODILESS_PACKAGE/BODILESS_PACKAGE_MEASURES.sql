CREATE OR REPLACE PACKAGE global_consts IS
	mile_to_kilo  CONSTANT NUMBER := 1.6093;
	kilo_to_mile  CONSTANT NUMBER := 0.6214;
	yard_to_meter CONSTANT NUMBER := 0.9144;
	meter_to_yard CONSTANT NUMBER := 1.0936;
END global_consts;

GRANT EXECUTE ON global_consts TO PUBLIC;

-- CALLING THE BODILESS PACKAGE
DECLARE
	distance_in_miles NUMBER(5) := 5000;
	distance_in_kilo  NUMBER(6,2);
BEGIN
	distance_in_kilo := 
		distance_in_miles * global_consts.mile_to_kilo;
	
	DBMS_OUTPUT.PUT_LINE(distance_in_kilo);
END;

SET SERVEROUTPUT ON;