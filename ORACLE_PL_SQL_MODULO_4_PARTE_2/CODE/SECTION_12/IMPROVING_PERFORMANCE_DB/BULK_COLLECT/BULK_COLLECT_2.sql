CREATE OR REPLACE PROCEDURE fetch_some_emps 
IS
	TYPE t_salary IS TABLE OF employees.salary%TYPE
	INDEX BY BINARY_INTEGER;
	
	v_saltab t_salary;
BEGIN
	
	SELECT salary BULK COLLECT INTO v_saltab
	FROM employees
	WHERE department_id = 20 
	ORDER BY salary;
	
	FOR i IN v_saltab.FIRST .. v_saltab.LAST LOOP
        
        IF v_saltab.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE(v_satab(i));
        END IF;
    END LOOP;
END fetch_some_emps;