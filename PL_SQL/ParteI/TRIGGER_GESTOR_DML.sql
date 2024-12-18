CREATE OR REPLACE TRIGGER TG_GESTOR_DML
BEFORE INSERT OR UPDATE OR DELETE ON CATEGORIES
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    
    IF(INSERTING) THEN
        DBMS_OUTPUT.PUT_LINE('INSERTANDO DATOS EN CATEGORIES');
        COMMIT;
        SAVEPOINT PT1;
    END IF;

    IF(UPDATING) THEN
        DBMS_OUTPUT.PUT_LINE('ACTUALIZANDO DATOS EN CATEGORIES');    
        COMMIT;
        SAVEPOINT PT1;
    END IF;
    
    IF(DELETING) THEN
        DBMS_OUTPUT.PUT_LINE('BORRANDO DATOS EN CATEGORIES');  
        COMMIT;
        SAVEPOINT PT1;
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('WE DONT�T KNOW WHAT HAPPENNED :C');
            ROLLBACK TO SAVEPOINT PT1;
END;