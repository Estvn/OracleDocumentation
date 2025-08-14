
**Objetivos:**

- Describir como las excepciones se propagan
- Remover funciones y procedimientos
- Usar las vistas del diccionario de datos para identificar y manejar los programas almacenados

- En esta lección aprenderá a manejar procedimientos y funciones
- Para hacer programas robustos, siempre debería manejar condiciones de excepciones usando las configuraciones de manejo de excepciones de PL/SQL

# Manejar Excepciones 

Cuando una excepción ocurre y es manejada en un procedimiento llamado o función, el siguiente flujo de código toma lugar:

1. La excepción es lanzada
2. El control es transferido al manejo de excepciones del bloque que lanza la excepción
3. La excepción del código es ejecutada y el bloque termina 
4. El control vuelve al programa de la llamada
5. El bloque/programa de la llamada continua la ejecución

```
CREATE OR REPLACE PROCEDURE add_department(
	p_name VARCHAR2, p_mgr NUMBER, p_loc NUMBER) 
IS BEGIN
	INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id)
	VALUES (DEPARTMENTS_SEQ.NEXTVAL, p_name, p_mgrm p_loc);

	DBMS_OUTPUT.PUT_LINE('Added dept: ' || p_name);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error adding dept: ' || p_name);
END;
```

```
BEGIN
	add_department('Media', 100, 1800); -- FUNCIONA
	add_department('Editing', 99, 1800); -- NO FUNCIONA
	add_department('Adsvertising', 101, 1800); -- FUNCIONA
END;
```

# Excepciones No Manejadas

- Si una sección de excepción no provee un manejador para la excepción lanzada, entonces no está siendo manejada

En el siguiente flujo de código ocurre:

1. La excepción es lanzada
2. El control es transferido a un manejador de excepciones del bloque que lanza la excepción
3. Desde que no existe el manejador de excepciones, el bloque termina y cualquier operación DML manejada dentro del bloque que lanza la excepción se le realiza un ROLLBACK.
4. El control retorna al programa de la llamada y la excepción se propaga a la sección de excepciones del programa de la llamada.
5. Si la excepción no es manejada por el programa de la llamada, el programa de la llamada termina y cualquier operación DML realizada antes de que se produjera la excepción no controlada se le realiza un ROLLBACK

# Removiendo Procedimientos y Funciones 

- Puedes remover un procedimiento o función que está almacenado en la base de datos.

Sintáxis:

```
DROP {PROCEDURE procedure_name | FUNCTION function_name}
```

Ejemplos:

```
DROP PROCEDURE my_procedure;
DROP FUNCTION my_function;
```

Este ejemplo lista todas las funciones PL/SQL de tu pertenencia:

```
SELECT object_name
	FROM USER_OBJECTS WHERE object_type = 'FUNCTION';
```

# Viendo el Código Fuente de la Tabla USER_SOURCE

- Este ejemplo te muestra el código fuente del código de la función TAX de tu pertenencia
- Asegurese de incluir ORDER BY line para ver las líneas de código en la secuencia correcta

```
SELECT text
	FROM USER_SOURCE
	WHERE name = 'TAX'
	ORDER BY LINE;
```

```
DROP PROCEDURE my_procedure

DROP FUNCTION my_function

SELECT text FROM user_source WHERE name = 'TAX' order by line;

SELECT object_name FROM USER_OBJECTS WHERE object_type = 'FUNCTION';

SELECT * FROM USER_SOURCE;
```
































