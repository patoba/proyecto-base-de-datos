--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el procedimiento entrar_seleccion_prueba

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Pasando parametros correctos
Prompt ========================================

declare
    p_centro_operativo_id number := -1;
    p_mascota_id number := -1;
    p_fecha_revision date := sysdate;
    p_calificacion number := 2;
    p_estado_salud varchar2(40) := 'bien';
    p_costo number := 100;
    p_observaciones varchar2(40) := 'no se dejo poner la injeccion';
    v_username varchar2(20) := 'prueba01';
    v_folio varchar2(8) := 'prueba01';
    v_cat varchar(5) := 'prt01';
    v_empleado_id number := -1;
    v_mascota_id number := -1;
    v_cliente_id number := -1;
    v_num_revision number;
    v_descripcion varchar2(40) := 'holi';
    v_insercion_correcta number;
    v_codigo number;
	v_mensaje varchar2(1000);
begin

    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'prueba01', 'prb01--7321', 'prueba01@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into centro_operativo (centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-1, 'prt01', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 0, 1, 0, -1);

    insert into clinica (centro_operativo_id, hora_inicio, hora_fin, telefono_atencion, telefono_emergencia) values (-1, to_date('09:32:45', 'hh24:mi:ss'), to_date('21:57:51', 'hh24:mi:ss'), '+257 (509) 877-2486', '+880 (966) 215-2469');

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-1, 'prueba01', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba01@nba.com', '4390 American Ash Hill', 'Technical Writer');

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-1, 'prueba01', 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

    select count(*) into v_num_revision
    from revision 
    where mascota_id = v_mascota_id;


    p_mascota_va_al_medico(p_centro_operativo_id, p_mascota_id, p_fecha_revision, p_calificacion, p_estado_salud, p_costo, p_observaciones);

    select count(*) into v_insercion_correcta
    from revision 
    where numero_revision = v_num_revision + 1
      and mascota_id = v_mascota_id
      and clinica_id = p_centro_operativo_id 
      and calificacion = p_calificacion
      and estado_salud = p_estado_salud
      and observaciones = p_observaciones;

    if v_insercion_correcta = 1 then
        dbms_output.put_line('OK, prueba 1 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 1 '|| v_insercion_correcta);
    end if;
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    raise;
end;
/
show errors;

Prompt =======================================
Prompt Prueba 2.
prompt Pasando una mascota_id invalida
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_cliente_id number := -2;
    v_mascota_id number := -2;
    v_empleado_id number := -2;
    v_descripcion varchar2(40) := 'hola';
    v_username varchar2(20) := 'prueba02';
    v_folio varchar2(8) := 'prueba02';
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (v_empleado_id, 'prueba02', 'prt-02-7321', 'prueba02@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (v_mascota_id, v_folio, 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, v_empleado_id, null, null, null, null, null);


    p_entrar_seleccion(v_username, v_folio, v_descripcion);

    raise_application_error(-20200, 'Se ha insertado el registro');
      
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20008 then
    	dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
prompt Pasando una mascota que nunca ha ido a revision
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_cliente_id number := -3;
    v_mascota_id number := -3;
    v_empleado_id number := -3;
    v_username varchar2(20) := 'prueba03';
    v_folio varchar2(8) := 'prueba03';
    v_descripcion varchar2(40) := 'hola';
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (v_empleado_id, v_username, 'prt-03-7321', 'prueba03@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (v_cliente_id, v_username, 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba03@nba.com', '4390 American Ash Hill', 'Technical Writer');

    p_entrar_seleccion(v_username, v_folio, v_descripcion);

    raise_application_error(-20200, 'Se ha insertado el registro');

exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20009 then
    	dbms_output.put_line('OK, prueba 3 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 4.
prompt Pasando una mascota que esta enferma y tiene dueño
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_cliente_id number := -4;
    v_mascota_id number := -4;
    v_empleado_id number := -4;
    v_username varchar2(20) := 'prueba04';
    v_folio varchar2(8) := 'prueba04';
    v_descripcion varchar2(40) := 'hola';
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    p_entrar_seleccion(v_username, v_folio, v_descripcion);

    raise_application_error(-20200, 'Se ha insertado el registro');

exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo in (-20008, -20009) then
    	dbms_output.put_line('OK, prueba 4 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 5.
prompt Pasando una mascota que esta enferma y no tiene dueño (chequeo)
Prompt ========================================


Prompt =======================================
Prompt Prueba 6.
prompt Pasando una mascota que no esta enferma
Prompt ========================================

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;