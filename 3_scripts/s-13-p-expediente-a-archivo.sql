--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Procedimiento que permite obtener el historial de revisiones de una mascota

create or replace procedure p_expediente_a_archivo(
    p_mascota_id in mascota.mascota_id%type
) is
    cursor cur_datos_revision is
    SELECT r.numero_revision,m.folio,m.nombre as nombre_mascota,m.fecha_nacimiento,
       m.fecha_ingreso,m.origen,m.descripcion_muerte,
       tm.nombre as nombre_tipo_mascota, sm.clave,
       co.nombre as nombre_clinica, c.telefono_atencion,r.fecha_revision,r.costo,
       r.calificacion,r.estado_salud,r.observaciones
    from revision r, mascota m, clinica c, centro_operativo co, tipo_mascota tm, status_mascota sm
    where r.mascota_id = m.mascota_id 
    and c.centro_operativo_id = r.clinica_id
    and co.centro_operativo_id = c.centro_operativo_id
    and tm.tipo_mascota_id = m.tipo_mascota_id
    and sm.status_mascota_id = m.status_mascota_id;

    out_File  UTL_FILE.FILE_TYPE;
    v_texto_salida varchar2(10000);
    v_linea varchar2(200);
BEGIN
    v_texto_salida := '';
  
  out_File := UTL_FILE.FOPEN('CTEST', p_mascota_id, '-mascota.txt' , 'W');

    for r in cur_datos_revision loop
        v_linea := to_char(r.numero_revision) || ' ' || to_char(r.folio) || ' ' || r.nombre_mascota || ' ' 
                    || to_char(r.fecha_nacimiento, 'dd/mm/yyyy') || ' ' || to_char(r.fecha_ingreso, 'dd/mm/yyyy') ||
                    ' ' || r.origen || ' '
                    || r.descripcion_muerte || ' ' || r.nombre_tipo_mascota || ' ' || to_char(r.clave) || ' '
                    || r.nombre_clinica || ' ' || r.telefono_atencion || ' ' || to_char(r.fecha_revision,'dd/mm/yyyy') || ' '
                    || to_char(r.costo) || ' ' || to_char(r.calificacion) || ' ' || r.estado_salud || ' ' || r.observaciones
                    || chr(10);
        v_texto_salida := v_texto_salida + v_linea;
    end loop;
  UTL_FILE.PUT_LINE(out_file , v_texto_salida);
  UTL_FILE.FCLOSE(out_file);
END;
/
show errors;