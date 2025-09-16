
**Objetives:**

- View trigger information in the Data Dictionary
- Disable and enable a database trigger
- Remove a trigger from the database

------------------------------------

- There may be times when you want to turn off a trigger in order to perform some maintenance or debug some code.
- Or, in order to understrand the triggers that exist in the Data Dictionary, you may need to view them
- You can do all of this bu managing triggers

# Privileger Needed for Triggers

To create a trigger in your own schema, you need:

- CREATE TRIGGER system privilege
- Normal object privileges (SELECT, UPDATE, EXECUTE, and so on) on objects in othe schemas that are referenced in you trigger body
- ALTER prvilege on the table or view associated with the trigger

- To create triggers in other user's schemas, you need the CREATE ANY TRIGGER privilege.

- Statements in the tirgger body use the privileges of the trigger owner. NOT the privileges of the user executing the operation that fires the trigger

# Privileges Needed for Triggers Example 

User Monica need to create the following trigger:

```
CREATE OR REPLACE TRIGGER upd_tom_emp
AFTER UPDATE ON tom.employees
BEGIN
	INSERT INTO mary.log_table VALUES (USER, SYSDATE);
	sharon.calledproc;
END;
```

Monica needs the following privileges:

- CREATE TRIGGER
- ALTER on TOM.EMPLOYEES
- INSERT on MARY.LOG_TABLE
- EXECUTE on SHARON.CALLEDPROC

# Viewing Triggers in the Data Dictionary

You can see trigger information in the following Data Dictionary views:

- USER_OBJECTS: Object name and object type
- USER_TRIGGERS: Detailed code and status of the trigger
- USER_ERRORS: PL/SQL syntax error of the trigger
- Source code for triggers is in USER_TRIGGERS no USER_SOURCE

# USER_TRIGGERS Data Dictionary

| Column            | Column Description                       |
| ----------------- | ---------------------------------------- |
| TRIGGER_NAME      | Name of the trigger                      |
| TRIGGER_TYPE      | When it fires - BEFORE, AFTER, ROW, etc. |
| TRIGGERING_EVENT  | The DML opeeration firing the trigger    |
| TABLE_NAME        | Name of the associated table             |
| REFERENCING_NAMES | Name used for :OLD and :NEW              |
| WHEN_CLAUSE       | The when_clause used                     |
| STATUS            | The status of the trigger                |
| TRIGGER_BODY      | Action taken by the trigger              |

# Viewing Trigger Information Using USER_TRIGGERS

- This example shows the triggering event, timing, type of trigger, status, and detailed body code of the RESTRICT_SALARY trigger

```
SELECT trigger_name, trigger_type, triggering_event, table_name, status, trigger_body
FROM USER_TRIGGERS
WHERE trigger_name = 'RESTRICT_SALARY'
```

# Changing the Status of Triggers

- Is you need a trigger turned off temporarily, don't drop it and the recreate it, just disable it for a little while by using the ALTER TRIGGER statement

```
-- Disable or re-enable a database trigger
ALTER TRIGGER trigger_name DISABLE | ENABLE

-- Disable or re-enable all triggers for a table 
ALTER TABLE DISABLE | ENABLE ALL TIRGGERS;

-- Recompile a trigger for a table 
ALTER TRIGGER trigger_name COMPILE;
```

- When a trigger is first created, it is enabled by default

**Why would we disable a trigger?**

- To improve performance when loading very large amounts of data into the database

- Now someone (maybe the DBA) inserts 10 million rows into BIGTABLE
- This row trigger will fire 10 million times, slowing down the data load considerabily

- We may disable a trigger when it references a database object that is currently unavailable due to a failed network connection, disk crash, offline data file, of offline table space.

# Removing Triggers

- To remove a trigger from the database, use the DROP TRIGGER statement:

```
DROP TRIGGER trigger_name
```

> [!NOTE]
> Al trigger on a table are remove when the table is removed






























