# INTRODUCCIÓN A LOS PROCEDIMIENTOS ALMACENADOS

## Introducción a SP (Parte A)
-------------------------

- Los procedimientos almacenados (SP) son una parte de los subprogramas de Oracle. 
- **Es un programa que estará almacenado de forma permanente en la base de datos**, a través de cual se pueden hacer distintas acciones: Modificación, inserción u operaciones para obtener resultados.
La sintaxis para crear un SP es la siguiente:

```
CREATE OR REPLACE PROCEDURE <NOMBRE SP> (PARAMETROS OPCIONALES) 
IS
	<DECLARACION DE VARIABLES>
BEGIN
	<INSTRUCCIONES SQL>
END;

```
##### ¿Los parámetros son obligatorios en los SP?
- **No es obligatorio que los SP siempre reciban parámetros para poder realizar acciones.** 
- Cuando no se usan parámetros, no se deben dejar los paréntesis vacíos como se hace normalmente en un método de lenguajes de programación.
- Cuando no se usan parámetros se tiene que eliminar toda la parte que corresponde a la sección de parámetros (incluidos los paréntesis).

Esto también es válido
```
CREATE OR REPLACE PROCEDURE <NOMBRE SP>
IS
	<DECLARACION DE VARIABLES>
BEGIN
	<INSTRUCCIONES SQL>
END;
```
### Declaración de Parámetros

- Cuando se declaran parámetros de tipo de dato **VARCHAR2** no se debe definir el rango para el parámetro.
-  Entre el nombre del parámetro y su tipo de dato se debe de indicar si el parámetro es de entrada o salida con las palabras reservadas: **IN**, **OUT** e **IN OUT** .
- **IN OUT** indica que el parámetro es de entrada y salida.

> [!IMPORTANT]
> ¡Los nombres de los objetos no deben tener más de 30 caracteres!

Crear un SP encargado de obtener el nombre de las categorías e imprimir el valor obtenido. El nombre se debe obtener en base a una condición (CATEGORIA = 2).

```
CREATE OR REPLACE PROCEDURE SP_OBTENER_NOMB_CAT(IDCAT IN NUMBER)
IS
	NOMBRE_CAT CATEGORIES.CATEGORY_NAME%TYPE;
BEGIN
	SELECT CATEGORIES.CATEGORY_NAME INTO NOMBRE_CAT 
	FROM CATEGORIES 
	WHERE CATEGORY_ID = IDCAT;
	
	DBMS_OUTPUT.PUT_LINE(NOMBRE_CAT);
END;

SET SERVER_OUTPUT ON;
```

- Los procedimientos almacenados se usan para que los programadores los puedan usar para insertar, modificar, o tomar datos de una DB.
- **Cuando se crea un procedimiento almacenado, primero se debe ejecutar su estructura para que se almacene como objeto en la DB.**

Para ejecutar un procedimiento almacenado se usa la palabra reservada **EXECUTE**, y se ingresa el nombre del SP a ejecutar incluyendo los argumentos para sus parámetros.

```
EXECUTE SP_OBTENER_NOMB_CAT(2);
```

**Los SP también se pueden ejecutar por medio de un bloque anónimo (se evita usar la palabra EXECUTE):**

```
BEGIN 
	SP_OBTENER_NOMB_CAT(2);
END;
```

En el siguiente ejemplo retorna el valor obtenido en el SP en lugar de imprimirlo dentro de si mismo:
```
CREATE OR REPLACE PROCEDURE SP_OBTENER_NOMB_CAT(IDCAT IN NUMBER, 
							NOMBRE_CAT OUT CATEGORIES.CATEGORY_NAME%TYPE)
IS
BEGIN
	SELECT CATEGORIES.CATEGORY_NAME INTO NOMBRE_CAT
	FROM CATEGORIES
	WHERE CATEOGRY_ID = IDCAT;

END;

DECLARE
	NOMBRE_CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE;
BEGIN
	SP_OBTENER_NOMB_CAT(2, NOMBRE_CATEGORIA);
	DBMS_OUTPUT.PUT_LINE(NOMBRE_CATEGORIA);
END;

SET SERVER_OUTPUT ON;
```

> [!IMPORTANT]
> Los parámetros de salida pueden recibir valores NULL.
> Los parámetros de entrada no pueden ser modificados dentro del SP.

## Introducción a SP (Parte B)
------------

- Los SP no necesariamente tienen que tener parámetros.
- Cuando un SP no recibe parámetros, entonces se tiene que eliminar toda la estructura que forma parte de los parámetros en el SP.

Crear un SP que obtenga la cantidad total de productos
```
CREATE OR REPLACE PROCEDURE SP_CANT_PRODUCTOS 
IS
	CANTIDAD NUMBER;
BEGIN
	SELECT COUNT(*) INTO CANTIDAD FROM PRODUCTS;
	DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE PRODUCTOS GUARDADOS ES:' || CANTIDAD);
END;

EXECUTE SP_CANT_PRODUCTOS;
```

