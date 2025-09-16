
- NOCOPY
- DETEMINISTIC - INDEX
- BULK COLLECT
- FORALL
- FORALL - SQL%BULK_ROWCOUNT
- FORALL - SAVE EXCEPTIONS
- SAVE EXCEPTIONS - SQL%BULK_EXCEPTIONS
- RETURNING
- RETURNING - FORALL

Mejorando el rendimiento del PL/SQL

**Objectives:**

- Identify the benefits of the NOCOPY hint and the DETERMINISTIC clause
- Create subprograms which use the NOCOPY hint and the DETERMINISTIC clause
- Use Bulk Binding FORALL in a DML statement
- Use BULK COLLECT in a SELECT or FETCH statement
- Use the Bulk Binding Returning clause.

-----------------------

- Until now, you hacve learned how to write, compile, and execute PL/SQL code without thinking much how long the execution will take.

- In real organizations, tables can contain millions or billions of rows.
- **In this lesson you will learn some ways to speed up the processing of every large sets of data.**

--------------------------------

# Using the NOCOPY Hint

- By default, PL/SQL IN parameter arguments are passed by reference, WHILE OUT and IN OUT agruments are passed by value.

- **We can change this to pass an OUT or IN OUT argument by reference, using the NOCOPY hint.**

```
CREATE OR REPLACE PACKAGE emp_pkg 
IS
	TYPE t_emp IS TABLE OF employees%ROWTYPE 
	INDEX BY BYNARY_INTEGER;
	
	PROCEDURE emp_proc(
		p_small_arg IN NUMBER,
		p_big_arg OUT NOCOPY t_emp
	);
END emp_pkg;
```

- Notice that NOCOPY must come immediately after the parameter mode (OUT or IN OUT)
- Specify NOCOPY to instruct the database to pass an argumeent as fast as possible
- This clause can significantly enhance performance when passing a large value.

-----------------------------------

# Function Based Indexes

- All of the Function Based Index examples have demonstrated the use of the UPPER and LOWER function 
- While these two are frequently used in Function Based Indexes, the Oracle Database is not limited to just allowing those two functions in an index.

- Any valid Oracle built-in function can be used in a Function-Based index.
- Also, any database function you write yourself can be used.

> [!NOTE] Determinista
> En matemáticas, algo es determinista ==si produce el mismo resultado exacto cada vez que se le dan las mismas condiciones iniciales, es decir, no hay aleatoriedad o azar involucrado==.

**There is one rule you must remember:**

- If you are writing your own functions to use in a Functions Based Index, you must include the key word **DETERMINISTIC** in the function header.

- In mathematics, a deterministic systems is a system in which no randomness is involved in the development of future states of the system.
- **Deterministic models therefore produce the same output for a given starting condition.**

## IMPORTANT!!!:

- **When a Oracle Database encounters a deterministic function, it attempts to use previously calculated results when posibble rather than re-executing the function.**

- Specify **DETERMINISTIC** for a user-defined function to indicate that the function returns the same result value whenever it is invoked with the same values for its parameters.

- Do not specify DETERMINISTIC for a function whose result depends on the value of session variables or the state schema objects, because results might vary across calls.

- If you are defining a function that will be used in a function based index, you must tell Oracle that the function is DETERMINISTIC and will return a consistent result given in the same inputs.

- The built-in SQL functions UPPER, LOWER, and TO_CHAR are already defined as deterministic by Oracle, so this is why you can create an index on the UPPER values of a column.

A random example:

```
CREATE INDEX d_evnt_dt_indx
	ON d_event (TO_CHAR(event_date, 'mon'));
```

**This INDEX will not work, because the function is not DETERMINISTIC:**

```
CREATE OR REPLACE FUNCTION twicenum
	(p_number IN NUMBER)
RETURN NUMBER 
IS
BEGIN
	RETURN p_number * 2;
END twicenum;
```

```
CREATE INDEX emp_twicesal_idx
	ON employees(twicenum(salary));
```

## Using the DETERMINISTIC Clause

- If you want to create a Functions Based Index on your own function you must create the function using the DETERMINISTIC clause:

