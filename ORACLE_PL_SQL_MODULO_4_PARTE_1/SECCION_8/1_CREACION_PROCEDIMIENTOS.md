
**Objetivos:**

- Diferenciar entre bloques anónimos y los subprogramas
- Identificar los beneficios de los subprogramas
- Definir un procedimiento almacenado
- Crear un procedimiento
- Describir como un procedimiento almacenado es invocado
- Listar los pasos de desarrollo para crear un procedimiento
- Crear un subprograma anidado en la sección declarativa de un procedimiento.

- Aprenderás como crear, ejecutar y manejar dos tipos de subprogramas en PL/SQL que son nombrados y almacenados en la base de datos, que resulta en varios beneficios como compartibilidad, mejor seguridad y configuraciones rápidas.

**Hay dos tipos de subprogramas:**
1. Funciones
2. Procedimientos

# Diferencias Entres Bloques Anónimos y Subprogramas

- Los bloques anónimos con bloques PL/SQL ejecutables sin nombre.
- Debido a que no son nombrados, tampoco pueden ser reusados o almacenados en la base de datos para un uso posterior.
- Mientras almacenas bloques anónimos en la PC, la base de datos no se advierte de ellos, y nadie más puede compartirlo.

- **Los procedimientos y funciones son bloques PL/SQL que son nombrados, y también se conocen como subprogramas.**
- Estos subprogramas son compilados y almacenados en la base de datos.
- La estructura de bloques de los subprogramas es similar a la estructura de los bloques anónimos.
- Mientras los subprogramas son compartidos explícitamente, por defecto es hacerlos privados en su propio esquema.
- Los subprogramas posteriores se convierten en los componentes básicos de los paquetes y triggers.

Bloque anónimo:

```
DECLARE (Optional)
	variables, cursors, etc.;
BEGIN (Mandatory)
	SQL and PL/SQL statements;
EXCEPTIONS (Optional)
	WHEN exception-handling actions;
END; (Mandatory)
```

Subprogramas (procedimientos)

```
CREATE [OR REPLACE] PROCEDURE name [parameters] IS|AS (Mandatory)
	variables, cursors, etc.; (optional)
BEGIN (Mandatory)
	SQL and PL/SQL statements;
EXCEPTION (Optional)
	WHEN exception-handling actions;
END [name]; (Mandatory)
```

- La alternativa de un bloque anónimo es un bloque nombrado. Como el nombre sea llamado, depende de su creatividad.

Puedes crear:
- Un procedimiento nombrado (no retorna valores a excepción de los parámetros de salida)
- Una función (debe retornar un único valor sin necesidad de incluir parámetros de salida)
- Un paquete (agrupa funciones y procedimientos en un único lugar)
- Un trigger

- La llave DECLARE es reemplazada por CREATE PROCEDURE procedure-name IS | AS
- En los bloques anónimos, la declaración DECLARE es el inicio del bloque
- Debido a que la declaración CREATE PROCEDURE es el inicio del subprograma, no necesitamos usar DECLARE

| Anonymous Blocks                               | Subprograms                                                              |
| ---------------------------------------------- | ------------------------------------------------------------------------ |
| Bloques PL/SQL sin nombre                      | Bloques PL/SQL nombrados.                                                |
| Compilados en cada ejecución                   | Compilados solo una vez, cuando son creados                              |
| No se guardan en la base de datos              | Se guardan en la base de datos                                           |
| No pueden ser invocados por otras aplicaciones | Estos son nombrados, y luego pueden ser invocados por otras aplicaciones |
| No retorna valores                             | Los subprogramas llamados funciones deben retornar valores               |
| No puede tomar parámetros                      | Puede tomar parámetros                                                   |

# Diferencias Entre Bloques Anónimos y Subprogramas

- La clave DECLARE es reemplazada por CREATE PROCEDURE procedure-name IS | AS
- En los bloques anónimos, la declaración DECLARE es el inicio de un bloque
- Debido a que la declaración CREATE PROCEDURE es el inicio de un subprograma, no necesitamos usar DECLARE

# Beneficios de los Subprogramas

- Los procedimientos y las funciones tienen muchos beneficios acorde a la modularización del código
	- **Mantenimiento fácil:** Las modificaciones solo necesitan ser hechas una vez para mejorar múltiples aplicaciones y minimizar las prácticas
	- **Reúso de código:** Los subprogramas se localizan solo en un lugar

