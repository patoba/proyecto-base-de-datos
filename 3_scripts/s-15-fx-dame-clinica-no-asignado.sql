--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion que regresa el centro_operativo_id de una clinica que no este asociada a la tabla clinica

create or replace function dame_clinica_no_asignada
return number is 
    v_centro_operativo_id number;
begin
    select centro_operativo_id into v_centro_operativo_id
    from centro_operativo 
    where es_clinica = 1 
      and centro_operativo_id not in (select centro_operativo_id
                                      from clinica) 
    ORDER BY dbms_random.value 
    fetch next 1 rows only;
    return v_centro_operativo_id;
end;
/
show errors