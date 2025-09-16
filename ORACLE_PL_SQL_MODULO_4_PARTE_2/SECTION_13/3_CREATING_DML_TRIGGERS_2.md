
- CONDITIONAL PREDICATES
- ROW TRIGGERS
- OLD AND NEW QUALIFIERS
- REFERENCING clause
- WHEN clause
- INSTEAD OF triggers
- COMPOUNT Trigger

**Objetives:**

- Create a DML trigger that uses conditional predicates
- Create a row-level trigger
- Create a row-level trigger that used OLD and NEW qualifiers 
- Create an INSTEAD OF triggers
- Create a Compound Trigger

- There might be times when you want a trigger to fire under a specific condition
- Or, you might want a trigger to impact just a row of data
- These are examples of the DML trigger features covered in this lesson

# Using Conditional Predicates

- In the previous lesson, you saw a trigger that prevents INSERTs into the EMPLOYEES table during the weekend

```
CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON employees
BEGIN
	IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
		RAISE_APPLICATION_ERROR(-20500,
		'You may insert into EMPLOYEES table only during
		business hours');
	END IF;
END;
```

- Suppose you want to prevent any DML operation on EMPLOYEES during the weekend, but with different error messages for INSERT, UPDATE, and DELETE.

# Using Conditional Predicates

- The trigger keywords **DELETING, INSERTING and UPDATING** are automatically delcared Boolean variables which are set to TRUE or FALSE by the Oracle Server

```
CREATE OR REPLACE TRIGGER secure_emp
	BEFORE INSERT OR UPDATE OR DELETE ON employes
BEGIN
	
	IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
		IF DELETING THEN 
			RAISE_APPLICATION_ERROR(-20501, 'Cannot delete in weekends');
		
		ELSIF INSERTING THEN
			RAISE_APPLICATION_ERROR(-20502, 'Cannot insert in weekends');
			
		ELSIF UPDATING THEN
			RAISE_APPLICATION_ERROR(-20503, 'Cannot update in weekends');
		END IF;
	END IF;
END;	
```

---------------------
# Conditional Predicates In a Column Table

**You can use conditional predicates to test for UPDATE on a specific column:**

```
CREATE OR REPLACE TRIGGER secure_emp
BEFORE UPDATE ON employees
BEGIN
    
    IF UPDATING('SALARY') THEN
        
        IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
            RAISE_APPLICATION_ERROR(-20501, 'Cannot update salary on weekend');
        END IF;
    
    ELSIF UPDATING('JOB_ID') THEN
        
        IF TO_CHAR(SYSDATE, 'DY') = 'SUN' THEN
            RAISE_APPLICATION_ERROR(-20502, 'Cannot update JOB_ID on sunday');
        END IF;
    END IF;
END;
```

- This trigger will allow other columns of EMPLOYEES to be updated at any time

---------------------------
# Understanding Row Triggers

- Remember that a statement trigger executes only once for each triggering DML statement.

```
CREATE OR REPLACE TRIGGER log_emps
	AFTER UPDATE OF salary ON employees
BEGIN
	INSERT INTO log_emp_table (who, when)
	VALUES (USER, SYSDATE);
END;
```

- This trigger inserts exactly one row into the log table, regardless of whether/independientement de si the triggering statements updates one employee, seleval employees, or no employees at all

# Understanding Row Triggers

- Suppose you want to insert one row into the log table for each updated employee

- For example, if five employees were updated, you want to insert five rows into the log table so you have a record of each row that was created

- **For this, you need a row trigger.**

# Row Trigger Firing Sequence

- **A row trigger (executes) once for each row affected by the triggering DML statement, either just BEFORE the rows is processed or just AFTER.**

- If five employess are in department 50, a row triggers associated with an UPDATE on the employees table would execute five times, storing five rows in the log file, because of the following DML statement:

```
UPDATE employees
	SET salary = salary * 1.1;
	WHERE department_id = 50;
```

