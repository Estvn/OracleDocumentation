CREATE OR REPLACE PROCEDURE get_emps 
IS
	CURSOR get_emps_curs IS
	SELECT * FROM employees
	WHERE
	$IF tax_code_pack.new_tax_code $THEN
		salary > 20000;
	$ELSE
		salary > 50000;
	$END
BEGIN
	FOR v_emps IN get_emps_curs LOOP
		... /* real code here */
	END LOOP;
END get_emps;