PROCEDURE log_usage (p_card_id NUMBER, p_loc NUMBER)
IS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO log_table(card_id, location, tran_date)
        VALUES (p_card_id, p_loc, SYSDATE);
    COMMIT;
END atm_trans;

PROCEDURE atm_trans(p_cardnbr NUMBER, p_loc NUMBER) IS
BEGIN
    ... -- try to withdraw cash
    log_usage(p_cardnbr, p_loc);
    ... -- id withdraw fails then
    ROLLBACK;
END atm_trans;