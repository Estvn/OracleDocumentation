DECLARE
    v_deptno copy_emp.department_id%TYPE := 50;
BEGIN
    DELETE FROM copy_emp
        WHERE department_id = v_deptno;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' filas borradas.');
END;

DECLARE
    v_sal_increase employees.salary%TYPE := 800;
BEGIN
    UPDATE copy_emp
        SET salary = salary + v_sal_increase
        WHERE job_id = 'ST_CLERCK';
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' filas actualizadas');
END;

CREATE TABLE results (num_rows NUMBER(4));


BEGIN
    UPDATE copy_emp
        SET salary = salary + 100
        WHERE job_id = 'ST_CLERK';
        
    INSERT INTO results(num_rows) VALUES(SQL%ROWCOUNT);
END;
/

SELECT * FROM results;