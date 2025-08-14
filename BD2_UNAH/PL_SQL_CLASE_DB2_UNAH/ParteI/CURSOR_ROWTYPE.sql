DECLARE 
    -- Definiendo un CURSOR y los valores del SELECT con un alias.
    -- Es importante definir alias en los valores obtenidos, en caso que dos columnas tengan el mismo nombre cuando se hace un JOIN.
    CURSOR CDATOS_PRODUCTOS IS SELECT PRODUCTS.PRODUCT_NAME NOMBRE, CATEGORIES.CATEGORY_NAME CATEGORIA, PRODUCTS.MODEL_YEAR MODELO FROM PRODUCTS
    INNER JOIN CATEGORIES ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY_ID;
    
    -- Se puede usar ROWTYPE para capturar los datos de las columnas definidas en un cursor o una tabla.
    DATOS_PRODUCTOS CDATOS_PRODUCTOS%ROWTYPE; 

BEGIN
    OPEN CDATOS_PRODUCTOS;
    LOOP
        FETCH CDATOS_PRODUCTOS INTO DATOS_PRODUCTOS;
        EXIT WHEN CDATOS_PRODUCTOS%NOTFOUND;
        -- Se debe definir el nombre de las llaves del diccionario para poder acceder a los valores obtenidos de la DB.
        DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO ES:' || DATOS_PRODUCTOS.NOMBRE);
        DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA CATEGORIA DEL PRODUCTO ES: ' || DATOS_PRODUCTOS.CATEGORIA);
        DBMS_OUTPUT.PUT_LINE('EL AÑO DEL MODELO DEL PRODUCTO ES: ' || DATOS_PRODUCTOS.MODELO || CHR(10));
    END LOOP;
    CLOSE CDATOS_PRODUCTOS;
END;

SET SERVEROUTPUT ON;