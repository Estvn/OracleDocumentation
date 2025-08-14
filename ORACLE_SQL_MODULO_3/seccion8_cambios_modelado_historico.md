# Modelado de Datos Históricos

**Objetivos**
- Identificar la necesidad de un sieguimiento de los datos que cambian a lo largo del tiempo.
- Crear modelos de ERD que incorporen elementos de "datos a lo largo del tiempo".
- Identificar el UID de una entidad que almacena datos históricos; explicar y justificar la elección del UID.

**Introducción**
- La mayoría de las empresas necesitan realizar un seguimiento de algunos datos históricos.
- Esto les ayuda a averiguar las tendencias y los patrones que son las base de las innovaciones empresariales o mejoras de procesos.

**Modelado de Datos a Través del Tiempo**
- ¿Cuándo es necesario modelar datos  a lo largo del tiempo?
- Pregunte al tiempo:
	- ¿Pueden cambiar los valores de los atributos a lo largo del tiempo?
	- ¿Pueden cambiar las relaciones a lo largo del tiempo?
	- ¿Necesitan producir informes sobre datos antiguos?
	- ¿Necesitan conservar versiones anteriores sobre los datos?
	
**Ejemplo de datos a lo largo del tiempo**
- Una organización necesita mantener datos sobre salarios de los empleados.
- Se paga a todos los empleados semanalmente.
- Los requisitos especifican que la organización necesita mantener un registro histórico de como y cuando han cambiado los salarios de los empleados durante su empleo.
- **Para modelar cambios de salarios a los largo del tiempo de crea una entidad que maneje el historia de los salarios.**
- **El UID de la entidad del historial de los salarios es el ID  de empleado y la fecha de inicio de los salarios está relacionado.**



