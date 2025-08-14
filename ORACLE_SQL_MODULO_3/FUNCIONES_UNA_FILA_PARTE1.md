
# FUNCIONES DE UNA SOLA FILA - PARTE I

# Manipulación de Mayúsculas/Minúsculas y de Carácteres
------------------------------------------------------------------------

- Las funciones de una sola fila se pueden usar en los SELECT, WHERE y ORDER BY.
- Estas conversiones se pueden usar para aplicar formato a la salida, y también para buscar cadenas específicas.
- Se pueden usar en la mayoría de las partes de una sentencia SQL: SELECT, WHERE, ORDER BY, etc.
## Funciones de manipulación de mayúsculas/minúsculas
- Las funciones de manipulación mayuscula/minuscula son útiles para dar formato a la salida cuando se usa en SELECT, y para buscar cadenas de carácteres con WHERE cuando existe la posibilidad de que los registros contengan mayusculas y minusculas.
- Las funciones de conversión a mayúsculas y minúsculas permite convertir temporalmente los datos de la base de datos. Y se evita el hecho de que no coincida la cadena de caracteres por que no se sabe como se ha escrito.

- **Lista de las funciones de manipulación mayúscula/minúscula:**
    - LOWER(COLUMNA)
	    - convierte los caracteres en minuscula.
    - UPPER(COLUMNA)
	    - Convierte los caracteres de una cadena en mayúscula.
    - INITCAP(COLUMNA)
	    - Convierte la primera letra de una cadena en mayúscula (letra capital).
        - WHERE COLUMNA LIKE INITCAP('%all these years');
## Funciones de manipulación de caracteres
- Se usan para extraer, cambiar, formatear o modificar de alguna forma una cadena de caracteres.
- A la función se le puede pasar uno o más caracteres o palabras, entonces, esta realiza sus funciones en los valores de entrada, y devuelve en la salida la cadena de caracteres con su valor cambiado, extráido, contado o alterado.

