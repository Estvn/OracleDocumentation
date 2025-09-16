
**Objectives:**

- Explain the similarities and differences between a warning and a error
- Compare and contrast the warning levels which can be set by the PLSQL_WARNINGS parameter
- Set warning levels by calling the DBMS_WARNING server-supplied package from with a PL/SQL program.

# Errors and Warnings

What's wring with this PL/SQL code?

```
CREATE OR REPLACE PROCEDURE count_emps IS
	v_count PLS_INTEGER;
BEGIN
	SELECT COUNT(*) INTO v_count FROM countries;
	DBMS_OUTPUT.PUT_LINE(v_counter);
END;
```

- Clearly, V_COUNTER is not declared
- The PL/SQL compiler detects the error and the procedure is not compiled

- The PL/SQL compiler detects the error and the procedure is not compiled.

--------------

What is wrong with this PL/SQL code?

```
CREATE OR REPLACE PROCEDURE unreachable 
IS
	c_const CONSTANT BOOLEAN := TRUE;
BEGIN
	IF c_const THEN
		DBMS_OUTPUT.PUT_LINE('TRUE');
	ELSE
		DBMS_OUTPUT.PUT_LINE('NOT TRUE');	
	END IF;
END unreachable;
```

- The procedure will compile without errors, but the ELSE branch can never be executed
- **Shouldn't the PL/SQL compiler warn you about this?**
- **It can!**

# Errors and Warnings

- Use the ALTER SESSION command to enable PL/SQL warning messages

```
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:ALL';

CREATE OR REPLACE PROCEDURE unreachable 
IS
	c_const CONSTANT BOOLEAN := TRUE;
BEGIN
	IF c_const THEN
		DBMS_OUTPUT.PUT_LINE('TRUE');
	ELSE
		DBMS_OUTPUT.PUT_LINE('NOT TRUE');	
	END IF;
END unreachable;

SELECT line, position, text, attribute FROM USER_ERRORS
WHERE name = 'UNREACHABLE';
```

# PL/SQL Compiler Warnings

- In PL/SQL, an error accurs when the code cannot be compiled successfully
- **A warning occurs when the code compiles successfully, but it could be coded better.**

- **By default, the PL/SQL compiler does not produce warning messages, but you can tell the compiler to produce them, and also the types (categories) of warnings that you want.**

# Categories of PL/SQL Warning Messages

### SEVERE

- Code that can cause unexpected behavior or wrong results when executed
### PERFORMANCE

- Code that can cause execution speed to be slow
### INFORMATIONAL

- Other poor coding practices (for example, code that can never be executed).

- The keyword ALL is shorthand for all three categories.

# Enabling PL/SQL Compiler Warnings

- Oracle can issue warnings when you compile subprograms that produce ambiguous results or use inefficient constructs

There are two ways to enable compiler warning categories:

- Using the initialization parameter PLSQL_WARNINGS
- Using the DBMS_WARNING server-supplied package

- Therefore, you can see warnings only for named subprograms, not for anonymous blocks.

# Using PLSQL_WARNINGS

- You must set the value of the PLSQL_WARNINGS initialization parameter to one or more comma-separated strings.
- Each string enables or disables a category of warning messages.

This parameter enables the PERFORMANCE category, leaving other categories unchanged:

```
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:PERFORMANCE'
```

In this example, the first parameter enables all three categories, and the second disables the SEVERE category, leaving the PERFORMANCE and INFORMATIONAL categories enabled

```
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:ALL', 'DISABLE:SEVERE';
```

Other examples:

```
ALTER SESSION SET PLSQL_WARNINGS = 'DISABLE:ALL';
...
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:PERFORMANCE';
...
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:SEVERE';
...
ALTER SESSION SET PLSQL_WARNINGS =
'ENABLE:ALL','DISABLE:SEVERE';
...
ALTER SESSION SET PLSQL_WARNINGS =
'DISABLE:SEVERE','ENABLE:ALL'
```

> [!NOTE]
> Warning messages helps to use the methods or functions used to improve the performance, etc.
> For example, you create a function that could use NOCOPY in the parameters, if you dont put this, and you have enable the PERFORMANCE warning messages, in the console will appear the recommendation.

-----------------------------------
# Using DBMS_WARNING 

- You can also set and change warning categories using the DBMS_WARNING server-supplied package.

- This allows you to set the same warning categories as the PLSQL_WARNINGS parameter, but also allows you to save your previous warning settings in a PL/SQL variable.

- This is useful if you want to change your settings, compile some PL/SQL programs, then change settings back to whay thet were at the beginning.

DBMS_WARNING contains three types of subprograms

- SET_* 
- ADD_*
- GET_**

- SET_* procedures replace all previous warning settings with the new settings
- ADD_* procedures change only the specified warning settings, leaving the other unaltered
- GET_* functions don´t change any settings; they store the current settings in a PL/SQL variable 

# Using DBMS_WARNING.ADD_*

Here is an ADD_* procedure:

```
BEGIN
	DBMS_WARNING.ADD_WARNING_SETTING_CAT
	('PERFORMANCE', 'EANBLE', 'SESSION');
END;
```

- This enables the PERFORMANCE warning category, leaving other category settings unchanged.
- The third argument, 'SESSION' is required
- This has exactly the same effect as:

```
ALTER SESSION SET PLSQL_WARNINGS = 'ENABLE:PERFORMANCE';
```

# Using DBMS_WARNING.SET_*

```
BEGIN
	DBMS_WARNING.SET_WARNING_SETTING_STRING
	('ENABLE:SEVERE', 'SESSION');
END;
```

- This disables all warning categories, then enables the SEVERE category
- This has exactly the same effect as:

```
ALTER SESSION SET PLSQL_WARNINGS = 'DISABLE:ALL', 'ENABLE:SEVERE';
```

# Using DBMS_WARNING.GET_*

Here is a GET_* function:

```
DECLARE 
	v_string VARCHAR2(200);
BEGIN
	v_string := 
	DBMS_WARNING.GET_WARNING_SETTING_STRING;
	DBMS_OUTPUT.PUT_LINE (v_string);
END;
```

- This returns all the current warning settings into a VARCHAR2 variable

```
DECLARE
	v_string VARCHAR2(200);
BEGIN
	v_string := 
	DBMS_WARNING.GET_CATEGORY(7203);
	DBMS_OUTPUT.PUT_LINE(v_string);
END;
```

- This returns the warning category of a PLW-warning number: PLW-07203 is in the performance category.











