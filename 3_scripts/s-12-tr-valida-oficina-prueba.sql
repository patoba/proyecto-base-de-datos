--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_valida_oficina

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido (centro operativo que es oficina)
Prompt ========================================

insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'prueba01', 'prt-01-7321', 'prueba01@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


insert into  centro_operativo(centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-1, 'prt01', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 1, 0, 0, -1);

insert into oficina (centro_operativo_id, rfc, responsable_legal) values (-1, complemento('pru-01-6960', 13), 'Queenie Karpets');


Prompt OK, prueba 1 exitosa.


Prompt =======================================
Prompt Prueba 2.
prompt Intentando insertar un centro operativo que no es oficina
Prompt ========================================


declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin

	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-2, 'prueba02', 'prt-02-7321', 'prueba02@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into  centro_operativo(centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-2, 'prt02', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 0, 0, 1, -2);

	insert into oficina (centro_operativo_id, rfc, responsable_legal) values (-2, complemento('pru-02-6960', 13), 'Queenie Karpets');

	
	raise_application_error(-20200,
		' ERROR: Centro operativo que no es oficina insertado.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20004 then
    	dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =================================================
Prompt Prueba 3.
Prompt Modificando la referencia de un centro_operativo_id de una oficina, con una referencia que no es oficina 
Prompt ==================================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin	
	update oficina
	set centro_operativo_id = -2
	where centro_operativo_id = -1;

	raise_application_error(-20200,
		' ERROR: Centro operativo que no es oficina actualizado.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20004 then
    	dbms_output.put_line('OK, prueba 3 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/


Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;