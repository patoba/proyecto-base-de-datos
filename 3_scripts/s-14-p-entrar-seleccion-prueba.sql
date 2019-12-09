--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_respaldo_seleccion

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Pasando como parametros un username y folio validos
Prompt ========================================

declare
    v_username varchar2(20) := 'prueba01';
    v_folio varchar2(8) := 'prueba01';
    v_empleado_id number := -1;
    v_mascota_id number := -1;
    v_cliente_id number := -1;
    v_descripcion varchar2(40) := 'holi';
    v_insercion_correcta number;
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (v_empleado_id, v_username, 'prt-01-7321', 'prueba01@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (v_mascota_id, v_folio, 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, v_empleado_id, null, null, null, null, null);

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (v_cliente_id, v_username, 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba01@nba.com', '4390 American Ash Hill', 'Technical Writer');

    p_entrar_seleccion(v_username, v_folio, v_descripcion);

    select count(*) into v_insercion_correcta
    from seleccion 
    where cliente_id = v_cliente_id
      and mascota_id = v_mascota_id;

    if v_insercion_correcta = 1 then
        dbms_output.put_line('OK, prueba 1 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 1');
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


Prompt =======================================
Prompt Prueba 2.
prompt Pasando como parametros un username invalido y folio valido
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
prompt Pasando como parametros un username valido y folio invalido
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
prompt Actualizando la columna es_ganador de un registro en la tabla revision
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


Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;