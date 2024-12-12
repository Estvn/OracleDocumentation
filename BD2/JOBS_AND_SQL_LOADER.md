# Introducción a Jobs
----------

- Un Job es una tarea programada.
- Se utiliza cuando queremos que se ejecute una acción de forma automática cada cierto tiempo.
- Un Job se ejecuta para que un objeto realice una acción cada cierto tiempo.
- Este otro objeto puede ser un procedimiento o una función.

- **Para hacer uso de un Job tenemos que hacer uso de funciones que vienen por defecto con el gestor de bases de datos cuando se instala por primera vez.**
- Estas funciones nos van a permitir crear y configurar todos los parámetros del Job, para que se ejecute de acuerdo a nuestras indicaciones.

- **Un Job no realiza las acciones, solo ejecuta cada cierto tiempo un objeto que se encarga de ejecutar las acciones que deseamos que se realicen periódicamente.**

- El inicio de ejecución del Job debe estar sincronizado con el día y fecha de la frecuencia de ejecución,
- **Si se crea un Job con parámetros, para modificar los parámetros se tiene que eliminar el Job, realizar la modificación de los parámetros y volver a crear el JOB.**

> [!NOTA]
> Revise los ejercicios de Jobs para ver su sintaxis.

# SQL LOADER
-----------------------

- SQL Loader es una herramienta que se instala por defecto cuando se descarga por primera vez el gestor de bases de datos.
- Sirve para cargar datos de forma masiva desde un archivo hacia una tabla de la base de datos.

- Con el uso de SQL Loader no será necesario crear código de inserciones.
- Solo representamos en un formato determinado los datos que queremos insertar en las tablas de la base de datos.

Tres pasos para llevar a cabo el uso de SQL Loader:
1. Tener un archivo con los datos en formato .csv
2. Crear un archivo de control .ctl
	1. En este archivo se indica en que tabla se van a guardar los datos, y en que formato se van a interpretar los datos.
3. Ejecutar el comando de SQL Loader.
	1. El comando a ejecutar se va a encargar de procesar el archivo .ctl y obtener los datos del archivo .csv

### Información del archivo .csv

- En la primera fila del archivo .csv, de forma opcional se puede indicar los nombres de las columnas de la tabla en la que se van a cargar los datos.
- Las demás filas son las instancias que se van a insertar en la tabla. Cada dato debe estar separado por una coma, y cada fila debe estar separado por un salto de línea.
### Configuración del archivo de control .ctl

- El archivo de control tiene una estructura ya definida.
- Este archivo se encarga de interpretar la información que se encuentra en el archivo .csv, y nos indica en que tabla queremos guardar los datos

Estructura:
```
OPTIONS (SKIP ='1') -- IGNORA LA PRIMERA FILA DEL .csv
LOAD DATA 
APPEND INTO TABLE {NOMBRE DE TABLA}
WHEN ({COLUMNA} = 'CONDICION') -- LÍNEA OPCIONAL
(
COLUMNA_ID INTEGER EXTERNAL TERMINATED BY ', ',
COLUMNA_TEXTO CHAR TERMINATED BY ', ',
COLUMNA_TEXTO CHAR TERMINATED BY ', ',
COLUMNA_NUMERO INTEGER EXTERNAL TERMINATED BY ', '
)
```

- La palabra "APPEND" indica que si ya existe contenido en la tabla, que el nuevo contenido no sustituya lo que ya existe, y que se ingrese después del contenido que ya existía en la tabla.
### Comando para ejecutar el SQL Loader

- Para ejecutar el comando SQL Loader se debe indicar cuál es el archivo .csv y .ctl que se van a utilizar.
- Tenemos que saber en que ruta se encuentran los archivos a utilizar.
- Se recomienda guardar estos archivos en una ruta que no sea complicada.

- **Este comando se ejecuta desde la terminal del sistema que esté utilizando.**
```
C:\Windows\system32>sqlldr C##_USER_NAME_BD/password_user@oracle_service control='C:\control.ctl' data='C:\data.csv'
```

- Cuando se ejecute el comando indicado y no ocurran problemas, se habrá insertado la información del .csv en la tabla de la base de datos.
- **Si algunas filas a insertar ocasionaron un error, se van a guardar en un .csv que se generará en la misma ruta donde se encuentra el archivo de carga.**
- El archivo generado que guarda las filas que tuvieron un problema tiene el mismo nombre que el archivo de datos (.csv), pero tendrá la extensión .bad

- Si ejecuta dos veces el mismo archivo .csv, las filas no se duplicarán en la tabla, las filas correctas generarán un error y se guardarán en el archivo de filas fallidas.
- Esto causará que se mezclen con las filas que realmente tiene un problema para insertarse.






