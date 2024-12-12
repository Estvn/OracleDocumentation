-- Este comando solo funciona en los usuarios que tiene un rol con los permisos necesarios.
SELECT * FROM C##_USR_DB_PAISES.PAISES;

-- Este comando solo funciona en los usuarios que tiene un rol con los permisos necesarios.
INSERT INTO C##_USR_DB_PAISES.PAISES VALUES (29, 'Honduras', 28);

-- REMOVIENDO PERMISO SELECT DE UNA TABLA EN UNA BD A LA QUE NO SE TIENE ACCESO.
REVOKE SELECT ON C##_USR_DB_PAISES.PAISES FROM C##_ROLE_ADMINISTRATORS;
-- GARANTIZANDO PERMISO SELECT DE UNA TABLA EN UNA BD A LA QUE NO SE TIENE ACCESO.
GRANT SELECT ON C##_USR_DB_PAISES.PAISES TO C##_ROLE_ADMINISTRATORS;

-- Asignando permisos de inserci�n, actualizaci�n y eliminaci�n para una tabla a un rol.
GRANT INSERT, UPDATE, DELETE ON C##_USR_DB_PAISES.PAISES TO C##_ROLE_ADMINISTRATORS;

-- Eliminando un privileegio DML a un rol.
REVOKE SELECT ON C##_USR_DB_PAISES.PAISES FROM C##_ROLE_ADMINISTRATORS;

-- Consulta para ver los permisos DML que tiene un rol o usuario
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'C##_ROLE_ADMINISTRATORS';

-- Consulta para ver los permisos DDL que tiene un rol
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'C##_ROLE_ADMINISTRATORS';

REVOKE 
CREATE ANY PROCEDURE, ALTER ANY PROCEDURE, DROP ANY PROCEDURE 
FROM C##_ROLE_ADMINISTRATORS;


SELECT * FROM DBA_ROLES; -- Ver todos los role existentes.
SELECT * FROM DBA_USERS; -- Ver todos los usuarios existentes.

