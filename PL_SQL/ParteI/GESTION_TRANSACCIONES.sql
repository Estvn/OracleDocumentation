BEGIN

INSERT INTO BRANDS VALUES('6', 'Brand F');
INSERT INTO BRANDS VALUES('7', 'Brand G');
-- Si todo sale bien, se hará un COMMIT para guardar permanentemente estos cambios.
COMMIT; 
-- Los SAVEPOINT se definen después de haber hecho un COMMIT.
-- Se crea un SAVEPOINT para poder volver a el último COMMIT exitoso en caso de fallos.
SAVEPOINT PUNTO1; 

INSERT INTO BRANDS VALUES('6', 'Brand H');
/*
Se hará COMMIT si no de genera ningún error.
Se usa el mismo nombre para todos los SAVEPOINT.
Ya se tiene la seguridad que el último COMMIT se realizó exitosamente, entonces el último SAVEPOINT debe ser reemplazado por el más nuevo.
*/
COMMIT;
SAVEPOINT PUNTO1; 

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Si eso se muestra en pantalla, el gestor regresó al SAVEPOINT anterior de la parte que generó el error');
        ROLLBACK TO SAVEPOINT PUNTO1;
END;

-- SET SERVEROUTPUT ON;