
# RESTRICCIONES

# Introducción a las Restricciones; Restricciones NOT NULL y UNIQUE
---------------------------

**Objetivos:**
- Definir el término "restricción" relacionado con el modelado de datos.
- Establecer cuando es posible definir una restricción a nivel de columna y cuando es posible a nivel de tabla.
- Definir por qué es importante proporcionar nombres significativos a las restricciones.
- Definir que reglas de integridad de datos aplican a restricciones NOT NULL y UNIQUE.

- Escribir una sentencia CREATE TABLE que incluya las restricciones NOT NULL y UNIQUE en los niveles de tabla y columna.
- Explicar cómo crear restricciones en el momento de la creación de tabla.

- En las bases de datos, es una regla que no se pueda introducir un valor de clave ajena sin primero introducir un valor de clave primaria.
- Una base de datos solo es tan fiable como lo son los datos que tiene.
- **Las restricciones se utilizan para evitar la entrada de datos no válidos en las tablas.**
### Restricciones en General
- Piense en las restricciones como reglas de la base de datos.
- Todas las reglas de las restricciones se almacenan en diccionarios de datos.
- Las restricciones evitan la supresión de una tabla si hay dependencias a otras tablas.
- Las restricciones aplican reglas a los datos cuando se inserta, actualiza o suprime una fila de la tabla.

- Las restricciones son importantes y asignarles un nombre también es importante.
- Aunque puede asignar a una restricción el nombre "constraint_1" o "constraint_2", pronto le resultará difícil distinguirlas entre sí y acabará rehaciendo mucho trabajo.
### **Creación de Restricciones**

- Utilice la sentencia CREATE TABLE para establecer restricciones para cada columna de la tabla.
- **Hay dos ubicaciones diferentes en la sentencia CREATE TABLE en los que se puede especificar los detalles de restricción:**
	- En el nivel de columna situado junto al nombre y tipo de dato.
	- En el nivel de tabla una vez que se muestran todos los nombres de columna.
##### Restricciones en el Nivel de Columna
- Una restricción en el nivel de columna hace referencia a una única columna.
- Para establecer la restricción a nivel de columna, la restricción se debe definir en la sentencia CREATE TABLE como parte de la definición de columna.

```
CREATE TABLE clients(
client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
first_name VARCHAR2(14),
last_name VARCHAR2(13)
);
```
##### Restricciones de Nomenclatura
- Todas las restricciones deben tener un nombre. Si usted no asigna un nombre a la restricción, el gestor de la base de datos le asignará uno.
- Una convención de nomenclatura puede ser la combinación del nombre de la tabla abreviado y el nombre de la columna abreviado, seguido de la abreviatura de la restricción: tabla_columna_tipoRestricción
- Si se utiliza la palabra reservada CONSTRAINT en la definición de CREATE TABLE, debe asignar un nombre a la restricción. Los nombres de la restricción tienen un límite de 30 caracteres.

- **Es mejor que asigne usted mismo un nombre a las restricciones, porque los nombres generados por el gestor no son fáciles de conocer.**

```
CREATE TABLE clients(
client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
last_name VARCHAR(13) CONSTRAINT clients_client_last_name_nn NOT NULL,
email VARCHAR(80) constraint clients_email_uk UNIQUE
);
```

- En el siguiente ejemplo se muestra una restricción a la que ha asignado un nombre el usuario y una restricción a la que ha asignado un nombre el sistema

```
CREATE TABLE clients(
client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
last_name VARCHAR(13) NOT NULL,
email VARCHAR(80));
```
##### Restricciones a Nivel de Tabla
- Las restricciones de nivel de tabla se muestran por separado de las definiciones de columna en la sentencia CREATE TABLE.
- Las definiciones de restricciones de nivel de tabla se muestran después de que se hayan definido todas las columnas de la tabla.

```
CREATE TABLE clients(
client_number NUMBER(6) NOT NULL,
first_name VARCHAR2(20),
last_name VARCHAR2(20),
phone VARCHAR2(20),
email VARCHAR2(20) NOT NULL,
CONSTRAINT clients_phone_email_uk UNIQUE (email,phone));
```
### Reglas Básicas para Restricciones
- Las restricciones que hacen referencia a más de una columna se deben especificar en el nivel de tabla.
- La restricción NOT NULL se puede especificar solo en el nivel de columna.
- Las restricciones UNIQUE, PRIMARY KEY, FOREIGN KEY y CHECK  se pueden definir en el nivel de columna o de tabla.
- Si se utiliza la palabra CONSTRAINT en la sentencia CREATE TABLE, debe asignar un nombre a la restricción.
### **Cinco Tipos de Restricciones**
- Existen cinco tipos de restricciones en una base de datos Oracle.
- Cada tipo aplica una regla diferente.
- Los tipos son:
	- Restricciones NOT NULL
	- Restricciones UNIQUE
	- Restricciones PRIMARY KEY
	- Restricciones FOREIGN KEY
	- Restricciones CHECK
