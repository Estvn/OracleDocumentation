
# PRIVILEGIOS Y EXPRESIONES REGULARES

# <span style="color: blue;">Control del Acceso de los Usuarios</span>
----------------

**Objetivos:**
- Comparar la diferencia entre los privilegios de objeto y privilegios del sistema.
- Construir los dos comandos necesarios para permitir que un usuario tenga acceso a una base de datos.
- Construir y ejecutar una sentencia GRANT ... ON ... TO para asignar privilegios a objetos de un esquema para otros usuarios y/o a PUBLIC.
- Consultar el diccionario de datos para confirmar los privilegios otorgados.

- En las bases de datos, la seguridad de los datos es muy importante.
- En esta lección aprenderá a otorgar o quitar acceso a los objetos de base de datos como un medio para controlar quién puede modificar, suprimir, actualizar, insertar, indexar o hacer referencia a los objetos de la base de datos.
### **Control de Acceso a los Usuarios**

En un entorno de varios usuarios, desea mantener la seguridad del uso y acceso a la base de datos.
**Con la seguridad de la base de datos del servidor de Oracle, puede realizar lo siguiente:**
	- Controlar el acceso de la base de datos.
	- Proporcionar acceso a objetos específicos en la base de datos.
	- Confirmar los privilegios asignados y recibidos en el diccionario de datos Oracle.
	- Crear sinónimos para objetos de bases de datos.
### **Seguridad de la Base de Datos**

La seguridad de la base de datos se puede clasificar en dos categorías:
- Seguridad del sistema
- Seguridad de los datos

La seguridad del sistema abarca el acceso a la base de datos en el nivel del sistema, como la creación de usuarios, nombres de usuario y contraseñas, la asignación de espacio en disco a los usuarios y la concesión de privilegios del sistema que los usuarios pueden llevar a cabo, como crear tablas, vistas y secuencias.

> [!IMPORTANT]
> **¡Existen más de 100 privilegios del sistema distintos!**

La seguridad de datos (también denominada seguridad de objetos) está relacionada con los privilegios de objeto que abarca el acceso y el uso de los objetos de base de datos, así como las acciones que los usuarios pueden realizar sobre los objetos.
**Estos privilegios incluyen poder ejecutar sentencias DML.**
### **Privilegios y Esquemas**
- Los privilegios son el derecho a ejecutar sentencias SQL determinadas.
- El DBA es un usuario de alto nivel con capacidad para otorgar a los usuarios acceso a la base de datos y sus objetos.
- Los usuarios necesitan privilegios del sistema para obtener acceso a la base de datos.
- Necesitan privilegios de objeto para manipular el contenido de los objetos en la base de datos.
- A los usuarios también se les da el privilegio de otorgar privilegios adicionales a otros usuarios o a otros roles, que son grupos con nombres de privilegios relacionados.

- Un esquema es una recopilación de objetos, como tablas, vistas y secuencias.
- El esquema es propiedad de un usuario de base de datos y tiene el mismo nombre que el usuario.
### **Seguridad del Sistema**
- Este nivel de seguridad abarca el acceso y uso de la base de datos en el nivel del sistema.
- Existen más de 100 privilegios del sistema distintos.
- **Los privilegios del sistema, como la capacidad de crear o eliminar usuarios, eliminar tablas o realizar copias de seguridad de tablas, solo los suele tener el DBA.**

En esta tabla se muestran algunos de los privilegios del sistema que el DBA normalmente otorga a otros usuarios:

