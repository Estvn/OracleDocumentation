DECLARE    
    /*
    Para poder realizar un SELECT INTO se deben una variable por cada valor de columna a recuperar.
    */
    NOMBRE PRODUCTS.PRODUCT_NAME%TYPE; -- Se obtiene el tipo de dato definido en el campo de la tabla.
    MODELO PRODUCTS.MODEL_YEAR%TYPE;
    
    VAR_WHILE NUMBER(3) := 1;
    VAR_LOOP NUMBER(3) := 1;
    CANTIDAD_PRODUCTOS NUMBER(5) := 0;
    
BEGIN 

    SELECT COUNT(PRODUCT_ID) INTO CANTIDAD_PRODUCTOS FROM PRODUCTS;
    DBMS_OUTPUT.PUT_LINE('La cantidad de productos en la DB son: ' || CANTIDAD_PRODUCTOS);
    /*
    Con SELECT INTO solo se puede obtener una fila.
    Si se intenta obtener más de una fila se obtendrá un error.
    Solo funcionará si en la tabla hay una instancia, o definiendo un WHERE para obtener un solo valor.
    */
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'Respuesta del ciclo FOR' || CHR(10));
    
    FOR VARIABLE IN 1 .. 5 LOOP
        SELECT PRODUCT_NAME, MODEL_YEAR INTO NOMBRE, MODELO FROM PRODUCTS WHERE PRODUCT_ID = VARIABLE;
        
        -- Definiendo una estructura condicional IF
        IF(NOMBRE = 'Smartphone') THEN
            DBMS_OUTPUT.PUT_LINE('Este es un teléfono');
        ELSIF(MODELO = '2021') THEN 
            DBMS_OUTPUT.PUT_LINE('El producto de nombre ' || NOMBRE || ' tiene un modelo del año ' || MODELO);
        ELSE
            DBMS_OUTPUT.PUT_LINE(NOMBRE || ' ' || MODELO);
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Respuesta del ciclo WHILE' || CHR(10));    
    WHILE (VAR_WHILE < 6) LOOP
    
    SELECT PRODUCT_NAME, MODEL_YEAR INTO NOMBRE, MODELO FROM PRODUCTS WHERE PRODUCT_ID = VAR_WHILE;
    
    -- Inicio de una estructura condicional CASE
    CASE
        WHEN (NOMBRE = 'Smartphone') THEN
            DBMS_OUTPUT.PUT_LINE('El producto es un ' || NOMBRE);
        WHEN (MODELO = '2023') THEN
            DBMS_OUTPUT.PUT_LINE('El producto de nombre ' || NOMBRE || ' es un modelo del año ' || MODELO);
        ELSE
            DBMS_OUTPUT.PUT_LINE(NOMBRE || ' ' || MODELO);
    END CASE;
    
    VAR_WHILE := VAR_WHILE + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) ||'Respuesta del ciclo LOOP' || CHR(10));
    LOOP 
    EXIT WHEN (VAR_LOOP = 5);
    
    SELECT PRODUCT_NAME, MODEL_YEAR INTO NOMBRE, MODELO FROM PRODUCTS WHERE PRODUCT_ID = VAR_LOOP;
    DBMS_OUTPUT.PUT_LINE(NOMBRE || ' ' || MODELO);
    VAR_LOOP := VAR_LOOP + 1;
    END LOOP;
END;

SET SERVEROUTPUT ON;

SELECT * FROM PRODUCTS;
DESC PRODUCTS;