##### Restricción NOT NULL
- Una columna definida con una restricción NOT NULL necesita que para cada fila introducida en la tabla, **debe existir un valor para dicha columna.**
- Si una columna se ha definido como NOT NULL, cada inserción a la tabla no debe llevar valores nulos para ese campo.
##### Restricción UNIQUE
- Una restricción UNIQUE necesita que todos los valores de una columna o juego de columnas (clave compuesta) sean únicos; es decir, que **dos filas de una tabla no pueden tener valores duplicados.**
- Por ejemplo, puede ser importante para un negocio garantizar que no hay dos personas que tengan la misma dirección de correo electrónico.
- La columna o juego de columnas que se define como UNIQUE se denomina una clave única.

- Si la combinación de dos o más columnas debe ser única para cada entrada, se dice que la restricción es una clave única compuesta.
- La palabra "clave" hace referencia a las columnas, no a los nombres de restricciones.

- Por ejemplo, si la columna de correo electrónico de la tabla se define con una restricción UNIQUE, ninguna otra entrada de cliente puede tener el mismo correo electrónico.
### Clave Única Compuesta
- Las restricciones UNIQUE permiten la entrada de valores nulos a menos que la columna también tenga definida una restricción NOT NULL.
- Un valor nulo en la columna (o en todas las columnas de una clave única compuesta) cumple siempre una restricción UNIQUE porque los valores nulos no se consideran iguales a nada.

- Para cumplir una restricción que designa una clave única compuesta, dos filas de la tabla no pueden tener la misma combinación de valores en las columnas de clave.
- Además, cualquier fila que contenga valores nulos en todas las columnas de clave automáticamente cumple con la restricción.
### Restricciones Creadas en la Creación de la Tabla
- Al agregar una restricción NOT NULL como parte de la sentencia de creación de una tabla, la base de datos Oracle creará una restricción CHECK en la base de datos para aplicar un valor en la columna NOT NULL.
- La creación de esta restricción puede ser casi invisible para el usuario al crear la tabla: Oracle solo lo hace.
- Al final de la sentencia de creación de tabla, se muestra el mensaje "Tabla creada", pero no se proporcionan detalles sobre el número o tipos de restricciones que también se han creado.

# Restricciones PRIMARY KEY, FOREIGN KEY y CHECK
---------------

**Objetivos:**
- Explicar el objetivo de definir las restricciones PRIMARY KEY, FOREIGN KEY y CHECK.
- Demostrar la creación de las restricciones a nivel de columna y a nivel de tabla en una sentencia CREATE TABLE.
- Las restricciones se utilizan para evitar la entrada de datos no válidos en las tablas de la base de datos. 
### **PRIMARY KEY**
- Una restricción PRIMARY KEY es una regla de que los valores de una columna o una combinación de columnas deben identificar de forma única cada fila de la tabla.
- No puede aparecer ningún valor de clave primaria en más de una fila de la tabla.
- **Para cumplir una restricción PRIMARY KEY, las dos condiciones siguientes deben ser verdaderas:**
	- Ninguna columna que forma parte de la clave primaria puede contener un valor nulo.
	- Una tabla solo puede tener una clave primaria.

- Las restricciones PRIMARY KEY se pueden definir en nivel de columna o de fila.
- Sin embargo, si se crea una PRIMARY KEY compuesta, se debe definir en el nivel de la tabla.
- Al definir columnas PRIMARY KEY, es buena práctica utilizar el sufijo \_pk en el nombre de la restricción. 

A nivel de columna:
```
CREATE TABLE clients(
client_number NUMBER (4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
first_name VARCHAR2(14),
last_name VARCHAR2(13));
```

A nivel de tabla:
```
CREATE TABLE clients(
client_number NUMBER(4),
first_name VARCHAR2(14),
last_name VARCHAR2(13),
CONSTRAINT clients_client_num_pk PRIMARY KEY (client_number));
```

