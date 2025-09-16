CREATE OR REPLACE TRIGGER logon_trig
AFTER LOGON ON SCHEMA
BEGIN
    INSERT INTO log_trig_table(user_id, log_date, action)
    VALUES(USER, SYSDATE, 'Loggin on');
END;