- **Lista de funciones de manipulación de caracteres:**
    - CONCAT(CADENA1, CADENA2)
	    - Une dos valores. Funciona como el "||".
	    
    - LENGTH(CADENA)
	    - Muestra la longitud de una cadena con un valor numérico.
	    
    - SUBSTR(CADENA, POSICION INICIO, LENGTH) 
	    - Extrae una cadena de caracteres.
	    - El parámetro LENGTH es opcional, si no se agrega devuelve toda la cadena desde la posición de inicio que se ha indicado.
	    
    - INSTR(CADENA, CARACTER)
	    - Devuelve el número de la posición en la que se encuentra un caracter en una cadena.
	    -     Si no se encuentra el caracter, devolverá el número 0.
	    
    - LPAD(CADENA, CANTIDAD, CARACTER) | RPAD 
	    - Rellena la izquierda o derecha de una cadena con caracteres, y la cadena deberá tener la cantidad indicada en los parámetros (incluidos los caracteres de la palabra).
	    
    - TRIM
        TRIM(LEADING 'caracter' FROM 'cadena') -> Elimina caracteres al inicio.
        TRIM(TRAILING, 'caracter' FROM cadena) -> Elimina caracteres al final.
        TRIM(BOTH 'caracter FROM cadena)  -> Elimina caracteres en los extremos de una cadena.
    
    - REPLACE(CADENA, cadena a buscar, cadena de reemplazo)
	    - Busca una cadena de caracteres y la reemplaza por otra.
## Variables de Sustitución

- Para usar una variable de sustitución, se debe agregar el valor codificado en la sentencia con un :nombre_variable.
- El signo de : hace que Oracle reconozca el texto que le sigue como una variable.
- Las variables de sustitución se tratan como cadenas de caracteres, lo que significa que al transferir caracteres o valores de fecha, no se necesita agregar el nombre de la variable dentro de comillas para delimitar la cadena.
## Ejercicios practicados

```
SELECT RPAD(LAST_NAME, 6, '-') FROM EMPLOYEES WHERE LOWER(last_name) = 'abel';
SELECT (LAST_NAME || ' ' || FIRST_NAME) FROM EMPLOYEES WHERE UPPER(LAST_NAME) = 'ABEL';
SELECT LENGTH(SUBSTR(CONCAT(LAST_NAME, FIRST_NAME), 5, 4)) FROM EMPLOYEES WHERE UPPER(LAST_NAME) = 'ABEL';

SELECT INSTR(CONCAT(INITCAP(LAST_NAME), FIRST_NAME), 'l') FROM EMPLOYEES WHERE INITCAP(LAST_NAME) = 'Abel';

SELECT REPLACE(UPPER(TRIM(BOTH 'E' FROM LPAD(RPAD(LAST_NAME, 10, '-'), 10, '-'))), '------', '') FROM EMPLOYEES WHERE UPPER(LAST_NAME) = 'ABEL';

SELECT REPLACE(LOWER(LAST_NAME), 'abel', 'Estiven') from EMPLOYEES WHERE UPPER(LAST_NAME) = 'ABEL';

SELECT INSTR('ESTIVEN', 'E') "POSICIÓN DE E" FROM DUAL;
SELECT SUBSTR('ESTIVEN', 1, 6) "NOMBRE SIN LA ULTIMA E" FROM DUAL;
DESC EMPLOYEES;
```
# Funciones Numéricas
-------------------------------------

- Las tres funciones numéricas son:
	- ROUND(VALOR, NÚMERO PRECISIÓN)
		- Se usa para decimales y fechas.
		- Si se agrega un cero o no se define el numero de precisión, el valor se redondeará al entero más cercano.
		- Si el número de precisión es positivo, va a redondear los decimales.
		- Si el número de precisión es un -1, va a redondear el entero.
		
	- TRUNC(VALOR, PRECISIÓN)
		- Se puede usar para decimales o fechas
		- Trunca o corta la cantidad de caracteres de un número decimal o fecha en el punto especificado. 
		- No redondea los valores, solo redefine la cantidad del valor en el punto especificado.
		- Si el número de precisión es positivo, va a redefinir la cantidad de decimales.
		- Si el número de precisión es negativo, va a quitar los decimales y redondea el entero a la decena anterior.
	- MOD(VALOR, NÚMERO DE DIVISIÓN) -> MOD(10, 2) = 0
		- Encuentra el resto después de que un valor se divida de otro.
		- Se usa para definir si un entero es par o impar.
## Ejercicios practicados

```
SELECT ROUND(40.5) FROM DUAL;
SELECT ROUND(45.25534, -1) FROM DUAL;

SELECT TRUNC(45.42354245) FROM DUAL;
SELECT TRUNC(46.456, -1) FROM DUAL;

SELECT MOD(10, 2) FROM DUAL; -- es par/múltiplo de 2
SELECT MOD(9, 3) FROM DUAL; -- es múltiplo de 3
```
# Funciones de Fecha 
----------------------------

- **Las bases de datos de Oracle almacenan las fechas como números, debido a esto las fechas se pueden manipular y realizar cálculos matemáticos, entre otras cosas.**
- El formato estándar de las fechas en Oracle es: YYYY-MON-DD
- Las bases de datos de Oracle almacena las fechas de modo interno en un formato numérico que representa el siglo, año, mes, día, hora, minuto y segundo.

- Estas son las funciones de fecha en Oracle:
	- SYSDATE 
		- Devuelve hora y fecha actuales del servidor de bases de datos.
	- DATE
		- Este tipo de dato almacena internamente la información del año como un número de 4 dígitos: dos dígitos para el siglo y dos para el año.
	- MONTHS_BETWEEN(SYSDATE, '2009-10-01')
		- Devuelve el número de meses entre dos fechas.
	- ADD_MONTHS('2024-01-31', 9)
		- Agregar meses a una fecha.
	- NEXT_DAY(SYSDATE, 'Saturday')
		- Devuelve la fecha del sábado de la próxima semana.
	- LAST_DAY(SYSDATE)
		- Devuelve el último día del mes.
	- ROUND(SYSDATE, 'Month')
		- Redondea la fecha al día, mes o año más cercano.
	- TRUNC
		- Trunca la fecha.
## Ejercicios practicados

```
SELECT ADD_MONTHS(SYSDATE, 10) FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, '10-Oct-2014') FROM DUAL;
SELECT SYSDATE FROM DUAL;

SELECT NEXT_DAY(SYSDATE, 'Sunday') FROM DUAL;
SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT ROUND(SYSDATE, 'year') FROM DUAL;
```