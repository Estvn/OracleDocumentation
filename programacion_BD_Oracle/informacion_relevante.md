# 29/09/24
- WHERE last_name LIKE 'D%a%e%'
- se puede usar !=, ^= y <> para negacion
- LIKE 'D%' para cadenas que empiezan con D
# 30/09/24

## Lenguajes en SQL:
- DML: INSERT, UPTATE, DELETE, MERGE (para confirmar estos comandos en la DB se debe hacer un COMMIT).
- DDL: CREATE, ALTER, DROP, RENAME, TRUNCATE (estos comandos hace un COMMMIT implícito).
- TCL: COMMIT, ROLLBACK (se usan para confirmar comandos DML).
- DCL: GRANT, REVOKE (se usan para otorgar y remover permisos de usuarios y roles).
## Uso de comillas simples y dobles
- Se usan comillas simples cuando se quieren definir valores literares, como cadenas de texto o fechas.
- Se usan comillas dobles para definir alias o nombres de columnas que tienen espacios.
## Uso de DISTINCT
- Se puede usar DISTINCT si se está definiendo el nombre de la columna.
- Si se usa DISTINCT y se intentan traer todas las columnas de una tabla, se mostrará un error como respuesta.

- Para asignar un alias a una columna se puede omitir la palabra reservada AS.
- DESC o DESCRIBE son palabras reservadas para obtener la estructura de una tabla.
- Se pueden escribir cadenas en LIKE de la siguiente manera: LIKE '%E%s%v%'
## Proyección, selección y filtro
- El Select es la proyeccción donde se definen las columnas que se desean ver
- FROM es donde se define la seleccion de la tabla.
- WHERE es donde se aplica el filtro de las filas/instancias en específico que se desean ver en la tabla.
## BETWEEN ... AND e IN(...)
- Se usan para reducir otras alternativas de código, aunque la eficiencia es la misma.
- No tiene mejor eficiencia, solo se usa para facilitar la escritura de código.
- Cuando se usa BETWEEN ... AND se tiene que ingresar primero el valor más bajo.
## Información a considerar en el uso de LIKE
- SELECT last_name FROM EMPLOYEES WHERE last_name LIKE '%a_o_';
- En LIKE se usa % para especificar que puede haber 0 o más letras o números después del caracter definido.
- En LIKE se usa _ para especificar que debería haber una letra antes o después del caracter definido.

- SELECT LAST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%\_R%' ESCAPE '\';
- Se puede ingresar un caracter cualquiera para definirlo como caracter de espace en la cadena definida en la comparación LIKE.
## WHERE ... IS NULL y WHERE ... IS NOT NULL
- Se usan para obtener la información que tiene campos nulos o no nulos.

- En el WHERE se pueden usar las comparaciones lógicas: AND, OR, NOT.
- AND y OR se pueden usar en los filtros del WHERE.
- NOT se puede usar en LIKE, IN y BETWEEN.