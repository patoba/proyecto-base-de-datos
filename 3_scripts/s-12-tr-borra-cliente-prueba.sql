--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el trigger trg_borra_cliente

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un cliente lo borramos y comprobamos que no se encuentre ni en mascota ni en seleccion
Prompt ========================================


declare
	v_codigo number;
	v_mensaje varchar2(1000);
    v_se_encuentra_en_mascota number;
    v_se_encuentra_en_seleccion number;
begin

	insert into cliente (cliente_id, username, contrasena, nombre, apellido_paterno, apellido_materno, email, direccion, ocupacion) values (-1, 'prueba01', 'g0ekvPOqp6', 'Ferdy', 'Doyley', 'Elton', 'prueba01@nba.com', '4390 American Ash Hill', 'Technical Writer');

    insert into empleado (empleado_id, username, curp, email, contrasena, nombre, apellido_paterno, apellido_materno, sueldo_mensual, fecha_ingreso, es_administrativo, es_veterinario, es_gerente) values (-1, 'pruera01', 'prt-01-7221', 'prueba01@artister.com', 'ymRHPL9r', 'Georges', 'Alenov', 'Raine', 53251.68, to_date('13/11/2019', 'dd/mm/yyyy'), 1, 1, 1);

	insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-1,complemento('pr91', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 5, null, -1, null, null, null, -1, -1);

    insert into mascota (mascota_id, folio, nombre, fecha_nacimiento, fecha_ingreso, fecha_status, origen, estado_salud, tipo_mascota_id, status_mascota_id, descripcion_muerte, veterinario_empleado_id, centro_refugio_id, padre_mascota_id, madre_mascota_id, dueno_cliente_id, donador_cliente_id) values (-2,complemento('pr02', 8), 'Marie-ève', to_date('30/10/2016', 'dd/mm/yyyy'), to_date( '09/12/2017', 'dd/mm/yyyy'), to_date('26/06/2019', 'dd/mm/yyyy'), 'A', 'tibia', 30, 2, null, -1, null, null, null, null, null);
	
    insert into seleccion (seleccion_id, cliente_id, mascota_id, fecha_seleccion, descripcion)
    values (-1, -1, -2, sysdate, 'holi');

    delete from cliente 
    where cliente_id = -1;

    select count(*) into v_se_encuentra_en_mascota
    from mascota 
    where donador_cliente_id = -1
      or dueno_cliente_id = -1;

    select count(*) into v_se_encuentra_en_seleccion
    from seleccion 
    where cliente_id = -1;

    if v_se_encuentra_en_mascota = 0 and v_se_encuentra_en_seleccion = 0 then 
	    dbms_output.put_line('OK, prueba 1 Exitosa.');
    else
        dbms_output.put_line('Error, prueba 1 fallida.');
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

rollback;