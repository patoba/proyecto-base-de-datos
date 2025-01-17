--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_valida_empleado_es_gerente

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido (empleado que es gerente)
Prompt ========================================

insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'prueba01', 'prt-01-7321', 'prueba01@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

insert into  centro_operativo(centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-1, 'prt01', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 1, 0, 0, -1);

Prompt OK, prueba 1 exitosa.


Prompt =======================================
Prompt Prueba 2.
prompt Intentando insertar un empleado que no es gerente en centro operativo
Prompt ========================================


declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin

    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-2, 'prueba02', 'prt-02-7321', 'prueba02@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 0);

	insert into  centro_operativo(centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-2, 'prt02', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 0, 0, 1, -2);

	raise_application_error(-20200,
		' ERROR: Centro operativo que no es oficina insertado.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20000 then
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
	update centro_operativo
	set gerente_empleado_id = -2
	where gerente_empleado_id = -1;

	raise_application_error(-20200,
		' ERROR: Centro operativo que no es oficina actualizado.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20000 then
    	dbms_output.put_line('OK, prueba 3 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/


Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;