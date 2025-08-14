
**Objetivos:**

- Describir el alcance de una excepción
- Reconocer los problemas del alcance de excepciones cuando una excepción está dentro de bloques anidados.
- Describir el efecto de la propagación de excepción en bloques anidados

- Una excepción es una variable PL/SQL; por lo tanto, sigue las mismas reglas de alcance y visibilidad que los otros tipos de variables.
- **Para manejar correctamente las excepciones, debes entender el alcance y visibilidad de las variables de excepción.**
- Esto es particularmente importante cuando usas bloques anidados.

Puedes tratar con una excepción:
- Manejándolas en el bloque en el cual ocurren
- Propagarlas hacia el entorno donde se llama (puede ser un nivel de bloque más alto)

# Manejando Excepciones en un Bloque Interno

- En este ejemplo, un error ocurre durante la ejecución de un bloque interno.
- La sección de excepción del bloque interno trata con la excepción satisfactoriamente, y PL/SQL considera que es la excepción ya está finalizada.
- El bloque externo continúan normalmente con la ejecución

```
BEGIN -- outer block
	...
	BEGIN -- inner block
		... -- exception name occurs here
		...
	EXCEPTION
		WHEN exception_name THEN --handled here
		...
	END; -- inner block termina satisfactoriamente
	... -- outer block termina satisfactoriamente
END;
```

# Propagación de Excepciones a un Bloque Externo

- Si la excepción es lanzada en la sección ejecutable del inner block, y el manejador correspondiente de la excepción no existe, el bloque PL/SQL termina con fallos y la excepción es propagada al bloque de cierre.

```
DECLARE -- outer block
	e_no_rows EXCEPTION;
BEGIN
	BEGIN -- inner block
		IF ... THEN RAISE e_no_rows; -- exception occurs here
		...
	END; -- Inner block termina insatisfactoriamente
	... -- El resto del código ejecutable del outer block 
	... -- Sección saltaa
EXCEPTION
	WHEN e_no_rows THEN -- outer block maneja la excepción
	...
END;
```

- El inner block termina insatisfactoriamente y PL/SWL pasa/propaga la excepción al outer block
- La sección de excepción del outer block maneja la excepción satisfactoriamente.

# Propagando Excepciones a un Sub-bloque

- Si un PL/SQL lanza una excepción y el bloque actual no tiene un manejador para esa excepción, la excepción se propaga al siguiente bloque de cierre hasta que encuentre un manejador.
- Cuando la excepción se propaga a un bloque de cierre, las acciones ejecutables restantes se omiten.

- Una ventaja de este comportamiento es que se pueden encerrar sentencias que requieren su propio manejo exclusivo de errores en su propio bloque, mientras que se deja el manejo de excepciones más generales.

```
DECLARE
    v_last_name employees.last_name%TYPE;
BEGIN
    BEGIN
        SELECT last_name INTO v_last_name 
        FROM employees WHERE employee_id = 999;
        DBMS_OUTPUT.PUT_LINE('Message 1');
    EXCEPTION 
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Messsage 2');
        END;
    DBMS_OUTPUT.PUT_LINE('Message 3');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Message 4');
END;
```

# Alcance de los Nombres de Excepciones

- Excepciones predefinidas por el Oracle Server, tal como NO_DATA_FOUND, TOO_MANY_ROWS y OTHERS no son declaradas por el programador.
- **Pueden ser lanzados en cualquier bloques y manejador en cualquier bloque.**

- Las excepciones nombradas por el usuario son declaradas por el programador como variables de tipo EXCEPTION.

> [!WARNING] 
 **Sin embargo, una excepción nombrada por el usuario declarada en un bloque interno no puede ser referenciada en la sección de excepciones de un bloque externo.**

- Para evitar esto, siempre declare las excepciones nombradas por el usuario en el bloque más externo.


































