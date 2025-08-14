
**Objetivos:**

- Definir que es una transacción
- Construir y ejecutar declaraciones de control de transacciones en PL/SQL.


- Las transacciones comúnmente tienen varias partes o pasos.
- Si algo impide, por ejemplo, que se complete el tercer paso, se mantiene la integridad de la base de datos, ya que los pasos uno y dos no modificaron la base de datos porque nunca se emitió una sentencia COMMIT

- **Las declaraciones COMMIT o ROLLBACK le dan control adicional en el procesamiento de las transacciones.**

# Transacciones en la Base de Datos

- Una transacción es una lista inseparable de las operaciones de la base de datos que deben ser ejecutadas ya sea por completo o ninguna en absoluto.
- **Las transacciones mantienen la integridad de la data y garantizan que las bases de datos siempre estén en un estado consistente.**

- Un ejemplo de las transacciones es si usted intenta retirar más dinero del que posee en su cuenta de banco. Si tiene el dinero, todos los pasos se ejecutan y se hace COMMIT. Si no tiene el dinero, se harán unos pasos, pero el paso donde se detecte el problema no termina de ejecutarse y se hace ROLLBACK.

# Estados de Control de las Transacciones

- **Puede usar declaraciones de control de transacciones para hacer cambios permanentes en la base de datos o deshacerlos todos.**

Hay tres comando principales de transacciones:
- COMMMIT 
- ROLLBACK
- SAVEPOINT

- Los comandos de transacciones son válidos en PL/SQL y **pueden ser ejecutados directamente en la sección de Excepciones de un bloque PL/SQL.**

# COMMIT 

- COMMIT es usado para hacer cambios permanentes en la base de datos.
- Si una transacción termina con un COMMIT, todos los cambios hechos durante la transacción serán permanentes en la base de datos.

```
BEGIN
	INSERT INTO pairtable values(1,2);
	COMMIT;
END;
```

- La palabra END señala el fin del bloque PL/SQL, no el fin de la transacción.
- Una transacción puede incluir múltiples bloques PL/SQL y bloques PL/SQL anidados.

# ROLLBACK

- ROLLBACK es para descartar cualquier cambio que fue hecho en la base de datos después del último COMMIT.
- Si la transacción falla, o termina con un ROLLBACK, entonces ninguno de los cambios hará efecto en la base de datos.

```
BEGIN
	INSERT INTO pairtable values(3,4);
	ROLLBACK;
	INSERT INTO pairtable VALUES(5,6);
	COMMIT;
```

# SAVEPOINT 

- SAVEPOINT es usado para marcar un punto en el proceso de la transacción.
- ROLLBACK es usado para retornar los valores de la data al punto del SAVEPOINT.

```
BEGIN
	INSERT INTO pairtable VALUES(7,8);
	SAVEPOINT my_sp_1;
	INSERT INTO pairtable VALUES(9,10);
	SAVEPOINT my_sp_2;
	INSERT INTO pairtable VALUES(11,12);
	ROLLBACK to my_sp_1;
	INSERT INTO pairtable VALUES(13,14);
	COMMIT;
```








































