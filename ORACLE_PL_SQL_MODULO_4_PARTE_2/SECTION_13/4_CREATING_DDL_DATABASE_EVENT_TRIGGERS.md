
**Objectives:**

- Describe events that cause DDL and database event triggers to fire
- Create a trigger for a DDL stratement
- Create a trigger for a database event
- Call a stored procedure from a trigger
- Describe the cause of a mutating table

-----------------------------

- What if you accidentally drop an important table?
- If you have a backup copy of the table data, you can retrieve the lost data
- But it might be important to know exactly when the table was dropped

- For security reasons, a Database Administrator might want to keep an automatic record of who has logged into a database, and when

# What are DDL and Database Event Triggers?

- DDL triggers are fired by DDL statements: **CREATE, ALTER, or DROP**

Database Event triggers are fired by non-SQL events in the database, for example:

- A user connects to, or disconnects from the database
- The DBA starts up, or shuts down the database
- A specific exception is raised in a user session

# Creating Triggers on DDL Statements Syntax

- ON DATABASE fires the trigger for DDL on all schemas in the database
- ON SCHEMAS fires the trigger only for DDL on objects in your own schema

```
CREATE [OR REPLACE] TRIGGER trigger_name 
Timing 
[ddl_event1 [OR ddl_event2 OR ...]]
ON {DATABASE | SCHEMA}
trigger_body
```

## Example of a DDL Trigger

> [!NOTE] What's a Schema in Oracle DB?
> - It's a database object collection, that belongs to the user that create the objects.
> - An user is an account to access, a schema are the objects that belongs to the user.
> - Every user has an schema, when you create an user, automatically its created a schema with his name.
> - **The schema is the container of all the user objects**

- You want to writre a log record every time a new database object is created on your schema.

```
CREATE OR REPLACE TRIGGER log_create_trigg
AFTER CREATE ON SCHEMA 
BEGIN
	INSERT INTO log_table
	VALUES (USER, SYSDATE);
END;
```

- The trigger fires whenever/siempre cuando any type of objects is created
- You cannot create a DDL trigger that refers to a specific database object

## A Second Example of a DDL Trigger

- You want to prevent any object being dropped from your schema

```
CREATE OR REPLACE TRIGGER prevent_drop_trigg
BEFORE DROP ON SCHEMA
BEGIN
    RAISE_APPLICATION_ERROR (-20203, 'Attempted drop - failed');
END;
```

- The trigger fires whenever any (type of) object is dropped 
- Again, you cannot create a DDL trigger that refers to a specific database object

# Creating Triggers on Database Events Syntax

- ON DATABASE fires the trigger for events on all sessions in the database
- ON SCHEMA fires the trigger only for your own sessions

```
CREATE [OR REPLACE] TRIGGER trigger_name
timing 
[database_event1 [OR database_event2 OR ...]]
ON {DATABASE | SCHEMA}
trigger_body
```

# Creating Triggers on Database Events Guidelines

- Remember, you cannot use INSTEAD OF with Database Event Triggers.
- You can define triggers to respond to such system events as LOGON , SHUTDOWN, and even SERVERERROR.

- Database Event triggers can be created ON DATABASE or ON SCHEMA, except that ON SCHEMA cannot be used with SHUTDOWN and STARTUP events.

# Example 1: LOGON and LOGOFF Triggers

```
CREATE OR REPLACE TRIGGER logon_trig
AFTER LOGON ON SCHEMA
BEGIN
    INSERT INTO log_trig_table(user_id, log_date, action)
    VALUES(USER, SYSDATE, 'Loggin on');
END;
```

```
CREATE OR REPLACE TRIGGER logoff_trig
BEFORE LOGOFF ON SCHEMA
BEGIN
    INSERT INTO log_trig_table(user_id, log_date, action)
    VALUES(USER, SYSDATE, 'Loggin off');
END;
```

# Example 2: A SERVERERROR Trigger

- You want to keep a los of any ORA-00942 errors that occur in your sessions:

```
CREATE OR REPLACE TRIGGER servererror_trig
AFTER SERVERERROR ON SCHEMA 
BEGIN
	IF (IS_SERVERERROR (942)) THEN
		INSERT INTO error_log_table ...
	END IF;
END;
```

# Calling a Stored Procedure from a Trigger

```
CREATE OR REPLACE PROCEDURE showmsg 
AS 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Showing msg');
END;

CREATE OR REPLACE TRIGGER showmsg_trig
BEFORE INSERT ON employees
BEGIN
    showmsg;
END;
```

------------------------

# Mutating Tables and Row Triggers

- A mutating table is a table that is currently being modified by a DML statement

- A row trigger cannot SELECT from a mutating table, because it would see an inconsistent set of data (the data in the table would be changing while the trigger was trying to read it).

- However, a row trigger can SELECT from a different table of needed.
- This restriction does not apply to DML statement triggers, only to DML row triggers.

To avoid mutating table errors:

- A row-level trigger must not query or modify a mutating table 
- A statement-level trigger must not query or modify a mutating table if the trigger is fired as the result of a CASCADE delete
- Reading and writing data using triggers is subject to certain rules
- The restrictions apply only to row triggers, unless a statement trigger is fired as a result of ON DELETE CASCADE

# Mutating Tables and Row Triggers

```
CREATE OR REPLACE TRIGGER emp_trigg
	AFTER INSERT OR UPDATE OR DELETE ON employees
	-- employees is the mutating table
	FOR EACH ROW
BEGIN
	SELECT ... FROM employees ... -- is not allowed
	SELECT ... FROM departments ... -- is allowed
	...
END;
```

## Mutating Table: Example

```
-- In a trigger does´s permit to make a SELECT in the table used in the Trigger
-- This causes inconsistent in the data.

-- This Trigger will cause an error
CREATE OR REPLACE TRIGGER check_salary
    BEFORE INSERT OR UPDATE OF salary, job_id ON employees
    FOR EACH ROW
DECLARE
    v_minsalary employees.salary%TYPE;
    v_maxsalary employees.salary%TYPE;
BEGIN
    SELECT MIN(salary), MAX(salary) INTO v_minsalary, v_maxsalary
    FROM employees
    WHERE job_id = :NEW.job_id;
    
    IF :NEW.salary < v_minsalary OR :NEW.salary > v_maxsalary THEN
        RAISE_APPLICATION_ERROR(-20505, 'Out of range');
    END IF;
END;
```

# More Possible Uses for Triggers

- You should not create a trigger to do something that can easily be done in another way, such as by check constraint or by suitable object provileges.

- But sometimes you must create a trigger because there is no other way to do what is needed
- The following examples show just three situations where a trigger must be created































































