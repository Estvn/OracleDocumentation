SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('The cat sat on the mat');
END;

BEGIN
    DBMS_OUTPUT.PUT('The cat sat'); -- Put text in the buffer
    DBMS_OUTPUT.PUT('On the mat'); -- Put text in the buffer
    DBMS_OUTPUT.NEW_LINE; -- Read the text in the buffer, and display it
END;


