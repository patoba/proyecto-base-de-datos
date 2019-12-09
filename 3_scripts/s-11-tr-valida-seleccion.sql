--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que valida que un empleado que desee seleccionar una mascota posea 5 mascotas aceptadas, que no han pasado mas de  15 días con respecto a la última selección y que la mascota tenga el status disponible_para_adopcion 

create or replace trigger trg_valida_seleccion
before insert on seleccion
for each row
declare 
    v_num_mascotas number(4, 0);
    v_num_dias number(4, 0);
    v_existe_anterior number(1, 0);
    v_mascota_disponible_para_adopcion number(1, 0);
    v_status_disponible_para_adopcion status_mascota.status_mascota_id%type;
begin
    v_status_disponible_para_adopcion := 2;
    select count(*) into v_mascota_disponible_para_adopcion
    from mascota 
    where mascota_id = :new.mascota_id
      and status_mascota_id = v_status_disponible_para_adopcion;
    if v_mascota_disponible_para_adopcion < 1 then 
        raise_application_error(-20007, 'La mascota no esta disponible para adopcion');
    end if;

    select count(*) into v_existe_anterior
    from seleccion
    where mascota_id = :new.mascota_id;

    if v_existe_anterior >= 1 then
        select (:new.fecha_seleccion - max(fecha_seleccion)) into v_num_dias
        from seleccion
        where mascota_id = :new.mascota_id;
    else 
        v_num_dias := 0;
    end if;
    
    if v_num_dias <= 15 then
        select count(*) into v_num_mascotas
        from mascota
        where dueno_cliente_id = :new.cliente_id;

        if v_num_mascotas > 5 then 
          raise_application_error(-20005, 'El cliente posee mas de 5 mascotas');
        end if;
    else 
        raise_application_error(-20006, 'Han pasado mas de 15 dias de la ultima seleccion');
    end if;
   
end;
/
SHOW ERRORS


--v_existe_cliente number(1, 0);
--v_existe_mascota number(1, 0);
--select count(*) into v_existe_cliente
--    from cliente 
--    where cliente_id = :new.cliente_id;
--    if v_existe_cliente = 0 then
        -- arrojar excepcion
--        raise_application_error(-20000, 'El cliente_id no existe');

--    end if;

--    select count(*) into v_existe_mascota
--    from mascota 
--    where mascota_id = :new.mascota_id;
--    if v_existe_mascota = 0 then
        -- arrojar excepcion
--        raise_application_error(-20000, 'La mascota_id no existe');

--    end if;