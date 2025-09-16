-- DYNAMIC SQL WITH DML STATEMENT

CREATE FUNCTION del_rows (p_table_name VARCHAR2) 
RETURN NUMBER IS 
BEGIN
    EXECUTE IMMEDIATE 'DELETE FROM ' || p_table_name;
    RETURN SQL%ROWCOUNT;
END;

DECLARE
    v_count NUMBER;
BEGIN
    v_count := del_rows('EMPLOYEE_NAMES');
    DBMS_OUTPUT.PUT_LINE(v_count || ' rows deleted.');
END;

SET SERVEROUTPUT ON;

SELECT * FROM employee_names;

create table employee_names (
    id INT,
    nombre VARCHAR2(60)
);

insert into employee_names (id, nombre) values (1, 'Estiven');

