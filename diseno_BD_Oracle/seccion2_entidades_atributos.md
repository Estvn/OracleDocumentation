# Modelos Conceptuales y Físicos

**Objetivos:**
- Explicar la importancia de comunicar de forma clara y capturar de forma precisa los requisitos de información.
- Distinguir entre un modelo conceptual y su implantación física.
- Enumerar cinco motivos para crear un modelo de datos conceptual.
- Proporcionar ejemplos de modelos conceptuales y físicos.
- Cuándo sea capaz de reconocer y analizar información, podrá comprender mejor cómo funcionan las cosas, y posiblemente mejorarlas.
- **El reconocimiento y análisis de la información ayuda a evitar errores y malentendidos.** Para un negocio esto es importante, ya que se ahorra tiempo y dinero.

**¿Qué es un modelo conceptual?**
- Un modelo conceptual:
	- Captura las necesidades funcionales e informativas de un negocio.
	- Se basa en las necesidades actuales, pero puede reflejar las necesidades futuras.
	- Un modelo conceptual aborda las necesidades de un negocio (lo que es idóneo conceptual-mente), pero no aborda su implantación (lo que es posible físicamente).
	- Es el resultado de terminar el proceso de modelado de datos.

* Un modelo conceptual:
	* Identifica entidades importantes (objetos que se convierte en tablas en la base de datos) y relaciones entre entidades.
	* No especifica atributos e identificadores únicos (un atributo que se convierte en una PK en la base de datos).

- Un modelo conceptual es importante para un negocio porque:
	* Describe exactamente las necesidades de información de un negocio.
	* Facilita la explicación.
	* Evita errores y malentendidos.
	* Formula documentación importante del "sistema ideal".
	* Formula una base sólida para el diseño de la base de datos física.
	* Documenta los procesos (también denominado "reglas de negocio") del negocio.
	* Tiene en cuenta las normativas y leyes que rigen este sector.

**¿Qué es un modelo lógico?**
- Un modelo lógico:
	- Incluye todas las entidades y relaciones entre sí.
	- Se denomina modelo de relación de entidades (ERM).
	- Se ilustra en un ERD.
	- Especifica todos los atributos y UID para cada entidad.
	- Determina la opcionalidad de los atributos.
	- Determina la opcionalidad y cardinalidad de la relación.

**¿Qué es un modelo físico**
- Es una extensión del modelo de datos lógico.
	- Especifica las definiciones de la tabla, los tipos de datos y la precisión.
	- Identifica las vistas, los índices y otros objetos de la base de datos.
- Describe como se deben implantar los objetos en una base de datos específica.
- Muestra todas las estructuras de la tabla, incluidas las columnas, las claves primarias y foráneas.

**Modelos conceptuales y físicos**
- El modelado de datos es el proceso de capturar los conceptos importantes y las reglas que dan forma a un negocio y de representarlos visualmente en un diagrama.
- Es el arte de la planificación, el desarrollo y la comunicación que permite a un grupo de personas que trabajan conjuntamente lograr un resultado deseado.
- Este diagrama se convierte en el plano para diseñar el elemento físico.

**Terminología**
- Modelo conceptual.
- Datos.
- Modelado de datos. 
- Modelo físico.

# Entidades, Instancias, Atributos e Identificadores

**Objetivos:**
- Definir y dar ejemplo de una entidad.
- Distinguir la diferencia entre una entidad, y la instancia de una entidad. 
- Nombrar y describir los atributos de una entidad determinada.
- Distinguir entre un atributo y su valor. 
- Distinguir entre atributos obligatorios y opcionales.
- Distinguir entre atributos volátiles y no volátiles.
- Seleccionar y justificar un identificador único (UID) para una entidad.

**Objetivo de las entidades**
- Saber como organizar y clasificar datos posibilita extraer conclusiones útiles sobre hechos aparentemente aleatorios.
- Nuestro mundo muy tecnológico produce grandes cantidades de hechos que necesitan de una estructura y un orden.
- Es importante conocer la entidades porque son las cosas sobre las que se almacenan los datos.

**Objetivo de los atributos**
- Es importante conocer los atributos porque proporcionan información más específica sobre una entidad.
- Los atributos ayudan a distinguir entre una instancia y otra proporcionando mayores detalles de la entidad. 
	- Por ejemplo, en un restaurante, tiene que mostrar los elementos individuales del pedido de un cliente para que se pueda calcular la factura.
	- Al crear varios informes de ventas, debe ser capaz de identificar un informe específico en la lista de informes. 

**Objetivo de los identificadores únicos**
- Es importante conocer los identificadores únicos, porque distinguen una instancia de una entidad y otra.

**Definición de una entidad**
Una entidad es:
- Algo de importancia para el negocio, sobre lo que se deben conocer datos.
- Un nombre de un juego de elementos similares que se puede enumerar.
- Normalmente un sustantivo.
- **Las entidades tienen instancias.**
- **Una instancia es una única incidencia de una entidad.**

