
**Objetivos:**

- Listar y definir los diferentes tipos de unidades léxicas disponibles en PL/SQL
- Describir identificadores e identificar, validar e invalidar identificadores en PL/SQL.
- Describe and identify reserved words, delimiters, literals, and comment in PL/SQL.

# Lexical Units in a PL/SQL Block

Lexical units:
- Are the building blocks of any Pl/SQL block
- Are sequences of characters including letters, digits, tabs, returns and symbols.

Can be classified as:
- Identifiers
- Reserved words
- Delimiters
- Literals
- Comments

# Identificadores

- Es el nombre dado a un objeto PL/SQL
- Varios identificadores son resaltados en el bloque PL/SQL

#### Propiedades de los identificadores

- Máximo 30 caracteres 
- Deben empezar con una letra
- Pueden incluir: $, \_, #
- No deben tener espacios
- No son sensibles a las mayúsculas o minúsculas

- Los ideal es que su identificador describa al objeto y su propósito.
- Evite los nombres de identificadores simples o genéricos.

# Palabras reservadas

- Son palabras con un significado especial en la base de datos Oracle
- Las palabras reservadas no pueden ser usadas como identificadores en un programa PL/SQL

# Delimitadores

- Son símbolos que tienen un significado especial.
- Consisten en un simple caracter (+, *, /, =)
- Los delimitadores compuestos consisten en dos caracteres (<>, !=, ||)

# Literales

- Los literales son un numérico explícito, cadenas de caractes, date, o valor booleano que puede estar almacenado en una variable.

Los literales son clasificados como:
- Character
- Numeric
- Boolean

#### Caracteres literales

- Deben incluir algún caracter imprimible en PL/SQL
- Típicamente son definidos usando el tipo de dato VARCHAR2
- Deben ser encerrados por los delimitadores de cadenas ('')
- Pueden estar compuestos de 0 o más caracteres
- Son sensibles a las mayúsculas y minúsculas.
 
#### Literales numéricos

- Pueden ser valores como (5, -32.4, 127634, 3.141592)
- Pueden añadirse notaciones científicas
- Típicamente usan el tipo de dato NUMBER

#### Literales Booleanos

- TRUE, FALSE y NULL son lo literales booleanos.

# Comentarios

- Los comentarios de programación de toda la vida.

















































