Para definir una PRIMARY KEY compuesta, debe definir la restricción en el nivel de tabla en lugar del nivel de columna:
```
CREATE TABLE copy_job_history(
	employee_id NUMBER(6,0),
	start_date DATE,
	job_id VARCHAR2(10),
	department_id NUMBER(4,0),
	CONSTRAINT copy_jhist_id_st_date_pk PRIMARY KEY (employee_id, start_date)
);
```
### **FOREIGN KEY** (INTEGRIDAD REFERENCIAL)
- Las restricciones Foreign Key designan una columna o una combinación de columnas como una clave ajena.
- **Una clave ajena enlaza a la clave primaria (o una clave única) en otra tabla y este enlace es la base de la relación entre las tablas.**

- Para cumplir una restricción de integridad referencial, el valor de clave ajena debe coincidir en un valor existente de la tabla principal o ser un valor NULL.
- Puede existir un valor de clave primaria sin un valor de clave ajena correspondiente; sin embargo, una clave ajena debe tener una clase principal correspondiente.
- **Antes de definir una restricción de integridad referencial en la tabla secundaria, ya debe estar definida la restricción UNIQUE o PRIMARY a la que se hace referencia.**

- Primero debe tener una clave primaria principal definida para que pueda crear una clave ajena en una tabla secundaria.
- Para definir una restricción FOREIGN KEY, es una buena práctica utiliza el sufijo \_fk en el nombre de la restricción.
### Sintaxis de Restricción FOREIGN KEY
- La sintaxis para definir una restricción FOREIGN KEY necesita una referencia a la tabla y columna de la tabla principal.

FOREIGN KEY  a nivel de columna:
```
CREATE TABLE copy_employees(
employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0) CONSTRAINT c_emps_depst_id_fk REFERENCES departments(department_id),
email VARCHAR2(25)
);
```

FOREIGN KEY a nivel de tabla:
```
CREATE TABLE copy_employees(
employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0),
email VARCHAR2(25),
CONSTRAINT c_emps_depst_id_fk FOREIGN KEY(department_id) REFERENCES departments(department_id),
);
```
### ON DELETE CASCADE: Mantenimiento de Integridad Referencial
- El uso de la opción ON DELETE CASCADE al definir una clave ajena permite la supresión de las dependientes en la tabla secundaria cuando se suprime una fila de la tabla principal.
- Si la clave ajena no tiene una opción ON DELETE CASCADE, las filas a las que se hace referencia de la tabla principal no se pueden suprimir.
- **Es decir, la restricción FOREIGN KEY de la tabla secundaria incluye el permiso ON DELETE CASCADE que permite a su principal suprimir las filas a las que hace referencia.**

- Si se intenta eliminar una fila dependiente a la que no se definió ON DELETE CASCADE, fallará el intento de supresión de la fila, ya que la fila de la tabla a la que hace referencia no se podrá borrar.

Aplicando ON DELETE CASCADE en la definición de un FOREIGN KEY:
```
CREATE TABLE copy_employees(
employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0),
email VARCHAR2(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id) REFERENCES copy_departments(department_id) ON DELETE CASCADE);
```
### ON DELETE SET NULL
- En lugar de que se supriman las filas de la tabla secundaria al utilizar la opción ON DELETE CASCADE, las filas secundarias se pueden rellenar con valores nulos mediante la opción ON DELETE SET NULL

```
CREATE TABLE copy_employees(
employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0),
email VARCHAR2(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id) REFERENCES copy_departments(department_id) ON DELETE SET NULL);
```

- Esto se usa cuando no desea suprimir las filas de la tabla secundaria.
- Este podría resultar útil cuando el valor de la tabla principal se va a cambiar a un nuevo número como, por ejemplo, al convertir números de inventario a números de código de barras.
- Cuando se introduzcan los nuevos números de código de barras en la tabla principal, se podrán insertar en la tabla secundaria sin tener que volver a crear totalmente cada una de las filas de la tabla secundaria.
### **Restricciones CHECK**
- Define explícitamente una condición que se debe cumplir.
- Para cumplir la restricción, cada una de las filas de la tabla debe hacer que la condición sea True o desconocida (debido a un valor nulo).
- La condición de una restricción de CHECK puede hacer referencia a cualquier columna de la tabla especificada, pero no a columnas de otras tablas.

