DECLARE

    -- La siguiente estructura es un arreglo asociativo.
    TYPE ARREGLO IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    
    -- Una vez definido el arreglo, se debe crear una variable, y su tipo de dato será el arreglo creado.
    DATOS ARREGLO;
    
BEGIN

    DATOS(1) := 'ELEMENTO 1';
    DATOS(2) := 'ELEMENTO 2';
    DATOS(3) := 'ELEMENTO 3';
    DATOS(4) := 'ELEMENTO 4';
    DATOS(5) := 'ELEMENTO 5';
    DATOS(6) := 'ELEMENTO 6';
    
    -- DATOS.COUNT devuelve la cantidad de elementos en el arreglo.
    FOR ITERADOR IN 1 .. DATOS.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(DATOS(ITERADOR));
    END LOOP;

    -- La función DATOS.PRIOR() devuelve el elemento anterior del índice indicado en el parámetro.
    DBMS_OUTPUT.PUT_LINE(DATOS(DATOS.PRIOR(DATOS.COUNT)));
    
    -- La función DATOS.NEXT() devuelve el siguiente elemento del índice indicado en el parámetro.
    DBMS_OUTPUT.PUT_LINE(DATOS(DATOS.NEXT(DATOS.COUNT-1)));
    
    -- DATOS.DELETE() elimina del arreglo el elemento que se encuentra en el índice indicado en el parámetro.
    -- Se puede agregar dos parámetros, un índice inicial y uno final. Se eliminará todo lo que esté entre estos dos índices.
    DATOS.DELETE(1, 3); -- El segundo parámetro es opcional.
    DBMS_OUTPUT.PUT_LINE('La cantida de elementos en el arreglo es: ' || DATOS.COUNT());

END;

-- SET SERVEROUTPUT ON;
