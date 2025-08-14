
**Objetivos:**

- Escribir código PL/SQL para nombrar excepciones definidas por el usuario
- Escribir código PL/SQL para lanzar una excepción
- Escribir código PL/SQL para manejar una excepción
- Escribir código PL/SQL para usar RAISE_APPLICATION_ERROR

- Adicional a los errores predefinidos de Oracle, los programadores pueden crear sus propios errores.
- **Los errores definidos por el usuario no son lanzados automáticamente por el servidor de Oracle,** pero son definidos por el programador y debe ser lanzados por el programador cuando ocurran.

- **Con un error definido por el usuario, el programador crea un código de error y mensaje de error.**

# Atrapando Excepciones Definidas por el Usuario

- PL/SQL te permite definir tus propias excepciones
- Tu defines las excepciones, dependiendo de los requerimientos de tu aplicación.

Declara el nombre de la excepción definida por el usuario en la sección declarativa

```
e_invalid_department EXCEPTION;
```

Usa la declaración RAISE para lanzar la excepción explícita dentro de la sección ejecutable

```
IF SQL%NOTFOUND THEN RAISE e_invalid_department;
```

Referencia el nombre de la excepción declarada dentro de una cláusula WHEN en la sección de manejo de excepciones

```
EXCEPTION
	WHEN e_invalid_departmeent THEN
		DBMS_OUTPUT.PUT_LINE ('No hay un departamento con ese ID.');
```

- Estos tres pasos son similares a lo que se hizo en la lección previa con los errores de Oracle no predefinidos. 
- La diferencia es que no se requiere del uso de PRAGMA EXCEPTION_INIT, y puedes lanzar la excepción usando el comando RAISE.

```
DECLARE
    e_invalid_deparment EXCEPTION;
    v_name VARCHAR2(20) := 'Accounting';
    v_deptno NUMBER := 27;
BEGIN
    UPDATE departments
        SET department_name = v_name 
        WHERE department_id = v_deptno;
    
    IF SQL%NOTFOUND THEN
        RAISE e_invalid_deparment;
    END IF;
    
EXCEPTION
    WHEN e_invalid_deparment THEN
        DBMS_OUTPUT.PUT_LINE('No such department id.');
END;

SET SERVEROUTPUT ON;
```

# La Declaración RAISE

- Puedes usar la declaración RAISE para lanzar excepciones

```
IF v_grand_total = THEN
	RAISE e_invalid_total;
ELSE
	DBMS_OUTPUT.PUT_LINE(v_num_students / v_grand_total);
END IF;
```

# El Procedimiento RAISE_APPLICATION_ERROR

- Puedes usar el procedimiento RAISE_APPLICATION_ERROR para retornar mensajes de error definidos por el usuario de subprogramas almacenados.

- **La principal ventaja de usar este procedimiento en lugar de RAISE es que RAISE_APPLICATION_EROR te permite asociar tu propio número de error y un mensaje significativo con la excepción.**

**Sintaxis de RAISE_APPLICATION_ERROR**

1. El error_number debe estar entre -20000 y 20999
2. Este rango es reservado por Oracle para el uso de los programadores
3. El mensaje es especificado por el usuario
4. El carácter de string debe ser de un máximo de 2048 bytes.

```
RAISE_APPLICATION_ERROR (error_number, message[, {TRUE | FALSE}]);
```

- TRUE | FALSE es un parámetro Booleano opcional.
- Si es TRUE, el error es puesto en el Stack de los errores previos.
- Si es FALSE -DEFAULT- el error reemplaza todos los errores previos.

# El Uso de RAISE_APPLICATION_ERROR

Tu puedes usar RAISE_APPLICATION_ERROR en dos diferentes lugares

- Sección ejecutable
- Sección de excepciones

# RAISE_APPLICATION_ERROR en la Sección Ejecutable

- Cuando se llama el procedimiento RAISE_APPLICATION_ERROR, muestra el número de error y un mensaje al usuario.
- Este procedimiento consiste con otros errores de Oracle Server.

```
DECLARE
    v_mgr PLS_INTEGER := 123;
BEGIN
    DELETE FROM employees
        WHERE manager_id = v_mgr;
    
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'This is nos a valid manager');
    END IF;
END;
```

# RAISE_APPLICATION_ERROR en la Sección de Excepciones

```
DECLARE
    v_mgr PLS_INTEGER := 27;
    v_employee_id employees.employee_id%TYPE;
    
BEGIN   
    SELECT employee_id INTO v_employee_id 
    FROM employees
    WHERE manager_id = v_mgr;
    
    DBMS_OUTPUT.PUT_LINE('Employee #' || v_employee_id || ' works for manager #' || v_mgr);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20201, 'This manager has no employees');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20202, 'Too many employees were found');
END;
```

# Usando RAISE_APPLICATION_ERROR con Excepciones Definidas por el Usuario

```
DECLARE
    e_name EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_name, -20999);
    v_last_name employees.last_name%TYPE := 'Silly name';
    
BEGIN
    DELETE FROM employees 
    WHERE last_name = v_last_name;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20999, 'Invalida last name');
    ELSE    
        DBMS_OUTPUT.PUT_LINE(v_last_name || ' deleted');
    END IF;
EXCEPTION
    WHEN e_name THEN 
        DBMS_OUTPUT.PUT_LINE('Valid last names are: ');
        FOR c1 IN (SELECT DISTINCT last_name from employees) LOOP   
            DBMS_OUTPUT.PUT_LINE(c1.last_name);
        END LOOP;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting from employees');
END;
```
