Esta restricción CHECK garantiza que un valor introducido para end_date sea posterior a start_date
**Como esta restricción CHECK  hace referencia a dos columnas de la tabla, se debe definir en el nivel de tabla.**
```
CREATE TABLE copy_job_history(
employee_id NUMBER(6,0),
start_date DATE,
end_date DATE,
job_id VARCHAR(10),
department_id NUMBER(4,0),
CONSTRAINT cjhist_emp_id_st_date_pk PRIMARY KEY (employee_id, start_date),
CONSTRAINT cjhist_end_ck CHECK (end_date > start_date));
```
##### Condiciones de la Restricción CHECK
- Una restricción CHECK solo debe estar en la fila en la que se define la restricción.
- Una restricción CHECK no se puede utilizar en consultas que hacen referencia a valores de otras filas.
- La restricción CHECK no puede contener llamadas a las funciones SYSDATE, UID, USER o USERENV.
- La sentencia CHECK(SYSDATE > '05-May-1999') no está permitida.
- La restricción USER no puede utilizar las pseudocolumnas CURRVAL, NEXTVAL, LEVEL o ROWNUM.
- La sentencia CHECK(NEXTVAL > 0) no está permitida
- Una sola columna puede tener varias restricciones CHECK que hagan referencia a la columna en su definición.
- No hay un ningún límite en cuanto al número de restricciones CHECK que puede definir en una columna.
- **Las restricciones CHECK se pueden definir en nivel de tabla o de columna.**

```
salary NUMBER(8,2) CONSTRAINT employees_min_sal_ck CHECK (salary > 0)

CONSTRAINT employees_min_sal_ck CHECK  (salary > 0)
```

# Gestión de Restricciones
---------------------

**Objetivos:**
- Enumerar cuatro funciones diferentes que puede realiza la sentencia ALTER en las restricciones.
- Escribir sentencias ALTER TABLE para agregar, borrar, desactivar y activar restricciones.
- Nombrar una función de negocio que necesitaría un DBA para borrar, activar y/o desactivar una restricción o utilizar la sintaxis CASCADE.
- Consultar USER_CONSTRAINTS en el diccionario de datos e interpretar la información devuelta.

Un sistema de base de datos tiene que poder aplicar reglas de negocio y, al mismo tiempo, evitar la adición, la modificación o la supresión de datos que pueda dar como resultado una violación de la integridad referencial de la base de datos.
### Gestión de Restricciones
- La sentencia ALTER TABLE se utiliza para realizar cambios en las restricciones de tablas existentes.
- Estos cambios pueden incluir agregar o borrar restricciones activar o desactivar restricciones, así como agregar una restricción NOT NULL a una columna.

Las directrices para realizar cambios en las restricciones son:
- Puede agregar, borrar, activar o desactivar una restricción, pero no puede modificar su estructura.
- Puede agregar una restricción NOT NULL a una columna existente mediante la cláusula MODIFY de la sentencia ALTER TABLE.
- MODIFY se utiliza porque NOT NULL  es un cambio de nivel de columna.
- Solo puede definir una restricción NOT NULL si la tabla está vacía o si la columna tiene un valor para cada fila.
### Sentencia ALTER
La sentencia ALTER necesita lo siguiente:
- Nombre de la tabla
- Nombre de la restricción
- Tipo de restricción
- Nombre de la columna a la que afecta la restricción

```
ALTER TABLE employees
ADD CONSTRAINT emp_id_pk PRIMARY KEY (employee_id);
```

Si la restricción es FOREIGN KEY, la palabra clave REFERENCES se debe incluir en la sentencia
```
ALTER TABLE tablename
ADD CONSTRAINT constarint_name FOREIGN KEY (column_name)
REFERENCES tablename (column_name);

ALTER TABLE employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE CASCADE;
```
### Condiciones para la Adición de Restricciones
- Si la restricción es una restricción NOT NULL, la sentencia ALTER TABLE utiliza MODIFY en lugar de ADD.
- Las restricciones NOT NULL solo se pueden agregar si la tabla está vacía o si la columna tiene un valor para cada fila
```
ALTER TABLE employees
MODIFY (email CONSTRAINT emp_email_nn NOT NULL);
```
### ¿Por Qué Activar y Desactivar Restricciones?
- Para aplicar las reglas definidas por restricciones de integridad, las restricciones deben estar siempre activadas.
- En determinadas situaciones, se recomienda desactivar temporalmente las restricciones de integridad de una tabla por motivos de rendimiento, por ejemplo:
	- Al cargar grandes cantidades de datos en una tabla.
	- Al ejecutar operaciones por lotes que realizan cambios masivos en una tabla.
### Borrado de Restricciones
- Para borrar el nombre de una restricción, debe saber que nombre se le asignó.
- La opción CASCADE de la cláusula DROP provoca que se borren también las restricciones dependientes.
- Tenga en cuenta que al borrar una restricción de integridad, Oracle Server ya no aplica esa restricción y deja de estar disponible en el diccionario de datos.
- **No se borra ninguna fila ni ningún dato en ninguna de las tablas afectadas al borrar una restricción.**