| Privilegio del Sistema | Operaciones Autorizadas                                                                      |
| ---------------------- | -------------------------------------------------------------------------------------------- |
| CREATE USER            | Privilegio necesario para el DBA                                                             |
| DROP USER              | Puede borrar otro usuario                                                                    |
| DROP ANY TABLE         | Borra una tabla de cualquier esquema                                                         |
| BACKUP ANY TABLE       | Realiza una copia de seguridad de tablas de cualquier esquema para propósito de exportación. |
| SELECT ANY TABLE       | Accede a cualquier tabla, vista o instantánea de un esquema.                                 |
| CREATE ANY TABLE       | Crea una tabla en cualquier esquema.                                                         |
### **Privilegios del Sistema**
- El DBA crea el usuario mediante la ejecución de la sentencia CREATE USER.
- El usuario no tiene ningún privilegio en este punto.
- El DBA puede otorgar privilegios necesarios a dicho usuario.

```
CREATE USER user
IDENTIFIED BY password;
```

Mediante la sentencia ALTER USER, un usuario puede cambiar su contraseña
```
ALTER USER scott
IDENTIFIED BY imscott35;
```
### **Privilegios del Sistema de Usuario**

- El DBA utiliza la sentencia GRANT para asignar privilegios del sistema al usuario.
- Estos privilegios del sistema determinan lo que el usuario puede realizar en el nivel de base de datos.
- Una vez que el usuario ha otorgado los privilegios, el usuario puede utilizar estos privilegios inmediatamente.

```
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW
TO scott;
```

- Un usuario debe tener un privilegio CREATE SESSION y un identificador de usuario si debe poder acceder a una base de datos.

| Privilegio del Sistema | Operaciones Autorizadas                                       |
| ---------------------- | ------------------------------------------------------------- |
| CREATE SESSION         | Conecta a la base de datos                                    |
| CREATE TABLE           | Crea tablas solo en el esquema del usuario                    |
| CREATE SEQUENCE        | Crea secuencias solo en el esquema del usuario                |
| CREATE VIEW            | Crea vistas solo en el esquema del usuario                    |
| CREATE PROCEDURE       | Crea procedimiento almacenados solo en el esquema del usuario |
### **Seguridad de Objetos**
- Este nivel de seguridad abarca el acceso y el uso de los objetos de la base de datos así como las acciones que los usuarios puedan realizar en dichos objetos.
- Cada objeto tiene un juego determinado de privilegios que se pueden otorgar

En la tabla siguiente se muestran los privilegios para varios objetos:

| Privilegio del Objeto | Tabla | Vista | Secuencia | Procedimiento |
| --------------------- | ----- | ----- | --------- | ------------- |
| ALTER                 | x     |       | x         |               |
| DELETE                | x     | x     |           |               |
| EXECUTE               |       |       |           | x             |
| INDEX                 | x     | x     |           |               |
| INSERT                | x     | x     |           |               |
| REFERENCES            | x     |       |           |               |
| SELECT                | x     | x     | x         |               |
| UPDATE                | x     | x     |           |               |
### Privilegios de Objeto

Es importante tener en cuenta los siguientes cuatro puntos sobre los privilegios de objeto:
1. Los únicos privilegios que se aplican a una secuencia son SELECT y ALTER.
2. Recuerde que una secuencia utiliza ALTER para cambiar las opciones INCREMENT, MAXVALUE, CACHE/NOCACHE o CYCLE/NOCYCLE.
3. La opción START WITH no se puede cambiar mediante ALTER.

Puede otorgar los privilegios UPDATE, REFERENCES e INSERT en columnas individuales de una tabla:
```
GRANT UPDATE (salary)
ON employees TO steven_king;
```

- Un privilegio SELECT se puede restringir mediante la creación de una vista con un subjuego y otorgamiento de privilegio SELECT solo en la vista.
- No puede otorgar SELECT en columnas individuales.

- Un privilegio otorgado en un sinónimo se convierte en un privilegio en la tabla base a la que hace referencia el sinónimo.
- Es decir, un sinónimo es simplemente un nuevo nombre más fácil de utilizar.
- El uso de este nombre para otorgar un privilegio es lo mismo que otorga el privilegio en la propia tabla.
### **Palabra Clave PUBLIC**
- Un propietario en una tabla puede otorgar acceso a todos los usuarios mediante la palabra clave PUBLIC.

