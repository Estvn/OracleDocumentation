
# FUNCIONES DE UNA SOLA FILA - PARTE 2

# Funciones de Conversión
---------------------------------------

- En las bases de datos, los cambios de formato y visualización se realizan utilizando funciones de conversión.
- Las funciones de formato permiten mostrar los números en la moneda local, aplicar una gran variedad de formato a las fechas, mostrar la hora incluyendo hasta los segundos y hacer un seguimiento del siglo al que hace referencia una fecha.
### Tipos de dato
- Cuando se crea una tabla para una base de datos, el programador SQL debe definir qué tipos de dato se almacenarán en cada uno de los campos de la tabla.
- En SQL, hay diferentes tipos de dato. Estos tipos de datos definen el dominio de valores que pueden incluir cada columna.
	- VARCHAR2, CHAR, NUMBER, DATE, ETC.

- La moneda se almacena como tipo de dato numérico.
- Oracle almacena las fechas como números y, por defecto, se muestra la información de DATE como: DD-MM-YYYY.
### Conversión de tipo de dato
- Oracle Server puede convertir automáticamente datos VARCHAR2 y CHAR en tipos de datos NUMBER y DATE.
- Puede convertir datos de tipo NUMBER y DATE en un nuevo tipo de datos CHARACTER.
- **A esto se le conoce como conversión de datos implícita**.
	- VARCHAR2 o CHAR -> NUMBER
	- VARCHAR2 o CHAR -> DATE
	- NUMBER -> VARCHAR2
	- DATE -> VARCHAR2
- **Conversión de datos explícita:**
	- NUMBER -> TO_CHAR -> CHARACTER
	- CHARACTER -> TO_NUMBER -> NUMBER
	- CHARACTER -> TO_DATE -> DATE
	- DATE -> TO_CHAR -> CHARACTER
### Conversión de datos DATE a CHARACTERS
- Por lo general, es aconsejable que un formato de fecha se convierta de su formato DD-Mon-YYYY  por defecto en otro formato especificado por el usuario.
- El 'modelo de formato' debe estar entre comillas simples y es sensible a mayúsculas/minúsculas.
- Separe el valor de fecha del modelo de formato con una coma.
- Se puede incluir cualquier elemento de formato de fecha válido.
- **Utilice sp para deletrear un número.**
- **Utilice th para que el número aparezca como un ordinal.**
- **Utilice un elemento fm para eliminar los espacios en blanco o eliminar los ceros iniciales de la salida.**
- Conversión de datos de fecha en datos de caracteres:
	- YYYY
	- YEAR
	- MM
	- MONTH
	- MON
	- DY -> Abreviatura de tres letras del día de la semana
	- DAY -> Nombre del día de la semana
	- DD -> Día numérico del mes
	- DDspth
	- Ddspth
	- ddspth
	- DDD | DD | D -> día del año | día del mes | día de la semana
	- HH24:MIN:SS AM
	- DD "of" MONTH
### Conversión de datos NUMBER a CHARACTER (VARCHAR2)
- Los números almacenados en la base de datos no debe de tener formato.
- Esto significa que no tienen ningún símbolo/signo de moneda, comas, decimales, ni ningún otro formato.
- **Para agregar formato a un número, en primer lugar debe convertir el número en un formato de caracter**.
- Elementos de formato que se pueden usar con las funciones TO_CHAR:
	- 9 -> 999999 -> 1234
	- 0 -> 0999999 -> 01234
	- $ -> $999999 -> $1234
	- . -> 999.99 -> 1234.00
	- , -> 999,99 -> 1234,00
	- MI -> 999MI -> 1234-
	- PR -> 999999PR -> <1234>
	- EEEE -> 999999EEEE -> 1,23E+03
	- V -> 9999V99 -> Multiplica por 10 n cantidad de veces
	- B -> B9999.99 -> 1234.00 -> Deja los decimales en 0
### Conversión de CHARACTER a NUMBER
- Es aconsejable convertir una cadena de caracteres en un número.
- No se puede realizar cálculos de forma fiable con datos de caracteres.
- El modelo de formato es opcional, pero se debería incluir si la cadena de caracteres que se va a convertir contiene cualquier carácter que no sean números.
- El formato en número se debe de escribir con la cantidad de dígitos y los caracteres en la misma posición que el tipo de dato VARCHAR que se desea convertir a NUMBER.

```
TO_NUMBER('$2,343.54', '$9,999.99');
```
### Conversión de caracteres en fechas

```
TO_DATE('character String','Format model');

TO_DATE('November 3, 2001', 'Month dd, yyyy');
```

### Reglas del Modificador fx
- Cuando se realiza una conversión de caracteres en fecha, el modificador fx (formato exacto) especifica la coindencia exacta entre el argumento carácter y el modelo de formato de fecha.
- El modelo de formato fx busca la coincidencia con el argumento de caracteres.

```
SELECT TO_DATE('May10, 1989','fxMonDD, YYYY') as Convert FROM DUAL;
SELECT TO_DATE('July312004','fxMonthDDYYYY');
SELECT TO_DATE('June 19, 1990','fxMonth DD, YYYY');
```

- Las reglas del modificador fx son:
	- La puntuación y el texto entre comillas en el argumento de caracteres deben coincidir con las partes correspondientes del modelo de formato exactamente (excepto en lo que respecta a mayúsculas/minúsculas).
	- El argumento de carácter no puede tener espacios en blancos adicionales.
	- Los datos numéricos del argumento de carácter deben tener el mismo número de dígitos que el elemento correspondiente en el modelo de formato.

