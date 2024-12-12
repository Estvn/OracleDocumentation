# Supertipos y Subtipos

**Objetivos:**
- Definir y dar el ejemplo de un subtipo.
- Definir y dar el ejemplo de un supertipo.
- Indicar las reglas que relacionan entidades y subtipos, y dar ejemplo de cada una.
- Aplicar las reglas de supertipo y subtipo evaluando la exactitud de los diagramas de ER que las representan.
- Aplicar las reglas de supertipo y subtipo e incluirlas en un diagrama cuando sea necesario.

**Introducción**
- Los supertipos y subtipos aparecen con frecuencia en el mundo real.
- Normalmente, puede asociar **"opciones"** de algo a supertipos y subtipos.
- Comprender los ejemplos del mundo real nos ayuda a comprender cómo y cuándo modelarlos.

**Evaluación de entidades**
- **A menudo algunas instancias de una entidad tienen atributos y/o relaciones que otras instancias no tienen.** Aquí entra el concepto de los subtipos.
- Imagine que hay un negocio que necesita realizar un seguimiento de los clientes. Los clientes pueden pagar en efectivo, con cheque o con tarjeta de crédito.
- Todos los pagos tienen atributos comunes, pero solo las tarjetas de crédito tendrán el atributo de "número de tarjeta". Dato que no es necesario para los pagos con cheque.

**Subdivisión de una entidad**
- A veces tiene sentido subdividir una entidad en subtipos.
- Este puede ser el caso cuando un grupo de instancias tiene propiedades especiales, como atributos o relaciones que existen solo para ese grupo.
- En este caso, la entidad se denomina "supertipo" y cada grupo se denomina "subtipo".

**Características de supertipo**
- Los atributos que son comunes entre los subtipos se muestran a nivel de supertipo.
- Los subtipos heredan todos los atributos y las relaciones de la entidad de supertipo.

**Características del subtipo**
- Hereda todos los atributos del supertipo.
- Hereda todas las relaciones del supertipo.
- Normalmente tiene sus propios atributos o relaciones.
- Se dibuja dentro del supertipo.
- Nunca existe de forma autónoma.
- Puede tener sutipos propios.
- Todas las intancias de un subtipo deber ser una instancia del supetipo.

![[Captura desde 2024-05-07 08-20-53.png]]

**Siempre más de un subtipo**
- Cuando un modelo de ER está terminado, los subtipos nunca están solos. Es decir, si una entidad tiene un subtipo, también debe existir un segundo subtipo.
- Un único subtipo es exactamente lo mismo que el supertipo.
- Dos reglas de subtipo:
	1. Exhaustiva: Cada instancia del supertipo también es una instancia de uno de los subtipos, se muestran todos los subtipos sin omisión.
	2. Mutuamente excluyente: Cada instancia de un supertipo es una instancia de solo uno de los posibles subtipos.
- **En la etapa de modelado conceptual, es una buena práctica incluir un subtipo OTRO para asegurarse de que otros subtipos son exhaustivos, que maneja cada instancia del subtipo.**

**Siempre existe subtipos**
- Cualquier entidad se puede dividir en subtipos elaborando una regla que subdivida las instancias en grupos.
- El problema es encontrar un motivo para dividir en subtipos.
- **Cuando exista una necesidad en el negocio de mostrar similitudes y diferencias entre las instancias, divida en subtipos.**
- Los subtipos pueden tener más subtipos, no hay límite de anidación.

![[Captura desde 2024-05-07 08-43-09.png]]

**Identificación correcta de subtipos**
- Al modelar supertipos y subtipos, pueden utlizar tres preguntas para ver si el subtipo se ha identificado correctamente:
	1. ¿Es teste subtipo un tipo de uspertipo?
	2. ¿He cubierto todos los casos posibles? (exhaustivo)
	3. ¿Se ajusta cada instancia a un único subtipo? (mutuamente excluyente)

**Terminología**
- Exhaustivo.
- Mutuamente excluyentes.
- Subtipo.
- Supertipo.

- Se pueden crear relaciones con subtipos y supertipos.
- Todas las instancias de subtipo deben ser instancias de supertipo.
# Documentación de las Reglas de Negocio

**Objetivos**
- Definir y elaborar una regla de negocio estructural.
- Definir y elaborar una regla de negocio de procedimiento.
- Reconocer que algunas reglas de negocio requieren de programación.
- Confeccionar un diagrama de reglas de negocio cuando se puedan representar en un modelo de ER.

**Introducción**
- Uno de los principales objetivos del modelado de datos es asegurarse de que se reconocen todas las partes de información que son necesarias para hacer que un negocio funcione.
- La identificación y la documentación de reglas de negocio son claves para comprobar que el modelo de datos es completo y preciso.
- Es importante reconocer que no todas las reglas de negocio se pueden representar en el ERD.
- Algunas reglas de negocio se deben implantar mediante programación.

**Reglas de negocio estructurales de de procedimiento**
- **Las reglas de negocio estructurales** indican los tipos de información que se van a almacenar y cómo se interrelacionan los elementos de información.
- **Las reglas de negocio de procedimiento** gestionan los requisitos, pasos, procesos o requisitos de flujo de trabajo de un negocio.

- Muchas reglas de negocio de procedimiento están relacionadas con el tiempo: El evento A se debe producir antes del evento B.
- Las reglas de negocio estructurales se pueden representar casi siempre en diagramas de ERD.
- Algunas reglas de negocio de procedimiento no se pueden representar en diagramas, pero se deben seguir documentando para que se puedan programar más tarde.

**Reglas de negocio estructurales**
- La reglas de negocio estructurales indican los tipos de información que se van a almacenar (atributos) y cómo se relacionan a los elementos de información (relaciones).
- Reglas de negocio estructurales definen atributos y relaciones.
- Se debe analizar las reglas de negocio, para que tenga la lógica correcta según el ámbito donde se usará.
- **La reglas de negocio estructurales garantizan que sabemos que datos almacenar, y como funcionan conjuntamente esos datos.**

![[Captura desde 2024-05-07 09-23-42.png]]

**Reglas de negocio de procedimiento**
- La reglas de negocio de procedimiento están relacionadas don el flujo de trabajo o proceso.
- Ejemplo:
	- La aprobación de todas las solicitudes de viaje para un evento de formación debe estar firmadas por el jefe del empleado antes de que el empleado pueda registrarse para el evento.
	- Los alumnos deben haber estudiado álgebra y geometría para poder inscribirse en trigonometría.

![[Captura desde 2024-05-07 09-32-22.png]]

**Documentación de reglas**
- En el proceso de desarrollo de un modelo de datos conceptual, no todas la reglas de negocio se pueden modelar.
- Algunas reglas se deben implantar programando los procesos que interactúan con los datos.
- Ejemplos:
	- A cualquier empleado cuyas horas extra superen las 10 horas por semana, se le debe pagar 1,5 veces la tarifa por horas.
	- No se permitirá a los clientes cuyos balances de cuenta tengan un atraso de 90 días realizar cargos por pedidos adicionales.

**Terminología**
- Regla de negocio.
- Regla de negocio de procedimiento.
- Regla de negocio estructural.


