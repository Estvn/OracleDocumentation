-- Can reference a element before it is declared, just using forward declaration
-- The elements that need to reference into the code when is not declared yet, 
-- need to make a forward declaration at the start of the package

CREATE OR REPLACE PACKAGE BODY forward_pkg 
IS
    PROCEDURE calc_rating(...); -- forward declaration
    
    -- Subprograms defined in alphabetical order
    
    PROCEDURE award_bonus (...) 
    IS
    BEGIN
        calc_rating(...); -- resolved by forward declaration
        ...
    END;
    
    PROCEDURE calc_rating (...) -- implementation
    IS
    BEGIN
        ...
    END;
END forward_pkg;