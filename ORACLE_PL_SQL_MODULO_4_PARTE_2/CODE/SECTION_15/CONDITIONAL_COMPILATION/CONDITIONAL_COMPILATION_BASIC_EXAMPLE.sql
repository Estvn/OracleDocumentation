CREATE OR REPLACE PROCEDURE lets_pretend IS
BEGIN
	...
	$IF MS_OFFICE_VERSION >= '2018' $THEN
		include_holographics;
	$ELSE
		include_std_graphic;
	$END
	...
END lets_pretend;