```
GRANT SELECT ON alice.departments TO PUBLIC;
```

- Si una sentencia no utiliza el nombre completo de un objeto, Oracle Server incluye implícitamente en el nombre de objeto el nombre del usuario (o esquema) actual como prefijo.
- Si una sentencia no utiliza el nombre completo de un objeto y el usuario actual no es propietario de un objeto con ese nombre, el sistema incluye como prefijo PUBLIC en el nombre de objeto.
###### Confirmación de Privilegios Otorgados
- Si intenta realizar una operación no autorizada, como la supresión de una fila de una tabla para la que no tiene el privilegio DELETE, el servidor de Oracle no permite que se produzca la operación.
###### Privilegios de Visualización
- Puede acceder al diccionario de datos para ver los privilegios que tiene.

| Vista del Diccionario de Datos | Descripción                                                        |
| ------------------------------ | ------------------------------------------------------------------ |
| ROLE_SYS_PRIVS                 | Privilegios del sistema otorgados a los roles                      |
| ROLE_TAB_PRIVS                 | Privilegios de tabla otorgados a roles                             |
| USER_ROLE_PRIVS                | Roles a los que puede acceder el usuario                           |
| USER_TAB_PRIVS_MADE            | Privilegios de objeto otorgados a objetos del usuario              |
| USER_TAB_PRIVS_RECD            | Privilegios de objeto otorgados al usuario                         |
| USER_COL_PRIVS_MADE            | Privilegios de objeto otorgados a columnas de objetos de usuario   |
| USER_COL_PRIVS_RECD            | Privilegios de objeto otorgados al usuario en columnas específicas |
| USER_SYS_PRIVS                 | Muestra los privilegios del sistema otorgados al usuario           |
# <span style="color:blue;">Creación y Revocación de Privilegios de Objeto</span>
---------------

**Objetivos:**
- Explicar que es un ROL y cuáles son sus ventajas
- Crear una sentencia para crear un ROL y otorgarle privilegios.
- Crear una sentencia GRANT ... ON ... TO ... WITH GRANT OPTION para asignar privilegios a objetos de su esquema para otros usuarios y/o a PUBLIC.
- Crear y ejecutar una sentencia para REVOCAR los privilegios de objetos a otros usuarios y/o PUBLIC.
- Distinguir entre privilegios y roles.
- Explicar el objetivo de un enlace en la base de datos.
### **Roles**
- **Un rol es un grupo con nombre de privilegios relacionados que se pueden otorgar a un usuario.**
- Este método facilita la revocación y el mantenimiento de los privilegios.
- Un usuario puede tener acceso a diferentes roles y el mismo rol se puede asignar a diferentes usuarios.
- Los roles normalmente se crean para una aplicación de base de datos.

- Para crear y asignar un rol, en primer lugar el DBA debe crear un rol.
```
CREATE ROLE manager;
GRANT create table, create view TO manager;
GRANT manager TO jennifer_cho;
```

- Después de crear el rol, el DBA puede utilizar la sentencia GRANT para asignar el rol a los usuarios, así como asignar privilegios al rol.
- Si los usuarios tienen varios roles otorgados, reciben todos los privilegios asociados a todos los roles.
##### Características de los Roles
- Los roles son grupos con nombre de privilegios relacionados.
- Se pueden otorgar a usuarios.
- Simplifican el proceso de otorgamiento y revocación de privilegios
- Los crea un DBA
### Asignación de Privilegios de Objeto

```
GRANT object_priv [(column_list)]
ON object_name
TO {user|role|PUBLIC}
[WITH GRANT OPTION];
```

