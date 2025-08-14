DECLARE
    /*
    El RECORD se usa para guardar las columnas de una consulta que tiene varias tablas relacionadas.
    También se usa cuando se hace una consulta a una tabla, pero no se traen todos sus campos.
    
    En caso de hacer una consulta que traiga todas las columnas de una tabla, se hace lo siguiente:
    */
    -- Se define que se obtendrán todas las columnas de una tabla.
    TYPE TABLA IS TABLE OF CATEGORIES%ROWTYPE INDEX BY PLS_INTEGER;
   
   -- Se define una variable del tipo tabla para almacenar toda la información obtenida con el BULK COLLECT.
    DATOS_TABLA TABLA;
    ITERADOR NUMBER(10) := 0;
    
BEGIN
        
    -- Esto es un cursor implícito como un BULK COLLECT.
    SELECT CATEGORIES.CATEGORY_ID, CATEGORIES.CATEGORY_NAME BULK COLLECT INTO DATOS_TABLA FROM CATEGORIES;
    
    -- Recordando que el cursor implícito hecho anteriormente tiene por defecto el nombre SQL.
    WHILE (ITERADOR<SQL%ROWCOUNT) LOOP
        -- Como se ha usado %ROWCOUNT, los nombres de los campos son iguales que los de la tabla.
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ITERADOR);
        DBMS_OUTPUT.PUT_LINE('ID DEL PRODUCTO ES: ' || DATOS_TABLA(ITERADOR+1).CATEGORY_ID);
        DBMS_OUTPUT.PUT_LINE('CATEGORIA DEL PRODUCTO ES: ' || DATOS_TABLA(ITERADOR+1).CATEGORY_NAME);
        ITERADOR := ITERADOR +1;
    END LOOP;
END;

--SET SERVEROUTPUT ON;
