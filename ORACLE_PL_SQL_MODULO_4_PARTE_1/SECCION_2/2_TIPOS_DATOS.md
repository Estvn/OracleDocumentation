
**Objetivos:**

- Explicar el tipo de datos y por qué se necesita
- Listar y describir las categorías de los tipos de datos
- Dar ejemplos de los tipos de datos escalares y compuestos

- PL/SQL incluye una variedad de tipos de datos que se usan para definir variables, constantes y parámetros.
- Como en las columnas de las tablas, tienen tipos de datos que especifican el tipo y el tamaño de la data que puede ser almacenada en un lugar en particular.

# Tipos de datos PL/SQL

- PL/SQL soporta 5 categorías de tipos de datos.
- Un tipo de dato especifica el formato de almacenamiento, restricciones y un rango de valores válidos

| Tipo de dato       | Descripción                                                                                                                                         |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| Escalar            | Tiene un solo valor sin elementos internos                                                                                                          |
| Compuesto          | Contiene múltiples elementos internos que pueden ser manipulados internamente.                                                                      |
| Large Object (LOB) | Tiene valores llamados localizadores que especifican la ubicación de objetos grandes (como imágenes gráficas) que están almacenadas fuera de línea. |
| Reference          | Tiene valores llamados punteros que apuntan a una ubicación en memoria                                                                              |
| Objeto             | Es un esquema con un nombre, atributos y métodos. Un objeto es un tipo de datos similar a los mecanismos de clases de C++ y Java.                   |

# Tipos de datos Escalares

- Tienen un solo valores
- No tienen componentes internos

**Se clasifican en cuatro categorías:**

- CHAR
- NUMBER
- DARE
- BOOLEAN

Los diferentes tipos de datos especifican:

- Que tipo y que tamaño de data puede estar almacenado en una ubicación
- El rango de los valores que puede tener
- El tipo de operaciones que se pueden aplicar a los valores de ese tipo

Tipos de datos escalares:

- CHAR, VARCHAR2, LONG
- NUMBER, PLS_INTEGER
- DATE, TIMESTAMP, TIMESTAMP WITH TIME ZONE

- Use el valor Boolean para almacenar valores lógicos TRUE, FALSE, NULL
- Solo operaciones lógicas están permitidas para las variables booleanas
- Las columnas de las tablas no deberían ser definidas con un tipo de datos booleano.
- **El tipo de dato Boolean está permitido en PL/SQL pero no en SQL**

# Tipos de datos Compuestos

- Tienen componentes internos, a veces llamados elementos que pueden ser manipulados individualmente.

**Los tipos de datos compuestos incluyen lo siguiente:**

- RECORD
- TABLE
- VARRAY

> [!NOTA]
> Se puede crear una variable compuestas que contenga componentes internos que coincidan con la estructura de datos de una tabla

```
v_emp_record employees%ROWTYPE;
v_emp_record.first_name;
```

### Tipo de dato LOB

- El tipo de dato LOB te permite almacenar bloques de data desestructurada (texto, imágenes, video, audio) en tamaños de 4gb.
- Una columna de base de datos puede ser un tipo de dato LOB.

Hay cuatro tipos de datos LOB:
- Character large object (CLOB)
- Binary large object (BLOB)
- Binary file (BFILE)
- National language character large object (NCLOB)

- Los tipos de datos LOB almacenan localizadores, que apuntan a objetos grande almacenados en un archivo externo.
- Los tipos de datos LOB permiten un acceso eficiente, aleatorio y fragmentado a los datos.
- Los datos CLOB, BLOB y NCLOB se almacenan en la base de datos, ya sea dentro o fuera de la fila.
- Los datos BFILE se almacenan en archivos del sistema operativo fuera de la base de datos.

![[Pasted image 20250630105948.png]]
































