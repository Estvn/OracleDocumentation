
**Objectives:**

- Describe the benefits of conditional compilation
- Create and conditionally compile a PL/SQL program containing selection, inquiry and error directives
- Create a conditionally compile a PL/SQL program which calls the DBMS_DB_VERSION server-supplied package

# What is Conditional Compilation?

Conditional Compilation allows you to include some source code in your PL/SWL program that may be compiled or may be ingnored, depending on:

- The values of an initialization parameter
- The version of the Oracle software you are using 
- The value of a global package constant
- Any other condition that you choose to set

- You control conditional compilation by including directives in your source code.
- Directives are keywords that start with a single or double dollar sign ($ or \$$)

## Conditional Compilation and Microsoft Office

- You can´t really use PL/SQL with Microsoft Office, so this is not a real example, but let´s pretend.

```
CREATE OR REPLACE PROCEDURE lets_pretend IS
BEGIN
	...
	$IF MS_OFFICE_VERSION >= '2018' $THEN
		include_holographics;
	$ELSE
		include_std_graphic;
	$END
	...
END lets_pretend;
```

- $IF, $THEN, $ELSE and $END are selection directives

- Conditional compilation uses selection directives, inquiry directives, and error directives to specify source text for compilation
- The selection directive evaluates static expressions to determine which text should be included in the compilation

- The procedure example called LETS_PRETEND uses a selection directive

The selection directive is of the form:

```
$IF boolean_static_expression $THEN text
	[ $ELSEIF boolean_static_expression $THEN text ]
	[ $ELSE text ]
$END
```

# Conditional Compilation and Oracle Versions 

- You can't test which Office version you´re using, but you can test which Oracle version you´re using 

```
CREATE OR REPLACE FUNCTION lets_be_real
	RETURN NUMBER
	$IF DBMS_DB_VERSION.VERSION >= 11 $THEN
		DETERMINISTIC
	$END
IS
BEGIN
	RETURN 17;
END lets_be_real;

BEGIN
	DBMS_OUTPUT.PUT_LINE('Function returned ' || lets_be_real);
END lets_be_real;
```

- Deterministic functions are new in Oracle at version 11
- This code includes the word DETERMINISTIC if we compile the function on Version 11 or later, and is ignored if we compile on Version 10 or earlier

# What is in the Data Dictionary Now?

- After compiling the function on the previous slide, what is stored in the Data Dictionary?
- USER_SOURCE contains your complete source code, including the compiler directives:

```
SELECT text FROM USER_SOURCE
WHERE name = UPPER('lets_be_real')
ORDER BY line;
```

If you want to see which code has actually been included in your compiled program, you use the DBMS_PREPROCESSOR Oracle-supplied package.

```
BEGIN
	DBMS_PREPROCESSOR.PRINT_POST_PROCESSED_SOURCE
	('FUNCTION', '<YOUR_USERNAME>', 'lets_be_real');
END;
```

# Using Selection Directives

- There are five selection directives: $IF, $THEN, $ELSE, $ELSIF and $END (not $ENDIF)

- Their logic is the same as IF, THEN, ELSE, and so on, but they control which code is included at compile time, not what happens at execution time

```
...
$IF condition $THEN statement(s);
$ELSE statement(s);
$ELSIF statement(s);
$END ...
```

- Notice that $END does not end with a semicolon(;) unlike END;

# Using Selection Directives Example 

- Now let´s lok at the contents of the data dictionary
- Remember, the package set NEW_TAX_CODE to TRUE

```
CREATE OR REPLACE PROCEDURE get_emps 
IS
	CURSOR get_emps_curs IS
	SELECT * FROM employees
	WHERE
	$IF tax_code_pack.new_tax_code $THEN
		salary > 20000;
	$ELSE
		salary > 50000;
	$END
BEGIN
	FOR v_emps IN get_emps_curs LOOP
		... /* real code here */
	END LOOP;
END get_emps;
```

# The PLSQL_CCFLAGS Initialization Parameter

- You may want to use the selection directives, such as $IF, to test for a condition that has nothing to do with global package constants or Oracle software versions

- For example, you may to want to include extra code to help you debug a PL/SQL program, but once the errors have been corrected, you do not want to include this code in the final version because it will slow down the performance.
- You can control this using hte PLSQL_CCFLAGS initialization parameter

# The PLSQL_CCFLAGS Parameter

- PLSQL_CCFLAGS allows you to set values for variables, and then test those variables in your PL/SQL program 
- You define the variables and assign values to them using PLSQL_CCFLAGS

- Each PLSQL_CCFLAGS variable must be either a BOOLEAN literal or a PLS_INTEGER literal
- Then, you test the values of the variables in your PL/SQL program using inquiry directives
- An inquiry directive is the name of the variable prefixed by a double dollar sign (\$$)

First, set the value of the parameter:

```
ALTER SESSION SET PLSQL_CCFLAGS = 'debug_true'

CREATE OR REPLACE PROCEDURE testproc IS BEGIN
...
	IF $$debug $THEN
		DBMS_OUTPUT.PUT_LINE('This code was executed');
	$END
...
END testproc;
```

# Using PLSQL_CCFLAGS and Inquiry Directives

- DEBUG is not a keyword: you can use any name you like, and it can be a number or a character string, not just a Boolean

```
ALTER SESSION SET PLSQL_CCFLAGS = 'testflag:1';

CREATE OR REPLACE PROCEDURE testproc
IS 
BEGIN
...
	$IF $$testflag > 0 $THEN
		DBMS_OUTPUT.PUT_LINE('This code was executed');
	$END
...
END testproc;
```

# Using PLSQL_CCFLAGS and Inquiry Directives 

- You can set more than one variable, and then test them either together or separately

```
ALTER SESSION SET PLSQL_CCFLAGS = 
	'firstflag:1, secondflag:false';
	
CREATE OR REPLACE PROCEDURE testproc 
IS
BEGIN
...
	$IF $$firstflag > 0 AND NOT $$secondflag $THEN
		DBMS_OUTPUT.PUT_LINE('Testing both variables');
	$ELSIF
		DBMS_OUTPUT.PUT_LINE('Testing one variable');
	$END
...
END testproc;
```

# Using PLSQL_CCFLAGS and Inquiry Directives

- You can see which settings of PLSQL_CCFLAGS were used to compile a program by querying USER_PLSQL_OBJECT_SETTINGS

```
SELECT name, plsql_ccflags
FROM USER_PLSQL_OBJECT_SETTINGS
WHERE name = 'TESTPROC';
```

- And, as always, you can see what was included in the compiled program using DBMS_PREPROCESSOR

```
BEGIN
	DBMS_PREPROCESSOR.PRINT_POST_PROCESSED_SOURCE
	('PROCEDURE','<YOUR_USERNAME>','TESTPROC');
END;
```

-------------------

# Using DBMS_DB_VERSION

DBMS_DB_VERSION is a bodiless package that defines a number of contants, including 

- Version (the current Oracle Software version)
- VER_LE_11 (= TRUE if the current Oracle software os version 11 or earlier)
- VER_LE_10 (= TRUE if the current Oracle software is version 10 or earlier)

```
$IF DBMS_DB_VERSION.VER_LE_11 $THEN ...
```

Is exactly the same as:

```
$IF DBMS_DB_VERSION.VERSION <= 100 $THEN
```











































