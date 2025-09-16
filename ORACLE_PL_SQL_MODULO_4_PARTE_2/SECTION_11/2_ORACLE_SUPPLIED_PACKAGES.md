
- Describe two common uses of the DBMS_OUTPUT server_supplied package
- Recognize the correct syntax to specify messages for the DBMS_OUTPUT package
- Describe the purpose for the UTL_FILE server-supplied package
- Recall the exceptions used in conjunction with the UTL_FILE server-supplied package
- Describe the main features of the UTL_MAIL server-supplied package.

- You already know that Oracle supplies a number of SQL functions that you can use in your SQL statements when required
- It would be wasteful for you to have to "re-invent the wheel" by writing your own functions to do these things.

- **In the same way, Oracle supplies a number of ready-made PL/SQL packages to do things that most application developers and/or database administrators need to do from time to time.**

- In this lesson, you learn how to use two of the Oracle-supplied PL/SQL packages
- These packages focus on generating text output and manipulating text files.

# Using Oracle-Supplied Packages

- You can use these packages directly by invoking them from your own application, exactly as you would invoke packages that you had written yourself.

- Or, you can use these packages as ideas when you create your own subprograms.
- Think of these packages as ready-made "building blocks" that you can invoke from your own applications.

# List of Some Oracle-Supplied Packages

| Tab            | Function                                                                                            |
| -------------- | --------------------------------------------------------------------------------------------------- |
| DBMS_LOB       | enables manipulation of Oracle Large Object colunm datatypes. CLOB, BLOB and BFILE                  |
| DBMS_LOCK      | Used to request, convert, and release locks in the database through Oracle lock Management services |
| DBMS_OUTPUT    | Provides debuggin and buffering of messages                                                         |
| HTP            | Writes HTML-tagged data into database buffers                                                       |
| UTL_FILE       | Enables reading and writing of operative systems text files                                         |
| UTL_MAIL       | Enables composing and sending of e-mail messages                                                    |
| DBMS_SCHEDULER | Enables scheduling of PL/SQL blocks, stored procedures, and external procedures or executables.     |

-----------------------------------------

# The DBMS_OUTPUT Package

- The DBMS_:OUTPUT package sends text messages from any PL/SQL block into a private memory areas, form which message can be displayed on the screen.

Common uses of DBMS_OUTPUT include:

- You can output results back to the developer during testing for debugging purposes.
- You can trace/rastrear the code execution path for a function o procedure.

## How the DBMS_OUTPUT Package Works

- The DBMS_OUTPUT package enables you to send messages from stored subprograms and anonymous blocks - it's main purpose is for debugging

- PUT places text in the buffer
- NEW_LINE sends the buffer to the screen
- PUT_LINE does a PUT followed by a NEW_LINE
- GET_LINE and GET_LINES read the buffer
- Messages are not sent until after the calling block finishes

### Using DBMS_OUTPUT: Example 1

- This writes a text message into a buffer, then displays the buffer on the screen:

```
BEGIN
	DBMS_OUTPUT.PUT_LINE('The cat sat on the mat');
END;
```

- if you wanted to build a message a little at a time, you could code:

```
BEGIN
    DBMS_OUTPUT.PUT('The cat sat'); -- Put text in the buffer
    DBMS_OUTPUT.PUT('On the mat'); -- Put text in the buffer
    DBMS_OUTPUT.NEW_LINE; -- Read the text in the buffer, and display it
END;
```

## DBMS_OUTPUT is Designed for Debugging Only 

- **You should use DBMS_OUTPUT only in anonymous PL/SQL block for testing purposes.**

- You would not use DBMS_OUTPUT in PL/SQL programs that are called from a "real" application, which can include its own application code to display results on the user's screen.
- Instead, you would return the text to be displayed as an OUT aregument from the subprogram

- If you code a subprogram to include a DBMS_OUTPUT the subprogram will need to be modified and recompiled to omit the DBMS_OUTPUT in order to run the subprogram as part of a real application

---------------------------

# The UTL_FILE Package

- **Allows PL/SQL programas to read and write operating system text files.**

- Can access text files in operating systems directories defined by a CREATE DIRECTORY statement.
- You can also use the utl_file_dir database parameter

**IMPORTANT:**

- **The UTL_FILE package is simply a set of PL/SQL procedures that allows you to read, write, and manipulate operative system files.**
- The UTL_FILE I/O capabilities are similar to standard operative system stream file I/O (OPEN, GET, PUT, CLOSE) capabilities.

- The UTL_FILE package can be used only to manipulate text files, NOT binary files.
- To read binary files (BFILES) the BDMD_LOB package is used.

## File Processing Using the UTL_FILE Package

- The GET_LINE procedure reads a line of text from the file into an output buffer parameter.
- The maximum input record size is 1023 bytes
- The PUT and PUT_LINE procedures write text to the opened file.
- The NEW_LINE procedure terminates a line in an output file
- The FCLOSE procedure closes an opened file

## Exceptions in the UTL_FILE Package

UTL_FILE has its own set of exceptions that are applicable only when using this package:

- INVALID_PATH
- INVALID_MODE
- INVALID_FILEHANDLE
- INVALID_OPERATION
- READ_ERROR
- WRITE_ERROR
- INTERNAL_ERROR

The othes exceptions not specific to the UTL_FILE package are:

- NO_DATA_FOUND (raised when reading past the end of a file using GET_LINE(S))
- VALUE_ERROR

### Using UTL_FILE Example

- In this example, the sal_status procedure uses UTL_FILE to create a text report of employees for each department, along with their salaries.

