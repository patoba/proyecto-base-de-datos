--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el procedimiento entrar_seleccion_prueba

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt 
Prompt ========================================

declare
    v_mascota_id number := 8;
    v_diferencia_1 number;
    v_diferencia_2 number;
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    p_expediente_a_archivo(v_mascota_id);

    -- create table t_ext (
    --     numero_revision number(10, 0) not null,
    --     folio varchar2(8) not null,
    --     nombre_mascota varchar2(60) not null,
    --     fecha_nacimiento date not null,
    --     fecha_ingreso date not null,
    --     origen char(1) not null,
    --     nombre_tipo_mascota varchar2(60) not null, 
    --     clave varchar2(40) not null,
    --     nombre_clinica varchar2(60) not null, 
    --     telefono_atencion varchar2(20) not null,
    --     fecha_revision date not null,
    --     costo number(7, 2) not null,
    --     calificacion number(2, 0) not null,
    --     estado_salud varchar2(40) not null,
    --     observaciones varchar2(100) not null
    -- )
    -- organization external (
    -- --En oracle existen 2 tipos de drivers para parsear el archivo:
    -- -- oracle_loader y oracle_datapump
    --     type oracle_loader
    --     default directory CTEST
    --     access parameters (
    --     records delimited by newline
    --     badfile CTEST:'cliente_ext_bad.log'
    --     logfile CTEST:'cliente_ext.log'
    --     fields terminated by '#'
    --     lrtrim
    --     missing field values are null
    --     (
    --     numero_revision,
    --     folio,
    --     nombre_mascota,
    --     fecha_nacimiento,
    --     fecha_ingreso,
    --     origen,
    --     nombre_tipo_mascota, 
    --     clave,
    --     nombre_clinica, 
    --     telefono_atencion,
    --     fecha_revision,
    --     costo,
    --     calificacion,
    --     estado_salud,
    --     observaciones
    --     )
    --     )
    --     location (p_mascota)
    --     )
    -- reject limit unlimited;

    -- select count(*) insert v_diferencia_1
    -- from(
    --     select *
    --     from t_ext
    --     minus
    --     SELECT r.numero_revision,m.folio,m.nombre as nombre_mascota,m.fecha_nacimiento,
    --     m.fecha_ingreso,m.origen,
    --     tm.nombre as nombre_tipo_mascota, sm.clave,
    --     co.nombre as nombre_clinica, c.telefono_atencion,r.fecha_revision,r.costo,
    --     r.calificacion,r.estado_salud,r.observaciones
    --     from revision r, mascota m, clinica c, centro_operativo co, tipo_mascota tm, status_mascota sm
    --     where r.mascota_id = m.mascota_id 
    --     and c.centro_operativo_id = r.clinica_id
    --     and co.centro_operativo_id = c.centro_operativo_id
    --     and tm.tipo_mascota_id = m.tipo_mascota_id
    --     and sm.status_mascota_id = m.status_mascota_id
    --     and m.mascota_id = p_mascota_id); 

    -- select count(*) insert v_diferencia_2
    -- from(
    --     SELECT r.numero_revision,m.folio,m.nombre as nombre_mascota,m.fecha_nacimiento,
    --     m.fecha_ingreso,m.origen,
    --     tm.nombre as nombre_tipo_mascota, sm.clave,
    --     co.nombre as nombre_clinica, c.telefono_atencion,r.fecha_revision,r.costo,
    --     r.calificacion,r.estado_salud,r.observaciones
    --     from revision r, mascota m, clinica c, centro_operativo co, tipo_mascota tm, status_mascota sm
    --     where r.mascota_id = m.mascota_id 
    --     and c.centro_operativo_id = r.clinica_id
    --     and co.centro_operativo_id = c.centro_operativo_id
    --     and tm.tipo_mascota_id = m.tipo_mascota_id
    --     and sm.status_mascota_id = m.status_mascota_id
    --     and m.mascota_id = p_mascota_id
    --     minus
    --     select *
    --     from t_ext); 
    -- if v_diferencia_1 = 0 and v_diferencia_2 = 1 then
        dbms_output.put_line('OK, prueba 1 Exitosa.');

    -- else
    --     dbms_output.put_line('Error, fallo en prueba 1');
    --     raise_application_error(-20200, 'Error');
    -- end if;
    -- drop table t_ext cascade;
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    -- drop table t_ext cascade;

    raise;
end;
/
show errors;



Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;