```
CREATE OR REPLACE FUNCTION twicenum (p_number IN NUMBER)
RETURN NUMBER DETERMINISTIC
IS
BEGIN
	RETURN p_number * 2;
END twicenum;
```

- **Be careful!**
- The word "deterministic" means that the same input value will always produce the same output valiue

```
CREATE OR REPLACE FUNCTION total_sal 
(p_dept_id IN employees.department_id%TYPE)
RETURN NUMBER DETERMININSTIC
IS
	v_total_sal NUMBER;
BEGIN
	SELECT SUM(salary) INTO v_total_sal 
	FROM employees
	WHERE department_id = p_dept_id;
	
	RETURN v_total_sal;
END total_sal; 
```

- The function on the previous example is not really deterministic, but Oracle server still allowed you to create it
- What if we give everyone a salary increase?

```
UPDATE employees
SET salary = salary * 1.10;
COMMIT;
```

- Now the SUM(salary) values stored in the index are out-of-date, and the index will not be used unless you drop and create ir again.
- This will take a long time on a very large table

> [!IMPORTANT]
> Do NOT create a deterministic function which contains a SELECT Statement on data which may be modified in the future.

-------------------

# What is Bulk Binding?

- Many PL/SQL blocks contain both PL/SQL statements and SQL statements, each of which is execute by a different part of the Oracle software called the PL/SQL Engine and the SQL Engine.

- **A change from on engine to the other is called a context switch, wich has associated overhead and takes time.**

- For one change, this is at most a few milliseconds.
- But what if there are millions of changes?

- If we FETCH (in a cursor) and process millions of rows one at time, that´s millions of context switches.
- And that will really slow down the execution

- **FETCH is a SQL statement because it accesses database tables, but the processing is done by PL/SQL statements**

-------------------------------

- Look at this code, and imagen that our EMPLOYEES table has one million rows
- How many context switches occur during one execution of the procedure

```
CREATE OR REPLACE PROCEDURE fetch_all_emps 
IS
	CURSOR emp_curs IS SELECT * FROM EMPLOYEES;
BEGIN
	FOR v_emprec IN emp_curs LOOP
		DBMS_OUTPUT.PUT_LINE(v_emprec.first_name);
	END LOOP;
END fetch_all_emps;
```

- Remember that in a cursor FOR loop, al the fetches are still executed even though we don't explicity code a FETCH statement.

------------------------------------

- **It would be much quicker to fetch all the rows in just one context switch within the SQL engine.**
- This is what Bulk Binding does

- Of fcourse, if all rows are fetched in one statement, we will need an INDEX BY table of records to store all the fetched rows

# What is Bulk Binding?

- If each row is 100 bytes in size, storing one million rows will nedd 100 megabytes of memory.

- When you think about many users accessing a database, you can see how memory usage could become an issue.
- **So Bulk Binding is a trade-off: more memory required (possibly bad) but faster execution (good).**

# Bulk Binding a SELECT: Using BULK COLLECT

Here is one million row table from the earlier slide, this time using Bulk Binding to fetch all the rows in a single call to the SQL Engine.

```
CREATE OR REPLACE PROCEDURE fetch_all_emps IS
    
    TYPE t_emp IS TABLE OF employees%ROWTYPE INDEX BY BINARY_INTEGER;
    v_emptab t_emp;

BEGIN
    
    SELECT * BULK COLLECT INTO v_emptab FROM EMPLOYEES;
    
    FOR i IN v_emptab.FIRST .. v_emptab.LAST LOOP
        
        IF v_emptab.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE(v_emptab(i).last_name);
        END IF;
    END LOOP;
END fetch_all_emps;

BEGIN
    fetch_all_emps();
END;

set SERVEROUTPUT on;
```

- Now, how many context switches are there?

- **When using BULK COLLECT, we do not declare a cursor because we do not fetch individual rows one at a time.**

- Instead, we SELECT the whole database table into the PL/SQL INDEX BY table in a single SQL statement.

# Bulk Binding a SELECT: Using BULK COLLECT

Here is another example:

```
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
```

------------------

# Bulk Binding with DML: Using FORALL

- We may also want to speed up DML statements which process many rows.

