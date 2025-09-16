
**objectives:**

- Indentify persistent states of package variables
- Control de persistent state of a package cursor

- Suppose you connect to the database and modify the value in a package variable, for example from 10 to 20
- Real applications often invoke the same package many times
- It is importamt to understand when the values in package variables are kept (persist) and when they are lost.

# Package State

- The collections of package variables and their current values define the package state.

The package state is:

- **Initialized when the package is first loaded** 
- **Persistent (by default) for the life of the session**
- **Stored in the session's private memory area** 
- **Unique to each session even if the second session is started by the same user**
- Subject to change when package subprograms are called or public variables are modified.

- Other sessions each have their own package state, and do not see your changes.

# Persistence

- A database is all about persistence. If you insert a row into the database on Monday and commit the insert, that same row will be there on Friday, still in the database.

- Then there is session persistence... if you connect to an Oracle database and execute a program that assigns a value to a package-level variable, that variable is set for the length of your session, and it retains its value even of the program that performed the assignment has ended.

## Example of Package State

- The following is a simple package that initializes a single global variable and contains a procedure to update it.

```
CREATE OR REPLACE PACKAGE pers_pkg 
IS 
	g_var NUMBER := 10;
	PROCEDURE upd_g_var (p_var IN NUMBER);
	
END pers_pkg;
```

```
CREATE OR REPLACE PACKAGE BODY perd_pkg 
IS
	PROCEDURE upd_g_var (p_var IN NUMBER) 
	IS
	BEGIN
		g_var := p_var;
	END upd_g_var;
END pers_pkg;

GRANT EXECUTE ON pers_pkg TO PUBLIC;
```

- Each session see the number 10 in the variable, but the value could be different in each session if the user change the value, and the value changed is unique in each session.

# Persistent State of a Package Cursor 

- A cursor declared in the package specification is a type of global variable, and follows the same persistency rules as any other variable.
- **A cursor's state is not defined by a single numeric or other value.**

A cursor's state consists of the following attributes:

- Wheter the cursor is open or closed
- If open, how many rows have been fetched from the cursor (%ROWCOUNT) and whether the most recent fetch was succesfull (%FOUND or %NOTFOUND)

## Persistent State of a Package Cursor: Package Specification

- The cursor declaration is declared globally within the package specification
- Therefore, any or all of the package procedures can reference it

```
CREATE OR REPLACE PACKAGE curs_pkg IS
	CURSOR emp_curs IS select employee_id FROM employees
		ORDER BY employee_id;
		
	PROCEDURE open curs;
	FUNCTION fetch_n_rows(n NUMBER := 1) RETURN BOOLEAN;
	PROCEDURE close_curs;
END curs_pkg;
```

```
CREATE OR REPLACE PACKAGE BODY curs_pkg IS

	PROCEDURE open_curs IS
	BEGIN
		IF NOT emp_curs%ISOPEN THEN OPEN emp_curs; END IF;
	END open_curs;
	
	FUNCTION fetch_n_rows(n NUMBER := 1) RETURN BOOLEAN IS
		emp_id employees.employee_id%TYPE;
	BEGIN
		FOR count IN 1 .. n LOOP
			FETCH emp_curs INTO emp_id;
			EXIT WHEN emp_curs%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE('Id: ' || (emp_id));
		END LOOP;
		RETURN emp_curs%FOUND;
	END fetch_n_rows;

	PROCEDURE close_curs IS
	BEGIN
		IF emp_curs%ISOPEN THEN CLOSE emp_curs; END IF;
	END close_curs;
END curs_pkg;
```

## Invoking CURS_PKG

1. Opens the cursor
2. Fetched and displays the next three rows from the cursor untill all rows have been fetched.
3. Closes the cursor

```
DECLARE
	v_more_rows_exists BOOLEAN := TRUE;
BEGIN
	curs_pkg.open_curs;
	LOOP
		v_more_rows_exist := curs_pkg.fetch_n_rows(3); -- 2
		DBMS_OUTPUT.PUT_LINE('------------------');
		EXIT WHEN NOT v_more_rows_exist;
	END LOOP;
	curs_pkg.close_curs;
END;
```

- This technique is often used in applications that need to FETCH a large number of rows from a cursor
- But this technique can only display a few of them on the secreen at a time.






















































