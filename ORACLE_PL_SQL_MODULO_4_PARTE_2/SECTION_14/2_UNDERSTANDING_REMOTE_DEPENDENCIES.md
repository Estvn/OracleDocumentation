
**Objectives:**

- Describe remote dependencies
- List how remote dependencies are controlled
- Describe when a remote dependency is unsuccessfully recompiled
- Describe when a remote dependency is successfully recompiled

---------------------

- You have already learned that when a referenced object and a dependent abject are in the same database, the Oracle server automatically records their dependency in the Data Dictionary

- But if the two objects are in different databases, this dependency between them is not automatically recorded.

- Each database has its own Data Dictionary, so the status of the two objects is recorded in two separate Data Dictionaries, which do not automatically update each other across the network.

# Understanding Remote Dependencies

- **When the referenced and dependent objects are in two different databases, the dependency is called a remote dependency.**

- The Oracle server does not automatically track relationships (such as dependencies) between objects in two different databases, even when the two databases are on the same server machine 
- This is because each database has its own separate and independent data dictionary

In real life, you (or the DBA) would first create a database link, which is a pointer to a remote database, and then reference the database link within a local procedure.

```
CREATE DATABASE LINK my_db_link
	CONNECT TO remote_username IDENTIFIED BY remote_password
	USING 'remote_database_name';
	
	CREATE OR REPLACE procedureA ...
IS BEGIN
	... procedureB@my_db_link (parameters ... ) ... END;
```

- If the remote procedure is (directly or indirectly) invalidated, the server cannot automatically invalidate the local procedure because there is no reference to the local procedure within the remote data dictionary.

- The view and procedure in the remote database are automatically invalidated because they are in the same database as the table, but the local procedure is not invalidated because it is in a different database.

- However, the local procedure can (and will) be invalidated when it invokes (calls) the remote procedure; in other words, at execution time

# How are Remote Dependencies Managed?

- Because remote dependencies are not automatically tracked in data dictionaries, there must be another way for the Oracle server to check if a remote procedure has been invalidated.

There are two ways of doing this:

- TIMESTAMP mode checking (default)
- SIGNATURE mode checking

- To use signature mode, set the local database parameter:
	- REMOTE_DEPENDENCIES_MODE = SIGNATURE

# How to Change Dependency Mode

You can alter de dependency mode for the current session by using the ALTER SESSION command:

```
ALTER SESSION SET REMOTE_DEPENDENCIES_MODE = { SIGNATURE | TIMESTAMP }
```

And, you can alter the dependency mode system-wide after startup with the ALTER SYSTEM command:

```
ALTER SYSTEM SET REMOTE_DEPENDENCIES_MODE = { SIGNATURE | TIMESTAMP }
```

---------------------------------
# What is Timestamp Mode?

- **Whenever any database object is created or modified (for example when a PL/SQL procedure is recompiled), Oracle automatically records the timestamp of the change in the data dictionary.**

- You can see these timestamops in the USER_OBJECTS dictionary view

For example, to see when your procedures were last compiled:

```
SELECT object_name, timestamp
	FROM USER_OBJECTS
	WHERE object_type = 'PROCEDURE';
```

# Timestamps and PL/SQL Subprograms

- When local procedure A is compiled, and it references remote procedure B, the remote procedure's timestamp is read and stored within the local procedure, as well as the local procedure´s timestamp

# Disadvantage of Timestamp Mode

- Remote dependencies sometimes cause unnecesary failures and later recompilations
- To avoid this limitation, we can use Signature Mode 

----------------------
# Signature Mode

- In signature Mode, a unique number called a signature is calculated and stored each time a procedure is recompiled.

The signature of procedure is calculated from:

- The name of the procedure
- The data types of the parameters
- The modes of the parameters

- **The signature changes only if the procedure name or parameters are changed, not if a change is made to the body of the code.**

- The signature of the remote procedure is saved in the local procedure, just like timestamp mode.

- You cannot view the signature. It is not stored in USER_OBJECTS or any other Data Dictionary view.

> [!NOTE]
> Signature mode avoids unnecesary failures and recompilations, because the signatura changes only when the dependent object would have to be recompiled anyway.

# Terminology

- Remote dependency
- Signature mode
- Timestamp mode

# Summary

- Describe remote dependencies
- List how remote dependencies are controlled
- Describe when a remote dependency is unsuccessfully recompiled 
- Describe when a remote dependency is successfully recompiled
















































