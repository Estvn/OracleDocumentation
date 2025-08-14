
**Objetivos:**

- Contrastar los derechos de invocador con los derechos del definidor
- Crear un procedimiento que usar derechos de invocador
- Crear un procedimiento que ejecuta una Autonomous Transaction

- En la lección anterior aprendiste que el creador el subprograma PL/SQL se le debe otorgar los privilegios de objeto relevantes en las tablas a las que hace referencia las sentencias SQL dentro del subprograma.
- También, se asumen que los nombres de las tablas, nombres de vistas, etc., están en el esquema del creador del subprograma a menos que se les anteponga explícitamente un nombre de esquema diferente.
- **Esta forma de revisar la referencia de los objetos es llamado derechos del definidor.**

# Usando Derechos del Definidor

- "Definer" significa el propietario (usualmente el creador) del subprograma PL/SQL
- "Invoker" refiere al usuario que llama al programa

**Cuando los derechos del definidor son usados:**

- El definidor necesita privilegios en los objetos de la base de datos para referenciar dentro del subprograma.
- El invocador solo necesita ejecutar privilegios en el subprograma

- El subprograma ejecuta en la sesión de bases de datos del usuario, pero con los privilegios y nombres de tabla del definidor

# Usando Derechos del Invocador

**Cuando los derechos de invocador son usados:**

- El invocador de necesita privilegios sobre los objetos de la base de datos referenciados dentro del programa, así como el privilegio de ejecutar sobre el procedimiento.
- El definidor no necesita ningún privilegio.

- **El subprograma se ejecuta en la sesión de la base de datos del usuario, con los privilegios del usuario, referencias de tablas y sinónimos.**

# Usando Derechos de Invocador

- Agregue AUTHID a CURRENT_USER, inmediatamente antes de IS | AS:

```
CREATE OR REPLACE FUNCTION grades(
	p_name IN VARCHAR2)
RETURN NUMBER
AUTHID CURRENT_USER IS
	v_score NUMBER;
BEGIN
	SELECT score INTO v_score FROM tests WHERE key=p_name;
	RETURN v_score;
END;
```

- **Ahora los privilegios del usuario y las referencias de tabla son revisados en tiempo de ejecución.**
- Usando los derechos del invocador, los nombres de los objetos se resuelven en el esquema del invocador.

```
Tom> CREATE TABLE tests ... ;
Sue> CREATE TABLE tests ... ;

Tom> CREATE OR REPLACE PROCEDURE grades ...
	AUTHID CURRENT_USER IS BEGIN
	... SELECT ... FROM tests ... ;
END;

Tom> GRANT EXECUTE ON grades TO sue;
Sue> BEGIN ... tom.grades(...); ... END;
```

> [!NOTA]
> **AUTHID CURRENT_ID** es usado para que se usen los permisos del usuario que está ejecutando los objetos, no los permisos del definidor.

# Autonomous Transactions

- **Usando una transacción autónoma, tu sesión puede tener dos o más transacciones activas al mismo tiempo, las cuales pueden hacer COMMIT o ROLLBACK independientemente de cada otro.**

> [!IMPORTANT]
> - PRAGMA AUTONOMOUS_TRANSACTION puede hacer COMMIT o ROLLBACK sin afectar la transacción del bloque que lo llamó. 
> - El bloque se ejecuta como una transacción independiente de la transacción principal que lo llamó.
## ¿Cuándo una Transacción Autónoma se Necesita?

- La Autonomous Transaction (AT) es llamada dentro de la Main Transaction (MT)
- La AT debe estar en un subprograma separado, con **PRAGMA_AUTONOMOUS_TRANSACTION;** codificado inmediatamente después de IS/AS

```
PROCEDURE at_proc IS
	PRAGMA_AUTONOMOUS_TRANSACTION;
	dept_id NUMBER := 90;
BEGIN
	UPDATE ...
	INSERT ...
	COMMIT; -- Required
END at_proc;
```
  
# Creando una Autonomous Transaction

- Note que **PRAGMA AUTONOMOUS_TRANSACTION** debe termina con ";" y antes viene IS/AS
- **La transacción autónoma debe usar COMMIT o ROLLBACK dentro del mismo procedimiento**

```
PROCEDURE log_usage (p_card_id NUMBER, p_loc NUMBER)
IS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO log_table(card_id, location, tran_date)
        VALUES (p_card_id, p_loc, SYSDATE);
    COMMIT;
END atm_trans;

PROCEDURE atm_trans(p_cardnbr NUMBER, p_loc NUMBER) IS
BEGIN
    ... -- try to withdraw cash
    log_usage(p_cardnbr, p_loc);
    ... -- id withdraw fails then
    ROLLBACK;
END atm_trans;
```











































