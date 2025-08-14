BEGIN

INSERT INTO BRANDS VALUES('6', 'Brand F');
INSERT INTO BRANDS VALUES('7', 'Brand G');
-- Si todo sale bien, se har� un COMMIT para guardar permanentemente estos cambios.
COMMIT; 
-- Los SAVEPOINT se definen despu�s de haber hecho un COMMIT.
-- Se crea un SAVEPOINT para poder volver a el �ltimo COMMIT exitoso en caso de fallos.
SAVEPOINT PUNTO1; 

INSERT INTO BRANDS VALUES('6', 'Brand H');
/*
Se har� COMMIT si no de genera ning�n error.
Se usa el mismo nombre para todos los SAVEPOINT.
Ya se tiene la seguridad que el �ltimo COMMIT se realiz� exitosamente, entonces el �ltimo SAVEPOINT debe ser reemplazado por el m�s nuevo.
*/
COMMIT;
SAVEPOINT PUNTO1; 

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Si eso se muestra en pantalla, el gestor regres� al SAVEPOINT anterior de la parte que gener� el error');
        ROLLBACK TO SAVEPOINT PUNTO1;
END;

-- SET SERVEROUTPUT ON;