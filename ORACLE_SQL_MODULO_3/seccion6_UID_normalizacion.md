# UID Artificiales, Compuestos y Secundarios

**Objetivos**
- Definir los diferentes tipos de identificadores únicos.
- Definir un UID candidato y explicar por qué una entidad puede tener a veces más de un UID candidato.
- Analizar las reglas de negocio y elegir el UID primario más adecuado de los candidatos.
- Reconocer y debatir los problemas de identificación del mundo real.

**Introducción**
- El identificador único (UID) es muy importante en las bases de datos relacionales.
- Es el valor o combinación de valores que permite al usuario encontrar ese elemento único entre todos los demás.
- La identificación de justo el atributo correcto, o una combinación de atributos y relaciones, es una habilidad que cualquier diseñador de bases de datos debe dominar.
- **El identificador único permite buscar un registro en un archivo.**

**UID Simples frente a UID Compuestos**
- Un UID es solo un atributo simple, como los demás atributos en una tabla.
- Sin embargo, a veces un único atributo no es suficiente para identificar de forma única una instancia de una entidad.
- **Si el UID es una combinación de atributos, se denomina UID compuesto.**

![[Captura desde 2024-05-23 14-30-16.png]]

**UID Artificiales**
- Los UID artificiales son aquellos que no se producen en un mundo natural, pero se crean para fines de identificación en un sistema.
- Las personas no nacen con "números", pero muchos sistemas asignan números únicos para identificar a las personas: id_alumno, id_cliente, etc.
- A menudo, es más sencillo y más fácil crear un atributo artificial y convertirlo en el identificador único.

Un zapato tiene un color, un número de pie, un estilo, pero ningún número realmente descriptivo. Sin embargo una tienda de zapatos asignará números únicos a cada par de zapatos para que se puedan identificar de forma única: id_zapato.

**UID de Relaciones Excluidas**
- **A veces, el UID es una combinación de un atributo y una relación.**
- Dos personas podrían tener el mismo número de cuenta bancaria, pero en diferentes bancos.
- Las transferencias entre bancos siempre necesitan el número ABA del banco, además del número de cuenta bancaria.

![[Captura desde 2024-05-23 14-40-40.png]]

**UID de Entidad de Intersección de Relación Excluida**
- En la resolución de una relación M:M suele producir relaciones excluidas de la entidad de intersección a las originales. 
- Las barras de las relaciones indican que el UID de una entidad proviene de las entidades de las que se relaciona.

**Entidad de Intersección con UID Artificial**
- Una entidad de intersección puede utilizar un atributo artificial como UID, en lugar de las relaciones excluidas con las entidades originales.
- Cuando se usa un UID artificial y hay relaciones entre entidades, las relaciones entre las entidades no están excluidas, porque no se usan sus UID para generar un UID a la entidad con la que se relacionan.

**UID Candidatos**
- A veces existen dos o más posibles UID.
- Por ejemplo, cuando se solicita un producto de un sitio web comercial, normalmente se le asignará un código de cliente único y se le pedirá que introduzca su correo electrónico. Cada uno de ellos le identifica de forma única y ambos se podrían elegir como un UID. Ambos son UID candidatos.
- Solo se elige uno de los UID candidatos como UID real. Esto se denomina UID primario.
- Los demás candidatos se denominan UID secundarios.

**Identificación: Base de Datos Frente al Mundo Real**
- Los identificadores únicos nos permiten distinguir una instancia de una entidad de otra.
- Como verá más adelante, estos se convierten en claves primarias en la base de datos.
- Una clave primaria permite acceder a un registro concreto de una base de datos.

**Terminología**
- UID artificial.
- UID candidato.
- UID compuesto.
- UID primario.
- UID secundario.
- UID simple.

# Normalización y Primer Formato Normal

**Objetivos**
- Definir el objetivo de la normalización en las bases de datos.
- Definir la regla del primer formato normal en el proceso de normalización.
- Determinar si una entidad cumple con la regla del primer formato normal.
- Convertir una entidad al primer formato normal si es necesario.

**Introducción**
- ¿Qué sucede si los datos se almacenan en más de un lugar en una base de datos?
- ¿Qué sucede si alguien cambia la información en un lugar y en otro no? ¿Cómo sabe qué información es correcta?
- Una redundancia como esta provoca problemas innecesarios en una base de datos

**Normalización**
- La normalización es un proceso que se utiliza para eliminar este tipo de problemas.
- **Uno de sus objetivos como diseñador de base de datos es almacenar la información en un lugar, y en el mejor lugar posible.**
- Si sigue las reglas de la normalización, logrará este objetivo.

