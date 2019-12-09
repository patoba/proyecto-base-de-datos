--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 08/12/2019
--@Descripción: Ejecuta los scripts importantes del proyecto

-- Mostrar el nombre, fecha_nacimiento, nombre del padre, nombre de la madre, fecha_status, clave, descripcion muerte de las mascotas
-- (MUestra todas las mascotas que nacieron en un refugio y fallecieron)
select m.nombre, m.fecha_nacimiento, p.nombre as nombre_padre, ma.nombre as nombre_madre, m.fecha_status, sm.clave, m.descripcion_muerte
from mascota m 
join mascota p 
on m.padre_mascota_id = p.mascota_id
join mascota ma
on m.madre_mascota_id = ma.mascota_id
join status_mascota sm
on sm.status_mascota_id = m.status_mascota_id
where m.descripcion_muerte is not null;

-- Mostrar la informacion de los clientes y el numero de selecciones en los que han participado
select c.nombre, c.apellido_paterno, c.apellido_materno, count(*)
from cliente c
join seleccion_respaldo s
on c.cliente_id = s.cliente_id
group by (c.nombre, c.apellido_paterno, c.apellido_materno);

-- Mostrar el nombre de la mascota en las que se ha gastado mas en revisones, su tipo, su estado de salud, y el costo total de todas sus revisiones
select m.nombre, m.estado_salud, tm.nombre, tm.subcategoria, sum(r.costo)
from mascota m
join revision r
on m.mascota_id = r.mascota_id
join tipo_mascota tm
on tm.tipo_mascota_id = m.tipo_mascota_id
group by (m.nombre, m.estado_salud, tm.nombre, tm.subcategoria)
having sum(r.costo) = (
    select max(costo_total)
    from (
        select sum(costo) as costo_total
        from revision
        group by mascota_id
    )
);

-- Muestra el nombre completo del empleado que es gerente de un centro operativo que es refugio y clinica
-- a la vez muestra el nombre del centro asi como su numero de registro, su lema y su direccion  web
-- agregar el titulo y cedula que posee el gerente. Usando natural join
select ga.cedula_profesional, ga.titulo, e.nombre, e.apellido_paterno, e.apellido_materno, 
    co.nombre as centro_operativo, cr.numero_registro, cr.lema, dw.url
from grado_academico ga
natural join empleado e
join centro co
on empleado_id = co.gerente_empleado_id
natural join centro_refugio cr
natural join direccion_web dw
where co.es_centro_refugio = 1
and co.es_clinica = 1;

-- Muestra los datos de clientes externos e internos que se dedican a las ventas (SALES).
select *
from (
    select username, email, nombre, apellido_paterno, apellido_materno, ocupacion
    from cliente_ext
    union
    select username, email, nombre, apellido_paterno, apellido_materno, ocupacion
    from cliente
)
where upper(ocupacion) like '%SALES%';

select * from revision_mascota;

