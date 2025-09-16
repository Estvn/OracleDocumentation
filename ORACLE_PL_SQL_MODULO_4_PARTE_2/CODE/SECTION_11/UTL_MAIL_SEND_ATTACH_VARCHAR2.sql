CREATE OR REPLACE PROCEDURE send_mail_with_text
	(p_text_attachment IN VARCHAR2)
IS BEGIN
	UTL_MAIL.SEND_ATTACH_VARCHAR2(
	sender => 'me@here.com',
	recipients => 'you@somewhere.net',
	message => 'See attachment',
	subject => 'Useful document for our project',
	attachment => p_text_attachment,
END send_mail_with_text;

BEGIN
	send_mail_with_text('This document is designed to help in
	creating a project ...');
END;