# Creating a ROW TRIGGER

```
CREATE OR REPLACE TRIGGER log_emps 
	AFTER UPDATE OF salary
	FOR EACH ROW
BEGIN
	INSERT INTO log_emp_table(who, when)
	VALUES (USER, SYSDATE);
END;
```

- You specify a row trigger using FOR EACH ROW

- With this trigger, the UPDATE statement from the previous slide would cause five rows to be inserted into the log table, one for each EMPLOYEE row updated.

- However, all five rows in the log table would be identical, and they would not show which employee was updated or how SALARY was changed.

----------------------------
# Using :OLD and :NEW Qualifiers

- When using a row trigger, you can reference and use both old and new column values in the EMPLOYEES row currently being updated.

- You use **:OLD.column_name** to reference the pre-update value
- You use **:NEW.column_name** to reference the post-update value

- For example, if the UPDATE statement is changing an employee's salary from $10,000 to $11,000, then while the trigger is executing

	- :OLD.salary has a value of 10000
	- :NEW.salary has a value of 11000
	- With this information, you can now insert the data you need into the loggin table

```
CREATE OR REPLACE TRIGGER log_emps 
AFTER UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
	INSERT INTO log_emp_table
	(who, when, which_employee, old_salary, new_salary)
	VALUES 
	(USER, SYSDATE, :OLD.employee_id, :OLD.salary, :NEW.salary);
END;
```

- To log the employee_id, does it matter whether you code :OLD.employee_id or :NEW.employee:id?

## A Second Example of Row Triggers

```
CREATE OR REPLACE TRIGGER audit_emp_values 
    AFTER DELETE OR INSERT OR UPDATE ON EMPLOYEES 
    FOR EACH ROW
BEGIN
    
    INSERT INTO audit_emp
    (user_name, time_stamp, id, old_last_name,
    new_last_name, old_title, new_title, old_salary, new_salary)
    VALUES
    (USER, SYSDATE, :OLD.employee_id, :OLD.last_name,
    :NEW.last_name, :OLD.job_id, :NEW.job_id, :OLD.salary, :NEW.salary);
END;
```

## A Third Example of Row Triggers

- Suppose you need to prevent employees who are not a President or Vice-president from having a salary of more than $15,000

```
CREATE OR REPLACE TRIGGER restrict_salary
	BEFORE INSERT OR UPDATE OF salary ON employees
	FOR EACH ROW
BEGIN
	IF NOT (:NEW.job_id IN ('AD_PRES', 'AD_VP'))
	AND :NEW.salary > 15000 THEN
		RAISE_APPLICATION_ERROR 
		(-20202, 'Employee cannot eran more than $1500.');
	END IF;
END;
```

## A Fourth Example: Implementing an Integrity Constraint With a Trigger

- The EMPLOYEES table has a foreign key contraint on the DEPARTMENT_ID column of the DEPARTMENTS table.
- DEPARTMENT_ID 999 does not exist, so this DML statement violates the constraint and the employee row is not updated.

```
UPDATE employees
SET department_id = 999
WHERE employee_id = 124;
```

- You can use a trigger to create the new department automatically

```
CREATE OR REPLACE TRIGGER employee_dept_fk_trg
BEFORE UPDATE OF deparment_id ON employees 
FOR EACH ROW
DECLARE
	v_dept_id departments.department_id%TYPE;
BEGIN
	SELECT department_id INTO v_dept_id FROM departments
	WHERE department_id = :NEW.department_id;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		INSERT INTO departments
		VALUES(:NEW.department_id, 'Dept ' || :NEW.department_id, NULL, NULL);
END;
```

---------------------------

# Using the REFERENCING Clause

Look again at the first example of a row trigger

```
CREATE OR REPLACE TRIGGER log_emps 
	AFTER UPDATE OF salary ON employees 
	FOR EACH ROW
BEGIN
	INSERT INTO log_emp_table 
	(who, when, which_employee, old_salary, new_salary)
	VALUES
	(USER, SYSDATE, :OLD.employee_id, :OLD.salary, :NEW.salary);
END;
```

