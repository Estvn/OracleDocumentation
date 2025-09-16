CREATE OR REPLACE PROCEDURE update_all_emps
(p_salary_raise_percent IN NUMBER)
IS
    TYPE t_empid IS TABLE OF employees.employee_id%TYPE
    INDEX BY BINARY_INTEGER;
    
    TYPE t_sal IS TABLE OF employees.salary%TYPE
    INDEX BY BINARY_INTEGER;
    
    v_empidtab t_empud;
    v_saltab t_sal;
BEGIN
    
    SELECT employee_id BULK COLLECT INTO v_empidtab FROM employees;
    
    FORALL i IN v_empidtab.FIRST .. v_empidtab.LAST
        UPDATE employees
        SET salary = salary * (1 + p_salary_raise_percent)
        WHERE employee_id = v_empidtab(i)
        RETURNING salary BULK COLLECT INTO v_saltab;
END update_all_emps;



