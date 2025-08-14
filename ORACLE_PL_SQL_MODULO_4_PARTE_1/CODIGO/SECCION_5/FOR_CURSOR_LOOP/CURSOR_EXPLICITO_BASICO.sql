DECLARE 
    CURSOR CUR_DEPTS IS
        SELECT department_id, department_name FROM departments;
    
    v_department_id departments.department_id%TYPE;
    v_department_name departments.department_name%TYPE;
BEGIN
    OPEN CUR_DEPTS;
    <<depts_loop>>
    LOOP
        FETCH CUR_DEPTS INTO v_department_id, v_department_name;
        EXIT WHEN CUR_DEPTS%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_department_id || ' - ' || v_department_name);
    END LOOP depts_loop;
    CLOSE CUR_DEPTS;
END;