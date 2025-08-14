DECLARE
    v_emp_lname employees.last_name%TYPE;
BEGIN
    SELECT last_name
        INTO v_emp_lname
    FROM employees
        WHERE employee_id = 100;
        
    DBMS_OUTPUT.PUT_LINE('His last name is ' || v_emp_lname);
END;

DECLARE
    v_emp_hiredate employees.hire_date%TYPE;
    v_emp_salary employees.salary%TYPE;
BEGIN
    SELECT hire_date, salary
        INTO v_emp_hiredate, v_emp_salary
    FROM employees
        WHERE employee_id = 100;
        
    DBMS_OUTPUT.PUT_LINE('Hiredate: ' || v_emp_hiredate);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_emp_salary);
END;