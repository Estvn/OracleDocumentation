
**Objetivos:**

- Describir y proveer un ejemplo de un error definido por el servidor de Oracle.
- Describir y proveer un ejemplo de un error definido por el programa PL/SQL
- **Diferenciar entre los errores que son manejados implícitamente y explícitamente por Oracle Server**
- Escriba código PL/SQL para atrapar errores predefinidos por Oracle Server
- Escribir código PL/SWL para atrapar errores no predefinidos en Oracle Server
- Escribir código PL/SQL para identificar una excepción por código de error y mensaje de error.


- El manejo de errores PL/SQL es flexible y permite a los programadores manejar errores de Oracle Server y errores definidor por el programador.
- **En esta lección se discuten errores de Oracle Server**

- Los errores de Oracle Server pueden ser predefinidos o no predefinidos
- Ambos tipos tienen código de error y mensaje
- Los errores predefinidos son los más comunes y también tienen un nombre.

# Tipos de Excepciones

- Un error de Oracle Server es un error el cual es reconocido y lanzado automáticamente por el servidor de Oracle.

| Excepción                                         | Descripción                        | Manejo de Instrucciones                                                                                                           |
| ------------------------------------------------- | ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Errores predefinidos por el servidor de Oracle    | Son los errores PL/SQL más comunes | No necesitas declarar estas excepciones, están predefinidas por el Oracle Server y son lanzadas implícitamente (automáticamente), |
| Errores no predefinidor por el servidor de Oracle | Other PL/SQL errors (no name)      | Declarados en la sección declarativa y permite a Oracle Server lanzarlos implícitamente (automáticamente)                         |
| Errores definidor por el usuario                  | Definidos por el programador       | declarados en la sección declarativas y lanzados explícitamente                                                                   |
# Manejando Excepciones en PL/SQL

**Hay dos métodos para lanzar una excepción:**

**Implícitamente** (automáticamente) por el Oracle Server
- Un error de Oracle ocurre cuando la excepción asociada es lanzada automáticamente
- Por ejemplo, si el error ORA-01403 ocurre cuando no hay filas retornadas de la base de datos cuando se hace una consulta SELECT, entonces PL/SQL lanza una excepción NO_DATA_FOUND

**Explícitos por el programador**
- Dependiendo de la funcionalidad del negocio en el que tu programa es implementado, tienes que hacer lanzamientos explícitos de una excepción.
- **Se genera una excepción explícitamente al emitir una instrucción RAISE dentro del bloque.**
- La excepción que se genera puede ser lanzada por el usuario o predefinida.

# Dos Tipos de Errores de Oracle Server

- Cuando un error de Oracle Server ocurre, el Oracle Server automáticamente lanza la excepción asociada, se salta el resto de la sección de código del bloque, y busca una excepción en la sección de excepciones.

**Errores de Oracle Server Predefinidos:**

- Cada uno de estos errores está predefinido con un nombre, y también con un número de error estándar de Oracle y un mensaje

**Errores de Oracle Server no Predefinidos:**

- Cada uno de estos errores tiene un número de error estándar de Oracle y un mensaje, pero no tienen un nombre.

# Atrapando Errores de Oracle Predefinidos

- NO_DATA_FOUND
- TOO_MANY_ROWS
- INVALID_CURSOR
- ZERO_DIVIDE
- DUP_VAL_ON_INDEX

## Atrapando Varios Errores Predefinidos

```
DECLARE
    v_lname VARCHAR2(15);
BEGIN
    SELECT last_name INTO v_lname
    FROM employees WHERE job_id = 'ST_CLERK';
    
    DBMS_OUTPUT.PUT_LINE('The last name of the ST_CLERK is: ' || v_lname);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Select statement found multiple rows');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Select statement found no rows');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Another type of error ocurred');
END;
```

# Atrapando Errores de Oracle Server No Predefinidos

- Son similares que los errores predefinidos, pero estos no tienen un nombre.
- **Solo tienen un número de error estándar y un error de mensaje.**

- Para usarlos en manejos específicos, crea tus propios nombres para estos errores en la sección de declaración y asocia los nombres a un número de error específico usando la función **PRAGMA EXCEPTION_INIT**

- **Puedes atrapar errores de Oracle no predefinidos declarándolos primero.**
- La sección de declaración es lanzada implícitamente.
- **En PL/SQL el PRAGMA EXCEPTION_INIT le dice al compilador que asocie un nombre de excepción a un número de error Oracle.**
- Esto te permite referenciar a cualquier excepción de Oracle por un nombre y escribir un manejador específico para él.

Creando un error no predefinido en Oracle

```
BEGIN
	e_insert_except EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_insert_except, -01400);
```

# Errores no Predefinidos

```
DECLARE
	e_insert_except EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_insert_except, -01400);
BEGIN
	INSERT INTO departments (department_id, department_name)
	VALUES (280, NULL);
EXCEPTION
	WHEN e_insert_except THEN
		DBSM_OUTPUT.PUT_LINE('INSERT FAILED');
END;
```

# Funciones para Atrapar Excepciones

- Cuando un excepción ocurre, puedes retornar los valores de error asociados o el mensaje de error usando dos funciones.

Basado en los valores del código o el mensaje, puedes decidir cual acción tomar:

1. **SQLERRM.** Retorna el contenido del mensaje asociado a un número de error.
2. **SQLCODE.** Retorna el valor numérico del código de error (puedes asignarlos a una variable de tipo número).

+100 es un código internacional cuando no hay filas retornadas de una consulta

| SQLCODE Value   | Description                        |
| --------------- | ---------------------------------- |
| 0               | Sin excepción encontrada           |
| 1               | Excepción definida por el usuario  |
| +100            | NO_DATA_FOUND exception            |
| Negative number | Another Oracle Server error number |

> [!NOTA]
> - No puedes usar **SQLCODE o SQLERRM** directamente en una declaración SQL.
> - En cambio, puede asignar sus valores a variables locales, luego use las variables en declaraciones SQL

```
DECLARE
	v_error_code NUMBER;
	v_error_message VARCHAR2(255);
BEGIN
	...
EXCEPTION
	WHEN OTHERS THEN 
		ROLLBACK;
		v_error_code := SQLCODE;
		v_error_message := SQLERRM;

		INSERT INTO error_log(e_user, e_date, error_code, error_message)
		VALUES (USER, SYSDATE, v_error_code, v_error_message)
END;
```


























