CREATE OR REPLACE PROCEDURE add_dept 
IS
    v_dept_id copy_dept.department_id%TYPE;
    v_dept_name copy_dept.department_name%TYPE;
BEGIN
    v_dept_id := 280;
    v_dept_name := 'ST-Curriculum';
    
    INSERT INTO copy_dept(department_id, department_name)
        VALUES(v_dept_id, v_dept_name);
    DBMS_OUTPUT.PUT_LINE('Inserted ' || SQL%ROWCOUNT || ' row.');
END;

SELECT * from copy_dept;

BEGIN
    add_dept;
END;

SELECT * from copy_dept;
