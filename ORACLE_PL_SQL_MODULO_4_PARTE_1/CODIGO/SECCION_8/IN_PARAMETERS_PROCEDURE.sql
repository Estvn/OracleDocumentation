CREATE OR REPLACE PROCEDURE raise_salary (
    p_id IN copy_emp.employee_id%TYPE,
    p_percent IN NUMBER)
IS BEGIN
    UPDATE copy_emp
        SET salary = salary * (1 + p_percent/100)
        WHERE employee_id = p_id;
END raise_salary;

