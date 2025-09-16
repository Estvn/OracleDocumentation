-- Package initialization block
-- Is an unnamed block inside the package body used to initialize values for package variables
-- Doesn't matter if the variables are public or private

CREATE OR REPLACE PACKAGE taxes_pkg
IS
	g_tax NUMBER;
	... -- declare all public procedures/functions
END taxes_pkg;

CREATE OR REPLACE PACKAGE BODY taxes_pkg 
IS
	... -- declare the fordward declarations
	... -- declare all private variables
	... -- define public/private procedures/functions overloaded
	
	BEGIN -- unnamed initialization block
		SELECT rate_value INTO g_tax
			FROM tax_rates
			WHERE rate_name = 'TAX';
END taxes_pkg;