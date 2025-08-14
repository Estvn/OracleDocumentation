
**Objetivos:**

- Describir varias ventajas de incluir código de manejo de excepciones en PL/SQL
- Describir el propósito de una sección de excepciones en PL/SQL
- Crear código PL/SQL para incluir una sección de EXCEPTION
- Listas los lineamientos para el manejo de excepciones

- Ya aprendiste a escribir bloques PL/SQL con una sección declarativa y una sección ejecutable
- Todo el código SQL y PL/SWL debe ser ejecutado y escrito en un bloque ejecutable.
- **El código puede causar un error no anticipado en tiempo de ejecución.**

# ¿Qué es una Excepción?

- Una excepción ocurre cuando un error es descubierto durante la ejecución de un programa que interrumpe la operación normal del programa.

Hay varias posibles causas de las excepciones:
- El usuario hace un error de escritura en el código.
- El programa no trabaja correctamente
- Una web page no existe

# Excepciones en PL/SQL

- Cuando el código no trabaja como se espera, PL/SQL lanza una excepción.
- Cuando una excepción es lanzada, el resto del código en el bloque PL/SQL no es ejecutado.

# ¿Qué es el Manejo de una Excepción?

- Un manejo de excepción es código que define algunas acciones que son ejecutadas cuando una excepción es lanzada.
- Cuando escriba código, los programadores necesitan anticipar los tipos de errores que pueden ocurrir durante la ejecución de un código.
- Necesitan incluir manejos de excepciones en su código para dirigir estos errores.

**Algunas razone por las que el manejo de excepciones es importante:**

- Protege al usuario de los errores
- Protege a la base de datos de errores
- **Errores pueden ser costosos, en tiempo y recursos.**

# Manejo de Excepciones en PL/SQL

- Un bloque siempre termina cuando PL/SQL lanza una excepción, pero puede especificar un manejo de excepciones para configurar acciones finales antes de que el bloque termine.
- La sección de excepción empieza con la keyword EXCEPTION

```
DECLARE
    v_country_name countries.country_name%TYPE := 'Korea, South';
    v_elevation countries.highest_elevation%TYPE;
BEGIN
    SELECT highest_elevation
    INTO v_elevation
    FROM countries
    WHERE country_name = v_country_name;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Country name, '||v_country_name||' cannot be found.');
END;
```

- **Cuando una excepción es manejada, el programa PL/SQL no termina abruptamente.**
- Cuando una excepción es lanzadas, el control inmediatamente va a la sección de excepciones, hacia el manejo apropiado que la excepción tiene que ejecutar.
- **El bloque PL/SQL terminará de forma normal y satisfactoria.**

# Manejando Excepciones con PL/SQL

```
DECLARE
    v_country_name countries.country_name%TYPE := 'Korea, South';
    v_elevation countries.highest_elevation%TYPE;
BEGIN
    SELECT highest_elevation INTO v_elevation
    FROM countries WHERE country_name = v_country_name;
    DBMS_OUTPUT.PUT_LINE(v_elevation);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Country name, ' || v_country_name || ' cannot be found');
END;
```

- Cuando una excepción es lanzada, el resto de la sección ejecutable del bloque no se ejecuta; en lugar de eso, en la sección de excepciones se busca la más adecuada.

# Atrapando Excepciones

- Puede manejar o atrapar cualquier error incluyendo un manejo correspondiente en la sección de excepciones del bloque PL/SQL

```
EXCEPCION
	WHEN exception1 [OR exception2 ...] THEN
		statement1;
		statement2;
		...
	[WHEN exception3 [OR exception4 ...] THEN
	statement3;
	statement4;
	...]
	[WHEN exception5 [OR exception6 ...] THEN
		statement5;
		statement5;
		...]
```

- Cada manejador consiste en una cláusula WHEN, en la cuál se especifica el nombre de una excepción, seguida de THEN y uno o más declaraciones para ser ejecutadas cuando la excepción sea lanzada.
- **Puede manejar cualquier números de manejadores en la sección de EXCEPTION para manejar diferentes excepciones.**

# Atrapando

- En la sintaxis, **OTHER es un manejo de excepción opcional que atrapa cualquier excepción que no esté manejada de forma explícita.** 

```
EXCEPTION 
	WHEN exception1 [OR exception2 ...] THEN
		statement1;
		statement2;
	...
	[WHEN OTHERS THEN
		statement1;
		statement2;
		...]
```

# Manejo de Excepciones OTHERS

- La sección de manejo de excepciones atrapa solo aquellas excepciones que son especificadas; cualquier otras excepciones no son atrapadas, a menos que use el manejo de excepción **OTHER**.
- **El manejador OTHERS atrapa todas las excepciones que no son atrapadas explícitamente.**
- Si lo usa, OTHERS tiene que ser el último manejo de excepciones definido.

```
BEGIN
	...
	...
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		statement1;
		statement2;
		...
	WHEN TOO_MANY_ROWS THEN
		statement3;
		statement4;
		...
	WHEN OTHERS THEN
		statement5;
		statement6;
		...
END;
```

# Pautas para Atrapar Excepciones

- Siempre agregue excepciones cuando haya posibilidad de que un error ocurra.
- Los errores son especialmente probables durante cálculos, manipulación de strings y operaciones en la base de datos SQL.

- **Maneje excepciones nombradas siempre que sea posible, en lugar usar el manejo de excepción OTHERS.**
- Aprenda los nombres y causas de las excepciones predefinidas.
- **Testee si código con diferentes combinaciones de data mala para ver que potencialees errores pueden aparecer.**

- Escriba información de debugging en los manejos de excepciones

> [!IMPORTANT]
> - Considere cuidadosamente si cada manejador de excepciones debe confirmar la transacción, revertirla o dejar que continúe.
> - No importa cual severos son los errores, si quiere dejar la base de datos en un estado consistente y evitar guardar cualquier data corrupta.




