| Sintaxis          | Definida                                                                                  |
| ----------------- | ----------------------------------------------------------------------------------------- |
| object_priv       | Es un privilegio de objeto que se va a otorgar                                            |
| column_list       | Especifica la columna de una tabla o vista en la que se otorgan los privilegios           |
| ON object_name    | Es el objeto sobre el que se otorgan los privilegios                                      |
| TO user\|role     | Identifica el usuario o rol al que se otorga el privilegio                                |
| PUBLIC            | Otorga privilegios de objeto a todos los usuarios                                         |
| WITH GRANT OPTION | Permite al usuario con privilegios otorgar privilegios de objeto a otros usuarios y roles |
### Directrices de Privilegios de Objeto
- **Para otorgar privilegios en un objeto, el objeto debe estar en el propio esquema o debe otorgar el privilegio con WITH GRANT OPTION**
- Un propietario de objeto puede otorgar privilegios de objeto en el objeto a cualquier otro usuario o rol de la base de datos.
- El propietario de un objeto adquiere automáticamente todos los privilegios de objeto en dicho objeto.

```
GRANT UPDATE(first_name, last_name)
ON clients
TO jeniffer_cho, manager;
```

- Hay disponibles diferentes privilegios de objeto para distintos tipos de objeto del esquema.
- Un usuario automáticamente tiene todos los privilegios de objeto para los objetos de esquema que están en su esquema.
- Un usuario puede otorgar privilegios de objeto sobre cualquier objeto de esquema que el usuario posea otro usuario a otro rol.
### **WITH GRANT OPTION**
- El usuario con privilegios puede transferir un privilegio que se otorga con la cláusula WITH GRANT OPTION a otros usuarios y roles.
- Los privilegios de objeto otorgados con la cláusula WITH GRANT OPTION se revocan si se revoca el privilegio en el otorgante.
- **WITH GRANT OPTION sirve para, aparte de dar permisos DML a un USER o ROL, también permite que transfiera los permisos sin tener que ser propietario del objeto.**

> [!IMPORTANT]
> - Si se otorga a un usuario un privilegio con la cláusula WITH GRANT OPTION, dicho usuario también puede otorgar el privilegio mediante la cláusula WITH GRANT OPTION.
> - Esto significa que es posible una larga cadena de usuarios con privilegios, pero no se permite otorgar permisos de forma circular.

```
GRANT SELECT, INSERT
ON clients
TO scott_king
WITH GRANT OPTION;
```

Un propietario de una tabla puede otorgar acceso a todos los usuarios mediante la palabra clave PUBLIC
```
GRANT SELECT
ON jason_tsang.clients
TO PUBLIC;
```
#### Objeto **DELETE**
- Si intenta realizar una operación no autorizada, como la supresión de una fila de una tabla en la que no tiene el privilegio DELETE, Oracle Server no permite que se produzca la operación.
### Revocación de Privilegios de Objeto

- Puede eliminar los privilegios otorgados a otros usuarios mediante la sentencia REVOKE
- Al utilizar la sentencia REVOKE, los privilegios que especifique se revocarán a los usuarios que designe y a otros usuarios a los que se haya otorgado estos privilegios con las palabras clave WITH GRANT OPTION

```
REVOKE {prvilege [, privilege ...] | ALL}
ON object
FROM {user [, user ...] | role | PUBLIC}
[CASCADE CONSTRAINTS];
```

> [!WARNING]
> **CASCADE CONSTRAINTS** es obligatorio para eliminar todas las restricciones de integridad referenciales realizadas sobre el objeto mediante el privilegio REFERENCES.

