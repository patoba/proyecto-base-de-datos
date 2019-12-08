--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion que regresa el mascota_id de una mascota al azar

create or replace function dame_mascota
return number is 
    v_mascota_id number;
begin
    select mascota_id into v_mascota_id
    from mascota
    ORDER BY dbms_random.value
    fetch next 1 rows only;
    return v_mascota_id;
end;
/
show errors
