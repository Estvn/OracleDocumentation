# INTRODUCCIÓN A LAS FUNCIONES

## Introducción a las Funciones de PL/SQL
------------

- Las funciones son parte de los subprogramas disponibles en Oracle.
- Son objetos que se guardan de forma permanente en las bases de datos.
- A diferencia de los SP, se usa siempre que queramos retornar un valor.

La sintaxis de una función de Oracle es la siguiente:
```
CREATE OR REPLACE FUNCTION <NOMBRE FUNCION> (<PARÁMETROS>) RETURN <TIPO DATO>
IS
	<DECLARACION DE VARIABLE>;
BEGIN
	<CUERPO DE LA FUNCIÓN>
	
	RETURN <VALOR O VARIABLE A RETORNAR>;

	<BLOQUE DE EXCEPCIONES>
END;
```

Ejemplo básico de una función:
```
CREATE OR REPLACE FUNCTION FN_CANTIDAD_PRODUCTOS
RETURN NUMBER
IS
	CANTIDAD_PRODUCTOS NUMBER;
BEGIN
	SELECT COUNT(*) INTO CANTIDAD_PRODUCTOS FROM PRODUCTS;
	RETURN CANTIDAD_PRODUCTOS;
END;
```