-- CREACIÓN DE UN USUARIO
CREATE USER C##_USR_BD_BICICLETAS
IDENTIFIED BY 123
DEFAULT TABLESPACE users -- Se crean de forma lógica todos los elementos que se quieran usar en la DB
TEMPORARY TABLESPACE temp -- Se guarda temporalmente todos los objetos creados y usados en una sesión.
QUOTA UNLIMITED ON users; -- Se define una capacidad ilimitada para el nuevo usuario en la tabla users.

-- Cuando se termina de hacer la creación del usuario no tiene permisos de nada. 
-- Garantización y revocación de los privilegios a un usuario.
GRANT ALL PRIVILEGES TO C##_USR_BD_BICICLETAS;
REVOKE AL PRIVILEGES FROM C##_USR_BD_BICICLETAS;

-- Para otorgar permisos a un usuario se pueden hacer dos cosas:
-- 1. Otorgar permisos directamente a un usuario.
-- 2. Crear un rol con los permisos necesarios para luego otorgar ese rol al usuario (RECOMENDABLE).

-- Se puede asignar uno o varios permisos a los usuarios y los roles.
-- CREANDO UN ROL
CREATE ROLE C##_ADMIN_BD_BICICLETAS;

-- OTORGANDO PRIVILEGIOS A UN ROL
GRANT CREATE SESSION, 
CREATE ANY TABLE, CREATE ANY PROCEDURE, CREATE ANY TRIGGER,
ALTER ANY TABLE, ALTER ANY PROCEDURE, ALTER ANY TRIGGER,
DROP ANY TABLE, DROP ANY PROCEDURE, DROP ANY TRIGGER 
TO C##_ADMIN_BD_BICICLETAS;

-- REMOVIENDO PRIVILEGIOS DE UN ROL
REVOKE
CREATE ANY TRIGGER, ALTER ANY TRIGGER, DROP ANY TRIGGER
FROM C##_ADMIN_BD_BICICLETAS;

-- ASIGNANDO UN ROL A UN USUARIO
GRANT C##_ADMIN_BD_BICICLETAS TO C##_USR_BD_BICICLETAS;

-- CONSULTADO ROLES Y USUARIOS CREADOS
SELECT * FROM DBA_ROLES;
SELECT * FROM DBA_USERS;

-- CONSULTANDO LOS PRIVILEGIOS ASIGNADOS A UN ROL.
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'C##_ROLE_ADMINISTRATORS';


















