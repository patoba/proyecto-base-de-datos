--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_valida_oficina

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido (centro operativo que es oficina)
Prompt ========================================

insert into empleado (empleado_id, nombre, apellido_paterno, apellido_materno, username, constrasena, email, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'Eula', 'Newell', 'Chesterton', 'asdasdasd', 'FBiF6ouSTi', 'echestertonrr@+wired.com', 30880.26, sysdate, 1, 0, 1);

insert into  centro_operativo(centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, empleado_id) values (-1, 'HBI12', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 1, 0, 0, -1);

insert into oficina (centro_operativo_id, rfc, responsable_legal) values (-1, '381-52-6960', 'Queenie Karpets');

Prompt OK, prueba 1 exitosa.


Prompt =======================================
Prompt Prueba 2.
prompt Intentando insertar un centro operativo que no es oficina
Prompt ========================================


declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin

	insert into  centro_operativo(centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, empleado_id) values (-2, '12345', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 0, 1, 0, -1);

    insert into oficina (centro_operativo_id, rfc, responsable_legal) values (-2, '381-52-6960', 'Queenie Karpets');

	-- Si se llega a este punto, significa que el trigger no está funcionando, se lanza
	--excepcion
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
Prompt Modificando los examenes del estudiante 21
Prompt ==================================================

update estudiante_extraordinario
set calificacion = 10
where estudiante_id = 21
and asignatura_id = 3
and num_examen = 1;

Prompt Validando  inserción en auditoria_extraordinario

declare
	v_count number;
begin
	select count(*) into v_count
	from auditoria_extraordinario
	where estudiante_id = 21
	and asignatura_id = 3
	and  calificacion_nueva = 10
	and  calificacion_anterior = 5;
	if v_count = 0 then
		raise_application_error(-20001,
			'ERROR. No se encontró registro en auditoria_extraordinario');
	end if;
	dbms_output.put_line('OK, Prueba 3 Exitosa.');

end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;