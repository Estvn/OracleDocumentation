DECLARE
	v_outerloop PLS_INTEGER := 0;
	v_innerloop PLS_INTEGER := 5;
BEGIN
	<<outer_loop>>
	LOOP
		v_outerloop := v_outerloop + 1;
		v_innerloop := 5;
		EXIT WHEN v_outerloop > 3;
		<<inner_loop>>
		LOOP
			DBMS_OUTPUT.PUT_LINE('Padre: ' || v_outerloop || 'Hijo: ' || v_innerloop);
			v_innerloop := v_innerloop - 1;
			EXIT WHEN v_innerloop = 0;
		END LOOP inner_loop;
	END LOOP outer_loop;
END;


BEGIN 
	FOR v_outerloop IN 1..3 LOOP
		FOR v_innerloop IN 1..5 LOOP
			DBMS_OUTPUT.PUT_LINE('Outer loop is: ' || v_outerloop || '\nInner loop is: ' || v_innerloop);
		END LOOP;
	END LOOP;
END;

