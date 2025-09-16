
**Objectives:**

- Describe the implications of procedural dependencies
- Constrant dependent objects and referenced objects
- View dependency information in the data dictionary
- Use the UTLDTREE script to create the objects required to display dependencies
- Describe when automatic recompilation occurs 
- List how to minimize dependency failures.

## Purpose

- A PL/SQL subprogram can execute correctly only if the objects that it references exist and are valid

- These objects can be tables, views, other PL/SQL subprograms, and other kinds of database objects
- So what if a referenced object is altered or dropped?

# Understanding Dependencies

- Some objects reference other objects as part of their definitions
- **For example, a stored procedure could contain a SELECT statement that select columns from a table**

- For this reson, the stored procedure is called a dependent object, whereas the table is called a referenced object.

# Dependency Issues

- **If you alter the definition of a referenced object, dependent objects might not continue to work properly.**

- For example, if the table definition is changed, the procedure might not continue to work without error.
- The Oracle server automatically records dependencies among objects.

- To manage dependencies, all schema objects have a status (valid or invalid) that is recorded in the Data Dictionary, and you can view the status in the USER_OBJECTS Data Dictionay view.

--------------

- A procedure or functions can directly or indirectly (through an intermediate view, procedure, function, or packaged procedure or function) reference the following objects:

	- Tables
	- Views
	- Sequences
	- Procedures
	- Functions
	- Packaged procedures or functions

![[Pasted image 20250908104555.png]]

# Dependencies Summarized

- Some object types can be both dependent and referenced 

# Local Dependencies

- In the case of local dependencies, the objects are on the same node in the same database
- The Oracle server automacitally manages all local dependencies, using the database's internal "depends-on" table

- When a referenced object is modified, the dependent objects are invalidated
- The next time an invalidated object is called, the Oracle server automatically tries to recompile it.

- If the referenced object is in a different database, the dependency is called a remote dependency
- Because the two databases have separate data dictionaries.

> [!NOTE]
> The Oracle server implicitly attempts to recompile any INVALID object when the objects is next called

# Recompiling a PL/SQL Program Unit 

Recompilation is either:

- Handled automatically through implicit run-time recompilation

Or:

- Handled through explicit recompilation with the ALTER statement:

```
ALTER PROCEDURE [SCHEMA.]procedure_name COMPILE;
ALTER FUNCTION [SCHEMA.]function_name COMPILE;

ALTER PACKAGE [SCHEMA.]package_name
COMPILE [PACKAGE | SPECIFICATION | BODY];

ALTER TRIGGER trigger_name [COMPILE[DEBUG]];
```

# Recompiling a PL/SQL Program Unit 

- If the recompilation is successful, the object becomes valid
- If not, the Oracle server return an error and the object remains invalid

- When you recompile a PL/SQL object, the Oracle server first recompiles any invalid object on which it depends.

# Unsuccessful Recompilation

Recompiling dependent procedures and functions is unsuccessful when:

- The referenced object is dropped or renamed 
- The data type of the referenced columns is changed 
- The referenced column is dropped
- A referenced view is replaced by a view with different columns 
- The parameter list of a referenced procedure is modified

# Successful Recompilation

Recompiling dependent procedures and functions is successful if:

- New columns are added to a referenced table
- All INSERT statements include a column list
- No new column is defined as NOT NULL
- The data type of referenced columns has not changed 
- A private table is dropped, but a public table that has the same name and structure exists
- The PL/SQL body of a referenced procedure has been modified and recompiled successfully

# Recompilation of Procedures

Minimize dependency failures by:

- Declaring records with the %ROWTYPE attribute
- Declaring variables with the %TYPE attribute
- Querying with the SELECT * notation 
- Including a column list with the INSERT statements

# Packages and Dependencies

- You can simplify dependency management and avoid unnecesary invalidations with packages when referencing a package procedure or function from a stand-alone procedure or function

- If the package body changes and the package specification does not change, then the stand-alone procedure that references a package construct remains valid

- If the package specification changes, then the outside procedure referencing a package construct is invalidated, as is the package body

- If a stand-alone procedure that is referencing within the package changes, then the entire package body is invalidated, but the package specification reamins valid.
- Therefore, it is recommended that you bring the procedure into the packages.





























































































