
**Objectives:**

- Describe the reasons for using packages
- Describe the two components of a package: **specification and body**
- Create packages containing related variables, cursors, constants, expections, procedures and functions.
- Create a PL/SQL block that involves a package construct

--------------------------

- You have already learned how to create and use stored procedures and functions
- Suppose you want to create several procedures and functions that are related to each other.
- Im might be helpful to group them together or in some way identify theur relationhips to each other.

- **Can create and manage all the related subprograms as a single database object called a package.**

# What are PL/SQL Packages?

- Are containers (schema objects) that enable you to logically group together related PL/SQL subprograms, variables, cursors and exceptions.

- For example, Human Resources package can contain hiring/contratación and firing procedures, commission and bonus functions, and tax-exemption variables.

# Components of a PL/SQL Package

A package consists of two parts stored separately on the database:

## Package specification

- It must be created first
- It declares the contructs (procedures, functions, variables, and so on) that area visible to the calling enviroment.

## Package body

- This contains the executable code of the subprograms that were declared in the package sepecification.
- It can also contain its own variable declarations

# Components of a PL/SLQ Package

- The detailed package body code is invisible to the calling enviroment, which can see only the sepecification.

- If changes to the code are nedeed, tha body can be edited and recompiled without having to edit or recompile the sepecification.

- This two-part structure is an example of a modular programming principle called encapsulation.

# Syntax for Creating the Package Specification

- To create packages, you declare all public constructs within the package section

```
CREATE [OR REPLACE] PACKAGE package_name
IS | AS
	public type and variable declarations
	public subprogram specifications
END [package_name];
```

- **public type and variables declarations:** Declares public variables, constants, cursors, exceptions, user-defined types, and subtypes.
- Variables declared in the package specification are initialized to NULL by default

- public subprogram specifications: Declares the public procedures and/or functions in the package.

# Creating the Package Specification

- "Public" means that the package construct can be seen and executed from outside the package.
- All constructs declared in the package specification are automatically public constructs
- For all public procedures and functions, the package specification should contain the subprogram name and associated parameters terminated by a semicolon.

- The implementation of a procedure or function that is declared in a package specification is done in the package body.

# Example of Package Specification: check_emp_pkg

- **G_MAX_LENGHT_OF_SERVICE** is a constant declared and initialized in the specification (global not local)
- **CHK_HIREDATE and CHK_DEPT_MGR** are two public procedures declared in the specification

```
CREATE OR REPLACE PACKAGE check_emp_pkg
IS
	g_max_length_of_service CONSTANT NUMBER := 100;
	
	PROCEDURE chk_hiredate
		(p_date IN employees.hire_date%TYPE);
		
	PROCEDURE chk_dept_mgr
		(
			p_empid IN employees.employee_id%TYPE,
			p_mgr   IN employees.manager_id%TYPE
		);
END check_pkg;
```

A second example:

```
CREATE OR REPLACE PACKAGE manage_jobs_pkg
IS
	g_todays_date DATE := SYSDATE;
	
	CURSOR jobs_curs IS
		SELECT employee_id, job_id FROM employees
		ORDER BY employee_id;
	
	PROCEDURE update_job
		(p_emp_id IN employees.employee_id%TYPE);
		
	PROCEDURE fetch_emps
		(
			p_job_id IN employees.job_id%TYPE,
			p_emp_id OUT employees.employee_id%TYPE
		);
END manage_jobs_pkg;
```

----------------------------------
# Syntax for Creating the Package Body

- Create a package body to contain the detailed code for all the subprograms declared in the specification.

```
CREATE [OR REPLACE] PACKAGE BODY package_name 
IS | AS
	private type and variable declarations 
	subprogram bodies
[BEGIN initializations statements]
END [package_name];
```

- **package_name** specifies a name for the package body that must be the same as its package specification.

- subprogram bodies must contain the code of all the subprograms declared in the package specification, and the code for all private subprograms.

# Creating the Package Body

When the OR REPLACE option to overwrite an existing package body

- Specify the OR REPLACE option to overwrite an existing package body
- **Define the subprograms in an appropiate order**

- The basic principle it that you must declare a variable or subprogram before it can be referenced by other components in the same package body

- **Every subprogram declared in the package specification must also be included in the package body.**

# Example of Package Body: check_emp_pkg

```
CREATE OR REPLACE PACKAGE BODY check_emp_pkg 
IS

	PROCEDURE chk_hiredate
		(p_date IN employees.hire_date%TYPE)
		IS BEGIN
			IF MONTHS_BETWEEN(SYSDATE, p_date) > 
			g_max_length_of_service * 12 THEN
				RAISE_APPLICATION_ERROR(-20200, 'Invalid Hiredate');
				END IF;
	END chk_hiredate;
	
	PROCEDURE chk_dept_mgr
		(
			p_empid IN employees.employee_id%TYPE,
			p_mgr   IN employees.manager_id%TYPE
		)
		IS BEGIN ...
	END chk_dept_mgr;
	END check_emp_pfg;
```

# Changing the Package Body Code

- When you need to change a object inside a Package, just need to recompile the package body.
- No need to recompile the sepecification unless the name or parameters have changed.

- **Remember the specification can exist without the body (but the body cannot exists without the specification).**

- Because the specification is not recompiled, you do not need to recompile any applications (or other PL/SQL subprograms) that are already inkoking the package procedures.

> [!NOTE]
> To recompile a Package body, just make the changes and execute again the Package Body.
> If modified the name or parameters in the Package Body, must need to change and recompile the Package Specification

# Describing a Package

- Can describe a Package in the same way as you can DESCRIBLE a table or view

```
DESCRIBE check_emp_pkg;
```

- **You cannot DESCRIBE individual packaged subprograms, only the whole package.**

---------------------------------

# Reason for Using Packages

- **Modularity.** Related programs and variables can be grouped together.
- **Hiding information.** Only the declarations in the package specification are visible to invokers.

- Application developers do not need to know the details of the package body code.

- **Easier maintenance.** You can change and recompile the package body code without having to recompile the specification.

- **The applications that already use the package do not need to be recompiled.**

# Summary

- Describe the reasons for using a package
- Describe the two components of a package: specification and body
- Create packages containing related variables, cursors, constants, exceptions, procedures and functions.
- Create a PL/SQL block that invokes a package construct


































































































































































