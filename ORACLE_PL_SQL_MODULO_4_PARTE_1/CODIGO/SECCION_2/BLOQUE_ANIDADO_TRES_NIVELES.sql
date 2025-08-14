DECLARE
    v_outervar VARCHAR(20);
BEGIN
    DECLARE
        v_middlevar VARCHAR(20);
    BEGIN
        BEGIN
            v_outervar := 'Hola';
            v_middlevar := 'que tal';
        END;
        DBMS_OUTPUT.PUT_LINE(v_outervar || ' ' || v_middlevar);
    END;
END;