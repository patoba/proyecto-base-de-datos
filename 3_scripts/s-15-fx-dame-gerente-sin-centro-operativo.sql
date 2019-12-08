--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion que regresa el empleado_id de un gerente (empleado) que no posee asociado un centro operativo

create or replace function dame_gerente_sin_centro_operativo
return number is 
    v_empleado_id number;
begin
    select empleado_id into v_empleado_id
    from empleado 
    where es_gerente = 1
      and empleado_id not in (select gerente_empleado_id 
                              from centro_operativo) 
    ORDER BY dbms_random.value 
    fetch next 1 rows only;
    return v_empleado_id;
end;
/
show errors