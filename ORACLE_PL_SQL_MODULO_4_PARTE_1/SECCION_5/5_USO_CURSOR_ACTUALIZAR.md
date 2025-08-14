
**Objetivos:**

- Crear código PL/SQL para bloquear filas antes de un UPDATE usando la cláusula apropiada.
- Explicar el efecto de usar NOWAIT en una declaración de cursor para actualizar.
- Crear código PL/SQL para usar la fila actual del cursos en una declaración UPDATE o DELETE.

# Propósito 

- Si múltiples usuarios están conectados en la base de datos al mismo tiempo, existe la posibilidad de que otro usuario actualice las filas de una tabla en particular después de que usted abra su cursor y haga fetch a las filas de esa tabla.
- **Podemos bloquear filas al abrir el cursor para evitar que otros usuarios las actualicen. Esto es importante, especialmente si vamos a realizar actualizaciones nosotros mismos.**

- Un cursor abierto provee una vista consistente de lectura de los datos obtenidos por el cursor.
- Esto significa que cualquier actualización hecha por otros usuarios desde que el cursor fue abierto, no se verán cuando de haga FETCH de las filas, incluso si las actualizaciones han sido guardadas con COMMIT. 
- Nuestro cursor tendría que ser cerrado y re-abierto para poder ver las actualizaciones.

# Declarando un Cursor con la Sintaxis FOR UPDATE

> [!NOTA]
> Cuando declaramos un CURSOR FOR UPDATE, cada fila es bloqueada desde que abrimos el CURSOR.

- **Esto previene que otros usuarios puedan modificar las filas mientras el cursor está abierto.**
- Esto también nos permite modificar las filas nosotros mismos usando la cláusula **WHERE CURRENT OF ...**

Sintaxis:

```
CURSOR cursor_name IS
	SELECT ... FROM ...
		FOR UPDATE [OF column_reference] [NOWAIT | WAIT n];
```

- Esto no impide que otros usuarios puedan leer las filas.

- **column_reference es una columna en la tabla, la cual necesitamos bloquear sus filas.**

Si las filas ya fueron bloqueadas por otra sesión:

- **NOWAIT** -> Retorna un error del servidor de Oracle inmediatamente.
- **WAIT n** -> Espera por n segundos, y retorna un error del servicio de Oracle, si la otra sesión sigue bloqueando las filas ya pasados los n segundos.

# Clave NOWAIT en la Cláusula FOR UPDATE

- **La clave opcional NOWAIT le dice a Oracle Server que no espere si cualquier otra consulta ya está bloqueando otras filas desde otro usuario.**
- El control es inmediatamente retornado a tu programa para que pueda realizar otro trabajo antes de intentar adquirir el nuevo bloqueo.

- **Si omites la clave NOWAIT, entonces Oracle Server esperará indefinidamente hasta que las filas estén disponibles.**

```
DECLARE
	CURSOR cur_emps IS
		SELECT employee_id, last_name FROM employees
			WHERE department_id = 80 FOR UPDATE NOWAIT;
...
```

- Si las filas ya están bloqueadas en otra sesión y tienes definido en NOWAIT en tu cursor, **entonces la apertura del CURSOR resultará en un error.**
- Puedes intentar abrir el cursor nuevamente.

- puedes usar **WAIT n** en lugar de **NOWAIT** y especificar el número de segundos para esperar y luego revisar si las filas ya están desbloqueadas.
- **Si las** filas siguen bloqueadas después del tiempo, entonces se retornará un error.

# FOR UPDATE OF column-name Example

> [!NOTA]
 > Si el cursor está basado en un JOIN de dos tablas, deberíamos bloquear las filas de una tabla, pero no de la otra.

- **Para hacer esto, especificamos cualquier columna de la tabla que queremos bloquear.**

```
DECLARE
	CURSOR emp_cursor IS
		SELECT e.employee_id, d.departament_name
			FROM employees e, departments d
			WHERE e.department_id = d.department_id
			AND department_id = 80
		FOR UPDATE OF salary NOWAIT
```

# Sintáxis de la Declaración WHERE CURRENT OF

- La cláusula **WHERE CURRENT OF** se utiliza junto con la cláusula FOR UPDATE para hacer referencia a la fila actual (la fila obtenida más recientemente) en un cursor explícito.

- La cláusula **WHERE CURRENT OF** es usada en la declaración UPDATE o DELETE, mientras que la cláusula FOR UPDATE es especificada en la declaración del cursor.

```
WHERE CURRENT OF cursor-name;
```

- cursor_name es el nombre del cursor declarado (el cursor debe estar declarado con la cláusula FOR UPDATE).

# Cláusula de WHERE CURRENT OF

- Puede usar WHERE CURRENT OF para actualizar o borrar la fila actual que corresponde a la tabla de la base de datos.
- Esto le permite aplicar actualizaciones y eliminaciones a la fila que se está abordando actualmente, sin necesidad de usar una cláusula WHERE.

- **Es obligatorio incluir la cláusula FOR UPDATE en la consulta relacionada con el cursor para bloquear las filas cuando se abre el CURSOR.**

- Use cursores para actualizar o borrar la fila actual.
- Incluya la cláusula FOR UPDATE en la consulta del cursor para bloquear primero las filas.
- Use la cláusula WHERE CURRENT OF para referenciar la fila actual de un cursor explícito.

```
UPDATE employees
	SET salary = ...
	WHERE CURRENT OF cur_emps
```

# NOWAIT, FOR UPDATE and WHERE CURRENT OF Clause

- En este ejemplo, no necesitamos una columna de referencia en la cláusula FOR UPDATE porque el cursor no está basado en un JOIN

```
DECLARE
    CURSOR cur_emps IS
        SELECT employee_id, salary FROM copy_emp
        WHERE salary <= 20000
        FOR UPDATE NOWAIT;
    v_emp_rec cur_emps%ROWTYPE;
BEGIN
    OPEN cur_emps;
    LOOP
        FETCH cur_emps INTO v_emp_rec;
        EXIT WHEN cur_emps%NOTFOUND;
        
        UPDATE copy_emp
            SET salary = v_emp_rec.salary*1.1
            WHERE CURRENT OF cur_emps;
    END LOOP;
    CLOSE cur_emps;
END;    
```

# FOR UPDATE Second Example

- FOR UPDATE OF salary bloquea solo las filas de COPY_EMP, no las filas de MY_DEPARTMENTS
- Note que estamos actualizando en el nombre de la tabla, no el nombre del cursor

```
DECLARE 
    CURSOR cur_eds IS
        SELECT employee_id, salary, department_name 
            FROM copy_emp e, copy_dept d
            WHERE e.department_id = d.department_id
            FOR UPDATE OF salary NOWAIT;
BEGIN
    FOR v_eds_rec IN cur_eds LOOP   
        UPDATE copy_emp
            SET salary = v_eds_rec.salary * 1.1
            WHERE CURRENT OF cur_eds;
    END LOOP;
END;
```













