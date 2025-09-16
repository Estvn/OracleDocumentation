CREATE OR REPLACE PACKAGE manage_jobs_pkg
IS
    g_todays_date DATE := SYSDATE;
    
    CURSOR jobs_curs IS 
        SELECT employee_id, job_id FROM employees
            ORDER BY employee_id;
            
    PROCEDURE update_job
        (p_emp_id IN employees.employee_id%TYPE);
        
    PROCEDURE fetch_emps
        (
            p_job_id IN employees.job_id%TYPE,
            p_emp_id OUT employees.employee_id%TYPE
        );
END manage_jobs_pkg;