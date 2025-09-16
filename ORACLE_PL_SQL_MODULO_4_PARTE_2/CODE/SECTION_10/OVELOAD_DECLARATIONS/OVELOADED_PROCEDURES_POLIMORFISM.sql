CREATE PACKAGE sample_pack IS
	PROCEDURE sample_proc (p_char_param IN CHAR);
	PROCEDURE sample_proc (p_varchar_param IN VARCHAR2);
END sample_pack;

-- This will fails
BEGIN 
	sample_pack.sample_proc('Smith'); 
END;

-- This will work
BEGIN 
	sample_pack.sample_proc(p_char_param => 'Smith'); 
END;