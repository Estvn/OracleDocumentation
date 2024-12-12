-- SP QUE LLAMA A OTRO SP PARA INSERTARLE VALORES
CREATE OR REPLACE PROCEDURE SP_VALORES_REG_STAFF(STAFFID NUMBER, FNAME VARCHAR2, LNAME VARCHAR2, EMAIL VARCHAR2,
                                            PHONE VARCHAR2, ACTIVE NUMBER, STOREID NUMBER, MANAGERID NUMBER)
IS
    MSJ NUMBER;
BEGIN
    SP_INSERT_STAFFS(STAFFID, FNAME, LNAME, EMAIL, PHONE, ACTIVE, STOREID, MANAGERID, MSJ);
    
    IF(MSJ = 1) THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Insercion exitosa');
    ELSIF(MSJ = 2) THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('fracaso de insercion'|| SQLERRM);
    END IF;
END;

-- SP QUE INSERTA VALORES EN UNA TABLA
CREATE OR REPLACE PROCEDURE SP_INSERT_STAFFS(STAFFID NUMBER, FNAME VARCHAR2, LNAME VARCHAR2, EMAIL VARCHAR2,
                                            PHONE VARCHAR2, ACTIVE NUMBER, STOREID NUMBER, MANAGERID NUMBER, MSJ OUT NUMBER)
IS

BEGIN
    INSERT INTO STAFFS VALUES (STAFFID, FNAME, LNAME, EMAIL, PHONE, ACTIVE, STOREID, MANAGERID);
    MSJ := 1;
    
    EXCEPTION
        WHEN OTHERS THEN
            MSJ:=2;
END;

-- DESC STAFFS;
-- DESC STORES;
-- EJECUTAR SP
EXECUTE SP_VALORES_REG_STAFF(6, 'Estiven', 'Mejia', 'estiven.mejia@unah.hn', '96143856', 1, 3, 3);

SELECT * FROM STAFFS;
SELECT * FROM STORES;

SET SERVEROUTPUT ON;