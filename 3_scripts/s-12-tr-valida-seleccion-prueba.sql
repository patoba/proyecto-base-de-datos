--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_valida_seleccion

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro valido 
Prompt ========================================

insert into empleado (empleado_id, nombre, apellido_paterno, apellido_materno, username, contrasena, email, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'Eula', 'Newell', 'Chesterton', 'asdasdasd', 'FBiF6ouSTi', 'echestertonrr@+wired.com', 30880.26, sysdate, 0, 1, 0);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id) values (-1, 'prueba01', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1);

insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-1, 'felt3on0123', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'felton0@n+ba.com', '4390 American Ash Hill', 'Technical Writer');

insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
values (-1, -1, -1, sysdate, 'hola');

Prompt OK, prueba 1 exitosa.


Prompt =======================================
Prompt Prueba 2.
prompt Insertando a seleccion 1 cliente con una mascota no disponible para adopcion
Prompt ========================================

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id) values (-2, 'prueba02', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 1, -1);

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (-2, -1, -2, sysdate, 'hola');
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

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, dueno_cliente_id) values (-3, 'prueba03', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1, -1);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, dueno_cliente_id) values (-4, 'prueba04', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1, -1);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, dueno_cliente_id) values (-5, 'prueba05', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1, -1);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, dueno_cliente_id) values (-6, 'prueba06', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1, -1);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, dueno_cliente_id) values (-7, 'prueba07', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1, -1);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id, dueno_cliente_id) values (-8, 'prueba08', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1, -1);

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id) values (-9, 'prueba08', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1);

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin	
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (-3, -1, -9, sysdate, 'hola');

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

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id) values (-10, 'prueba10', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 2, -1);

insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-2, 'felt3on0223', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'felto+0@n+ba.com', '4390 American Ash Hill', 'Technical Writer');

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (-4, -2, -10, sysdate + 16, 'hola');
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
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (-5, -1, -10, sysdate + 16, 'hola');
	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo in (-20005, -2006) then
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

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id) values (-11, 'prueba11', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 3, -1);

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (-6, -2, -11, sysdate + 16, 'hola');
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

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id) values (-12, 'prueba12', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 3, -1);

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (-7, -1, -12, sysdate, 'hola');
	raise_application_error(-20200,
		' ERROR: Se ha realizado la insercion.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo in (-20005, ) then
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

insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud,  tipo_mascota_id, status_mascota_id, veterinario_empleado_id) values (-13, 'prueba13', 'Océanne', sysdate - 2, sysdate - 1, sysdate, 'A', 'Prolong labor NOS-deliv',  1, 3, -1);

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin
	insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (-8, -1, -13, sysdate + 16, 'hola');
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
    	dbms_output.put_line('OK, prueba 7 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;