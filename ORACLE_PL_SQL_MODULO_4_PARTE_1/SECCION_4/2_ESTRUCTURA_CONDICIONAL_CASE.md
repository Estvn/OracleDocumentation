
**Objetivos:**

- Construir y usar estructura CASE en PL/SQL
- Construir y usar expresiones CASE en PL/SQL
- Incluir la sintaxis correcta para manejar las condiciones NULL en las declaraciones CASE de PL/SQL 
- Incluir la sintaxis correcta para manejar condiciones boleanas en las declaraciones IF y CASE de PL/SQL

- Las declaraciones CASE son similares que las declaraciones IF, pero a veces son más fáciles de escribir y más fáciles de leer.
- Las expresiones CASE trabajan como funciones que retornan un valor de un número o valores dentro de una variable.

Estructura del CASE

```
DECLARE 
	v_numvar NUMBER;
BEGIN
	...
	CASE v_numvar
		WHEN 5 THEN statement1; statement2;
		WHEN 10 THEN statement3;
		WHEN 12 THEN statement4; statement5;
		WHEN 27 THEN statement6;
		WHEN ...
		ELSE statement15;
	END CASE;
END;
```

# Búsqueda en Declaraciones CASE

- Puedes usar declaraciones CASE con condicionales.
- Esta sintaxis es virtualmente idéntica a una declaración IF.
- **Tiene el mismo rendimiento que una condicional IF.**

```
DECLARE
    v_num NUMBER := 77;
    v_txt VARCHAR(50);
BEGIN
    CASE
        WHEN v_num < 20 THEN v_txt := 'Number is minus that 20';
        WHEN v_num = 30 THEN v_txt := 'Number equals 30';
        WHEN v_num > 40 THEN v_txt := 'Number is more that 40';
        ELSE v_txt := 'The number isnt here';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_txt);
END;
```

**Puede guardar el resultado de CASE en una variable**

```
DECLARE
    v_num NUMBER := 77;
    v_txt VARCHAR(50);
BEGIN
    v_txt := 
    CASE
        WHEN v_num < 20 THEN 'Number is minus that 20'
        WHEN v_num = 30 THEN  'Number equals 30'
        WHEN v_num > 40 THEN  'Number is more that 40'
        ELSE 'The number isnt here'
    END;
    DBMS_OUTPUT.PUT_LINE(v_txt);
END;
```















































