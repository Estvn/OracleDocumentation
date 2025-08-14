PROCEDURE at_proc IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    dept_id NUMBER := 90;
BEGIN   
    UPDATE ... 
    INSERT ...
    COMMIT; -- (o ROLLBACK) requerido;
END at_proc;