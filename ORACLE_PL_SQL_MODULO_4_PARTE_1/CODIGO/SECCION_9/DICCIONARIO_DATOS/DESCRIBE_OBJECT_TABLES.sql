DESCRIBE ALL_TABLES;

SELECT object_type, object_name FROM USER_OBJECTS;

SELECT object_type, COUNT(*) FROM USER_OBJECTS GROUP BY object_type;