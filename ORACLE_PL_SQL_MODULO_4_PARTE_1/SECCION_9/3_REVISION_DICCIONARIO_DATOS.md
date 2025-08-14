
**Objetivos:**

- Describa el propósito del diccionario de datos
- Diferencie entre los diferentes tipos de vistas en el diccionario de datos
- Escriba declaraciones SELECT SQL para retornar información desde el diccionario de datos.
- Explique el uso de DICTIONARY como un motor de búsqueda a los datos del diccionario

- Imagine que tiene que crear muchos procedimientos o funciones, tanto como tablas y otros objetos de base de datos.
- Es difícil recordar sus nombres, ¿no es así?
- **El diccionario de datos recuerda esta información por usted**

# ¿Qué es el Diccionario de Datos?

- Cada base de datos de Oracle contiene un diccionario de datos
- **Todos los objetos de base de datos, tal como tablas, vistas, usuarios y sus privilegios, procedimientos, funciones, y demás son automáticamente registrados en el diccionario de datos, cuando estos objetos son creados.**

- Si un objeto después es alterado o borrado, el diccionario es automáticamente actualizado para reflejar los cambios.
- **Piense en el diccionario de datos como un catálogo maestro gestionado automáticamente de todo lo que hay en la base de datos.**

# ¿Cómo Puedes Leer el Diccionario?

Hay dos clases de tablas de las cuales puedes hacer SELECT para ver la información del diccionario.

1. **USER_\*** es una tabla que contiene información de los objetos de tu pertenencia, usualmente porque tu los creaste.
	- Ejemplo: **USER_TABLES, USER_INDEXES**

2. **ALL_\*** es la tabla que contiene información sobre los objetos que tu tienes los privilegios para usar.
	-  Estos incluyen la información **USER_\***  como un subconjunto, porque siempre tienes privilegios para usar los objetos que posees.
		- Ejemplo: **ALL_TABLES, ALL_INDEXES**

3. La tercera clase de tablas que puedes seleccionar para ver la información del diccionario normalmente solo está disponible para el **administrador de la base de datos.**
	1. **DBA_\*** es una tabla que contiene información sobre todo en la base de datos, no importa quien sea el dueño.
		- Ejemplo: **DBA_TABLES, DBA_INDEXES**

> [!DANGER] Tablas de Diccionario
> - USER_TABLES, USER_INDEXES, ...
> - ALL_TABLES, ALL_INDEXES, ...
> - DBA_TABLES, DBA_INDEXES, ...

# Viendo Información en el Diccionario

- Aunque no tengas el permiso de modificar el diccionario por tu cuenta, puedes usar **DESCRIBE** y **SELECT** para manipular las tablas del Diccionario.

Por ejemplo, puedes ver información sobre todas las tablas de las que tienes el privilegio de utilizar:

```
DECRIBE ALL TABLES;
```

- La salida muestra columnas con los datos que están retenidos en cada tabla.

Tu decides cuales columnas quieres ver de las tablas de los objetos

```
SELECT table_name, owner FROM ALL_TABLES;
```

USER_OBJECTS le muestra todos los objetos de todo tipo de su propiedad:

```
SELECT object_type, object_name FROM USER_OBJECTS;
```

- También puede usar condiciones WHERE, ORDER BY, GROUP BY y otros tipos de manipulaciones DQL en las tablas de dicciones, tal como con las tablas regulares

```
SELECT, object_type, COUNT(*) FROM USER_OBJETS GROUP BY object_type;
```

> [!DANGER]
> Puede manipular las tablas de diccionario de la misma forma que las tablas regulares

# Usando la Super Vista del Diccionario

- **Varias cientos de tablas de diccionario existen, y nadie puede recordar el nombre de todas ellas.**
- Una super vista llamada DICTIONARU (o DICT) lista todas las tablas de diccionario

- Puede usar DICT como un motor de búsqueda en internet para mostrar nombres y descripciones (comentarios) de las tablas de diccionario relevantes.

```
SELECT COUNT(*) FROM DICT WHERE table_name LIKE 'USER%';
```

- Puede ver que hay más de cien tablas **USER\***




