```
REVOKE SELECT, INSERT
ON clientes
FROM scott_king;
```
### WITH GRANT OPTION
- Si el propietario revoca un privilegio de un usuario que ha otorgado privilegios a otros usuarios, la sentencia de revocación tiene un efecto en cascada en todos los privilegios otorgados.
### Sinónimos Privados y Públicos
- Puede crear un sinónimo para eliminar la necesidad de cualificar el nombre del objeto con el esquema y se ofrecen nombres alternativos para tablas, vistas, secuencias, procedimiento u otros objetos.
- Los sinónimos pueden ser privados (por defecto) o públicos.
- Un sinónimo público los pueden crear los administradores de base de datos o usuarios de base de datos a los que haya dado privilegios para hacerlo, pero no todo el mundo puede crear automáticamente sinónimos públicos.
### **Roles y Privilegios**
Los roles y los privilegios difieren de varias formas:
- Un privilegio de usuario es un derecho para ejecutar un tipo concreto de sentencia SQL o un derecho para acceder a un objeto de usuario.
- Oracle define todos los privilegios.
- Los roles los crean los usuarios (normalmente administradores), y se utilizan para agrupar los privilegios u otros roles.
- Se crean para que sea más fácil gestionar el otorgamiento de varios privilegios o roles a los usuarios.
- Los privilegios se incluyen con la base de datos y los roles los realizan los administradores de base de datos o los usuarios de una base de datos concreta.
### **Enlaces de Bases de Datos**
- Un enlace de base de datos es un puntero que define una ruta de acceso de comunicación unidireccional de una base de datos Oracle a otra base de datos.
- El puntero de enlace se define realmente como una entrada en la tabla del diccionario de datos.
- Para acceder al enlace, debe estar conectado a la base de datos local que contiene la entrada del diccionario de datos.

> [!IMPORTANT]
> Una conexión de enlace de base de datos es "unidireccional" en el sentido de que un cliente conectado a la base de datos local A puede utilizar un enlace almacenado en la base de datos A para acceder a la información de la base de datos remota B, pero los usuarios conectados a la base de datos B no pueden utilizar el mismo enlace para acceder a los datos de la base de datos A.

- **Una conexión de enlace de bases de datos proporciona a los usuarios locales acceso a los datos de una base de datos remota.**

- Para que se produzca esta conexión, cada base de datos del sistema distribuido debe tener un  nombre de base de datos global único.
- El nombre de la base de datos global identifica de forma única un servidor de base de datos en un sistema distribuido.
- **La gran ventaja de los enlaces de base de datos es que permiten a los usuarios acceder a objetos de otros usuarios en una base de datos remota, para que estén limitados por el juego de privilegios del propietario del objeto.**

> [!IMPORTANT]
> **Un usuario local puede acceder a una base de datos remota sin tener que un usuario en la base de datos remota.**

- **Normalmente, el administrador de bases de datos es el responsable de crear el enlace de la base de datos.**
- Una vez que se ha creado el enlace de base de datos, puede escribir sentencias SQL para los datos en el sitio remoto.
- Si se configura un sinónimo puede escribir sentencias SQL mediante el sinónimo.

```
CREATE PUBLIC SYNONYM HQ_EMP
FOR emp@HQ.ACME.COM;

SELECT * FROM HQ_EMP;
```

- **No se pueden otorgar privilegios en objetos remotos.**
- Se puede otorgar un rol a otro rol, no solo roles a usuarios.
# <span style="color: blue;">Expresiones Regulares</span>
------------------------

**Objetivo:**
- Describir las expresiones regulares.
- Utilizar expresiones regulares para buscar, hacer coincidir y sustituir cadenas en sentencias SQL.
- Construir y ejecutar expresiones regulares y restricciones de control.

**Objetivo**
- En ocasiones, puede que tenga que buscar o sustituir una parte concreta de texto en una columna, cadena de texto o documento.
- Ya sabe cómo realizar una coincidencia de patrón simple mediante LIKE y comodines.
- **En ocasiones puede que tenga que buscar cadenas de texto muy complejas como, por ejemplo, la extracción de todas las URL de un fragmento de texto.**
- Otras veces, es posible que se le solicite que realice una búsqueda más compleja como buscar todas las palabras cuyo segundo carácter es una vocal.
### **Expresiones Regulares!**

