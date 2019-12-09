--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_respaldo_seleccion

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un registro en  la tabla revision
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_seleccion_id number := -1;
    v_fecha_seleccion date := sysdate;
    v_cliente_id number := -1;
    v_mascota_id number := -1;
    v_descripcion varchar2(40) := 'hola';
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'prueba01', 'prt-01-7321', 'prueba01@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (v_mascota_id, complemento('pru01', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (v_cliente_id, 'prueba01', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba01@nba.com', '4390 American Ash Hill', 'Technical Writer');


    insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (v_seleccion_id, v_cliente_id, v_mascota_id, v_fecha_seleccion, v_descripcion);

    select count(*) into v_insercion_correcta
    from seleccion_respaldo
    where seleccion_respaldo_id = v_seleccion_id
      and cliente_id = v_cliente_id 
      and mascota_id = v_mascota_id
      and fecha_seleccion = v_fecha_seleccion
      and descripcion = v_descripcion;

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
prompt Borrando un registro en  la tabla revision
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_seleccion_id number := -2;
    v_fecha_seleccion date := sysdate;
    v_cliente_id number := -2;
    v_mascota_id number := -2;
    v_empleado_id number := -2;
    v_descripcion varchar2(40) := 'hola';
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (v_empleado_id, 'prueba02', 'prt-02-7321', 'prueba02@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (v_mascota_id, complemento('pru02', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, v_empleado_id, null, null, null, null, null);

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (v_cliente_id, 'prueba02', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba02@nba.com', '4390 American Ash Hill', 'Technical Writer');


    insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (v_seleccion_id, v_cliente_id, v_mascota_id, v_fecha_seleccion, v_descripcion);

    delete from seleccion
    where seleccion_id = v_seleccion_id;

    select count(*) into v_insercion_correcta
    from seleccion_respaldo
    where seleccion_respaldo_id = v_seleccion_id
      and cliente_id = v_cliente_id 
      and mascota_id = v_mascota_id
      and fecha_seleccion = v_fecha_seleccion
      and descripcion = v_descripcion;
      

    if v_insercion_correcta = 0 then
        dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 2');
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
Prompt Prueba 3.
prompt Actualizando la columna descripcion de un registro en la tabla revision
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_seleccion_id number := -3;
    v_fecha_seleccion date := sysdate;
    v_cliente_id number := -3;
    v_mascota_id number := -3;
    v_empleado_id number := -3;
    v_descripcion varchar2(40) := 'hola';
    v_nueva_descripcion varchar2(40) := 'adios';
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (v_empleado_id, 'prueba03', 'prt-03-7321', 'prueba03@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (v_mascota_id, complemento('pru03', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, v_empleado_id, null, null, null, null, null);

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (v_cliente_id, 'prueba03', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba03@nba.com', '4390 American Ash Hill', 'Technical Writer');


    insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (v_seleccion_id, v_cliente_id, v_mascota_id, v_fecha_seleccion, v_descripcion);

    update seleccion
    set descripcion = v_nueva_descripcion
    where seleccion_id = v_seleccion_id;

    select count(*) into v_insercion_correcta
    from seleccion_respaldo
    where seleccion_respaldo_id = v_seleccion_id
      and cliente_id = v_cliente_id 
      and mascota_id = v_mascota_id
      and fecha_seleccion = v_fecha_seleccion
      and descripcion = v_nueva_descripcion;

    if v_insercion_correcta = 1 then
        dbms_output.put_line('OK, prueba 3 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 3');
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
Prompt Prueba 4.
prompt Actualizando la columna es_ganador de un registro en la tabla revision
Prompt ========================================

declare
    v_insercion_correcta number := 0;
    v_seleccion_id number := -4;
    v_fecha_seleccion date := sysdate;
    v_cliente_id number := -4;
    v_mascota_id number := -4;
    v_empleado_id number := -4;
    v_descripcion varchar2(40) := 'hola';
    v_codigo number;
	v_mensaje varchar2(1000);
    v_cuenta_final number;
    v_num_ceros number;
    v_num_total number;
begin
    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (v_empleado_id, 'prueba04', 'prt-04-7321', 'prueba04@artisteer.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);


    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (v_mascota_id, complemento('pru04', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, v_empleado_id, null, null, null, null, null);

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (v_cliente_id, 'prueba04', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba04@nba.com', '4390 American Ash Hill', 'Technical Writer');

    insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (v_cliente_id-1, 'prueba04-1', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba04-1@nba.com', '4390 American Ash Hill', 'Technical Writer');

    insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (v_seleccion_id, v_cliente_id, v_mascota_id, v_fecha_seleccion, v_descripcion);

    insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion) values (v_seleccion_id-1, v_cliente_id-1, v_mascota_id, v_fecha_seleccion, v_descripcion);

    update seleccion
    set es_ganador = 1
    where cliente_id = v_cliente_id
      and mascota_id = v_mascota_id;

    select count(*) into v_cuenta_final
    from seleccion
    where mascota_id = v_mascota_id;

    select count(*) into v_insercion_correcta
    from seleccion_respaldo
    where seleccion_respaldo_id = v_seleccion_id
      and cliente_id = v_cliente_id 
      and mascota_id = v_mascota_id
      and fecha_seleccion = v_fecha_seleccion
      and descripcion = descripcion
      and es_ganador = 1;

    select count(*) into v_num_ceros
    from seleccion_respaldo
    where mascota_id = v_mascota_id
      and es_ganador = 0;

    select count(*) into v_num_total
    from seleccion_respaldo
    where mascota_id = v_mascota_id;
    
    if v_insercion_correcta = 1 and v_cuenta_final < 1 and v_num_total - v_num_ceros = 1 then
        dbms_output.put_line('OK, prueba 4 Exitosa.');
    else
        dbms_output.put_line('Error, fallo en prueba 4');
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


Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;