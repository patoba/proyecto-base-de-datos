--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Procedimiento que permite que un cliente seleccione una mascota

create or replace procedure p_entrar_seleccion(
    p_username in cliente.username%type, 
    p_folio in mascota.folio%type,
    p_descripcion in seleccion.descripcion%type
) is
v_existe number;
v_mascota_id mascota.mascota_id%type;
v_cliente_id cliente.cliente_id%type;

begin 
    select count(*) into v_existe 
    from cliente
    where username = p_username;

    if v_existe = 0 then 
        raise_application_error(-20008, 'El username '|| p_username || ' no esta registrado en la BD');
    end if;

    select count(*) into v_existe 
    from mascota
    where folio = p_folio;

    if v_existe = 0 then 
        raise_application_error(-20009, 'El folio '|| p_folio || ' no esta registrado en la BD');
    end if;

    select mascota_id into v_mascota_id
    from mascota 
    where folio = p_folio;

    select cliente_id into v_cliente_id
    from cliente
    where username = p_username;

    insert into seleccion 
        (seleccion_id, cliente_id, mascota_id, descripcion)
    values 
        (seleccion_seq.nextval, v_cliente_id, v_mascota_id, p_descripcion);
end;
/
show errors;
