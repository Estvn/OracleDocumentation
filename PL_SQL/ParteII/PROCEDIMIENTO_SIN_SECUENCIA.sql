-- INSERT VALUES IN A TABLE WITHOUT USING A SEQUENCE TO THE ID
CREATE OR REPLACE PROCEDURE SP_INSERTA_PRODUCTO(NOMB_PROD VARCHAR2, ID_BRAND NUMBER, CAT_ID NUMBER, ANIO_MODELO NUMBER, PRECIO NUMBER, MSJEXITO OUT VARCHAR2, MSJERROR OUT VARCHAR2)
IS
    VAL_MAX_PROD_ID NUMBER;
BEGIN
    -- SAVE THE NEXT INDEX TO USE INSIDE THE VARIABLE
    SELECT (MAX(PRODUCT_ID)+1) INTO VAL_MAX_PROD_ID FROM PRODUCTS;
    
    -- USE THE NEXT AVAILABLE INDEX TO INSERT THE NEW VALUE IN THE TABLE
    INSERT INTO PRODUCTS VALUES(VAL_MAX_PROD_ID, NOMB_PROD, ID_BRAND, CAT_ID, ANIO_MODELO, PRECIO);
    COMMIT;
    MSJEXITO := 'INSERCI�N EXITOSA';
    
    EXCEPTION
    WHEN OTHERS THEN
        MSJERROR := SQLERRM; 
END;

-- SELECT * FROM PRODUCTS;

DECLARE
    MSJEXITO VARCHAR2(255);
    MSJERROR VARCHAR2(255);
BEGIN
    SP_INSERTA_PRODUCTO('BICICLETA DE MONTA�A', 1, 4, 2019, 4345, MSJEXITO, MSJERROR);
    DBMS_OUTPUT.PUT_LINE(MSJEXITO || ' ' || MSJERROR);
END;

-- SET SERVEROUTPUT ON;