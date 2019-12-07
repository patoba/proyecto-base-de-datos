--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 03/12/2019
--@Descripción: Creación de vistas


-- Crearemos una vista para ver tanto a los clientes como a los empleados sin su contrasena
create or replace view v_usuarios (
    nombre, apellido_paterno, apellido_materno, email
) as select nombre, apellido_paterno, apellido_materno, email
from empleado
union
select nombre, apellido_paterno, apellido materno, email
from cliente;

-- Vista que muestra las mascotas que estan disponibles para adopción
create or replace view v_mascota (
    mascota_id, folio, nombre, fecha_nacimiento, fecha_status, clave
) as select m.mascota_id, m.folio, m.nombre, m.fecha_nacimiento, m.origen, m.estado_salud
from mascota m, status_mascota sm
where m.status_mascota_id = sm.status_mascota_id
and sm.clave = 'DISPONIBLE_PARA_ADOPCION';

-- Vista que muestra el nombre del cliente que gano la adopcion de una mascota
create or replace view v_cliente_ganador (
    nombre_cliente, apellido_paterno, apellido_materno, username, 
    folio, nombre_mascota, fecha_seleccion 
) as select c.nombre as nombre_cliente, c.apellido_paterno, c.apellido_materno, c.username, 
    m.folio, m.nombre as nombre_mascota, s.fecha_seleccion 
from cliente c
join seleccion s
on c.cliente_id = s.cliente_id
join mascota m 
on m.mascota_id = s.seleccion_id
where s.es_ganador = 1;
