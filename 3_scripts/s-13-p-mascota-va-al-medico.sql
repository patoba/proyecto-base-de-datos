--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Procedimiento que permite que a una mascota ir al medico

create or replace procedure p_mascota_va_al_medico(
    p_centro_operativo_id in clinica.centro_operativo_id%type,
    p_mascota_id in mascota.mascota_id%type,
    p_fecha_revision in date,
    p_calificacion in revision.calificacion%type,
    p_estado_salud in revision.estado_salud%type,
    p_costo in revision.costo%type,
    p_observaciones in revision.observaciones%type
) is
v_numero_revision revision.numero_revision%type := 0;
v_status_actual mascota.status_mascota_id%type;
V_STATUS_NUEVO mascota.status_mascota_id%type;

v_status_id_enfermo status_mascota.status_mascota_id%type;

v_tiene_dueno number;
v_existe_mascota_id mascota.mascota_id%type;

begin 

    select count(*) into v_existe_mascota_id
    from mascota
    where mascota_id = p_mascota_id;

    if v_existe_mascota_id = 0 then 
        raise_application_error(-20010, 'Mascota_id no existe en la tabla mascota');
    end if;

    select status_mascota_id into v_status_id_enfermo
    from status_mascota
    where upper(clave) = 'ENFERMA';

    select count(*)  into v_numero_revision
    from revision 
    where mascota_id = p_mascota_id;

    v_numero_revision := v_numero_revision + 1;
   
    insert into revision 
        (revision_id, numero_revision, mascota_id, fecha_revision, costo, calificacion,
        observaciones, estado_salud, clinica_id)
    values 
        (revision_seq.nextval, v_numero_revision, p_mascota_id, p_fecha_revision, p_costo,
        p_calificacion, p_observaciones, p_estado_salud, p_centro_operativo_id);

    select status_mascota_id into v_status_actual
    from mascota 
    where mascota_id = p_mascota_id;

    if v_status_actual = v_status_id_enfermo then 

        select count(*) into v_tiene_dueno
        from mascota 
        where mascota_id = p_mascota_id;

        if v_tiene_dueno = 1 then 
            V_STATUS_NUEVO := 5;
        else 
            V_STATUS_NUEVO := 2;
        end if;

        update mascota 
        set status_mascota_id = v_status_nuevo
        where mascota_id = p_mascota_id;

    end if;
end;
/
show errors;
