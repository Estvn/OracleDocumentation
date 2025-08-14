
**Objetivos:**

- Listar las ventajas de las funciones definidas por el usuario en declaraciones SQL
- Listar donde las funciones definidas por el usuario pueden ser llamadas dentro de declaraciones SQL
- Describir las restricciones de las llamadas a funciones en las declaraciones SQL

- En esta lección aprenderá como usar funciones dentro de las declaraciones SQL
- **Si las declaraciones SQL son procesadas en varias filas de una tabla, la función se ejecuta una vez por cada fila procesada en la declaración SQL.**

# Las Ventajas de las Funciones en las Declaraciones SQL

- **Si son usadas en la cláusula WHERE de una instrucción SELECT, las funciones pueden aumentar la eficiencia al garantizar que se devuelvan todas las filas deseadas.**

- Por ejemplo, en una grande base de datos de empleados, podría tener más de un empleado con el mismo apellido.

```
SELECT * FROM employees WHERE last_name = 'Taylor';
```

- Con esta sentencias SQL obtendrá los empleados cuyo apellido es 'Taylor', pero no 'taylor'

```
SELECT * FROM employees WHERE UPPER(last_name) = UPPER('TAylor');
```

- En esta sentencia, con la ayuda de una función puede obtener todas las personas que se apellidan 'TAYLOR'.

- **Las funciones en las declaraciones SQL también pueden manipular valores de datos.**
- **Las funciones definidas por el usuario pueden extender SQL donde las actividades con muy complejas, muy tediosas, o no disponibles con SQL regular.**

> [!NOTA]
> Las funciones nos pueden ayudar a cubrir un mismo código que se ejecuta repetidamente en varios lugares


# Funciones en Expresiones SQL: Ejemplo

```
CREATE OR REPLACE FUNCTION tax(p_value IN NUMBER)
RETURN NUMBER 
IS BEGIN
	RETURN (p_value * 0.08);
END tax;


SELECT employee_id, last_name, salary, tax(salary) FROM employees
WHERE department_id = 50;
```

- **Las funciones definidas por el usuario actúan como funciones que afecta fila por fila, tal como UPPER, LOWER y LPAD**

Pueden ser usadas en:

- Una lista de columnas de una consulta SELECT
- Una expresión condicional en las cláusulas WHERE y HAVING
- En una consulta con las cláusulas ORDER BY y GROUP BY
- Las cláusulas de valores con las declaración INSERT
- La cláusula SET con la declaración UPDATE
- **Pueden ser usadas en cualquier lugar donde tengas un valor o una expresión**

 >[!IMPORTANT]
 >Las funciones hacen el código mucho más fácil de leer y mucho más fácil de actualizar si la función tax tiene que cambiar su lógica

```
SELECT employee_id, tax(salary)
	FROM employees
	WHEFRE tax(salary) > (SELECT MAX(tax(salary)) FROM employees
							WHERE department_id = 20)
	ORDER BY tax(salary) DESC;
```

# Restricciones del Uso de las Funciones en las Declaraciones SQL

- Para usar una función definida por el usuario dentro de una declaración SQL, la función debe comprender las reglas y restricciones del lenguaje SQL
- La función puede aceptar solo tipos de datos válidos en SQL como parámetros IN, y debe retornar un tipo de dato SQL válido.

- **Los tipos de datos específicos de PL/SQL tal como Boolean o %ROWTYPE con están permitidos.**
- Como las funciones se usan el declaraciones SQL, no se deben usar tipos de datos o sintáxis propia de PL/SQL para el manejo de sus datos.
- Los límites de tamaño no deben se excedidos

> [!WARNING]
> - Las funciones definidas por el usuario pueden usar notaciones posicionales, nombradas y mezcladas para identificar los argumentos.
> - Los parámetros de las funciones del sistema deben ser especificados por notaciones posicionales.

- La funciones llamadas de declaraciones SELECT no pueden contener declaraciones DML
- Las funciones llamadas de declaraciones UPDATE o DELETE o una tabla no pueden consultar ni contener DML en la misma tabla.
- Las funciones llamadas de cualquier declaración SQL no pueden tener transacciones.
- **Las funciones llamadas de cualquier declaración SQL no puede tener DDL o DCL porque estos hace un COMMIT implícito.**


























