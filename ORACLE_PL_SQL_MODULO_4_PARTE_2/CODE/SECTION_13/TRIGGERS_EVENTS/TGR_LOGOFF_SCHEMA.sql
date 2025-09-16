CREATE OR REPLACE TRIGGER logoff_trig
BEFORE LOGOFF ON SCHEMA
BEGIN
    INSERT INTO log_trig_table(user_id, log_date, action)
    VALUES(USER, SYSDATE, 'Loggin off');
END;