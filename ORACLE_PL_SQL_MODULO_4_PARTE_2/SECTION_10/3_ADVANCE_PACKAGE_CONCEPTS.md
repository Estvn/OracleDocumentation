
**Objectives:**

- Write packages that use the overloading feature
- Write packages that use fordward declarations
- Explain the purpose of a package initialization block
- Create and use a bodiless package
- Invoke packaged functions from SQL
- Identify restrictions on using packaged functions in SQL statements
- Create a package that uses PL/SQL tables and records

# Overloading Subprograms

- The overloading feature in PL/SQL enables you to develop two or more packaged subprograms with the same name.
- Overloading is useful whe you want a subprogram to accept similar sets of parameters that have different data types.

- For example, the TO_CHAR function has more than one way to be called, enabling you to convert a number or a date to a character string.

```
FUNCTION TO_CHAR (p1 DATE) RETURN VARCHAR2;
FUNCTION TO_CHAR (p2 NUMBER) RETURN VARCHAR2;
```

- Oracle will determine which of the overloaded subprograms to use based on the argument(s) passed when calling the overloaded subprogram.

**The overloading feature in PL/SQL:**

- Enables you to create two or more subprograms with the same name, in the same package
- Enables you to build flexible ways for invoking the overloaded subprograms based on the argument(s) passed when calling the overloaded subprogram CHAR vs NUMBER vs DATE.

- Makes things easier for the application developer, who has to remember only the subprogram name.
- Overloading can be done with subprograms in packages, but not with stand-alone subprograms.

---------------------------------------

- Consider using overloading when the purposes of two or more subprograms are similar, but the type or number of parameters required varies.
- Overloading can provide alternative ways for finding differente data with varying search criteria

## Overloading: Example

```
CREATE OR REPLACE PACKAGE emp_pkg IS
	
	PROCEDURE find_emp
		(p_employee_id IN NUMBER, p_last_name OUT VARCHAR2);
	
	PROCEDURE find_emp
		(p_job_id IN VARCHAR2, p_last_name OUT VARCHAR2);
		
	PROCEDURE find_emp
		(p_hiredate IN DATE, p_last_name OUT VARCHAR2);
END emp_pkg;
```

- The input arguments of three declarations have different categories of data type.

```
DECLARE v_last_name VARCHAR(30);
BEGIN emp_pkg.find_emp('IT_PROG', v_last_name);
END;
```

## Overloading Restrictions

You cannot overload:
- Two subprograms if their formal parameters differ only in data type and the different data types are in the same category (NUMBER and INTEGER belong the same category; VARCHAR2 and CHAR belong to the same category)
- Two functions that differ only in return type, even if the types are in different categories.

- These restrictions apply if the names of the parameters are also the same.
- If you use different names for the parameters by using named notations for the parameters.

```
CREATE PACKAGE sample_pack IS
	PROCEDURE sample_proc (p_char_param IN CHAR);
	PROCEDURE sample_proc (p_varchar_param IN VARCHAR2);
END sample_pack;
```

- This fails because 'Smith' can be either CHAR or VARCHAR2

```
BEGIN 
	sample_pack.sample_proc('Smith'); 
END;
```

- But the following invocation succeds:

```
BEGIN 
	sample_pack.sample_proc(p_char_param => 'Smith'); 
END;
```

## Overloading: Example 3

Package specification:

```
CREATE OR REPLACE PACKAGE dept_pkg IS

	PROCEDURE add_department(p_deptno NUMBER,
		p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700);
		
	PROCEDURE add_department(
		p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700);
END dept_pkg;
```

Package body:

```
CREATE OR REPLACE PACKAGE BODY dept_pkg IS
	
	PROCEDURE add_departmenr(p_deptno NUMBER,
		p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700)
	IS
	BEGIN
		INSERT INTO departments(deparment_id, department_name, location_id);
		VALUES (p_deptno, p_name, p_loc);
	END add_department;
	
	PROCEDURE add_departmenr(p_deptno NUMBER,
		p_name VARCHAR2 := 'unknown', p_loc NUMBER := 1700)
	IS
	BEGIN
		INSERT INTO departments(deparment_id, department_name, location_id);
		VALUES (departments_seq.NEXTVAL, p_name, p_loc);
	END add_department;
END dept_pkg;
```

Using the first procedure:

```
BEGIN
	dept_pkg.add_department(980, 'Education', 2500);
END;
```

```
SELECT * FROM departments WHERE department_id = 980;
```

Using the second procedure:

```
BEGIN
	dept_pkg.add_department('Training', 2500);
END;
```

```
SELECT * FROM departments WHERE department_name = 'Training';
```

## Overloading and the STANDARD Package

- A package named STANDARD defines the PL/SQL environment and buit-in functions.
- Most built-in functions are overloaded

- You have already seen that TO_CHAR is overloaded

Another example is the UPPER function:

```
FUNCTION UPPER (ch VARCHAR2) RETURN VARCHAR2;
```

```
FUNCTION UPPER (ch CLOB) RETURN CLOB;
```

What if you create your own function with the same name as STANDARD package function?

- For example, you create your own UPPER function
- Even though your function is in your own schema, the built-in STANDARD function is executed.

To call your own function, you need to prefix it with your schema-name:

```
BEGIN
	v_return_value := your-schema-name.UPPER(argument);
```

----------------------------------------

# Using Forward Declarations

- Block-structured languages (such as PL/SQL) must declare identifiers before referencing them.