```
CREATE OR REPLACE PROCEDURE insert_emps
IS
	TYPE t_emps IS TABLE OF employees%ROWTYPE I
	INDEX BY BINARY_INTEGER;
	
	v_emptab t_emps;
	
BEGIN
	
	FOR i IN v_emptab.FIRST .. v_emptab.LAST LOOP
		INSERT INTO employees VALUES v_emptab(i);
	END LOOP;
END insert_emps;
```

- If we are inserting one million rows, this is one million executions of an INSERT SQL statement.
- How many contect switches?

------------------

- **Just like BULK COLLECT, there is no LOOP ... END LOOP code because all the rows are inserted with a single call to the SQL engine.**

```
CREATE OR REPLACE PROCEDURE insert_emps 
IS
	TYPE t_emps IS TABLE OF employees%ROWTYPE 
	INDEX BY BINARY_INTEGER;
	
	v_emptab t_emps;
BEGIN
	
	FORALL i IN v_emptab.FIRST .. v_emptab.LAST
	INSERT INTO employees VALUES v_emptab(i);
END insert_emps;
```

## Combine BULK COLLECT and FORALL

```
CREATE OR REPLACE PROCEDURE copy_emps 
IS
	TYPE t_emps IS TABLE OF employees%ROWTYPE 
	INDEX BY BINARY_INTEGER;
	
	v_emptab t_emps;
BEGIN
	SELECT * BULK COLLECT INTO v_emptab FROM employees;
	
	FORALL i IN v_emptab.FIRST .. v_emptab.LAST
	INSERT INTO new_employees VALUES v_emptab(i);
END copy_emps;
```

- Since no columns are specified in the INSERT statement, the record structure of the collections must match the table exactly.

- Bulk binds can also improve the performance when loading collections from queries.
- The BULK COLLECT INTO construct binds the output of the query to the collection.

- Populating two collections with 10,000 rows using a FOR .. LOOP takes approximately 0.05 seconds.
- **Using the BULK COLLECT INTO reduces this time to less than 0.01 seconds**

**We can use FORALL with UPDATE and DELETE statements as well as with INSERT:**

```
CREATE OR REPLACE PROCEDURE update_emps 
IS
	TYPE t_emp_id IS TABLE OF employees.employee_id%TYPE
	INDEX BY BINARY_INTEGER;
	
	v_emp_id_tab t_emp_id;
BEGIN
	
	SELECT employee_id BULK COLLECT INTO v_emp_id_tab
	FROM employees;
	
	FORALL i IN v_emp_id_tab.FIRST .. v_emp_id_tab.LAST
	UPDATE new_employees
	SET salary = salary * 1.05
	WHERE employee_id = v_emp_id_tab(i);
END update_emps;
```

# Bulk Binding Cursor Attibutes: SQL%BULK_ROWCOUNT

- In addition to implicit cursor attributes such as SQL%ROWCOUNT, Bulk Binding uses two extra cursor attributes, which are both INDEX BY tables.

```
-- create table emp as (select * from employees);
CREATE OR REPLACE PROCEDURE insert_emps 
IS 
    TYPE t_emps IS TABLE OF employees%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    v_emptab t_emps;
BEGIN
    
    SELECT * BULK COLLECT INTO v_emptab FROM employees;
    
    FORALL i IN v_emptab.FIRST .. v_emptab.LAST
    INSERT INTO emp VALUES v_emptab(i);
    
    FOR i IN v_emptab.FIRST .. v_emptab.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Inserted: '
        || i || ' ' || SQL%BULK_ROWCOUNT(i) || ' rows'
        );
    END LOOP;
END insert_emps;
    
    
BEGIN 
    insert_emps();
END;
```

# Bulk Binding Cursor Attibutes: SQL%BULK_EXCEPTIONS

- What if one of the INSERTs fails, perhaps because a constraint was violated?
- **The whole FORALL statement fails, so no rows are inserted. And you don't know which row failed to insert.**

- That has wasted a lot of time.

```
CREATE OR REPLACE PROCEDURE insert_emps 
IS
    TYPE t_emps IS TABLE OF employees%ROWTYPE 
    INDEX BY BINARY_INTEGER;
    
    v_emptab t_emps;
BEGIN
    
    SELECT * BULK COLLECT INTO v_emptab FROM employees;
    FORALL i IN v_emptab.FIRST .. v_emptab.LAST
    INSERT INTO employees VALUES v_emptab(1);
    
END insert_emps;
```

