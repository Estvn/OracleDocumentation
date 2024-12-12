# Identificación de las Relaciones

**Objetivos:**
- Interpretar y describir la opcionalidad de las relaciones.
- Interpretar y describir la cardinalidad de las relaciones.
- Relacionar entidades aplicando las reglas de cardinalidad y opcionalidad.

- Las relaciones le ayudan a ver cómo las distintas partes de un sistema afectan a otras.
- Para modelar con precisión el negocio, las relaciones entre las entidades son tan importantes como las propias entidades.
- Ser capaces de identificar las relaciones entre entidades facilita la comprensión de las conexiones entre distintas partes de datos.

**Relaciones**
* Las relaciones muestran como las entidades se encuentras relacionadas entre si.
* Las relaciones representan algo significativo o importante para el negocio.
* **Solo puede haber relación de entidad a entidad (entre dos entidades), o a ella misma.**
* Las relaciones son bidireccionales.
* Se asignan en ambos extremos.
* Una relación puede ser obligatoria en un extremo, y opcional en el otro.
* Tienen opcionalidad y cardinalidad.
* Las relaciones debe tener: Nombre, opcionalidad y cardinalidad.

**¿Qué es la opcionalidad en una relación?**
- Las relaciones son obligatorias o son opcionales.
- Las opcionalidades definen si la instancia de una entidad debe o podría estar relacionada con la instancia de otra entidad.

**¿Qué es la cardinalidad en una relación?**
- La cardinalidad mide la cantidad de algo.
- En una relación determina hacía cuantas instancias de una entidad puede estar relacionada la instancia de una entidad distinta.

**Opcionalidad y cardinalidad**
- Cada EMPLEADO debe tener solo un CARGO
	- Se está definidiendo la opcionalidad y cardinalidad de empleado a cargo.

- Cada PRODUCTO se debe clasificar mediante solo un TIPO DE PRODUCTO.
- Cada CARGO puede estar ocupado por cero o más EMPLEADOS.

**Terminología**
- Cardinalidad.
- Opcionalidad.
- Relación.

# Convenciones en ERD

**Objetivos:**
- Crear componentes de ERD que representen entidades, atributos y relaciones, de acuerdo con las convenciones gráficas.
- Las convenciones de ERD son internacionales.

**Convención compartida**
- Es eficaz para comunicar información de forma que pueda ser fácilmente comprendida por varias personas.
- Los ERD se deben crear con sus convenciones generales para que pueda ser entendido por cualquier persona.

**Convenciones de las entidades**
- Las entidades están representadas por un cuadro de esquinas redondeadas.
- Los nombres de las entidades van en la esquina superior izquierda, dentro de los cuadros.
- Los nombres de las entidades están siempre en singular y escritos con todas las letras mayúsculas.

**Convenciones de los diagramas**
- Los atributos obligatorios se marcan con un asterisco.
- Los atributos opcionales se marcan con un círculo, o una "o" minúscula.
- Los identificadores únicos están marcados con un numeral "#".

- La relaciones son líneas que conectan entidades.
- Las líneas son continuas o descontinuas (relación opcional u obligatoria).
- Las líneas pueden terminar en un extremo de una sola línea, o varias (relación a uno o muchos).

**Terminología**
- Cuadro editable.
- Diagramas de ER.
- Pata de gallo.
- Un dedo.

# Interpretación de ERD y Dibujo de Relaciones

**Objetivos**
- Indicar relaciones entre entidades con palabras precisas.
- Dibujar y etiquetas relaciones correctamente en un ERD.

**Lenguaje de ERD**
- ERD es el lenguaje que se utiliza para indicar relaciones entre entidades en un ERD.
- El ERD proporcionará un lenguaje común al recopilar las reglas de negocio del cliente y comunicarlas a los administradores de base de datos que implantarán el diseño.
- **ERD describe una relación con palabras.**
- **EL ERD es el diagrama que se hace en el modelo lógico.**

**Componentes de un ERD**
- CADA
- Entidad A
- OPCIONALIDAD (debe ser/puede ser)
- NOMBRE DE LA RELACIÓN
- CARDINALIDAD (solo uno/uno o más)
- Entidad B
- Puesto que cada relación tiene dos partes, leemos la primera relación de izquierda a derecha, o de arriba a abajo (según el diseño del ERD).

![[Captura desde 2024-05-07 07-33-09.png]]


# Diagramas de Matriz

**objetivos:**
- Identificar las relaciones mediante un diagrama de matriz.
- Dibujar un ERD a partir de un diagrama de matriz.

- El uso de un diagrama de matriz, especialmente cuando trabaja con muchas entidades, es una buena forma de asegurarse de que no falta ninguna relación.
- Los diagramas de matriz se usan para encontrar las relaciones entre las entidades.
- Los diagramas de matriz se desarrollan antes de crear el ERD, ya que las relaciones encontradas en la matriz se definirán en el ERD.

**Diagrama de matriz**
- Para evitar la confusión, sea consistente a la hora de escribir y leer de la matriz solo en una dirección.
- Las relaciones descubiertas mediante el diagrama de matriz se dibujan en el ERD.
- Los diagramas de matriz no muestran la opcionalidad ni la cardinalidad.

![[Captura desde 2024-05-07 07-43-39.png]]

