### Formato de Fecha RR  y Formato de Fecha YY
- Todos los datos de fecha ahora se almacenan utilizando años de cuatro dígitos (YYYY).
- No obstante, algunas bases de datos de legado pueden seguir utilizando el formato de dos dígitos (YY).
```
SELECT TO_DATE('27-Oct-95','DD-Mon-YY') FROM DUAL; -- 2095
SELECT TO_DATE('27-Oct-95','DD-Mon-RR') FROM DUAL; -- 1995
```

- RR
	- 0-49: La fecha estará en el siglo actual.
	- 50-99: La fecha estará en el siglo pasado.
- YY
	- 0-49: La fecha estará en el siglo siguiente.
	- 50-99: La fecha estará en el siglo actual.

# Funciones Null
-------------------------------------------

- Además de las funciones que controlan cómo se formatean los datos o se convierten en otro tipo, SQL utiliza un juego de funciones generales diseñado específicamente para tratar valores nulos.
- Lo nulo puede ser "nada", pero puede afectar a la forma que las expresiones se evalúan.
### Método de evaluación de las funciones
- Es posible anidar funciones a cualquier profundidad.
- Es importante saber como se evalúan las funciones anidadas.
- El proceso de evaluación empieza desde el nivel más profundo hasta el nivel menos profundo.
### Funciones relacionadas con los valores nulos
- Nulo es el valor que no está disponible, que está sin asignar o que no es aplicable.
- Como resultado, no podemos comprobar si es el mismo que otro valor, porque no sabemos que valor tiene.
- No es igual a nada, ni siquiera a cero.
- **Cuatro funciones para valores nulos:**
	- **NVL(posible valor nulo, valor a sustituir por el valor nulo)**
		- Convierte un valor nulo en un valor conocido de un tipo de dato fijo.
		- Los tipos de dato del valor nulo y el nuevo valor deben ser iguales.
		- Puede usar NVL para convertir valores de columna que contenga valores nulos en un número antes de realizar los cálculos.
		- Cuando se realiza un cálculo aritmético con un valor nulo, el resultado es nulo.
		- La función NVL se puede usar para cambiar el valor nulo a un cero antes de realizar cálculos.
	- **NVL2(expresión 1, expresión 2 (puede ser calculo), expresión 3)**
		- La función NVL2 se evalúa una expresión de tres valores.
		- Una manera fácil de recordar NVL2 es pensar: "Si la expresión 1 tiene un valor, sustituir la expresión 2, si la expresión 1 es nula, sustituir la expresión 3".
	- **NULLIF(expresión 1, expresión 2)**
		- La expresión compara dos expresiones.
		- Si son iguales, la función devuelve un valor nulo.
		- Si no son iguales, la función devuelve la primera expresión.
	- **COALESCE(exp 1, exp 2 ... exp n)**
		- Es una extensión de NVL, pero puede tener varios valores.
		- Si la primera expresión es nula, la función continúa bajando por la línea hasta que se encuentra una expresión no nula.
		- Si una expresión tiene un valor, la función devuelve esa expresión y se detiene.
		- **COALESCE(commision_ptc, salary, 10, 0);**

# Expresiones Condicionales
---------------------------------------

- Expresiones condicionales DECODE y CASE.
- Métodos para implantas la lógica condicional IF-THEN-ELSE.
- Saber cómo utilizar el procesamiento condicional facilita la toma de decisiones para obtener los datos que desee.

- Hay dos juegos de comandos o sintaxis que se pueden utilizar para escribir sentencias SQL:
	- Sentencias estándar compatibles con ANSI/ISO SQL 99
	- Sentencias propiedad de Oracle
- Los dos juegos de sintaxis son muy similares, pero hay unas cuantas diferencias.
- En este curso aprenderá a utilizar ambos juegos de sentencias SQL, pero se recomienda utilizar la sintaxis ANSI/ISO SQL 99.

- CASE y DECODE son ejemplos de una de estas diferencias.
- **CASE es una sentencia compatible con ANSI/ISO SQL 99.**
- **DECODE es una sentencia propiedad de Oracle.**
- Ambas sentencias devuelven la misma información utilizando sintaxis diferente.
### Expresión CASE
- La expresión CASE realiza la función de una sentencia IF-THEN-ELSE.
- Los tipos de dato de las expresiones CASE, WHEN y ELSE deben ser iguales.

```
CASE expr
	WHEN comparison_expr1 THEN return_expr1
	WHEN comparison_expr2 THEN return_expr2
	...
	WHEN comparison_exprn THEN return_exprn
	ELSE else_expr
END

SELECT last_name
CASE department_id
	WHEN 90 THEN 'Management'
	WHEN 80 THEN 'Sales'
	WHEN 70 THEN 'It'
	ELSE 'Other dept.'
END AS "Department"
FROM EMPLOYEES;
```

### Expresión DECODE
- La función DECODE evalúa una expresión de una forma similar a la lógica IF-THEN-ELSE
- DECODE compara una expresión con cada uno de los valores de búsqueda.
- Si se omite el valor por defecto (DEFAULT es el valor, no palabra reservada), se devuelve un valor nulo donde un valor de búsqueda no coincida con ninguno de los valores.

```
SELECT last_name
	DECODE(department_id,
	90, 'Management',
	80, 'Sales',
	70, 'It',
	'Other dept.'
	)
	AS "Department"
	FROM employees;
```





