> [!WARNING]
> - **Cuando vamos a ejecutar procedimientos almacenados, debemos asegurarnos de ejecutar la instrucción EXECUTE o llamarlos dentro de bloques anónimos para su correcto funcionamiento.**
> - Los SP **NO** pueden simplemente ser llamados en una sentencia SELECT y que forme parte de una columna de una sentencia.
> - Los SP **NO** pueden ser utilizados dentro de un WHERE de sentencia SELECT.
> - **Para obtener el o los valores que retorna un SP, debe llamarse con un EXECUTE o dentro de un bloque anónimo, y guardar su valor dentro de una variable para poder utilizarlos.**

## Clase 6 - Introducción a SP
------------
## SP con Validaciones

- Cualquier validación que no esté considerada, o cualquier error generado en un procedimiento se debe controlar por medio de una excepción.

Este ejemplo de SP crea ID secuenciales en una tabla sin usar el objeto SEQUENCE:
```
CREATE OR REPLACE PROCEDURE SP_INSERTAR_PRODUCTO(
												NOMB_PROD IN VARCHAR2,
												ID_BRAND IN NUMBER,
												CAT_ID IN NOMBER,
												ANIO_MODELO IN NUMBER,
												PRECIO IN NUMBER,
												MSJ_ERROR OUT VARCHAR2,
												MSJ_EXITO OUT VARCHAR2
												)
IS
	VAL_MAX_PROD_ID NUMBER;
	
BEGIN
	SELECT (MAX(PRODUCT_ID)+1) INTO VAL_MAX_PROD_ID FROM PRODUCTS;
	INSERT INTO PRODUCT VALUES (VAL_MAX_PROD_ID, NOMB_PROD, ID_BRAND, CAT_ID, 
								ANIO_MODELO, PRECIO);

	COMMIT;
	MSJ_EXITO := 'LA INSERCIÓN SE REALIZÓ DE FORMA EXITOSA.'

EXCEPTION
	WHEN OTHERS THEN 
		MSJ_ERROR := SQLERRM;
END;

-- INICIO DE BLOQUE ANÓNIMO
DECLARE
	MSJ_ERROR VARCHAR(500);
	MSJ_EXITO VARCHAR(500);
BEGIN
	SP_INSERTAR_PRODUCTO('BICICLETA DE MONTAÑA, 1, 4, 2019, 4345, MSJ_ERROR, MSJ_EXITO);
	DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR);
END;
```

Creando SEQUENCE y TRIGGER para el mismo propósito
```
CREATE SEQUENCE SQ_PRODUCTS
START WITH 233
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER TG_SQ_PRODUCTS
BEFORE INSERT ON PRODUCTS
FOR EACH ROW
DECLARE
BEGIN 
	:NEW.PRODUCT_ID := SQ_PRODUCTS.NEXTVAL;
END;
```

Cambios en el PROCEDURE usando la secuencia
```
CREATE OR REPLACE PROCEDURE SP_INSERTAR_PRODUCTO(
												NOMB_PROD IN VARCHAR2,
												ID_BRAND IN NUMBER,
												CAT_ID IN NOMBER,
												ANIO_MODELO IN NUMBER,
												PRECIO IN NUMBER,
												MSJ_ERROR OUT VARCHAR2,
												MSJ_EXITO OUT VARCHAR2
												)
IS	
BEGIN
	INSERT INTO PRODUCT (PRODUCT_NAME, BRAND_ID, CATEGORY_ID, MODEL_YEAR, 
						LIST_PRICE )					
	VALUES (NOMB_PROD, ID_BRAND, CAT_ID, ANIO_MODELO, PRECIO);
	COMMIT;
								
	MSJ_EXITO := 'LA INSERCIÓN SE REALIZÓ DE FORMA EXITOSA.'

EXCEPTION
	WHEN OTHERS THEN 
		MSJ_ERROR := SQLERRM;
END;

-- INICIO DE BLOQUE ANÓNIMO
DECLARE
	MSJ_ERROR VARCHAR(500);
	MSJ_EXITO VARCHAR(500);
BEGIN
	SP_INSERTAR_PRODUCTO('BICICLETA DE MONTAÑA, 1, 4, 2019, 4345, MSJ_ERROR, MSJ_EXITO);
	DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR);
END;
```

## Clase 7 - Introducción a SP
------------

- En lugar de controlar problemas respecto a valores vacíos en los parámetros por medio de las excepciones, se puede controlar ese tipo de problemas validando que los parámetros no vengan vacíos antes de permitir la ejecución de algún comando DML.
- Si algún valor en los parámetros viene vacío se puede permitir o impedir que se realice la ejecución de la estructura dentro de un objeto de bases de datos.
- Si el valor de los parámetros no existe, se puede insertar un nuevo valor en esa variable. **El punto es que se puede realizar cualquier actividad con las variables, de la misma forma que se realiza en los lenguajes de programación.**

- **Las transacciones (COMMIT y ROLLBACK) se pueden desarrollar en el SP principal que llama a todos los demás. No es necesario implementar transacciones en los SP que se encuentran en un nivel más bajo.**
































