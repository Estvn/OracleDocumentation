
**Objectives:**

- Describe how PLSQL_CODE_TYPE can improve execution speed
- Describe how PLSQL_OPTIMIZE_LEVEL can improve execution speed 
- Use USER_PLSQL_OBJECT_SETTINGS to see how a PL/SQL program was compiled 

- In many programming environments, fast program execution is imperative
- **In an earlier lesson, you learned how coding techniques such as the NOCOPY hint and Bulk Binding can improve the execution speed of PL/SQL programs**

- **Setting PL/SQL initialization parameters can help to maker your PL/SQL programs run even faster**

# What are Initialization Parameters?

- Oracle designed its database products to be flexible and configurable so they would operate on more than seventy computer platforms, from mainframes to PC networks to tablets and phones.

- The secret to his flexibility lies in the software's initialization parameters, whose numerous settings can be configured for top performance in countless environments.
- **On the downside, however, improper settings can slow a system down, even grind it to a halt.**

- Initialization parameters are used to change the way your database session interacts with the Oracle server.
- **All initialization parameters have a name, a data type, and a default value**

- They can be used to adjust security, improve performance, and do many other things.
- Many of them have nothing to do with PL/SQL

- In this lesson, you learn how to use two initialization parameters that change how your PL/SQL code is compiled
- Do not confuse initialization parameters with the formal and actual parameters that we pass to subprograms 

# Two PL/SQL Initialization Parameters

The names of these initialization parameters are:

- PLSQL_CODE_TYPE
- PLSQL_OPTIMIZE_LEVEL

- PLSQL_CODE_TYPE is a VARCHAR2 with possible values INTEPRETED (the default value) and NATIVE
- PLSQL_OPTIMIZE_LEVEL is a NUMBER with possible values 0,1,2 (default), and 3.

# Changing the Value of a Parameter

you can change any initialization parameter's value by executing an ALTER SESSION SQL statement:

```
ALTER SESSION SET PLSQL_CODE_TYPE = NATIVE;

CREATE OR REPLACE PROCEDURE run_faster_proc ...;

ALTER SESSION SET PLSQL_CODE_TYPE = INTERPRETED;

CREATE OR REPLACE PROCEDURE run_slower_proc ...;
```

- The new parameter value will be used until you log off or until you change the value again

# Using PLSQL_CODE_TYPE

- If PLSQL_CODE_TYPE es set to INTERPRETED (the default), your source code is compiled to bytcode and executed by the PL/SQL interpreter engine.

- If the parameter value is changed to NATIVE, your source code will be compiled to native machine code format and will not incur any interpreter ovehead.

- **You don´t need to know that these formats mean or how they work; the important thing is that native machine code PL/SQL executes faster than bytecode PL/SQL.**

# Using PLSQL_CODE_TYPE: Example

- To see the change in performance, we need some PL/SQL code that taker a long time to execute

**In this example, the NATIVE compilation is faster**

```
ALTER SESSION SET PLSQL_CODE_TYPE = NATIVE;
ALTER SESSION SET PLSQL_CODE_TYPE = INTERPRETED;

CREATE OR REPLACE PROCEDURE longproc 
IS
    v_number PLS_INTEGER;
BEGIN
    FOR i IN 1 .. 50000000 LOOP
        v_number := v_number * 2;
        v_number := v_number / 2;
    END LOOP;
END longproc;

BEGIN
    longproc;
END;
```

# Using PLSQL_CODE_TYPE: Second Example 

- Let's compile and execute an even longer procedure that includes a SQL statement

NATIVE in this case is slower, but still faster than INTERPRETED:

```
ALTER SESSION SET PLSQL_CODE_TYPE = INTERPRETED;

ALTER SESSION SET PLSQL_CODE_TYPE = NATIVE;

CREATE OR REPLACE PROCEDURE sqlproc 
IS 
	v_count PLS_INTEGER;
BEGIN
	FOR i IN 1 .. 50000 LOOP 
		SELECT COUNT(*) INTO v_count FROM countries;
	END LOOP;
END sqlproc

BEGIN
	sqlproc;
END;
```

