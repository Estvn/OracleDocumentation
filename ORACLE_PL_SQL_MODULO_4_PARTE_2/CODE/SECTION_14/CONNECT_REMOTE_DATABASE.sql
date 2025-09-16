CREATE DATABASE LINK my_db_link
	CONNECT TO remote_username IDENTIFIED BY remote_password
	USING 'remote_database_name';
	
	CREATE OR REPLACE procedureA ...
IS BEGIN
	... procedureB@my_db_link (parameters ... ) ... END;