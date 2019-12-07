--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_valida_mascota_veterinario

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido (empleado que es veterinario)
Prompt ========================================

insert into empleado (empleado_id, nombre, apellido_paterno, apellido_materno, username, constrasena, email, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'Eula', 'Newell', 'Chesterton', 'asdasdasd', 'FBiF6ouSTi', 'echestertonrr@+wired.com', 30880.26, sysdate, 0, 1, 0);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-1, '8HSPnsymmmmm', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  11, 5, -1, null, null, null, 642, null);


Prompt OK, prueba 1 exitosa.


Prompt =======================================
Prompt Prueba 2.
prompt Intentando insertar un empleado que no es veterinario
Prompt ========================================


declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin

	insert into empleado (empleado_id, nombre, apellido_paterno, apellido_materno, username, constrasena, email, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-2, 'Eula', 'Newell', 'Chesterton', 'asdasdasd', 'FBiF6ouSTi', 'echestertonrr@+wired.com', 30880.26, sysdate, 1, 0, 0);

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-1, '8HSPnsymñmmm', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  11, 5, -2, null, null, null, 642, null);

	
	raise_application_error(-20200,
		' ERROR: Centro operativo que no es oficina insertado.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20001 then
    	dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada ');
    	raise;
    end if;
end;
/

Prompt =================================================
Prompt Prueba 3.
Prompt Modificando la referencia de un veterinario de una mascota , con una referencia que no es veterinario 
Prompt ==================================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin	
	update mascota
	set veterinario_empleado_id = -2
	where veterinario_empleado_id = -1;

	raise_application_error(-20200,
		' ERROR: Centro operativo que no es clinica actualizado.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20001 then
    	dbms_output.put_line('OK, prueba 3 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;