DECLARE

    -- Definiendo una estructura tipo RECORD
    TYPE FILA IS RECORD(
        NOMBRE PRODUCTS.PRODUCT_NAME%TYPE,
    --    CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE,
        MODELO PRODUCTS.MODEL_YEAR%TYPE
    );
    
    -- Definiendo una tabla para poder definir los datos de RECORD como sus columnas.
    TYPE TABLA IS TABLE OF FILA INDEX BY PLS_INTEGER;
   
   -- Se define una variable del tipo tabla para almacenar toda la información obtenida con el BULK COLLECT.
    DATOS_TABLA TABLA;
    ITERADOR NUMBER(10) := 0;
    
BEGIN
    
    -- Esto es un cursor implícito como un BULK COLLECT.
    SELECT PRODUCTS.PRODUCT_NAME, PRODUCTS.MODEL_YEAR BULK COLLECT INTO DATOS_TABLA FROM PRODUCTS;
    --INNER JOIN CATEGORIES ON PRODUCTS.CATEGORY_ID = PRODUCTS.CATEGORY_ID;
    
    -- Recordando que el cursor implícito hecho anteriormente tiene por defecto el nombre SQL.
    WHILE (ITERADOR<SQL%ROWCOUNT) LOOP
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
        DBMS_OUTPUT.PUT_LINE('NOMBRE DEL PRODUCTO ES: ' || DATOS_TABLA(ITERADOR+1).NOMBRE);
        --DBMS_OUTPUT.PUT_LINE('CATEGORIA DEL PRODUCTO ES: ' || DATOS_TABLA(ITERADOR+1).CATEGORIA);
        DBMS_OUTPUT.PUT_LINE('AÑO DEL MODELO DEL PRODUCTO: ' || DATOS_TABLA(ITERADOR+1).MODELO || CHR(10));
        ITERADOR := ITERADOR +1;
    END LOOP;
END;

-- SET SERVEROUTPUT ON;
