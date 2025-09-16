CREATE OR REPLACE PACKAGE check_emp_pkg
IS
    
    g_max_length_of_service CONSTANT NUMBER := 100;
    
    PROCEDURE chk_hiredate 
        (p_date IN employees.hire_date%TYPE);
        
    PROCEDURE chk_dept_mgr
        (
            p_empid IN employees.employee_id%TYPE,
            p_mgr   IN employees.manager_id%TYPE
        );
END check_emp_pkg;