
**Objetivos:**

- Construir y usar el ciclo WHILE para construir ciclos en PL/SQL
- Construir y usar el ciclo FOR para construir ciclos en PL/SQL
- Describir cuando usar un ciclo WHILE en PL/SQL
- Describir cuando usar un ciclo FOR en PL/SQL

- El ciclo WHILE requiere un control condicional para evaluar el inicio de cada iteración.
- El ciclo FOR debería ser usado si en número de iteraciones es conocido.

# Ciclo WHILE

- Puede usar una condición WHILE para repetir una secuencia hasta que el control condicional ya no sea TRUE.
- La condición es evaluada al inicio de cada iteración.
- El ciclo termina cuando la condición es FALSE o NULL.
- Si la condición es FALSE o NULL al inicio de la ejecución del ciclo, no habrá iteraciones y el control pasará a la siguiente estructura.

```
WHILE condition LOOP
	statement1;
	statement2;
END LOOP;
```

- La condición es una variable o expresión boleana (TRUE, FALSE, NULL)
- Las declaraciones pueden ser una o más declaraciones PL/SQL o SQL.

- Si la condición es NULL, no hay error, sino que el control es pasado a la siguiente estructura.

```
DECLARE
	v_loc_id locations.location_id%TYPE;
	v_counter NUMBER := 1;
BEGIN
	SELECT MAX(location_id) INTO v_loc_id FROM locations
		WHERE country_id = 2;

	WHILE v_counter <= 3 LOOP
		INSERT INTO locations(location_id, city, country_id)
		VALUES((v_loc_id + v_counter), 'Montreal', 2);

		v_counter := v_counter +1;
	END LOOP;
END;
```

- Con cada iteración que se realiza, el contador incrementa en 1..
- Cuando el contador excede el número definido en la condición, esta retorna FALSE, y el control termina el ciclo.

# Descripción del LOOP FOR

- El FOR LOOP tiene la misma estructura general que el BASIC LOOP.
- Adicional, tiene la declaración del control antes del LOOP, y tiene definido el número de iteraciones que maneja PL/SQL.

```
FOR counter IN [REVERSE] lower_bound..upper_bound LOOP
	statement1;
	statement2;
	...
END LOOP;
```

# Reglas del LOOP FOR

- Use el LOOP FOR si conoce el número de iteraciones
- No declare el contador, está declarado implícitamente.
- lower_bound .. upper_bound es la sintaxis requerida.

- El contador está declarado implícitamente como un integer, el cual incrementa o decrementa automáticamente en 1 por cada iteración del ciclo hasta que el bounder o upper sea alcanzado.
- **REVERSE** causa que el contador decremente con cada iteración desde el upper hasta el lower_bound.
- **lower_bound .. upper_bound es el rango y número de iteraciones que el ciclo tiene que realizar.**

```
DECLARE
	v_loc_id locations.location_id%TYPE;
BEGIN
	SELECT MAX(location_id) INTO v_loc_id FROM locations
		WHERE country_id = 2;

    FOR i IN 1 .. 3 LOOP
		INSERT INTO locations(location_id, city, country_id)
		VALUES((v_loc_id + i), 'Montreal', 2);
    END LOOP;
END;
```

```
DECLARE
	v_lower NUMBER := 1;
	v_upper NUMBER := 100;
BEGIN
	FOR i IN v_lower .. v_upper LOOP
		...
	END LOOP;
END;
```
























