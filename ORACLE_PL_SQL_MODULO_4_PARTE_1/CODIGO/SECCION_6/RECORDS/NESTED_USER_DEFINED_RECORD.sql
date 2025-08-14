DECLARE
    TYPE dept_info_type IS RECORD(
        department_id departments.department_id%TYPE,
        department_name departments.department_name%TYPE
    );
    
    TYPE emp_dept_type IS RECORD(
        first_name employees.first_name%TYPE,
        last_name employees.last_name%TYPE,
        dept_info dept_info_type
    );
    
    v_emp_dept_rec emp_dept_type;
    
BEGIN
    ...
END;