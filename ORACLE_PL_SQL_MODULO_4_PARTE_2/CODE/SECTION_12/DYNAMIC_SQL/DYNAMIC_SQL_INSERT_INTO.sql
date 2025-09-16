-- DYNAMIC SQL WITH DML STATEMENT

CREATE PROCEDURE add_row(p_table_name VARCHAR2, 
                p_id NUMBER, p_name VARCHAR2) 
IS
BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name ||
    'VALUES(' || p_id || ', ''' || p_name || ''')';
END;

BEGIN
    add_row('EMPLOYEE_NAMES', 250, 'Chang');
END;

SET SERVEROUTPUT ON;

SELECT * FROM employee_names;

create table employee_names (
    id INT,
    nombre VARCHAR2(60)
);

insert into employee_names (id, nombre) values (1, 'Estiven');
