--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Situacion: Se desea visualizar los datos de los veterinarios, las clinica, y los datos de las revisiones de una determinada mascota
--@Descripción: Incluye tabla temporal que permite visualizar esa informacion

CREATE GLOBAL TEMPORARY TABLE revision_mascota
ON COMMIT PRESERVE ROWS
AS
SELECT r.numero_revision,m.folio,m.nombre as nombre_mascota,m.fecha_nacimiento,
       m.fecha_ingreso,m.origen,m.descripcion_muerte, m.veterinario_empleado_id,
       tm.nombre as nombre_tipo_mascota, sm.clave,
       co.nombre as nombre_clinica, c.telefono_atencion,r.fecha_revision,r.costo,
       r.calificacion,r.estado_salud,r.observaciones
from revision r, mascota m, clinica c, centro_operativo co, tipo_mascota tm, status_mascota sm
where r.mascota_id = m.mascota_id 
  and c.centro_operativo_id = r.clinica_id
  and co.centro_operativo_id = c.centro_operativo_id
  and tm.tipo_mascota_id = m.tipo_mascota_id
  and sm.status_mascota_id = m.status_mascota_id;