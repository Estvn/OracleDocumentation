-- DYNAMIC SQL WITH DDL STATEMENT

CREATE PROCEDURE drop_any_table (p_table_name VARCHAR2) 
IS
BEGIN
	EXECUTE IMMEDIATE 'DROP TABLE ' || p_table_name;
END;

CREATE OR REPLACE PROCEDURE drop_any_table (p_table_name VARCHAR2)
IS
	v_dynamic_stmt VARCHAR2(50);
BEGIN
	v_dynamic_stmt := 'DROP TABLE ' || p_table_name;
	EXECUTE IMMEDIATE v_dynamic_stmt;
END;

BEGIN
	drop_any_table ('EMPLOYEE_NAMES');
END;

SET SERVEROUTPUT ON;

SELECT * FROM employee_names;

create table employee_names (
    id INT,
    nombre VARCHAR2(60)
);

insert into employee_names (id, nombre) values (1, 'Estiven');

