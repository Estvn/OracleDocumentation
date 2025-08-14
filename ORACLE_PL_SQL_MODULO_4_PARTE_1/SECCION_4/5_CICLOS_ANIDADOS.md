
**Objetivos**

- Construir y ejecutar PL/SQL usando ciclos anidados.
- Etiquetar ciclos y usar las etiquetas para las salidas de las declaraciones.
- Evaluar la construcción de un ciclo anidado e identificar el punto de salida.

**Usted puede anidar FOR, WHILE y BASICS LOOPS uno dentro de otro.**

# Ejemplo de ciclo anidado

- En PL/SQL puede anidar ciclos en n niveles.

```
BEGIN 
	FOR v_outerloop IN 1 .. 3 LOOP
		FOR v_innerlopp IN 1..5 LOOP
			DBMS_OUTPUT.PUT_LINE('Outer loop is: || v_outerloop || '\nInner loop is: || v_innerloop');
		END LOOP;
	END LOOP;
END;
```

**¿Qué puede hacer para cortar el ciclo anidado?**

# Etiquetas para Ciclos

- En este ejemplo son requeridas las etiquetas en el ciclo para ordenar la salida para que el ciclo anidado pueda salir y dar el mando al ciclo padre

- Las etiquetas de los ciclos siguen las mismas reglas que los nombres de los identificadores
- Una etiqueta se ubica antes de una declaración, ya sea en la misma línea o una línea separada.
- Las etiquetas se agregan entre los delimitadores **<\<label>>**
- Si el ciclo es etiquetado, el nombre de la etiqueta puede ser opcionalmente incluida después de la declaración END LOOP para mayor claridad.

```
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
		END LOOP;
	END LOOP;
END;
```


# Ciclos Anidado y Etiquetas

```
BEGIN
	<<outer_loop>>
	LOOP
		v_counter := v_counter + 1;
	EXIT WHEN v_counter > 10;
		<<inner_loop>>
		LOOP 
			EXIT outer_loop WHEN v_total_done = 'YES';
			-- Leave both loops
			EXIT WHEN v_inner_done = 'YES';
			-- Leave inner loop only
		END LOOP;
	END LOOP;
END;
```




















