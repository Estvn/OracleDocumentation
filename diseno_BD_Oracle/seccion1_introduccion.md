# Introducción a Oracle Academy

# Introducción

Este curso comienza con temas que abarcan:
- Modelado de relaciones de entidad: diseño, desarrollo y normalización de la base de datos.
- Historia de la base de datos.
- Habilidades empresariales: presentaciones y estudios de casos.

Entre los temas adicionales que se tratan se incluyen:
- SQL
- Acceso a los datos con SQL
- Lenguajes de control, manipulación y definición de datos
- Control de transacciones
- Creación de las aplicaciones
- Habilidades empresariales: entrevistas, creación de una cartera profesional.

Este curso de Oracle Academy es el segundo de los dos cursos disponibles.
Los temas temas tratados en este curso incluyen:
- PL/SQL, extensión del lenguaje de procedimientos para SQL.
- Estructuras de programación de procedimientos, como variables, constantes y parámetros.
- Sentencias de control condicionales, incluidas IF y CASE.
- Sentencias de control iterativo, incluidos LOOP, WHILE y FOR.
- Manejo de excepciones.
- Creación de procedimientos, funciones, paquetes y disparadores.

# Datos Frente a la Información

**Objetivos:**
- Diferenciar entre datos e información, y proporcionar ejemplos de cada uno.
- Describir y dar un ejemplo de como los datos se convierten en información.

- Todos los tipos de información de almacenan en una base de datos.
- Interactuamos con las bases de datos todos los días.
- Es importante comprender lo que se almacena en una base de datos y lo que se puede recuperar de ella.

**Datos Comparados con Información**
- Si trabaja en el sector de TI, es esencial comprender cómo se modelan los datos, y cómo se almacenan en una base de datos.
- Si trabaja en cualquier otro sector, es muy probable que tenga que trabajar con los datos almacenados en una computadora y probablemente tenga que utilizar los datos en el trabajo para crear informes o tomar decisiones.
- En las bases de datos se guardan datos, y mediante estos datos recopilados se puede extraer información.

>[!NOTE]
>* *Los datos* son material raw o si procesar.
>* *La información* es el resultado de la combinación, comparación, análisis o realización de cálculos en los datos.

**¿Qué es una base de datos?**
- Una DB es un juego centralizado y estructurado de datos almacenados en un sistema de computadora.
- Proporciona utilidades para recuperar, agregar, modificar y suprimir los datos cuando sea necesario.
- También proporciona utilidades para transformar los datos recuperados en información útil.
- Normalmente, una DB está gestionada por un administrador de base de datos (DBA).

- En las bases de datos más modernas, puede almacenar y recuperar una gran variedad de datos y documentos.
- En la base de datos, los datos se almacenan en su formato "raw".
- Cuando estos datos raw se consultan o recuperan, se transforma en información más útil.

# Historia de las Bases de Datos

**Objetivos:**
- Describir la evolución de las bases de datos y proporcionar un ejemplo de su rol en el mundo empresarial.
- Enumerar y explicar los tres pasos importantes en el proceso de desarrollo de la base de datos.
- El modelado de datos es el primero paso en el desarrollo de bases de datos.
- Esta lección incluye una visión general del contenido que se trata en el resto del curso.

**¿Qué tiene que ver el modelado de datos con una base de datos?**
- El modelado de datos es el primer paso en el proceso de desarrollo de bases de datos.
- Implica recopilar y analizar los datos que necesita un negocio para realizar un seguimiento y continuación, traza la organización de los datos en un diagrama de relación de entidad.
- El modelado de datos comienza investigando los requisitos de información de un negocio.

**Proceso de desarrollo de base de datos**
- Modelado de datos conceptuales → Modelo conceptual
- Diseño de base de datos → Modelo lógico y relacional
- Creación de base de datos → Modelo físico

1. Un diagrama de relación de entidad debe capturar completamente y modelar de forma precisa las necesidades de información de la organización, y soportar las funciones del negocio.
2. En el paso dos, la fase de diseño de base de datos del proceso de desarrollo, convierte la información modelada en el diagrama de relación de entidad en un gráfico de instancia de tabla.

