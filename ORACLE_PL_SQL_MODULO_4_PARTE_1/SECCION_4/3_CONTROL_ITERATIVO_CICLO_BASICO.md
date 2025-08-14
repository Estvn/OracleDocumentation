
**Objetivos:**

- Describir la necesidad de declarar LOOPs en PL/SQL
- Reconocer la diferencia entre los tipos de declaraciones de LOOPs
- Crear PL/SQL que tienen ciclos básicos con declaraciones EXIT.
- Crear PL/SQL que tienen ciclos básicos con declaraciones EXIT y su condicional de terminación.

- Los ciclos son el segundo tipo de estructura de control.
- Los ciclos son mayormente usados para ejecutar declaraciones repetitivas hasta que la condición EXIT es alcanzada.
- PL/SQL provee tres tipos de estructuras cíclicas para repetir una declaración o una secuencia de declaraciones en múltiples ocasiones.

Los ciclos básicos son:
- FOR
- WHILE

# Control Iterativo: Declaraciones Cíclicas

- Los ciclos repiten una declaración o una secuencia de declaraciones múltiples veces.
- PL/SQL provee los siguientes tipos de loops:
	- Un loop básico que maneja acciones repetiticas sin generar condiciones
	- FOR loops que mantienen acciones iterativas basada en un contador.
	- WHILE loops que manejan acciones repetitivas basadas en condiciones.

# Basic Loops

- La más simple forma de un ciclo es el ciclo básico, que encierra una secuencia de declaraciones en medio de las llaves LOOP y END LOOP
- **Use el ciclo básico cuando la declaración dentro del ciclo se deba ejecutar al menos una vez.**

# Basic Loops Exit

- Cada vez que el flujo de ejecución alcanzar el END LOOP, el control es pasado al LOOP correspondiente 
- Un LOOP básico permite la ejecución de declaración al menos una vez, **incluso la salida está dentro de las llaves del LOOP básico.**
- **Sin la declaración EXIT, el cliclo nunca terminaría.**

```
BEGIN
	LOOP 
		statements;
		EXIT [WHEN condition];
	END LOOP;
END;
```

Ejemplo básico de un loop

```
DECLARE 
	v_number NUMBER(1) := 1;
BEGIN
	LOOP
		v_number := v_number + 1;
		EXIT WHEN v_number = 5;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_number);
END;
```

Usando un IF para indicar la condición de EXIT:

```
DECLARE 
	v_number NUMBER(2) := 1;
BEGIN
	LOOP
		v_number := v_number + 1;
        DBMS_OUTPUT.PUT_LINE(v_number);
		IF v_number >= 10 THEN 
            EXIT;
        END IF;
    END LOOP;
END;
```

# Reglas de Declaración de EXIT en Basic LOOP

- La declaración EXIT deben estar dentro del ciclo.
- Si la condición de EXIT está al inicio del LOOP, y la condición inicial es TRUE, el LOOP va a terminar y va a pasar a otra declaración, **entonces el LOOP nunca habrá ejecutado nada.**
- Un LOOP básico puede contener muchas declaraciones EXIT.

# BASIC LOOP con la Declaración EXIT WHEN

- A pesar de que IF... THEN EXIT funciona en el ciclo básico, **la forma correcta de escribir la condición de salida del ciclo es con la declaración EXIT WHEN.**
- Si la condición después de WHEN es TRUE, termina el ciclo y el control pasa a la siguiente estructura.

```
DECLARE 
	v_number NUMBER(1) := 1;
BEGIN
	LOOP
		v_number := v_number + 1;
		DBMS_OUTPUT.PUT_LINE(v_number);
		EXIT WHEN v_number = 5;
	END LOOP;
END;
```


