- **What if the EMPLOYEES table had a different name?**
- What if it was called OLD instead
- OLD is not a good name, but is possible 
- Whay would our code look like now?

```
CREATE OR REPLACE TRIGGER log_emps 
	AFTER UPDATE OF old ON employees 
	FOR EACH ROW
BEGIN
	INSERT INTO log_emp_table 
	(who, when, which_employee, old_salary, new_salary)
	VALUES
	(USER, SYSDATE, :OLD.employee_id, :OLD.salary, :NEW.salary);
END;
```

- The word "old" in this code means two things: it is a value qualifier (like :NEW) and also a table name
- The code will work, but is confusing to read
- **We don't have to use :OLD and :NEW**

- We can use different qualifiers by including a REFERENCING clause.

# Using the REFERENCING Clause

```
CREATE OR REPLACE TRIGGER log_emps 
	AFTER UPDATE OF salary ON old
	REFERENCING OLD as former NEW as latter 
	FOR EACH ROW
BEGIN
	INSERT INTO log_emp_table
	(who, when, which_employee, old_salary, new_salary)
	VALUES
	(USER, SYSDATE, :former.employee_id, :former.salary, :latter.salary);
END;
```

- FORMER and LATTER are called correlation-names
- They are aliases for OLD and NEW
- We can choose any correlation names we like as long as they are not reserver words
- The REFERENCING clause can be used only in row triggers

-----------------------------

# Using the WHEN Clause

Look at this trigger code. It records salary changes only if the new salary is greater than the old salary

```
CREATE OR REPLACE TRIGGER restrict_salary
	AFTER UPDATE of salary ON employees 
	FOR EACH ROW
BEGIN
	IF :NEW.salary > :OLD.salary THEN
		INSERT INTO log_emp_table
		(who, when, which_employee, old_salary, new_salary)
		VALUES
		(USER, SYSDATE, :OLD.employee_id, :OLD.salary, :NEW.salary)
	END IF;
END;
```

- **The whole trigger is a single IF statement**
- In real life, this could be many lines of code, including CASE statements, loops, and other constructs.

**We can code our IF conditions in the trigger header, just before the BEGIN clause**

```
CREATE OR REPLACE TRIGGER restrict_salary
	AFTER UPDATE of salary ON copy_employees 
	FOR EACH ROW
	WHEN (NEW.salary > OLD.salary)
BEGIN
	INSERT INTO log_emp_table
	(who, when, which_employee, old_salary, new_salary)
	VALUES
	(USER, SYSDATE, :OLD.employee_id, :OLD.salary, :NEW.salary);
END;
```

- This code is easier to read, especifically if the trigger body is long and complex

> [!NOTE]
> The WHEN clause can be used only with row triggers

-------------------------------
# INSTEAD OF Triggers

- Underlying tables cannot be updated using a Complex View (for example a view based on a join)

- Suppose the EMP_DETAILS view is a complex view based on a join of EMPLOYEES and DEPARTMENTS.

The following SQL statement fails:

```
INSERT INTO emp_details
VALUES 
(9001, 'ABBOTT', 3000, 10, 'Administration');
```

You can overcome this by creating an INSTEAD OF trigger that updates the underlying tables directly instead of trying to update the view

**INSTEAD OF triggers are always row triggers**

![[Pasted image 20250906160446.png]]

![[Pasted image 20250906160458.png]]

# Creating an INSTEAD OF Trigger

1. Create the tables and the complex view

```
CREATE TABLE new_emps AS
	SELECT employee_id, last_name, salary, department_id
	FROM employees;
	
CREATE TABLE new_depts AS
	SELECT d.department_id, d.department_name,
		sum(e.salary) dept_sal
	FROM employees e, departments d
	WHERE e.department_id = d.department_id
	GROUP BY d.department_id, d.department_name;
	
CREATE VIEW emp_details AS
	SELECT e.employee_id, e.last_name, e.salary,
		e.department_id, d.department_name
	FROM new_emps e, new_dept d
	WHERE e.department_id = d.department_id;
```