**Primer Formato Normal (1NF)**
- **El primer formato normal necesita que no existan atributos de varios valores.**
- Para comprobar el 1NF, valide que cada atributo tiene un único valor para cada instancia de la entidad.
- Existe un código, un nombre y una dirección para un centro educativo, pero no para un aula.
- **El primer formato normal nos dice que una entidad no puede tener un atributo que pueda tener distintos valores en una instancia. Si un atributo presenta casos donde puede tener sus propios atributos, la mejor opción es convertirlo en otra tabla con sus propios atributos y relacionarla con la entidad principal, es la mejor opción.**
- Si un atributo tiene varios valores, creamos una entidad adicional y la relacionamos con la entidad original en una relación 1:M
- **Cuando todos los atributos de una entidad tienen su propio valor, se dice que esa entidad está en el primer formato normal.**

 **Terminología**
 - Primer formato normal (1NF)
 - Normalización
 - Redundancia

# Segundo Formato Normal

**Objetivos**
- Definir la regla del segundo formato normal en el proceso de normalización.
- Examinar una entidad no normalizada y determinar que regla o reglas de normalización se violan.
- Aplicar la regla del segundo formato normal para resolver una violación en el modelo.

**Introduccción**
- **Su objetivo como diseñador de base de datos es "almacenar la información en un lugar solo y en el mejor lugar posible".**
- La aplicación consistente de las reglas de normalización ayuda a lograr este objetivo.
- Al organizar la información como, por ejemplo, los números de teléfono y las direcciones de sus amigos, desea asegurarse de que almacena esa información en el lugar adecuado, como una libreta de direcciones personal.
- Si almacena la dirección de un amigo en la caja de recetas, por ejemplo, puede que no lo encuentre hasta la próxima vez que consulte la receta.
- La normalización es un proceso que ayuda a eliminar estos tipos de problemas.

**Descripción del Segundo Formato Normal**
- **Todos los atributos que no sean UID deben depender de todo el UID.**
- El segundo formato normal (2NF) necesita que cualquier atributo que no sea UID, dependa, sea propiedad o una característica de todo el UID.
- **El segundo formato normal nos dice que si hay muchas entidades con un atributo que es probable que cambie, para evitar realizar a mano el cambio para este atributo en todas las entidades, la mejor opción es crear una tabla que contenga este atributo, y así realizar los cambios en un solo lugar.**
- Por ejemplo, si hay un nombre de proveedor, y se hacen 100 instancias con este nombre, y luego cambia, si no se ha hecho una entidad de proveedor, se tendrá que hacer el cambio en todas las instancias relacionadas. Por esta razón es mejor tener una entidad de proveedor, y hacer el cambio solo en un lugar.

**Relación excluida del segundo formato normal**
- El UID de una entidad puede ser un UID compuesto por una relación excluida que consta de dos entidades.
- Si un atributo se encuentra en muchas entidades y tiene probabilidad de cambiar con el tiempo, la mejor opción es crear una tabla a parte para manejar los cambios en un único lugar.

# Tercer Formato Normal

**Objetivos**
- Identificar las dependencias transitivas en un modelo de datos.
- Definir la regla del tercer formato normal en el proceso de normalización.
- Examinar una entidad no normalizada y determinar que regla o reglas de normalización se violan.
- Aplicar la regla del tercer formato normal para resolver una violación en el modelo.

**Introducción**
- **Su objetivo como diseñador de bases de datos es "almacenar la información es un solo lugar y en el mejor lugar posible"**
- Si sigue las reglas de normalización podrá lograr este objetivo.
- Si tiene varios amigos que van al mismo centro educativo e introduce la dirección del centro junto con cada uno de ellos, no solo duplicaría los datos, sino que produciría posibles problemas: por ejemplo, si el centro educativo se traslada y cambia de dirección, tendría que volver atrás y cambiarlo en todas partes.
- La normalización es un proceso para eliminar estos tipos de problemas.

**Regla del Tercer Formato Normal**
- **La regla del tercer formato normal indica que ningún atributo que no sea UID puede depender otro atributo que no sea UID.**
- **Los atributos que no son UID no pueden tener atributos por si mismos.**
- El tercer formato normal prohíbe las dependencias transitivas.
- *Una dependencia transitiva se produce cuando cualquier atributo de una entidad depende de cualquier otro atributo que no sea el UID de esa entidad.*
- **El tercer formato normal no dice que no puede haber un atributo que dependa de otro atributo común dentro de una entidad, lo ideal es crear una tabla a parte, para evitar que atributos dependan de otro atributos normales.**