# NATIVE Compilation and SQL Statements

- Compiling a PL/SQL program with PLSQL_CODE_TYPE = NATIVE creates native PL/SQL code, but not native SQL code.
- So the PL/SQL engine executes faster, but SQL statements execute at the same speed as before.

- And SQL statements usually take far longer to execute than PL/SQL statements, especially when the tables contain thousands of rows.

- To speed up SQL statements, you use other techniques, such as Bulk Binding and choosing the correct indexes for your tables.

------------------------

# Does your PL/SQL Program Contain Useless Code?

Examine this code:

```
CREATE OR REPLACE PROCEDURE obviouslybadproc IS
v_number PLS_INTEGER := 1;
BEGIN
IF v_number = 1 THEN
DBMS_OUTPUT.PUT_LINE(‘This will always be displayed');
ELSE
DBMS_OUTPUT.PUT_LINE('This will never be displayed');
END IF;
END obviouslybadproc;
```

- You would never write useless lines of code that can nvever be executed.
- In large, complex PL/SQL, it is all too easy to write code that can never be executed, or exceptions that can never be raised.

- **Unnecessary code can slow down both creating and executing the program.**

-----------------------------------------
# The PLSQL_OPTIMIZE_LEVEL Initialization Parameter

- **PLSQL_OPTIMIZE_LEVEL can be used to control what the PL/SQL compiler does with useless code, as well as giving other performance benefits.**

- Its value muest be an integer between 0 and 3, inclusive
- The higher the value, the more effort the compiler makes to optimize the code for execution

- The benefits of optimization apply to both interpreted and natively compiled PL/SQL because optimizations are applied by analizying patterns in source code.

- The optimizing compiler is enables to level 2 by default.

## Level 0

**With PLSQL_OPTIMIZE_LEVEL = 0, the compiled code will run more slowly, but it will work with older versions of the Oracle software**

- This is similar to creating a document using Microsoft Word 2007, but saving it in Word 97-2003 format.

## Level 1

**With PLSQL_OPTIMIZE_LEVEL = 1, the compiler will remove unnecesary code and exceptions from the executable code (e.g. comments).**

 - The order of the source code is not tipically changed

## Level 2

**With PLSQL_OPTIMIZE_LEVEL = 2 (default), the compiler will remove useless code as before, but will also sometimes move code to a different place if it will execute faster there**

- For example, if a frequently-called procedure in a large package is coded near to the end of the package body, the compiler will move it nearer to the beginning.
- Your source code is never changed, only the compiled code.

## Level 3

**PLSQL_OPTIMIZE_LEVEL = 3 gives all the benefits of values 1 and 2, plus subprogran inlining.**

- This means that the compiled code of another called subprogram is copied into the calling subprogram, so that only one compiled unit of code is executed.

- The source code itself is not changed, it is only the executable code that is optimized.

# PLSQL_OPTIMIZE_LEVEL: An Example

- The compiled code of CALLINGPROC now contains the code of both subprograms, as if it had been written as part of CALLINGPROC instead of as a separate subprogram
- CALLEDPROC also still exists as a separate subprogram and can still be called from other places.

```
CREATE OR REPLACE PROCEDURE calledproc IS BEGIN ... END calledproc;

ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL = 3;

CREATE OR REPLEACE PROCEDURE callingproc 
IS 
BEGIN
	...
	calledproc;
	...
END;
```

# Using USER_PLSQL_OBJECT_SETTINGS

- You  dan see how your PL/SQL programs were compiled by querying the USER_PLSQL_OBJECT_SETTINGS Data Dictionary view:

```
SELECT 
	name, type, plsql_code_type AS CODE_TYPE,
	plsql_optimize_level AS OPT_LVL 
FROM 
	USER_PLSQL_OBJECT_SETTING WHERE name = 'TESTPROC';
```



































