- Las expresiones regulares son un método de descripción de patrones tanto simples como complejos para la búsqueda y manipulación.
- Se utilizan ampliamente en el sector informático y no están limitadas a Oracle.

> [!NOTA]
> La implantación de expresiones regulares de Oracle es una extensión de POSIX (Portable Operating System for UNIX) y, como tal, es completamente compatible con el estándar POSIX, controlado por Institute of Electrical and Electronics Engineers (IEEE).
 
**El uso de expresiones normales se basa en el uso de metacaracteres**
- Los metacaracteres son caracteres con un significado especial, como un carácter comodín, un carácter repetitivo, un carácter no coincidente o un rango de caracteres.
- Puede utilizar varios símbolos de metacaracteres predefinidos en la coincidencia de patrones.
### **Metacaracteres**

| Símbolo   | Descripción                                                                                                      |
| --------- | ---------------------------------------------------------------------------------------------------------------- |
| . (punto) | Coincide con cualquier carácter, en el juego de caracteres soportado, excepto NULL                               |
| ?         | Coincide con ninguna o con una coincidencia.                                                                     |
| *         | Coincide con cero o más coincidencias.                                                                           |
| +         | Coincide con una o más coincidencias.                                                                            |
| ()        | Expresión de agrupación, que se trata como una sola subexpresión.                                                |
| \         | Carácter de escape                                                                                               |
| \|        | Operados de alternancia para especificar coincidencias alternativas.                                             |
| ^/$       | Coincide con el principio de línea/final de línea.                                                               |
| []        | Expresión de corchetes para una lista coincidente que coincide con cualquier expresión representada en la lista. |
- Una expresión regular simple es muy similar a la búsqueda con comodines con la que ya está familiarizado.
### **Funciones de Expresiones Regulares**
- Oracle proporciona un juego de funciones SQL que puede utilizar para buscar y manipular cadenas mediante expresiones regulares.
- Puede utilizar estas funciones en cualquier tipo de datos que contenga datos de caracteres como CHAR, CLOB y VARCHAR2.
- **Una expresión regular debe ir entre comillas simples.**

| Name           | Description                                                                               |
| -------------- | ----------------------------------------------------------------------------------------- |
| REGEXP_LIKE    | Similar a LIKE, pero busca coincidencias de una expresión regular.                        |
| REGEXP_REPLACE | Busca un patrón de expresión regular y es reemplazado.                                    |
| REGEXP_INSRT   | Devuelve el índice de la cadena donde se encontró el inicio de la expresión.              |
| REGEX_SUBSTR   | Retorna la cadena donde se encontró coincidencia con la expresión regular.                |
| REGEX_COUNT    | Devuelve la cantidad de veces que aparece una coincidencia con la expresión en un String. |
Se pide que enumere todos los empleados con el nombre Stephen o Steven
```
SELECT first_name, last_name
FROM employees
WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$');
```

Se busca una "H" seguida de cualquier vocal y se sustituye por dos símbolos "*"
```
SELECT last_name,
REGEXP_REPLACE(last_name, '^H(a|e|i|o|u)', '**') AS "Name changed"
FROM employees;
```

Se busca la subexpresión "ab"
```
SELECT country_name,
REGEXP_COUNT(country_name, '(ab)') AS "Count of 'ab'"
FROM wf_countries
WHERE REGEXP_COUNT(country_name, '(ab)') > 0;
```
### Expresiones Regulares en Restricciones de Control
- Las expresiones regulares también se pueden utilizar como parte del código de la aplicación para garantizar que solo se almacenan los datos en la base de datos.
- Se puede incluir una llamada a una función de expresión regular, como una restricción **CHECK.**
- Mediante las expresiones regulares, puede comprobar el formato de las direcciones de correo electrónico más a fondo para comprobar que son válidas.

```
ALTER TABLE employees
ADD CONSTRAINT email_addr_chk
CHECK(REGEXP_LIKE(email, '@'));
```






















































































