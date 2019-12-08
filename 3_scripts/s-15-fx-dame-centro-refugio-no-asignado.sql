--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion que regresa el centro_operativo_id de una centro_refugio que no este asociada a la tabla centro_refugio

create or replace function dame_centro_refugio_no_asignada
return number is 
    v_centro_operativo_id number;
begin
    select centro_operativo_id into v_centro_operativo_id
    from centro_operativo 
    where es_centro_refugio = 1 
      and centro_operativo_id not in (select centro_operativo_id
                                      from centro_refugio) 
    ORDER BY dbms_random.value 
    fetch next 1 rows only;
    return v_centro_operativo_id;
end;
/
show errors