**Entidades e instancias**
- Un perro, un gato y una vaca son instancias de la entidad ANIMAL.
- Algunas entidades tienen muchas instancias, otras tienen pocas.
- **La entidades pueden ser:**
	- ***Tangibles***, como PERSONA o PRODUCTO.
	- ***Intangibles***, como NIVEL DE HABILIDAD.
	- ***Un evento***, como CONCIERTO.
Hay que aprender a identificar cuando un sustantivo puede ser una instancia o una entidad. Por ejemplo, si tenemos el sustantivo PERRO, este podría ser una instancia de la entidad ANIMAL. Pero, si el negocio se centra en perros, el sustantivo PERRO debería ser una entidad, y sus instancias serían los tipos de raza de perro.

**¿Qué es un atributo?**
- Al igual que una entidad, un atributo representa algo importante para el negocio.
- Un atributo es información específica, ayuda a:
	- Describir una entidad.
	- Cuantificar una entidad.
	- Cualificar una entidad.
	- Clasificar una entidad.
	- Especificar una entidad.
	- **Un atributo tiene un valor único.**

**Atributos**
- Los atributos tienen valores.
- Un atributo tiene un solo tipo de valor.
- Cada atributo solo puede tener un valor para cada instancia de la entidad.
- Un valor de un atributo puede ser un número, una cadena de caracteres, una imagen, un sonido, etc.
- El valor del atributo se denomina "tipo de dato" o "formato". 
- Un atributo, solo tiene un valor y un tipo de valor a la vez.

- Algunos atributos (como edad) tienen valores que cambian constantemente.
- **Los atributos que cambian constantemente se denominan volátiles.**
- **Los atributos no volátiles, rara vez pueden cambiar.**
- Si se puede elegir entre estas dos opciones, es preferible usar un valor que no es volátil.
- Por ejemplo, utilice fecha de nacimiento, en lugar de edad.

- Algunos atributos deben tener un valor. **Estos son los atributos obligatorios.** Por ejemplo, en la mayoría de las empresas que realizan el seguimiento de información personas, el nombre es obligatorio.
- Otros atributos pueden contener un valor o ser nulos. **Estos son los atributos opcionales.** Por ejemplo, un número de teléfono a menudo es opcional, excepto en las aplicaciones móviles.
- Un correo electrónico puede ser un atributo obligatorio para los empleados, pero opcional para los clientes.

**Los atributos tienen valores volátiles y no volátiles, también pueden tener valores obligatorios y opcionales.**

**Identificadores**
- Una entidad tiene un identificador único (UID).
- Un UID es un atributo único o una combinación de varios atributos que distingue la instancia de una entidad de otra.
- Cada instancia está descrita por varios rasgos o atributos. Poder seleccionar una instancia única por medio de las características que tiene en sus atributos, eso es lo que se conoce como UID.

**Terminología**
- Atributo.
- Tipo de dato.
- Entidad.
- Instancia.
- Obligatorio.
- Intangible.
- Nulo.
- Opcional.
- De único valor.
- Tangible.
- Identificador único.
- Volátil.

# Modelado de Relación de Entidades y ERD

**Objetivos:**
- Definir el significado de "sin implantación" en relación con la implantación de modelos de datos y el diseño de bases de datos.
- Enumerar los cuatro objetivos del modelado de relación de entidades.
- Identificar un diagrama de relación de entidades (ERD).

**ERD**
- Un diagrama de relación de entidades (ERD) es una herramienta consistente que se puede utilizar para representar los requisitos de datos de un negocio, independientemente del tipo de base de datos utilizada, e incluso sin una.

**Modelos sin implantación**
- Un buen modelo de datos conceptual, sigue siendo igual, independientemente del tipo de base de datos sobre el que se cree, o implante finalmente en el sistema.
- Esto es a lo que nos referimos al decir que el modelo es "sin implantación".
- **Un buen modelo conceptual, sin implantación, es aquel que se puede adaptar a cualquier base de datos donde se desee implementar.** 
- Un "modelo sin implantación" no tiene una implantación en específico para una base de datos.
- El modelo de datos debe permanecer igual, incluso aunque no se utilice ninguna base de datos.

**¿Qué es un modelo de relación de entidades (ERM)**
- Es una lista de todas las entidades y atributos, así como todas las relaciones entre las entidades que son importantes.
- Proporciona información de fondo como, por ejemplo, descripciones de las entidades, tipos de datos y restricciones.
- El modelo no necesita de un diagrama, pero este puede ser útil.

**Objetivos del modelo de relación de entidades**
1. Capturar todos los datos necesarios.
2. Garantizar que los datos aparezcan solo una vez.
3. No modelar ningún dato que se puede derivar de otros datos que ya se haya modelado.
4. Localizar los datos en un lugar visible y lógico.

- Los datos se tienen que almacenar de una manera lógica, a fin de permitir que el acceso y la actualización de registros se lleven a cabo de forma fácil y eficaz.
- Realizar un seguimiento de los objetivos del modelado de ER ayuda a lograrlo.
- **El ERD y ERM es la información que se muestra en el modelo lógico de la DB.**
- **Un ERD muestra todo el modelo de datos terminado.**

**Terminología**
- Diagrama de relación de entidades (ERD).
- Sin implantación.
