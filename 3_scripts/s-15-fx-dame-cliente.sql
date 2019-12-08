--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion que regresa el cliente_id de un cliente al azar

create or replace function dame_cliente 
return number is 
    v_cliente_id number;
begin
    select cliente_id  into v_cliente_id
    from cliente  
    ORDER BY dbms_random.value 
    fetch next 1 rows only;
    return v_cliente_id;
end;
/
show errors