- Cuando es compilados y validado, pueden ser usados y reusados en cualquier número de aplicaciones.
- **Mejora de la seguridad de los datos:** El acceso indirecto a los objetos es permitido por el concebimiento de los privilegios de seguridad de los subprogramas.

- Por defecto, los subprogramas corren con los privilegios del propietario del subprograma, **no con los privilegios del usuario.**
- **Integridad de los datos:** Las acciones relacionadas pueden ser agrupadas en un bloque y manejadas juntas.

- **Rendimiento Mejorado:** Puedes reusar y compilar código PL/SQL que es almacenado en el área de caché de SQL compartido del servidor.
- **Las subsecuencias llaman a un subprograma, evitando la compilación del código de nuevo.**

> [!NOTA]
> También, muchos usuarios pueden compartir una sola copia del código del subprograma en la memoria.

- **Mejora de la claridad del código:** Usando los nombres apropiados y convenciones para describir la acción de las rutinas, puedes reducir la cantidad de comentarios, y mejorar la claridad del código.

# Procedimientos y Funciones: Similitudes

- Son nombrados bloques PL/SQL
- Son nombrados subprogramas PL/SQL
- Tienen estructuras de bloques similares a los bloques anónimos:
	- Parámetros opcionales
	- Sección declarativa opcional
	- Sección ejecutable obligatoria
	- Sección opcional para manejar excepciones

- **Los procedimientos y funciones, ambos pueden retornar data como parámetros OUT e IN OUT.**

# Procedimientos y Funciones: Diferencias

- Una función debe retornar un valor usando la declaración RETURN
- Un procedimiento puede solo retornar un valor usando OUT o un IN OUT parámetro

- La declaración RETURN en una función retorna el control de la llamada del programa y retorna el resultado de la función.
- La declaración RETURN dentro de un procedimiento es opcional.
- Devuelve el control al programa que lo llama antes de que se haya ejecutado todo el código del procedimiento.

> [!NOTA]
**Las funciones pueden ser llamadas desde SQL, los procedimientos no.**

# ¿Qué es un Procedimiento?

- Un procedimiento es un bloque PL/SQL nombrado que acepta parámetros
- Normalmente, se usa un procedimiento para manejar una acción.
- **Un procedimiento es compilado y almacenado en la base de datos como un objeto del esquema**

# Sintaxis de la Creación de los Procedimientos

- Un parámetro es opcional
- El modo por defecto es IN
- El tipo de dato puede ser o explícito o implícito con %TYPE
- El cuerpo es el mismo como un bloque anónimo

```
CREATE [OR REPLACE] PROCEDURE procedure_name
	[(parameter1 [mode1] datatype1,
	  parameter2 [mode2] datatype2,
	  ...)]
IS | AS
procedure_body;
```

- Use CREATE PROCEDURE seguido del nombre, parámetros opcionales, y la clave IS o AS
- Agregue el OR REPLACE opción para sobrescribir un procedimiento existente.
- Escriba un bloque PL/SQL que contenga variables locales, un BEGIN, y un END (o END procedure_name)

```
CREATE [OR REPLACE] PROCEDURE procedure_name
[(parameter1 [mode1] datatype1,
  parameter2 [mode2] datatype2, ...)]
IS | AS
	[local_variable_declarations; ...]
BEGIN
	-- actions;
END [procedure_name];
```

# Procedimiento: Ejemplo

- En el siguiente ejemplo, el procedimiento add_dept inserta un nuevo departamento con el departamento department_id=280 y department_name=ST-Curriculum
- El procedimiento declara dos variables, v_dept_id y v_dept_name, en la sección declarativa.

```
CREATE OR REPLACE PROCEDURE add_dept 
IS
    v_dept_id copy_dept.department_id%TYPE;
    v_dept_name copy_dept.department_name%TYPE;
BEGIN
    v_dept_id := 280;
    v_dept_name := 'ST-Curriculum';
    
    INSERT INTO copy_dept(department_id, department_name)
        VALUES(v_dept_id, v_dept_name);
    DBMS_OUTPUT.PUT_LINE('Inserted ' || SQL%ROWCOUNT || ' row.');
END;
```

