
**Objetivos:**

- Entender el alcance y la visibilidad de las variables.
- Escribir bloques anidados y calificar las variables con etiquetas.
- Describir las reglas del alcance de las variables y cuando una variable es anidada en un bloque
- Reconocer los problemas del alcance de las variables cuando una variable es usada en un bloque anidado.
- Calificar una variable anidada en un bloque con una etiqueta

- Un bloque largo y complejo puede ser difícil de entender
- Puedes dividirlo en pequeños bloques que están anidados uno dentro de otro, haciendo el código más fácil para leer.
- Cuando anidas bloques, las variables declaradas pueden no estar disponibles dependiendo de su alcance y visibilidad.
- Puedes hacer que las variables invisibles estén disponibles usando bloques con etiquetas.

# Bloques Anidados

- PL/SQL es un lenguaje de bloques estructurados. 
- Las unidades básicas (procedimientos, funciones y bloques anónimos) son bloques lógicos, los cuáles pueden tener cualquier cantidad de sub-bloques anidados.
- Cada bloque lógico corresponde a un problema a resolver.

- **Los bloques anidados son bloques de código puestos entre otros bloques de código.**
- Puedes anidar tantos bloques como necesites, prácticamente no hay un límite en la profundidad de los bloques que Oracle permite.

# Ejemplo de un bloque anidado 

```
DECLARE
    v_outer_variable VARCHAR2(20) := 'GLOBAL VARIABLE';
BEGIN
    DECLARE
        v_inner_variable VARCHAR2(20) := 'LOCAL VARIABLE';
    BEGIN 
        DBMS_OUTPUT.PUT_LINE(v_inner_variable);
        DBMS_OUTPUT.PUT_LINE(v_outer_variable);
    END;
    DBMS_OUTPUT.PUT_LINE(v_outer_variable);
END;
```

# Alcance de las Variables

- El alcance de una variable, es el bloque o bloques en los cuales la variable es accesible, es donde puede ser usada.
- **En PL/SQL el alcance de las variables es el bloque en el cual está declarada más todos los bloques dentro del bloque principal donde se declaró la variable.**

# Variables Locales y Globales

- Las variables declaradas en un bloque PL/SQL es considerada local para el bloque, y global para todos los bloques anidados dentro del principal.
- **Cuando accedes a una variable global desde un bloque anidado, PL/SQL primero va a ver si en el bloque anidado hay una variable con ese nombre, si no hay, va a buscar en el bloque padre.** 

- La variable dentro del bloque anidado no se considera global, porque no hay bloques anidados dentro del bloque donde se ha declarado la variable.
- En este caso, esta variable solo es accedida por el bloque anidado.

```
DECLARE
	v_first_name VARCHAR2(20);
BEGIN
	DECLARE
		v_last_name VARCHAR2(20);
	BEGIN
		v_first_name := 'Carmen';
		v_last_name := 'Miranda';
		DBMS_OUTPUT.PUT_LINE (v_first_name || ' ' || v_last_name);
	END;
	DBMS_OUTPUT.PUT_LINE (v_first_name || ' ' || v_last_name);
END;
```

# Nombramiento de las Variables

- No puedes declarar dos variables con el mismo nombre en el mismo bloque.
- Sin embargo, puedes declarar dos variables con el mismo nombre si las variables están separadas en diferentes niveles de anidación de los bloques.
- Los valores o tipo de datos en las variables de mismo nombre pueden ser distintas, y el cambio en una no afectará la otra variable.

# Visibilidad de las Variables

- ¿Qué pasa si dos variables con el mismo nombre son usadas en un mismo nivel de bloque?

```
DECLARE
    v_father_name VARCHAR(20);
    v_date_birth DATE := '20-Apr-1972';
BEGIN
    v_father_name := 'Patrick';
    DECLARE 
        v_child_name VARCHAR2(20) := 'Mike';
        v_date_birth DATE := TO_DATE('12-Dec-2002', 'DD-Month-YYYY');
    BEGIN
        DBMS_OUTPUT.PUT_LINE('NACIMIENTO: ' || v_date_birth);
    END;
END;
```

- La visibilidad de una variables es la porción del programa donde la variable puede ser accedida sin usar un calificador.

> [!DANGER]
**Las variable global no pueden ser accedida en el bloque anidado, si el bloque anidado tiene una variable con el mismo nombre.**

- **¿Qué pasa si quieres acceder a la variable global que tiene el mismo nombre que una variable en mi bloque anidado?**

# Etiquetando un Bloque

- Un calificador es una etiqueta dada a un bloque.
- Puede usar un calificador para acceder a las variables que tienen alcance pero son invisibles.

```
<<first_block>>
DECLARE
    v_father_name VARCHAR2(20) := 'Patrick';
    v_date_birth DATE := '20-Apr-1972';
BEGIN
    DECLARE
        v_child_name VARCHAR2(20) := 'Mike';
        v_date_birth DATE := '12-Dec-2002';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nombre del padre' || v_father_name);
        DBMS_OUTPUT.PUT_LINE('Fecha de nacimiento' || first_block.v_date_birth);
        DBMS_OUTPUT.PUT_LINE('Nombre del hijo' || v_child_name);
        DBMS_OUTPUT.PUT_LINE('Fecha de nacimiento' || v_date_birth);
    END;
END;
```


























































































