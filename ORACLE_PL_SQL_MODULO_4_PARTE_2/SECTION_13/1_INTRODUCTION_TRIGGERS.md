
**Objetives:**.

- Describe database triggers and their uses
- Define a database trigger
- Recognize the difference between a database trigger and an application trigger.
- List two or more guidelines for using triggers
- Compare and contrast database triggers and stored procedures.

- In this lesson, you learn about database trigger
- **Triggers allow specify actions to be performed automatically within the database, without having to write extra application code.**

- **Triggers increase the power of the database and the power of your application**

# Need For a Trigger

Whenever an SQL statement updates a salary, this trigger executes automatically, inserting the row into the loggin table 

```
CREATE OR REPLACE TRIGGER log_sal_change_trigg
AFTER UPDATE OF salary ON employees
BEGIN
	INSERT INTO log_table (user_id, logon_date)
	VALUES (USER, SYSDATE);
END;
```

- This means the trigger automatically fires (that is, executes) whenever the triggering event (updating a salary) occurs.
- **Cause and effect: The event occurs, and the trigger fires**

# **What is a Trigger?**

- Is a PL/SQL block associated with a specific action (an event) such as a successful logon by a user, or an actions taken on a databse object such as a table or view.

- Executes automatically whenever the associated action occurs.
- Is stored in the database. 

- Triggers allows specified actions to be performed automatically in the database without having to write any extra front-end application code.

- **The key difference between procedures/functions and triggers is that procedures/functions have to be invoked explicitly.**

-  **Triggers are blocks of code that are always "listening" for something to happen in the database.**

- Also, since/dado que triggers are never explicitly invoked, they cannos receive parameters.

# Database Triggers Compared to Application Triggers

- Database triggers execute automatically whenever a data event (DML or DDL) or a system event (user connections or the DBA shutting down the database) occurs on a schema or database.

- Database triggers are created and stored in the database just like PL/SQL procedures, functions, and packages.

- **Application Triggers execute whenever a particular event occurs within an application.**
- They may lead/provocar to a database event, but they are not part of the database.

**The following evetns in the database can cause a trigger to execute:**

- DML operations on a table 
- DML operations on a view, with an INSTEAD OF trigger
- DDL statements, such as CREATE and ALTER
- Database system events, such as when a user logs on or the DBA shuts down the database.

# Types of Triggers

- Triggers can be either row-level or statement-level

- A row-level trigger fires once for each row affected by the triggerig statement
- A statement-level trigger fires once for the whole statement.

# Possible Uses for Triggers

You can use triggers to:

- Enhance complex database security rules3
- Create auditing records automatically
- Enforce complex data integrity rules
- Create loggin records automatically
- Prevent tables from being accidentally dropped
- Prevent invalid DML transactions from ocurring

- Generate derived column values automatically 
- Maintain synchronous tables replication
- Gather/recolectar statistics on table access
- Modify table data when DML statements are issued against views

# Example 1: Creating Logging Records Automatically

- The database administrator wants to keep an automatic record (in a database table) of who logs onto the database
- And when he/she could create the log table and suitable/adecuado trigger as follows

```
CREATE OR REPLACE log_table(
	user_id VARCHAR2(30),
	logon_date DATE
);

CREATE OR REPLACE TRIGGER logon_trigg
AFTER LOGON ON DATABASE
BEGIN
	INSERT INTO log_table (user_id, logon_table)
	VALUES (USER, SYSDATE);
END;
```

# Example 2: Enforcing Complex Data Integrity Rules

- Imagine a bussiness rule that states no employee's job can be changed to a job that the employee has already done in the past.

```
CREATE OR REPLACE TRIGGER check_sal_trigg
BEFORE UPDATE OF job_id ON employees
FOR EACH ROW 
DECLARE
	v_job_count INTEGER;
BEGIN
	SELECT COUNT(*) INTO v_job_count
	FROM job_history
	WHERE employee_id = :OLD.employee_id 
	AND job_id = :NEW.job_id;
	
	IF v_job_count > 0 THEN
		RAISE_APPLICATION_ERROR
		(-20201, 'This employee has already done this job');
	END IF;
END; 
```

# Guidelines for Triggers

- Do not define triggers to duplicate or replace actions you can do easily in other ways
- For example, implement simple data integrity rules using constrains, not triggers.

- Excessive use of triggers can result in slower processing and complex interdependencies, which can be difficult to maintain.
- Use triggers only when necessary and be aware of recursive and cascading effects.
- Avoid lenghty trigger logic by creating stored procedures or packaged procedures that are invoked in the trigger body.

# Comparison of Database Triggers and Stored Procedures

| Triggers                                              | Procedures                                          |
| ----------------------------------------------------- | --------------------------------------------------- |
| Defined with CREATE TRIGGER                           | Defined with CREATE PROCEDURE                       |
| Data Dictionary contains source code in USER_TRIGGERS | Data Dictionary contains source code in USER_SOURCE |
| Implicitly invoked                                    | Explicitly invoked                                  |
| COMMIT, SAVEPOINT, and ROLLBACK  are not allowed      | COMMIT, SAVEPOINT, and ROLLBACK are allowed         |



































































































































