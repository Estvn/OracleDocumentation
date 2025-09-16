-- Returning join an SELECT query within the UPDATE query 
CREATE OR REPLACE PROCEDURE update_one_emp 
(p_emp_id IN employees.employee_id%TYPE,
p_salary_raise_percent IN NUMBER)
IS
	v_new_salary employees.salary%TYPE;
BEGIN
	UPDATE employees
	SET salary = salary * (1 + p_salary_raise_percent)
	WHERE employee_id = p_emp_id
	RETURNING salary INTO v_new_salary;
	
	DBMS_OUTPUT.PUT_LINE('New salary is:' || v_new_salary);
END update_one_emp;