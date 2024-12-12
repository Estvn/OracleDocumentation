-- CREAR FUNCI�N QUE RETORNE LA CANTIDAD DE FILAS EN UNA TABLA PRODUCTS
CREATE OR REPLACE FUNCTION FN_CANTIDAD_PRODUCTOS
RETURN NUMBER
IS  
    CANTIDAD_PRODUCTOS NUMBER;
BEGIN
    SELECT COUNT(*) INTO CANTIDAD_PRODUCTOS FROM PRODUCTS;
    RETURN CANTIDAD_PRODUCTOS;
END;


DECLARE
    TOTAL_PRODUCTOS NUMBER;
BEGIN
    TOTAL_PRODUCTOS := FN_CANTIDAD_PRODUCTOS;
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE PRODUCTOS ES: ' || TOTAL_PRODUCTOS);
END;

SET SERVEROUTPUT ON;

SELECT FN_CANTIDAD_PRODUCTOS FROM DUAL;
-- SELECT * FROM PRODUCTS;