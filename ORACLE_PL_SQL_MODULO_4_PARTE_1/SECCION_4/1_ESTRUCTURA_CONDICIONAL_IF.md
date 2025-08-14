
**Objetivos:**

- Describir y usar las estructuras de control condicionales
- Listar los tipos de estructuras de control condicionales
- Construir y usar la declaración IF
- Construir y usar la declaración IF-THEN-ELSE
- Crear PL/SQL para manejar las condiciones NULL en las declaraciones IF

- Los procedimientos condicionales extienden una usabilidad del programa que permite usar tests simples lógicos para determinar cual de los estados será ejecutado.

# Controlando el Flujo de Ejecución

- Puede cambiar el flujo lógico de las declaraciones del bloque PL/SQL con un número de estructuras de control.

Esta lección cubre tres tipos de estructuras de control PL/SQL:
- Estructuras condicionales con la declaración IF
- expresiones CASE
- estructuras de control LOOP

# Declaración IF

- Una condición es una expresión donde un valor TRUE o FALSE es usado para tomar una decisión.

- La estructura del IF de PL/SQL es similar que en otros lenguajes de programación
- Permite que PL/SQL maneje acciones seleccionadas en base a condiciones.
- La condición es una variable o expresión boleana que retorna TRUE, FALSE o NULL.

```
IF condition THEN
	statement;
[ELSIF condition THEN
	statement;]
[ELSE 
	statement;
]
END IF;
```

- Los IF pueden estar anidados.
- La declaración después de THEN es ejecutada solo si la condición asociada al IF es TRUE
- Si la condición del IF es FALSE, el flujo puede ir a ELSEIF o ELSE.
- ELSEIF y ELSE son opcionales.
- Puede tener n cantidad de ELSEIF, y ELSE solo va al final.

```
DECLARE 
	v_myage NUMBER(2) := 23;
BEGIN
	IF v_myage < 11 THEN
		DBMS_OUTPUT.PUT_LINE('Tengo ' || v_myage);
	ELSE 
		DBMS_OUTPUT.PUT_LINE('xd');
	END IF;
END;
```

IF-ELSEIF-ELSE:

```
DECLARE 
	v_myage NUMBER(2) := 23;
BEGIN
	IF v_myage < 11 THEN
		DBMS_OUTPUT.PUT_LINE('Niño');
	ELSIF v_myage = 23 THEN
		DBMS_OUTPUT.PUT_LINE('Adulto');
	ELSE
		DBMS_OUTPUT.PUT_LINE('xd');
	END IF;
END;
```

- Las condiciones del IF son evaluadas de uno en uno.
- **Use AND o OR para agregar varias condiciones en un solo IF.**

> [!WARNING]
> Si la variable que usa en la condición de IF es nula, el IF tendrá error.

# Expresión CASE

- Es similar a la declaración IF donde también puede determinar el curso de una acción basada en una condición.
- El CASE puede ser usado fuera de un bloque PL/SQL, en una declaración SQL.

# Estructuras de Control LOOP

- Son estructuras de repetición que habilitan la repetición de declaraciones en bloques PL/SQL de forma repetida.

**Los tres tipos de estructuras de control cíclicas usadas en PL/SQL son:**

- LOOP
- FOR
- WHILE


