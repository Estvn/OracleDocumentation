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