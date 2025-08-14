# Arcos

**objetivos**
- Definir el término "restricción" según se aplica al modelado de datos.
- Identificar una relación OR exclusiva en un caso de negocio.
- Trazar un diagrama de una restricción de arco para representar una relación OR exclusiva.
- Distinguir entre el uso de un arco y un subtipo en el modelado de datos.

**Introducción**
	- Los arcos en el modelado de datos ayudan a los diseñadores a aclarar un OR exclusivo entre relaciones. 
	- Cuanto más explícita sea la definición de los requisitos del cliente, más precisa será la implantación final.

**¿Qué es una restricción?**
- Cada empresa tiene restricciones sobre los valores de atributo y las relaciones que están permitidas. Esto es lo que se reconoce como restricciones.
- Se puede hacer referencia a un único atributo de una entidad o a relaciones entre entidades.

**Relación OR exclusiva**
- A veces existen relaciones mutuamente excluyentes entre las entidades que también se denominan relaciones OR exclusivas.
- **Una relación OR exclusiva es una relación entre una entidad y otras dos (o más) entidades en la que solo una de las relaciones puede existir a la vez.**
- En los ERD, modelamos este tipo de relación con un arco.
- Una relación OR exclusiva puede utilizarse donde hay dos entidades relacionadas en una entidad mayor, y solo la relación de una de estas dos entidades puede existir y estar relacionada a la entidad mayor, es decir, que la relación de estas dos entidades no pueden existir al mismo tiempo.
- Un ejemplo de las relaciones de arco, es donde hay una entidad que es CARTELERA, también  eopcionalidadstán las entidades PELICULA, PRODUCTO Y PUBLICIDAD_GENERAL. Estos tres tipos de publicidades no pueden estar al mismo tiempo en una misma cartelera. Entonces, es en este punto donde se aplican las relaciones de arco, porque una entidad, que en este caso es CARTELERA, no puede tener más de una entidad de las tres mencionadas, relacionadas al mismo tiempo.

**Representación de relaciones OR exclusivas en el ERD**
- Los arcos son una forma de representar relaciones mutuamente excluyentes en el ERD.
- Un arco se representa en un ERD como una línea continua con extremos curvos.
- Se dibuja un círculo en el arco para cada relación que forma parte del arco.
- Cada AFILIACION debe ser propiedad de una COMPAÑIA o de un CLIENTE, pero no de ambos.

![[Captura desde 2024-06-03 08-07-30.png]]

**Arcos**
- Un arco siempre pertenece a una entidad.
- Los arcos pueden incluir más de dos relaciones.
- No todas las relaciones de una entidad se deben incluir en un arco.
- La entidad puede tener varios arcos. 
- Un arco siempre debe constar con relaciones que tienen el mismo tipo de opcionalidad.
- Todas las relaciones de un arco deben ser obligatorias o todas deben ser opocionales.
- Las relaciones de un arco pueden ser de distinta cardinalidad, aunque es en casos poco comunes.

**Arcos, supertipos y subtipos**
- Tanto los arcos como los supertipos y subtipos modelan la exclusividad mutua.
- Determinadas situaciones se modelan mejor como un arco y otras como el supertipo y subtipos.
- **Supertipo/Subtipo:** Utilizado para modelar una jerarquía de entidades donde cada instancia del supertipo pertenece a uno y solo uno de los subtipos.
- **Arco:** Utilizado para representar exclusión mutua entre varias opciones de relación de una entidad.

**Terminología**
- Arco.
- Restricción.
- Relación OR exclusiva.
- Relación mutuamente excluyente.

# Jerarquías y Relaciones Recursivas

**Objetivos**
- Definir y dar ejemplo de una relación jerárquica. 
- Identificar los UID en un modelo jerárquico.
- Definir y dar un ejemplo de una relación recursiva. 
- Representar una relación recursiva en un ERD con un caso concreto.
- Crear un modelo con recursión y jerarquías para expresar el mismo significado conceptual.

**Introducción**
- A menudo, los roles se organizan por jerarquía en las organizaciones. 
- Los datos jerárquicos son muy comunes.
- Comprender las relaciones jerárquicas le ayudará a comprender:
	- Diagramas de organización de un negocio.
	- Estructuras de construcción.
	- Árboles familiares.
	- Y muchas otras jerarquías que se encuentran en el mundo real.

**Relaciones de un diagrama de organización**
- La jerarquía de los informes de una organización puede estar representada por un diagrama de organización. Una especie de mapa conceptual donde se muestra la jerarquía de una organización.
- Un diagrama de organización en un ERD está representado por un modelo de datos donde creamos una entidad para cada nivel, con una relación con el siguiente nivel.
- Estas relaciones jerárquicas son una especie de relaciones en cascada. 

**Jerarquía frente a una relación recursiva**
- **Una relación no puede ser jerárquica y recursiva al mismo tiempo.**
- **Jerarquía**
	- Las estructuras jerárquicas son más explícitas y más fáciles de entender para la mayoría de los usuarios porque son muy similares a un diagrama de organización.
	- Cada entidad puede tener sus propios atributos y relaciones obligatorias, si el negocio lo requiere.
	- De esta forma, los modelos de datos reflejan las reglas del negocio.
	
- **Recursividad**
	- Las relaciones recursivas tienden a ser más sencillas porque está utilizando únicamente una entidad.
	- El diagrama ERD estará menos "ocupado".
	- Sin embargo, las relaciones recursivas son menos específicas: a diferencia de las relaciones jerárquicas, las relaciones recursivas no pueden tener atributos o relaciones obligatorias, a menos que estos sean obligatorios para todas las instancias de la entidad.

![[Captura desde 2024-06-03 08-56-34.png]]

**Convención de diagramas**
- La convención de ERD para mostrar una relación recursiva se dibuja como un bucle, también denominado "oreja".
- El modelo se puede crear como una relación recursiva simple

 ![[Captura desde 2024-06-03 09-11-39.png]]

**Terminología**
- Relación jerárquica.
- Relación recursiva.