- La sección declarativa de un procedimiento empieza inmediatamente después de la declaración de un procedimiento y no empieza con la palabra clave BEGIN.
- Este procedimiento usar el atributo de cursor SQL%ROWCOUNT para chequear si la fila fue insertada satisfactoriamente.
- SQL%ROWCOUNT debe retornar 1 en este caso.

# Invocar Procedimientos

**Puede invocar (ejecutar) un procedimiento desde:**
- Un bloque anónimo
- Otro procedimiento
- Una aplicación llamada

> [!NOTA]
> No puede invocar un procedimiento desde dentro de una declaración SQL como SELECT

- Para invocar (ejecutar) un procedimiento en Oracle Application Express, escribe y corre un bloque anónimo pequeño que invoca un procedimiento.

**Aquí se invoca un procedimiento y se usa SELECT para confirmar que el procedimiento funcionó correctamente:**

```
BEGIN
	add_dept;
END;

SELECT department_id, department_name FROM dept WHERE department_id=280;
```

- La declaración SELECT al final confirma que la fila se insertó satisfactoriamente.

# Corrigiendo Errores en la Declaración de Creación de Procedimientos

- Si existe un error de compilación, se mostrarán los errores en la ventana de terminal
- Debe editar el código fuente para hacer las correcciones.
- **Cuando un subprograma es creado, el código fuente es almacenado en la base de datos incluso si ocurrió un error de compilación.**
- Después de corregir el error del código, necesitas recrear el procedimiento.

Hay dos formas de hacer esto:

- Usa la declaración CREATE OR REPLACE PROCEDURE para sobrescribir el código existente
- DROP el procedimiento primero y luego ejecuta la declaración CREATE PROCEDURE

# Salvando tu Trabajo

- Una vez que un procedimiento ha sido creado satisfactoriamente, **debes poder salvar su definición en caso de necesitar modificar el código después.**

# Subprogramas Locales

- Cuando un procedimiento invoca a otro procedimiento, normalmente se crean separadamente, pero puede crearlos juntos como un solo procedimiento si lo desea.

**Procedimientos creados separados:**

```
CREATE OR REPLACE PROCEDURE subproc
	...
END subproc;

CREATE OR REPLACE PROCEDURE mainproc
	...
IS BEGIN
	...
	subproc(...);
	...
END mainproc;
```

**Procedimientos creados juntos:**

```
CREATE OR REPLACE PROCEDURE mainproc
	...
IS
	PROCEDURE subproc (...) IS BEGIN
		...
	END subproc;
BEGIN
	...
	subproc(...);
	...
END mainproc;
```

- El procedimiento anidado es llamado subprograma local

**Ejemplo de un subprograma local:**

```
CREATE OR REPLACE PROCEDURE delete_emp
	(p_emp_id IN employees.employee_id%TYPE)
IS
	PROCEDURE log_emp (p_emp IN employees.employee_id%TYPE)
	IS BEGIN
		INSERT INTO loggin_table VALUES (p_emp, ...);
	END log_emp;
BEGIN
	DELETE FROM employees
		WHERE employee_id = p_emp_id;
	log_emp(p_emp_id);
END delete_emp;
```

# Herramientas Alternativas para el Desarrollo de Procedimientos

- Si terminas escribiendo procedimientos PL/SQL como trabajo, hay varias herramientas gratuitas que pueden hacer tu proceso más fácil.
- Por ejemplo, Oracle tools, tal como SQL Developer y jDeveloper te ayuda a:
	- Comandos color-coding vs variables vs constantes
	- Resaltar coincidencias y discrepancias
	- Mostrar errores de forma más gráfica

- Maneja código con identaciones estándar y capitalización
- Completa comandos durante el Typing
- Completa nombres de columnas desde tablas

**Para desarrollar un procedimiento almacenado sin usar herramientas de Oracle, siga los siguiente pasos:**

1. Escriba el código para crear el procedimiento en un editor o un procesador de texto, y luego salve el script en un archivo de texto.
2. Cargue el código en una herramienta de desarrollo como iSQL\*Plus o SQL Developer
3. Cree un procedimiento en la base de datos
4. La declaración CREATE PROCEDURE compila y guarda el código fuente y el código compilado en la base de datos.
5. Si un error de compilación existe, entonces el código compilado no es guardado y debe editar el código fuente para hacer correcciones.
6. Después de una compilación exitosa, ejecute el procedimiento para llevar a cabo la acción deseada.




































































