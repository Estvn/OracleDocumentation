
- level-statement triggers

**Objectives:**

- Create a DML trigger
- List the DML trigger components
- Create a statement-level trigger
- Describe the trigger firing sequence components

- Suppose you want to keep an automatic record of the history of changes to employee's salaries.
- This is not only important for bussiness reasons, but is a legal requirement in many countries.
- To do this, you create a DML trigger.
- **DML triggers are the most common type of trigger in most Oracle databases**

# What is a DML Trigger?

- A DML trigger is a trigger that is automatically executed whenever an SQL DML statement is executed.

You classify DML triggers in two ways:

- By when they execute: **BEFORE, AFTER or INSTEAD OF** the triggering DML statement.
- By how many times they execute: **Once for the whole DML statement** (a statement trigger), or **once for each row affected by the DML statement** (a row trigger)

# Creating DML Statement Triggers

- The sections of CREATE TRIGGER statement that need to be considered before creating a trigger:

```
CREATE [OR REPLACE] TRIGGER trigger_name
	timing 
	event1 [OR event OR event3] ON object_name
trigger_body
```

- timing: when the trigger fires in relation to the triggering event
		- Values are BEFORE, AFTER, and INSTEAD OF
- event: Which DML operation causes the trigger to fire
- Values are INSERT, UPDATE \[OF column], and DELETE

- object_name: The table or view associated with the trigger
- trigger_body: The action(s) performed by the trigger are defined in an anonymous block

# Statement Trigger Timing 

- When should the trigger fire?

- **BEFORE:** Execute the trigger body before the triggering DML event on a table
- **AFTER:** Execute the trigger body after the triggering DML event on a table.
- **INSTEAD OF:** Execute the triggering body instead of the triggering DML event on a view

- **Programmig requirements will dictate which one will be used.**

# Trigger Timing and Events Examples

The first trigger executes immediately before and employee's salary is updated:

```
CREATE OR REPLACE TRIGGER sal_upd_trigg
BEFORE UPDATE OF salary ON employees
BEGIN ... END;
```

The second trigger executes immediately after and employee is deleted:

```
CREATE OR REPLACE TRIGGER emp_del_trigg
AFTER DELETE ON employees
BEGIN ... END;
```

# How Often Does a Statement Trigger Fire?

A statement trigger:

- **Fires only once each excution of the triggering statement (even if no rows are affected)**
- Is the default type of DML trigger
- Fires once event if no rows are affected
- Useful if the trigger body does not need to process column values from affected rows

```
CREATE OR REPLACE TRIGGER log_emp_changes
AFTER UPDATE ON employees BEGIN
	INSERT INTO log_emp_table (who, when)
	VALUES(USER, SYSDATE);
END;
```

- How many times does the trigger fire, if the UPDATE statement modifies three rows?
- **A statement trigger fires only once even if the triggering DML statement affects many rows.**

## DML Statement Trigger Example 1 

This statement trigger automatically inserts a row into a loggin table every time one or more rows are successfully inserted into EMPLOYEES

```
CREATE OR REPLACE TRIGGER log_emp
AFTER INSERT ON employees
BEGIN
	INSERT INTO log_emp_table (who, when)
	VALUES (USER, SYSDATE);
END;
```

## DML Statement Triggers Example 2

This statement trigger automatically isnerts a row into a loggin table every time a DML operation is successfully executed on the DEPARTMENTS table 

```
CREATE OR REPLACE TRIGGER log_dept_changes
AFTER INSERT OR UPDATE OR DELETE ON DEPARTMENTS
BEGIN
	INSERT INTO log_dept_table (which_user, when_done)
	VALUES (USER, SYSDATE);
END;
```

## DML Statement Trigger Example 3

- This example shows how you can use a DML trigger to enforce complex bussiness rules that cannot be enforced by a constraint.

- You want to allow INSERTs into the EMPLOYEES table during normal working days (Monday through friday) but prevent INSERTs in the weekend (Saturday and Sunday)

- If a user attempts to insert a a row into the EMPLOYEES table during the weekend, then the user sees an error message, the trigger fails, and the triggering statement ir rolled back.

```
CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON employees
BEGIN
	IF TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
		RAISE_APPLICATION_ERROR(-20500,
		'Yout may insert into EMPLOYEES table only during bussiness hours');
	END IF;
END;
```

> [!NOTE]
> COMMIT, ROLLBACK, and SAVEPOINT are not allowed in Triggers.














 