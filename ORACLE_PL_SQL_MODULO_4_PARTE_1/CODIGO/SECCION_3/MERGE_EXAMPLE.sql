CREATE TABLE bonuses(
    employee_id NUMBER(6,0) NOT NULL,
    bonus NUMBER(8,2) DEFAULT 0
);

INSERT INTO bonuses(employee_id)
    (SELECT employee_id FROM employees
        WHERE salary < 10000);
        
SELECT * FROM bonuses;

MERGE INTO bonuses b
    USING employees e
    on (b.employee_id = e.employee_id)
    WHEN MATCHED THEN
        UPDATE SET bonus = e.salary * .05;
    
SELECT * FROM employees;
    