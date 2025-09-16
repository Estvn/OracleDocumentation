
**Objectives:**

- Describe the benefits of obfuscated PL/SQL source code.
- Use the DBMS_DDL.CREATE_WRAPPED server-supplied procedure
- Describe how to use the Wrapper utility to obfuscate PL/SQL source code.

--------------

- When you create a clever PL/SQL package, you may want other users to execute it, but you dont´s always want them to be able to see the details of the package´s source code.
- Let´s examine how you can hide your source code from other users.

# PL/SQL Source Code in the Data Dictionary

- You already know that when you create a PL/SQL program - procedure, function or package - the source code is loades into the Data Dictionary, and you can see it using the Data Dictionary view USER_SOURCE

```
CREATE OR REPLACE PROCEDURE mycleverproc
(p_param1 IN NUMBER, p_param2 OUT NUMBER)
IS
BEGIN
	... /*some clever but private code here*/
END mycleverproc;
```

```
SELECT TEXT FROM USER_SOURCE
WHERE TYPE = 'PROCEDURE' AND NAME = 'MYCLEVERPROC'
ORDER BY LINE;
```

- If you now grant EXECUTE privilege on the procedure to other users, what can they see?

---------------

- Susan can describe your procedure 
- That´s fine; she needs to know its parameters and their data types in order to invoke it successfully
- Can she also see your source code?

```
You> GRANT EXECUTE ON mycleverproc TO susan;

Susan> DESCRIBE you.mycleverproc
```

Yes, Susan can see your source code 

```
Susan> SELECT TEXT FROM ALL_SOURCE
		WHERE OWNER = 'YOU' AND TYPE = 'PROCEDURE'
		AND NAME = 'MYCLEVERPROC'
		ORDER BY LINE;
```

# Obfuscating PL/SQL Source Code

- Anyone who has EXECUTE privilege on a preocedure or function can see your source cocde in ALL_SOURCE 

- We can hode the source code by converting it into a set of cryptic codes before we compile the subprogram.

- **Hiding the source code is called obfuscation, and converting the source code to cryptic codes is called wrapping the code.**

- When we compile the subprogram, only the wrapped code is loaded into the data dictionary.

- **Obfuscated code is source or machine code that has been made difficult to understand.**

 - Programmers may deliberate obfuscate code to conceal its purpose.
 - Programs know as obfuscators transform human-readable code into obfuscated dcode using various techniques.
 
- Obfuscating code is typically done to manage risks that stem from unauthorized access to source code.

# Obfuscating PL/SQL Source Code

**There are two ways to wrap the source code:**

- Using the DBMS_DDL.CREATE_WRAPPED Oracle-supplied package procedure
- Using the PL/SQL wrapper utility program, WRAP.

- To use WRAP utility you must be able to log into the database server computer.
- We can use the DBMS_DDL.CREATE_WRAPPED package and the end results are exactly the same 

# Using the DBMS_DDL Package

- The DBMS_DDL package contains procedures for obfuscating a single PL/SQL unit, such as a package specification, package body, function, preocedure, type specification, or type body.
- The DBMS_DDL package contains the WRAP function and the CREATE_WRAPPED procedure
- The CREATE_WRAPPED both wraps the text and creates the PL/SQL unit

# Using the DBMS_DDL.CREATE_WRAPPED Procedure

- We must pass the complete code of our subprogram as a single IN argument with data type VARCHAR2

- A VARCHAR2 variable has a maximum size of 32,767 characters, so this is the maximum size of our source code.
- Our source code is wrapped, and the wrapped code is automatically compiled

# Using DBMS_DDL.CREATE_WRAPPED: Example 1

Here we obfuscate the code

```
BEGIN
	DBMS_DDL.CREATE_WRAPPED('
		CREATE OR REPLACE PROCEDURE mycleverproc
		(p_param1 IN NUMBER, p_param2 OUT NUMBER)
		IS 
		BEGIN
			... /* some clever but provate code here */
		END mycleverproc;
	');
END;
```

```
GRANT EXECUTE ON mycleverproc TO SUSAN;

SELECT TEXT FROM ALL_SOURCE 
WHERE OWNER = 'YOU' AND TYPE = 'PROCEDURE'
AND NAME = 'MYCLEVERPROC'
ORDER BY LINE;
```

> [!NOTE]
> - Even you see only the obfuscated code, because the original source has not been loaded into the Data Dictionary
> - **Make sure you keep a private copy of the source code in case you want to modify later!**

























