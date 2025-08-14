DECLARE
    TYPE person_dept IS RECORD(
        first_name employees.first_name%TYPE,
        last_name employees.last_name%TYPE,
        department_name departments.department_name%TYPE
        );
    v_person_dept_rec person_dept;
BEGIN
    SELECT e.first_name, e.last_name, d.department_name
    INTO v_person_dept_rec
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE employee_id = 200;
    
    DBMS_OUTPUT.PUT_LINE(
        v_person_dept_rec.first_name || ' ' ||
        v_person_dept_rec.last_name || ' is in the ' ||
        v_person_dept_rec.department_name || ' department.');
END; 