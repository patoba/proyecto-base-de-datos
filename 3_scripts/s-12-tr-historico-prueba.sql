--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_historico

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido 
Prompt ========================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
    v_insercion_correcta number;
begin

	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'prueba01', 'prueba01321', 'prueba01@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-1, complemento('pr201', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

	
    select count(*) into v_insercion_correcta
    from historico_status_mascota 
    where mascota_id = -1
      and status_mascota_id = 2;

    if v_insercion_correcta = 1 then 
    	dbms_output.put_line('OK, prueba 1 Exitosa.');

    else 
        raise_application_error(-20200,
            ' El trigger no está funcionando correctamente');
    end if;
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
end;
/


Prompt =======================================
Prompt Prueba 2.
prompt Actualizando un registro de mascota
Prompt ========================================


declare
	v_codigo number;
	v_mensaje varchar2(1000);
    v_insercion_correcta number;

begin

	update mascota 
    set status_mascota_id = 1
    where mascota_id = -1;


	select count(*) into v_insercion_correcta
    from historico_status_mascota 
    where mascota_id = -1
      and status_mascota_id = 1;

    if v_insercion_correcta = 1 then 
    	dbms_output.put_line('OK, prueba 2 Exitosa.');

    else 
        raise_application_error(-20200,
            ' El trigger no está funcionando correctamente');
    end if;
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
end;
/

Prompt =================================================
Prompt Prueba 3.
Prompt Borrando un registro de mascota
Prompt ==================================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
        v_insercion_correcta number;

begin	
	
    delete from mascota 
    where mascota_id = -1;

	select count(*) into v_insercion_correcta
    from historico_status_mascota 
    where mascota_id = -1
      and status_mascota_id = 1;

    if v_insercion_correcta = 0 then 
    	dbms_output.put_line('OK, prueba 3 Exitosa.');
    else 
        raise_application_error(-20200,
            ' El trigger no está funcionando correctamente');
	end if;
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    
end;
/


Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