- In the code, the variable v_file is declared as UTL_FILE.FILE_TYPE, a BINARY_INTEGER datatype that is declared globally by the UTL_FILE package.

The sal_status procedure accepts two IN parameters
1. p_dir for the name of the directory in which to write the text file
2. p_filename to specify the name of the file.

To invoke the procedure, use:

```
BEGIN
	sal_status('MY_DIR', 'salreport.txt');
END;
```

```
GRANT EXECUTE ON UTL_FILE TO C#_USR_PLSQL;

BEGIN sal_status('C:\oracle_output', 'salreport.txt'); END;

CREATE OR REPLACE PROCEDURE sal_status(p_dir IN VARCHAR2, p_filename IN VARCHAR2)
IS
    v_file UTL_FILE.FILE_TYPE;
    
    CURSOR empc IS
        SELECT last_name, salary, department_id 
        FROM employees ORDER BY department_id;
        
    v_newdepto employees.department_id%TYPE;
    v_olddepto employees.department_id%TYPE := 0;

BEGIN
    
    v_file := UTL_FILE.FOPEN (p_dir, p_filename, 'w'); 
    UTL_FILE.PUT_LINE(v_file, 'REPORT: GENERATED ON ' || SYSDATE);
    
    UTL_FILE.NEW_LINE(v_file);
    
    FOR emp_rec IN empc LOOP   
        UTL_FILE.PUT_LINE (v_file, 
                        ' EMPLOYEE: ' || emp_rec.last_name ||
                        'earns: ' || emp_rec.salary);
    END LOOP;
    
    UTL_FILE.PUT_LINE(v_file,'*** END OF REPORT ***'); 
    UTL_FILE.FCLOSE (v_file); 

    EXCEPTION
        WHEN UTL_FILE.INVALID_FILEHANDLE THEN 
            RAISE_APPLICATION_ERROR(-20001,'Invalid File.');
        WHEN UTL_FILE.WRITE_ERROR THEN 
            RAISE_APPLICATION_ERROR (-20002, 'Unable to write to file');

END sal_status;
```

-------------------------------

# The UTL_MAIL Package

- The UTL_MAIL package allows sending email from the Oracle database to remote recipients

Contains three procedures:

- SEND for messages without attachments
- SEND_ATTACH_RAW for messages with binary attachments
- SEND_ATTACH_VARCHAR2 for messages with text attachments

- The Oracle Academy provided online APEX environment is not configured to run the UTL_MAIL package.

## The UTL_MAIL.SEND Procedure Example

- Sends an email to one or more recipients
- No attachment are allowed

```
UTL_MAIL.SEND (
	sender IN VARCHAR2,
	recipients IN VARCHAR2,
	cc IN VARCHAR2 DEFAULT NULL,
	bcc IN VARCHAR2 DEFAULT NULL,
	subject IN VARCHAR2 DEFAULT NULL,
	message IN VARCHAR2,
...);
```

```
BEGIN
	UTL_MAIL.SEND('database@oracle.com',
	'joe43@yahoo.com',
	message => 'Friday’s meeting will be at 10:30 in Room 6',
	subject => 'Our PL/SQL meeting');
END;
```

# The UTL_MAIL.SEND_ATTACH_RAW Procedure

- Similar to UTL_MAIL.SEND, but allows sending an attachment of data type RAW (for example, a small picture).

```
UTL_MAIL.SEND_ATTACH_RAW (
	sender IN VARCHAR2,
	recipients IN VARCHAR2,
	cc IN VARCHAR2 DEFAULT NULL,
	bcc IN VARCHAR2 DEFAULT NULL,
	subject IN VARCHAR2 DEFAULT NULL,
	message IN VARCHAR2 DEFAULT NULL,
	...
	attachment IN RAW,
...);
```

- The maximum size of a RAW file is 32,767 bytes, so you cannot use this to send a large JPEG, MP3, or WAV file.

## The UTL_MAIL.SEND_ATTACH_RAW Example

- In this example, the attachments is read from an operative system image file (named company_logo.gif) by a PL/SQL function (GET_IMAGE) wich RETURNs a RAW data type
- Notice that all UTL_MAIL procedures allow you to send to more than one recipient.

```
BEGIN
	UTL_MAIL.SEND_ATTACH_RAW(
	sender => 'marketing@ourcompany.com',
	recipients => 'sally@ourcompany.com,bill@ourcompany.com',
	message => 'Please display this logo on our website',
	subject => 'Display Logo',
	attachment => get_image('company_logo.gif'),
END;
```

# The UTL_MAIL.SEND_ATTACH_VARCHAR2 Procedure

- This is identical to UTL_MAIL.SEND_ATTACH_RAW, but the attachment is a VARCHAR2 text.
- Again, the maximum size of a VARCHAR2 argument is 32,767 bytes, but this can be quite a large document.

## UTL_MAIL.SEND_ATTACH_VARCHAR2: Example

- In this example, the attachment is passed to a procedure as an argument, instead of being read from an operative system file.

```
CREATE OR REPLACE PROCEDURE send_mail_with_text
	(p_text_attachment IN VARCHAR2)
IS BEGIN
	UTL_MAIL.SEND_ATTACH_VARCHAR2(
	sender => 'me@here.com',
	recipients => 'you@somewhere.net',
	message => 'See attachment',
	subject => 'Useful document for our project',
	attachment => p_text_attachment,
END send_mail_with_text;

BEGIN
	send_mail_with_text('This document is designed to help in
	creating a project ...');
END;
```


































































































