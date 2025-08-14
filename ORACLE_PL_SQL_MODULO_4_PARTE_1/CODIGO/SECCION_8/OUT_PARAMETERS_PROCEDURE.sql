CREATE OR REPLACE PROCEDURE query_emp(
    p_id IN employees.employee_id%TYPE,
    p_name OUT employees.last_name%TYPE,
    p_salary employees.salary%TYPE)
IS BEGIN
    SELECT last_name, salary INTO p_name, p_salary
    FROM employees
    WHERE employee_id = p_id;
END query_emp;

DECLARE 
    a_emp_name copy_emp.salary%TYPE;
    a_emp_sal copy_emp.salary%TYPE;
BEGIN
    -- En las variables se guardan los resultados retornados
    query_emp(178, a_emp_name, a_emp_sal);
END;
    