
**Objetivos:**

- Listar y explicar diferentes privilegios de objetos
- Explicar la función de ejecutar privilegios de objetos
- Escribir declaraciones SQL para dar y remover privilegios de objetos

- **Ya sabe que uno de los beneficios de los subprogramas PL/SQL es que pueden ser reusados en diferentes aplicaciones.**
- Los usuarios pueden llamar y ejecutar subprogramas solo si ellos tienen los privilegios para hacer eso.

# ¿Qué es un Privilegio en un Objeto?

- Un privilegio de objeto te permite usar un objeto especifico de la base de datos, tal como una tabla, una vista, o un procedimiento PL/SQL, para uno o más usuarios de la base de datos.

- **Cuando un objeto en la base de datos es creado, solo el propietario y el administrador de la base de datos tienen el privilegio de usarlo.**

- Los privilegios a los otros usuarios deben ser especificados mediante el GRANT (o quizás luego removerlos con el REVOKE).
- Esto puede ser realizado por el propietario del objeto o por el DBA.

# ¿Qué Privilegios de Objeto Están Disponibles?

- Cada objeto tiene sus permisos definidos 

| Privilegio del objeto | Tabla | Vista | Secuencia | Procedimiento |
| --------------------- | ----- | ----- | --------- | ------------- |
| ALTER                 | X     |       | X         |               |
| DELETE                | X     | X     |           |               |
| EXECUTE               |       |       |           | X             |
| INDEX                 | X     |       |           |               |
| INSERT                | X     | X     |           |               |
| REFERENCES            | X     | X     |           |               |
| SELECT                | X     | X     | X         |               |
| UPDATE                | X     | X     |           |               |
# ¿Qué Privilegios de Objeto están Disponibles?

- SELECT, INSERT, UPDATE y DELETE permiten al titular del privilegio usar la instrucción SQL correspondiente en el objeto.
- El privilegio **ALTER** permite que se hagan alteraciones en la tabla, mientras que **INDEX** permiten que se creen índices en la tabla.
	- Por supuesto, puedes hacerlo automáticamente haciéndolo en tus propias tablas

- El privilegio REFERENCES permite chequear por la existencia de las filas en una tabla o una vista usando restricciones de FK.

# Concediendo Privilegios de Objeto con GRANT

Sintáxis:

```
GRANT object_priv [(columns)] 
ON object
TO {user | role | PUBLIC}
[WITH GRANT OPTION];
```

> [!NOTA] WITH GRANT OPTION
> Permite al usuario o rol al que se le concibieron los privilegios, otorgar los privilegios que se le han dado, a otros usuarios o roles.

Ejemplos:

```
GRANT INSERT, UPDATE 
ON employees 
TO TOM, SUSAN;
```

```
GRANT SELECT
ON departments
TO PUBLIC;
```

# Removiendo Privilegios de Objeto con REVOKE

Sintáxis:

```
REVOKE object_priv [(columns)]
ON object
FROM {user | role | PUBLIC};
```

Ejemplos:

```
REVOKE INSERT, UPDATE 
ON employees
FROM TOM, SUSAN;
```

```
REVOKE SELECT
ON departments
FROM PUBLIC;
```

# Usando el Privilegio EXECUTE con Subprogramas Almacenados

- Para invocar y ejecutar un subprograma PL/SQL, el usuario debe tener el privilegio EXECUTE en el subprograma

```
CREATE OR REPLACE PROCEDURE add_dept ...;
CREATE OR REPLACE FUNCTION get_sal ...;

GRANT EXECUTE ON add_dept TO TOM, SUSAN;
GRANT EXECUTE ON get_sal TO PUBLIC;

REVOKE EXECUTE ON get_sal FROM PUBLIC;
```

# Referencias Objetos en Subprogramas

¿Qué pasa con los objetos que son referenciados dentro de subprogramas?
- **Solo necesita ejecutar los privilegios a un subprograma**

```
CREATE OR REPLACE PROCEDURE add_dept ...
IS BEGIN
	...
	INSERT INTO DEPARTMENTS ...;
	...
END;
```

```
GRANT EXECUTE ON add_dept TO SUSAN;
```

- **Los usuarios o roles no necesitan privilegios para los objetos que están siendo usados en los subprogramas que usan directamente.**


• El propietario (creador) del subprograma debe tener los privilegios adecuados sobre los objetos referenciados por el subprograma; esto se denomina "Derechos del definidor".

```
(Table owner or DBA): GRANT INSERT ON departments TO TOM;

(Tom) CREATE OR REPLACE PROCEDURE add_dept ...
IS BEGIN
...
INSERT INTO DEPARTMENTS ... ;
...
END;
(Tom) GRANT EXECUTE ON add_dept TO SUSAN;
```





















