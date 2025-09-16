UTL_MAIL.SEND (
sender IN VARCHAR2,
recipients IN VARCHAR2,
cc IN VARCHAR2 DEFAULT NULL,
bcc IN VARCHAR2 DEFAULT NULL,
subject IN VARCHAR2 DEFAULT NULL,
message IN VARCHAR2,
...);

BEGIN
UTL_MAIL.SEND('database@oracle.com',
'joe43@yahoo.com',
message => 'Friday’s meeting will be at 10:30 in Room 6',
subject => 'Our PL/SQL meeting');
END;