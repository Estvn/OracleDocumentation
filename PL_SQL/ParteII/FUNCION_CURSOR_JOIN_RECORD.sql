-- CREAR FUNCION QUE RETORNE TODAS LAS ORDENES Y LOS CLIENTES QUE HAN HECHO UNA ORDEN
-- SE DEBEN RETORNAR EL CAMPO ORDER_ID, ORDER_DATE, SHIPPED_DATE, CUSTOMER_ID, FIRST_NAME, LAST_NAME 

CREATE OR REPLACE FUNCTION FN_INF_ORDEN_CLIENTES
RETURN SYS_REFCURSOR
IS
    CDATOS SYS_REFCURSOR;
BEGIN
    OPEN CDATOS FOR SELECT ORDERS.ORDER_ID, ORDERS.ORDER_DATE, NVL(ORDERS.SHIPPED_DATE, 0), 
    CUSTOMERS.CUSTOMER_ID, CUSTOMERS.FIRST_NAME, CUSTOMERS.LAST_NAME
    FROM ORDERS
    INNER JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID;
    
    RETURN CDATOS;
END;

DECLARE
    DATOS_CAT SYS_REFCURSOR;
    
    TYPE FILA IS RECORD(
        ORDER_ID ORDERS.ORDER_ID%TYPE,
        ORDER_DATE ORDERS.ORDER_DATE%TYPE,
        SHIPPED_DATE ORDERS.SHIPPED_DATE%TYPE,
        CUSTOMER_ID CUSTOMERS.CUSTOMER_ID%TYPE,
        FIRST_NAME CUSTOMERS.FIRST_NAME%TYPE,
        LAST_NAME CUSTOMERS.LAST_NAME%TYPE
    );
    
    REGISTRO FILA;

BEGIN
    DATOS_CAT := FN_INF_ORDEN_CLIENTES;
    
    LOOP
        FETCH DATOS_CAT INTO REGISTRO;
        EXIT WHEN DATOS_CAT%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('EL ID DE LA ORDEN ES: ' || REGISTRO.ORDER_ID);
        DBMS_OUTPUT.PUT_LINE('FECHA DE ENVIO DE LA ORDEN: ' || REGISTRO.SHIPPED_DATE);
        DBMS_OUTPUT.PUT_LINE('EL ID DEL CLIENTE ES: ' || REGISTRO.CUSTOMER_ID);
        DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL CLIENTE ES: ' || REGISTRO.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('EL APELIDO DEL CLIENTE ES: ' || REGISTRO.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE(CHR(10));
    
    END LOOP;
END;
    