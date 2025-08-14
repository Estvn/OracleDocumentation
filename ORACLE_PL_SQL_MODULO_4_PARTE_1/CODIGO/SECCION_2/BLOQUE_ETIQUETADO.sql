<<first_block>>
DECLARE
    v_father_name VARCHAR2(20) := 'Patrick';
    v_date_birth DATE := '20-Apr-1972';
BEGIN
    DECLARE
        v_child_name VARCHAR2(20) := 'Mike';
        v_date_birth DATE := '12-Dec-2002';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nombre del padre' || v_father_name);
        DBMS_OUTPUT.PUT_LINE('Fecha de nacimiento' || first_block.v_date_birth);
        DBMS_OUTPUT.PUT_LINE('Nombre del hijo' || v_child_name);
        DBMS_OUTPUT.PUT_LINE('Fecha de nacimiento' || v_date_birth);
    END;
END;