We add **SAVE EXCEPTIONS** to our FORALL statement:

```
CREATE OR REPLACE PROCEDURE insert_emps 
IS
    TYPE t_emps IS TABLE OF employees%ROWTYPE 
    INDEX BY BINARY_INTEGER;
    
    v_emptab t_emps;
BEGIN
    
    SELECT * BULK COLLECT INTO v_emptab FROM employees;
    FORALL i IN v_emptab.FIRST .. v_emptab.LAST SAVE EXCEPTIONS
    INSERT INTO employees VALUES v_emptab(1);
    
END insert_emps;
```

- **Now, all the non-violating rows will be inserted**
- The violating rows populate an INDEX BY table called SQL%BULK_EXCEPTIONS which has two fields:
	- ERROR_INDEX shows which inserts failed
	- ERROR_CODE shows the Oracle Server predefined error code

```
CREATE OR REPLACE PROCEDURE insert_emps IS
	TYPE t_emps IS TABLE OF employees%ROWTYPE 
	INDEX BY BINARY_INTEGER;
	
	v_emptab t_emps;
BEGIN

	SELECT * BULK COLLECT INTO v_emptab FROM employees;
	FORALL i IN v_emptab.FIRST .. v_emptab.LAST SAVE EXCEPTIONS
	INSERT INTO employees VALUES v_emptab(i);

EXCEPTION
	WHEN OTHERS THEN
		
		FOR j in 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
			DBMS_OUTPUT.PUT_LINE(SQL%BULK_EXCEPTIONS(j).ERROR_INDEX);
			DBMS_OUTPUT.PUT_LINE(SQL%BULK_EXCEPTIONS(j).ERROR_CODE);
		END LOOP;
END isnert_emps;
```

- An exception has been raised (at least one row failed to insert) so we must code the display of SQL%BULK_EXCEPTIONS in the EXCEPTION section

# Bulk Binding Cursor Attributes: SQL%BULK_EXCEPTIONS

- The FORALL statement includes an optional SAVE EXCEPTIONS clause that allows bulk operations to save exception information and continue proccesing.

- Once the operation is complete, the exception information can be retrieved using the SQL%BULK_EXCEPTIONS attibute.

- This is a collection of exceptions for the most recently executed FORALL statement, with the following two fields for each exception:

	- SQL%BULK_EXCEPTIONS(i).ERROR_INDEX
	- SQL%BULK_EXCEPTIONS(i).ERROR_CODE

-------------------------

# Using the RETURNING Clause 

- Sometimes we need to DML a row, then SELECT column values from the updated row for later use.

```
CREATE OR REPLACE PROCEDURE update_one_emp
(p_emp_id IN employees.employee_id%TYPE,
p_salary_raise_percent IN NUMBER) 
IS
	v_new_salary employees.salary%TYPE;
BEGIN
	UPDATE employees
	SET salary = salary * (1 + p_salary_raise_percent)
	WHERE employee_id = p_emp_id;

	SELECT salary INTO v_new_salary
	FROM employees
	WHERE employee_id = p_emp_id;

	DBMS_OUTPUT.PUT_LINE('New salary is: ' || v_new_salary);
END update_one_emp;
```

- Two SQL statements are required: an UPDATE and a SELECT

**However, we can do the SELECT within the UPDATE statement:**

```
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
```

# Using the RETURNING Clause with FORALL

- What if we want to update millions of rows and see the updated values?

We can use RETURNING with a Bulk Binding FORALL clause:

```
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
```

> [!NOTE]
> In the examples, RETURNING was most used to reduce code, compriming SELECT queries

# Summary

- Identify the benefits of the NOCOPY hint and the DETERMINISTIC clause
- Create subprograms which use the NOCOPY hint and the DETERMINISTIC clause
- Use Bulk Binding FORALL in a DML statement 
- User BULT COLLECT in a SELECT of FETCH statement
- Use the Bulk Binding RETURNING clause 








































































































































