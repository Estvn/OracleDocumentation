/*

- Programación con Oracle PL/SQL - Módulo 2
- Estiven J. Mejia
- Tarea 2
*/

-- Creando la tabla de departamentos
CREATE TABLE DEPARTAMENTOS 
AS
SELECT * FROM DEPARTMENTS 
WHERE 1 = 0;

INSERT INTO DEPARTAMENTOS VALUES (2, 'XDnt', 2, 2);

DESCRIBE DEPARTAMENTOS;

SELECT * FROM DEPARTAMENTOS;

-- Agregando ID a la tabla de DEPARTAMENTOS
ALTER TABLE DEPARTAMENTOS
ADD CONSTRAINT PK_DEPARTAMENTOS PRIMARY KEY (DEPARTMENT_ID);

----------------------------------------------------------

-- Creando tabla para registro de inserciones en LOG_DEPARTAMENTOS
CREATE TABLE LOG_DEPARTAMENTOS(
    USUARIO VARCHAR2(50),
    FECHA TIMESTAMP
);

SELECT * FROM LOG_DEPARTAMENTOS;

----------------------------------------------------------

-- Creación de TRIGGER que almacena el usuario y fecha que se ha insertaedo en la tabla de DEPARTAMENTOS 
CREATE OR REPLACE TRIGGER TGR_USR_INSERT_DEPARTAMENTOS
BEFORE INSERT ON DEPARTAMENTOS
BEGIN
    INSERT INTO LOG_DEPARTAMENTOS VALUES(USER, SYSDATE);
END;