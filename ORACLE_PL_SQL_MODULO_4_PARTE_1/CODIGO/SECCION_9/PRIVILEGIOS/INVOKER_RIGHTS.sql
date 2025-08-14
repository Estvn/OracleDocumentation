Tom> CREATE TABLE tests ... ;
Sue> CREATE TABLE tests ... ;

Tom> CREATE OR REPLACE PROCEDURE grades ...
	AUTHID CURRENT_USER IS BEGIN
	... SELECT ... FROM tests ... ;
END;

Tom> GRANT EXECUTE ON grades TO sue;
Sue> BEGIN ... tom.grades(...); ... END;