```
ALTER TABLE copy_departments
DROP CONSTRAINT c_dept_id_pk CASCADE;
```
### Desactivación de Restricciones
- Por defecto, siempre que una restricción de integridad está definida en una sentencia CREATE o ALTER TABLE, Oracle activa (aplica) automáticamente la restricción, a menos que se cree específicamente con un estado desactivado con la cláusula DISABLE.

- **Puede desactivar una restricción sin borrarla o volver a crearla mediante DISABLE de la opción ALTER TABLE.**
- DISABLE permite datos entrantes, tanto si se ajustan a la restricción como si no.
- Esta función permite agregar datos a una tabla secundaria sin tener los valores correspondientes en la tabla principal.
- **DISABLE simplemente desactiva la restricción.**

- Puede utilizar la cláusula DISABLE tanto en la sentencia ALTER TABLE como en la sentencia CREATE TABLE
- La desactivación de una restricción UNIQUE o PRIMARY KEY elimina el índice único.

```
CREATE TABLE copy_employees(
employee_id NUMBER(6,0) PRIMARY KEY DISABLE.
...
);

ALTER TABLE copy_employees DISABLE CONSTRAINT c_emo_dept_id_fk;
```
### Uso de la Cláusula CASCADE
- La cláusula CASCADE desactiva las restricciones de integridad dependientes. Si la restricción de activa posteriormente, las restricciones dependientes no se activan automáticamente.

```
ALTER TABLE copy_departments
DISABLE CONSTRAINT c_dept_id_pk CASCADE;
```
### Activación de Restricciones
- Para activar una restricción de integridad actualmente desactivada, utilice la cláusula ENABLE en la sentencia ALTER TABLE
- ENABLE garantiza que todos los datos entrantes se ajustan a la restricción.

```
ALTER TABLE copy_departments
ENABLE CONSTRAINT c_dept_id_pk;
```

- **Puede usar ENABLE en la sentencia CREATE TABLE y en la sentencia ALTER TABLE.**
### Consideraciones sobre la Activación de Restricciones
- Si activa una restricción, se aplica a todos los datos de la tabla.
- Todos los datos de la tabla deben de cumplir con la restricción.
- Si activa una CLAVE UNIQUE o una restricción PRIMARY KEY, se crea un índice UNIQUE o PRIMARY KEY automáticamente.
- La activación de una restricción PRIMARY KEY desactivada con la opción CASCADE no activa ninguna clave ajena dependiente de la clave primaria.
- ENABLE vuelve a activar la restricción después de desactivarla.
### Restricciones en Cascada
- La cláusula CASCADE CONSTRAINTS se utiliza junto con la cláusula DROP COLUMN.
- Borra todas las restricciones de integridad referencial que hacen referencia a las claves primarias y únicas definidas en las columnas borradas.
- Borra también todas las restricciones de varias columnas definidas en las columnas borradas.

- **Si una sentencia ALTER TABLE no incluye la opción CASCADE CONSTRAINTS, cualquier intento de borrar una restricción de clave primaria o varias columnas fallará.**
- Recuerde que no puede suprimir un valor principal si existen valores secundarios en otras tablas.

```
ALTER TABLE table_name
DROP (column name(s) CASCADE CONSTRAINTS);
```
### Cuando No es Necesario CASCADE
- Si las columnas a las que hacen referencia la restricciones definidas en las columnas borradas también se borran, CASCADE CONSTRAINTS no es necesario.
- Por ejemplo, si ninguna restricción referencial de otras tablas hace referencia a la columna PK, es válido ejecutar la siguiente sentencia sin la cláusula CASCADE CONSTRAINTS.
- Sin embargo, si las columnas de otras tablas o las columnas que quedan en la tabla de destino hacen referencia a las restricciones, se deben especificar CASCADE CONSTRAINTS.
### Visualización de Restricciones
- Después de crear una tabla, puede confirmar su existencia emitiendo un comando DESCRIBE.
- La única restricción que se puede verificar con el comando DESCRIBE es la restricción NOT NULL.
- La restricción NOT NULL también aparece en el diccionario de datos como una restricción CHECK.

- Para ver todas las restricciones de la tabla, consulte la tabla USER_CONSTRAINTS
```
SELECT constraint_name, table_name, constraint_type, status
FROM USER_CONSTRAINTS
WHERE table_name = 'COPY_EMPLOYEES';
```
















































































































































































