**This example has an error:**

```
CREATE OR REPLACE PACKAGE BODY forward_pkg 
IS
	PROCEDURE award_bonus(...)
	IS
	BEGIN
		calc_rating (...); -- illegal reference
	END;

	PROCEDURE calc_rating (...) 
	IS
	BEGIN
		...
	END;
END forward_pkg;
```

- **All identifiers must be declared before being used, so you could solve the illegal reference problem by reversing the order of the two procedures.**
- However, coding standards often require that subprograms be kept in alphabetical sequence to make the easy to find.

- **Using forward declarations can solve this problem**

In the package body, a forward declaration is a private subprogram specification terminate by a semicolon

**Example of a forward declaration:**

```
CREATE OR REPLACE PACKAGE BODY forward_pkg 
IS
    PROCEDURE calc_rating(...); -- forward declaration
    
    -- Subprograms defined in alphabetical order
    
    PROCEDURE award_bonus (...) 
    IS
    BEGIN
        calc_rating(...); -- resolved by forward declaration
        ...
    END;
    
    PROCEDURE calc_rating (...) -- implementation
    IS
    BEGIN
        ...
    END;
END forward_pkg;
```

## Forward declarations help to

- Define subprograms in logical or alphabetical order
- Define mutually recursive subprograms
- Mutually recursive programs are programs that call each other directly or indirectly.
- Group and logically organize subprograms in a package body

When creating a forward declaration:

- The formal parameters must appear in both the forward declaration and the subprogram body.
- The subprogram body can appear anywhere after the forward declaration, but must appear in the same package body.

---------------------------

# Package Initialization Block

- Suppose you want to automatically execute some code every time you make the first call to a package in your session.
- For example, you want to automatically load a tax rate into a package variable
- If the rate is constant, you can initialize the package variable as part of its declaration:

```
CREATE OR REPLACE PACKAGE taxes_pkg 
IS
	g_tax NUMBER := 0.20;
	...
END taxes_pkg;
```

- But what if the tax rate is stored in a database table?

> [!NOTE]
> - **However, you can include an unnamed block at the end of the package body to initialize public and private package variables**
> - This block automatically executes once and is used to initialize variables.

**An example:**

```
CREATE OR REPLACE PACKAGE taxes_pkg
IS
	g_tax NUMBER;
	... -- declare all public procedures/functions
END taxes_pkg;

CREATE OR REPLACE PACKAGE BODY taxes_pkg 
IS
	... -- declare the fordward declarations
	... -- declare all private variables
	... -- define public/private procedures/functions overloaded
	
	BEGIN -- unnamed initialization block
		SELECT rate_value INTO g_tax
			FROM tax_rates
			WHERE rate_name = 'TAX';
END taxes_pkg;
```

--------------------------

# Bodiless Packages

- You can create a useful package which has a specification but not body

- **Because it has not body, a bodiless package cannot contain any executable code: no procedures or functions.**
- It can contain public (global) variables

- Bodiless packages are often used to give standarized names to unchanging constants, or to give names to non-predefined Oracle Server exceptions.

## Bodiless Packages: Example 1

- This package gives names to several constant ratios used in converting distances between two different systems of measurement.

```
CREATE OR REPLACE PACKAGE global_consts IS
	mile_to_kilo  CONSTANT NUMBER := 1.6093;
	kilo_to_mile  CONSTANT NUMBER := 0.6214;
	yard_to_meter CONSTANT NUMBER := 0.9144;
	meter_to_yard CONSTANT NUMBER := 1.0936;
END global_consts;

GRANT EXECUTE ON global_consts TO PUBLIC;
```

**This package declares two non-predefined Oracle Server exceptions:**

```
CREATE OR REPLACE PACKAGE our_exceptions IS
	
	e_cons_vliolation EXCEPTION;
	PRAGMA EXCEPTION_INIT (e_cons_violation, -2292);
	e_value_too_large EXCEPTION;
	PRAGMA EXCEPTION_INIT (e_value_too_large, 1438);
END our_exceptions;

GRANT EXECUTE ON our_exceptions TO PUBLIC;
```

## Invoking a Bodiless Package

The block below converts 5000 miles to kilometers using the constant defined in the GLOBAL_CONSTS package

```
DECLARE
	distance_in_miles NUMBER(5) := 5000;
	distance_in_kilo  NUMBER(6,2);
BEGIN
	distance_in_kilo := 
		distance_in_miles * global_consts.mile_to_kilo;
	
	DBMS_OUTPUT.PUT_LINE(distance_in_kilo);
END;
```

The code belows uses the exception defined in the OUR_EXCEPTIONS package

```
BEGIN
	INSERT INTO except_test (number_col) VALUES (12345);
EXCEPTION 
	WHEN our_exceptions.e_value_too_large THEN
		DBMS_OUTPUT.PUT_LINE('Value too big for column data type');
END;

CREATE TABLE except_test (number_col NUMBER(3));
```

-------------------------

# Restrictions on Using Package Functions in SQL Statements

- Package functions, like  standalone functions, can be used in SQL statements and they must follow the same rules.

Functions called from:

- A query or DML statement must not end the current transactions, create or roll back to a savepoint, or alter the system or session
- A query or a aparellized DML statement cannot execute a DML statement or modify the database
- A DML statement cannot read or modify the table being changed by that DML statement.
- A function calling subprograms that break the preceding restrictions is not allowed.

























































































































