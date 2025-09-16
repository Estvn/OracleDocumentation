BEGIN
	UTL_MAIL.SEND_ATTACH_RAW(
	sender => 'marketing@ourcompany.com',
	recipients => 'sally@ourcompany.com,bill@ourcompany.com',
	message => 'Please display this logo on our website',
	subject => 'Display Logo',
	attachment => get_image('company_logo.gif')
END;