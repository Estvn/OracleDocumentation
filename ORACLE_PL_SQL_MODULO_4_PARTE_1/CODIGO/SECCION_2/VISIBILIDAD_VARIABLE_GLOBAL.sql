DECLARE
    v_father_name VARCHAR(20);
    v_date_birth DATE := '20-Apr-1972';
BEGIN
    v_father_name := 'Patrick';
    DECLARE 
        v_child_name VARCHAR2(20) := 'Mike';
        v_date_birth DATE := TO_DATE('12-Dec-2002', 'DD-Month-YYYY');
    BEGIN
        DBMS_OUTPUT.PUT_LINE('NACIMIENTO: ' || v_date_birth);
    END;
END;