**El gráfico de instancia de tabla muestra las especificaciones del diseño de la información y tiene los siguientes componentes:**
- **Nombre de la tabla**
- **Nombre de las columnas**
- **Claves**
	- La clave primaria (PK) es el identificador único para cada fila de datos.
	- La clave foránea (FK) enlaza los datos de una tabla con los datos de una segunda tabla, haciendo referencia a la columna PK de la segunda tabla.
- **Valores nulos**: Indica si una columna debe contener un valor (obligatorio).
- **Único**: Indica si el valor incluido en la columna es único en la tabla.
- **Tipo de dato**: Identifica la definición y el formato de los datos almacenados en cada columna.

**Proceso de desarrollo de la base de datos**
- Los comandos del lenguaje de consulta estructurado (SQL) se utiliza para crear la estructura física de la base de datos 
![[Captura desde 2024-05-03 10-35-35.png]]

- También se utiliza SQL para rellenar, acceder y manipular los datos de la base de datos relacional.
![[Captura desde 2024-05-03 10-36-40.png]]

**Terminología**
- Tipo de dato
- Clave foránea
- Clave primaria
- Valores nulos
- Gráfico de instancia de tabla
- Única

# Transformaciones  Importantes en la Informática

**objetivos:**
- Definir y proporcionar ejemplos de estos términos: Hardware, sistemas operativos, Software.
- Identificar ejemplos de negocios que utilicen software de base de datos, y explicar de que modo es esencial para su éxito.
- Puede que su primer trabajo tras su graduación no exista en 20 años después.

 **Términos clave**
- **Hardware**. Son las partes físicas de una computadora.
- **Software**. Programas (juegos de instrucciones) que indican al Hardware que hacer.
- **Sistema operativo**. Programa de Software, que controla y gestiona directamente el Hardware.
- **Aplicación**. Programa que Software que lleva a cabo tareas específicas en nombre de los usuarios de computadoras.
- **Cliente**. 
	- Estación de trabajo o una computadora de escritorio, incluida una pantalla, un teclado y un mouse.
	- Los clientes interactúan directamente con usuarios humanos de computadoras.
- **Servidor**. Es una computadora más potente que acepta solicitudes de trabajo de los clientes, ejecuta cada solicitud y devuelve resultados al cliente.

**Información sobre los servidores**
- Los servidores son una computadora más potente que acepta solicitudes de trabajo de los clientes, ejecuta cada solicitud y devuelve resultados al cliente.
- Cada que se solicita información de una página web, la computadora cliente envía una solicitud a la base de datos del servidor.
- El servidor recupera los datos de la base de datos, los convierte en información útil y envía la información de nuevo al cliente.
- El software que gestiona los datos, se encuentra en el servidor de la base de datos. Realizan el procesamiento de almacenamiento y recuperación.
- Las aplicaciones para las operaciones del negocio, se encuentran en el servidor de aplicaciones. Interactúa, procesa, desarrolla o manipula datos para crear documentos.

**Grid Computing**
- En el modelo de Grid computing, todas las computadoras de una organización en ubicaciones diferentes se pueden utilizar igual que si fueran un pool de recursos informáticos.
- Grid computing crea una infraestructura de software que se puede ejecutar en un gran número de servidores de red.
- Un usuario realiza una solicitud de información o cálculo desde su estación y dicha solicitud se procesa en alguna parte de la cuadrícula, de la forma más eficaz posible.
- Grid computing trata el cálculo como una utilidad, como la compañía eléctrica. No sabe donde está el generador ni cómo está conectada la red eléctrica. Solo solicita electricidad y la obtiene.
- Grid computing mejora el rendimiento y la fiabilidad de las estructuras del sistema de Oracle con servidores de base de datos, servidores de aplicaciones y exploradores de cliente.

**Computación en la nube**
- La computación en la nube permite a las empresas acceder a software y hardware de un proveedor de nube.
- Estos servicios están ubicados remotamente y se envía a los usuarios mediante tecnologías web.

La bases de datos soportan el funcionamiento de los negocios en todos los sectores de la industria, entre ellos se incluyen
- Finanzas y banca
- Minoristas
- Telecomunicaciones
- Compañías aéreas

**Terminología**
- Aplicación
- Cliente
- Grid Computing
- Hardware
- Infraestructura
- Sistema Operativo
- Servidor
- Software
- Cloud Computing


