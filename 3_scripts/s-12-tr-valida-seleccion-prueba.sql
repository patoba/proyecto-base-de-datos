--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_valida_seleccion

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido 
Prompt ========================================

insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'prueba01', 'prt-01-7321', 'prueba01@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-1, complemento('pru01', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-1, 'prueba01', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba01@nba.com', '4390 American Ash Hill', 'Technical Writer');


insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
values (-1, -1, -1, sysdate, 'hola');

Prompt OK, prueba 1 exitosa.


Prompt =======================================
Prompt Prueba 2.
prompt Insertando a seleccion 1 cliente con una mascota no disponible para adopcion
Prompt ========================================


declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin

	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-2, 'prueba02', 'prueba02321', 'prueba02@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-2, complemento('pru02', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 1, null, -1, null, null, null, null, null);

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-2, 'prueba02', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba02@nba.com', '4390 American Ash Hill', 'Technical Writer');


	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-2, -2, -2, sysdate, 'hola');


	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20007 then
    	dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =================================================
Prompt Prueba 3.
Prompt Insertando un cliente que posee mas de 5 mascotas con una mascota x (la mascota se encuentra disponible para adopcion)
Prompt ==================================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin	
	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-3, 'prueba03', 'prueba03321', 'prueba03@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-3, complemento('pru03', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-3, 'prueba03', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba03@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-4, complemento('pru02-1', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -3, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-5, complemento('pru02-2', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -3, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-6, complemento('pru02-3', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -3, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-7, complemento('pru02-4', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -3, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-8, complemento('pru02-5', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -3, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-9, complemento('pru02-6', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -3, null);

	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-3, -3, -3, sysdate, 'hola');

	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20005 then
    	dbms_output.put_line('OK, prueba 3 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 4.
prompt Insertando a seleccion 1 cliente en una fecha posterior a 15 dias de la ultima fecha y una mascota x (la mascota se encuentra disponible para adopcion)
Prompt ========================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-4, 'prueba04', 'prueba04321', 'prueba04@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-10, complemento('pru04', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-4, 'prueba04-1', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba04-1@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-5, 'prueba04-2', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba04-2@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-4, -4, -10, sysdate, 'hola');
	
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-5, -5, -10, sysdate + 16, 'hola');


	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20006 then
    	dbms_output.put_line('OK, prueba 4 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 5.
prompt Insertando a seleccion 1 cliente en una fecha posterior a 15 dias de la ultima fecha y el cliente posee mas de 5 mascotas (la mascota se encuentra disponible para adopcion)
Prompt ========================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-5, 'prueba05', 'prueba05321', 'prueba05@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-11, complemento('pru05', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-6, 'prueba05-1', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba05-1@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-7, 'prueba05-2', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba05-2@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-12, complemento('pru05-1', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -7, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-13, complemento('pru05-2', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -7, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-14, complemento('pru05-7', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -7, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-15, complemento('pru05-4', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -7, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-16, complemento('pru05-5', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -7, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-17, complemento('pru05-6', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -7, null);


	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-6, -6, -11, sysdate, 'hola');
	
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-7, -7, -11, sysdate + 16, 'hola');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo in (-20006, -20005) then
    	dbms_output.put_line('OK, prueba 5 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 6.
prompt Insertando a seleccion 1 cliente en una fecha posterior a 15 dias de la ultima fecha y una mascota x (la mascota no se encuentra disponible para adopcion)
Prompt ========================================

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	
	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-6, 'prueba06', 'prueba06321', 'prueba06@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-18, complemento('pru06', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-8, 'prueba06-1', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba06-1@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-9, 'prueba06-2', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba06-2@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-8, -8, -11, sysdate, 'hola');

	update mascota
	set status_mascota_id = 1
	where mascota_id = -18;
	
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-9, -9, -11, sysdate + 16, 'hola');

	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo in (-20006, -2000) then
    	dbms_output.put_line('OK, prueba 6 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 7.
prompt Insertando a seleccion un cliente que posee mas de 5 mascotas y una mascota x (la mascota no se encuentra disponible para adopcion)
Prompt ========================================



declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	
	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-7, 'prueba07', 'prueba07321', 'prueba07@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-19, complemento('pru07', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 1, null, -1, null, null, null, null, null);

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-10, 'prueba07-1', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba07-1@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-20, complemento('pru07-1', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -10, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-21, complemento('pru07-2', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -10, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-22, complemento('pru07-3', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -10, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-23, complemento('pru07-4', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -10, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-24, complemento('pru07-5', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -10, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-25, complemento('pru07-6', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -10, null);

	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-10, -10, -19, sysdate, 'hola');

	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo in (-20005, -20007) then
    	dbms_output.put_line('OK, prueba 7 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/


Prompt =======================================
Prompt Prueba 8.
prompt Insertando a seleccion un cliente que posee mas de 5 mascotas, en una fecha posterior a 15 dias de la ultima fecha y la mascota a seleccionar no se encuentra disponible para adopcion
Prompt ========================================



declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	
	insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-8, 'prueba08', 'prueba08321', 'prueba08@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-26, complemento('pru08', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -8, null, null, null, null, null);

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-11, 'prueba08-1', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba08-1@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-12, 'prueba08-2', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba08-2@nba.com', '4390 American Ash Hill', 'Technical Writer');

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-27, complemento('pru08-1', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -12, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-28, complemento('pru08-2', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -12, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-29, complemento('pru08-3', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -12, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-30, complemento('pru08-4', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -12, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-31, complemento('pru08-5', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -12, null);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-32, complemento('pru08-6', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -12, null);

	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-11, -11, -26, sysdate, 'hola');

	update mascota
	set status_mascota_id = 1
	where mascota_id = -26;
	
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
	values (-12, -12, -11, sysdate + 16, 'hola');

	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo in (-20007, -20006, -20005) then
    	dbms_output.put_line('OK, prueba 8 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;