2. Create the INSTEAD OF Trigger:

```
CREATE OR REPLACE TRIGGER new_emp_dept 
	INSTEAD OF INSERT ON emp_details
BEGIN
	INSERT INTO new_emps
	VALUES 
	(:NEW.employee_id, :NEW.last_name, :NEW.salary, :NEW.department_id);
	
	UPDATE new_depts
	SET dept_sal = dept_sal + :NEW.salary
	WHERE department_id = :NEW.department_id;
END;
```

- **INSTEAD OF triggers are always row triggers**

------------------------------
# Row Trigger Revisited

- Look at this row trigger
- It adds a row to the LOG_TABLE whenever and employee's salary changes

```
CREATE OR REPLACE TRIGGER log_emps 
	AFTER UPDATE OF salary ON employees 
	FOR EACH ROW 
BEGIN
	INSERT INTO log_table 
	(employee_id, change_date, salary)
	VALUES
	(:OLD.employee_id, SYSDATE, :NEW.salary);
END;
```

- **What if ther are one million employees and you give every employee a 5% salary increase?**
- The row trigger will automaticallly execute one million times, INSERTinf one row each time.
- **This will be very slow**

- You cannot use FORALL inside the Triggers

- **Each time the rwo trigger is fired, all the data already collected in a variable is lost**
- To avoid the loosing data, we need a trigger that fires only once.

- A single trigger can be both a row trigger and a statement trigger at the same time.
- **This is called a Compound Trigger**

# **What is a Compound Trigger?**

- A single trigger that can include actions for each of the four possible timing points:
	- Before the triggering statement
	- Before each row
	- After each row 
	- After the triggering statement

- A Compound Trigger has a declaration section and a section for each of its timing points
- You do not have to include all the timing points, just the ones you need.

- The scope compound trigger variables is the whole trigger, so they retain their scope throughout the whole execution.

## Compound Trigger Structure

```
CREATE OR REPLACE TRIGGER trigger_name
	FOR dml_event_clause ON COMPOUND TRIGGER

-- Initial section
-- Declarations
-- Subprograms

-- Optional section
BEFORE STATEMENT IS ...;

-- optional section
BEFORE EACH ROW IS ...;

-- optional section
AFTER EACH ROW IS ...;		
```

## **Compound Trigger Example: Full Code**

```
CREATE OR REPLACE TRIGGER log_emps
    FOR UPDATE OF salary ON copy_employees 
    COMPOUND TRIGGER
        
        TYPE t_log_emp IS TABLE OF log_table%ROWTYPE
        INDEX BY BINARY_INTEGER
        
        log_emp_tab t_log_emp;
        v_index BINARY_INTEGER := 0;
    
    AFTER EACH ROW IS 
    BEGIN
        
        v_index := v_index + 1;
        log_emp_tab(v_index).employee_id := :OLD.employee_id;
        log_emp_tab(v_index).change_date := SYSDATE;
        log_emp_tab(v_index).salary := :NEW.salary;
    
    END AFTER EACH ROW;
    
    AFTER STATEMENT IS 
    BEGIN   
        
        FORALL I IN log_emp_tab.FIRST .. log_emp_tab.LAST
        INSERT INTO log_table VALUES log_emp_tab(i);
    
    END AFTER STATEMENT;
END log_emps;
```

# Terminology 

- Conditional predicate
- Compound trigger
- DML row trigger
- INSTEAD OF trigger
- :OLD and :NEW qualifiers

# Summary

- Create a DML trigger that uses conditional predicates
- Create a row-level trigger
- Create a row-leve trigger that uses OLD and NEW qualifiers
- Create an INSTEAD OF trigger
- Create a Compound Trigger

























































































































