--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion que regresa el centro_refugio_id de un centro_refugio al azar

create or replace function dame_centro_refugio 
return number is 
    v_centro_refugio_id number;
begin
    select centro_operativo_id into v_centro_refugio_id
    from centro_refugio  
    ORDER BY dbms_random.value 
    fetch next 1 rows only;
    return v_centro_refugio_id;
end;
/
show errors
