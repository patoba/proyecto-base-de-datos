--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion que regresa empleado_id de un empleado que es veterinario

create or replace function dame_veterinario 
return number is 
    v_veterinario_id number;
begin
    select empleado_id into v_veterinario_id 
    from empleado where es_veterinario = 1 
    ORDER BY dbms_random.value 
    fetch next 1 rows only;
    return v_veterinario_id;
end;
/
show errors
