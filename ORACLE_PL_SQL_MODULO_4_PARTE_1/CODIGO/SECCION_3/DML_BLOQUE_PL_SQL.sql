-- CREANDO COPIA DE TABLA
CREATE TABLE copy_emp AS SELECT * FROM employees;

SELECT * FROM copy_emp;

-- INSERT
BEGIN
    INSERT INTO copy_emp
        (employee_id, first_name, last_name, email, hire_date, job_id, salary)
    VALUES (99, 'Ruth', 'Core', 'RCORES', SYSDATE, 'AD_ASST', 4000);
END;

SELECT salary, job_id FROM copy_emp WHERE job_id = 'ST_CLERK';

-- UPDATE
DECLARE
    v_sal_increase copy_emp.salary%TYPE := 1000;
BEGIN
    UPDATE copy_emp
        SET salary = salary + v_sal_increase
    WHERE job_id = 'ST_CLERK';
END;

SELECT * FROM copy_emp;

-- DELETE 
DECLARE 
    v_deptno copy_emp.department_id%TYPE := 10;
BEGIN
    DELETE FROM copy_emp
        WHERE department_id = v_deptno;
END;
    
    
    
    
    
    
    