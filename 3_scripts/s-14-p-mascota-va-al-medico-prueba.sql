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
        dbms_output.put_line('Error, fallo en prueba 1');
        raise_application_error(-20200, 'Error');
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
    p_centro_operativo_id number := -1;
    p_mascota_id number := -2;
    p_fecha_revision date := sysdate;
    p_calificacion number := 2;
    p_estado_salud varchar2(40) := 'bien';
    p_costo number := 100;
    p_observaciones varchar2(40) := 'no se dejo poner la injeccion';
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    p_mascota_va_al_medico(p_centro_operativo_id, p_mascota_id, p_fecha_revision, p_calificacion, p_estado_salud, p_costo, p_observaciones);

    raise_application_error(-20200, 'Se ha insertado el registro');
      
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20010 then
    	dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
prompt Pasando una mascota que esta enferma y tiene dueño
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_codigo number;
	v_mensaje varchar2(1000);
begin

    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-3, 'prueba03', 'prb03--7321', 'prueba03@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into centro_operativo (centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-3, 'prt03', 'Hanesbrands Inc.', '782 Spaight Hill', -33.9705607, -71.8326771, 0, 1, 0, -3);

    insert into clinica (centro_operativo_id, hora_inicio, hora_fin, telefono_atencion, telefono_emergencia) values (-3, to_date('09:32:45', 'hh24:mi:ss'), to_date('21:57:51', 'hh24:mi:ss'), '+257 (509) 877-2486', '+880 (966) 215-2469');

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-3, 'prueba03', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba03@nba.com', '4390 American Ash Hill', 'Technical Writer');

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-3, 'prueba03', 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 3, null, -3, null, null, null, -3, null);


    p_mascota_va_al_medico(-3, -3, sysdate, 3, 'p_estado_salud', 10, 'p_observaciones');

    select count(*) into v_insercion_correcta
    from mascota 
    where mascota_id = -3
      and status_mascota_id = 5; --status adoptada
    
    if v_insercion_correcta = 1 then  
        dbms_output.put_line('OK, prueba 1 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 1');
        raise_application_error(-20200, 'Error');
    end if;

exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
end;
/

Prompt =======================================
Prompt Prueba 4.
prompt Pasando una mascota que esta enferma y no tiene dueño (chequeo)
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_codigo number;
	v_mensaje varchar2(1000);
begin

    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-4, 'prueba04', 'prb04--7321', 'prueba04@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into centro_operativo (centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-4, 'prt04', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 0, 1, 0, -4);

    insert into clinica (centro_operativo_id, hora_inicio, hora_fin, telefono_atencion, telefono_emergencia) values (-4, to_date('09:32:45', 'hh24:mi:ss'), to_date('21:57:51', 'hh24:mi:ss'), '+257 (509) 877-2486', '+880 (966) 215-2469');

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-4, 'prueba04', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba04@nba.com', '4390 American Ash Hill', 'Technical Writer');

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-4, 'prueba04', 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 3, null, -4, null, null, null, null, null);


    p_mascota_va_al_medico(-4, -4, sysdate, 3, 'p_estado_salud', 10, 'p_observaciones');

    select count(*) into v_insercion_correcta
    from mascota 
    where mascota_id = -4
      and status_mascota_id = 2; --disponible para adopcion
    
    if v_insercion_correcta = 1 then  
        dbms_output.put_line('OK, prueba 4 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 4');
        raise_application_error(-20200, 'Error');
    end if;

exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
end;
/

Prompt =======================================
Prompt Prueba 5.
prompt Pasando una mascota que no esta enferma
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_codigo number;
	v_mensaje varchar2(1000);
begin

    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-5, 'prueba05', 'prb05--7321', 'prueba05@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into centro_operativo (centro_operativo_id, codigo, nombre, direccion, latitud, longitud, es_oficina, es_clinica, es_centro_refugio, gerente_empleado_id) values (-5, 'prt05', 'Hanesbrands Inc.', '782 Spaight Hill', -13.9705607, -71.8326771, 0, 1, 0, -5);

    insert into clinica (centro_operativo_id, hora_inicio, hora_fin, telefono_atencion, telefono_emergencia) values (-5, to_date('09:32:45', 'hh24:mi:ss'), to_date('21:57:51', 'hh24:mi:ss'), '+257 (509) 877-2486', '+880 (966) 215-2469');

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-5, 'prueba05', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba05@nba.com', '4390 American Ash Hill', 'Technical Writer');

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-5, 'prueba05', 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -5, null, null, null, null, null);


    p_mascota_va_al_medico(-5, -5, sysdate, 3, 'p_estado_salud', 10, 'p_observaciones');

    select count(*) into v_insercion_correcta
    from mascota 
    where mascota_id = -5
      and status_mascota_id = 2; --disponible para adopcion
    
    if v_insercion_correcta = 1 then  
        dbms_output.put_line('OK, prueba 5 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 5');
        raise_application_error(-20200, 'Error');
    end if;

exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;