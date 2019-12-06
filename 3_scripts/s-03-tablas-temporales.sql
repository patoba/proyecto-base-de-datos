--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: DDL empleado para crear las tablas del caso de estudio

--Se desea ver todos los usernames para el login

CREATE GLOBAL TEMPORARY TABLE usuario
ON COMMIT PRESERVE ROWS
AS (
    SELECT e.username, e.password  
    FROM empleado e
    UNION 
    SELECT c.username, c.password
    FROM cliente c
);

--Se desea ver todos los datos de los clientes que seleccionaron a una mascota

CREATE GLOBAL TEMPORARY TABLE seleccion_cliente


CREATE GLOBAL TEMPORARY TABLE usuario
ON COMMIT PRESERVE ROWS
AS (
    SELECT e.username, e.password  
    FROM empleado e
    UNION 
    SELECT c.username, c.password
    FROM cliente c
);