--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que antes de borrar un cliente borra los registros de las tablas mascota y seleccion

create or replace trigger trg_borra_cliente
before delete on cliente
for each row
    
begin
    update mascota 
    set dueno_cliente_id = null
    where dueno_cliente_id = :old.cliente_id;

    update mascota 
    set donador_cliente_id = null
    where donador_cliente_id = :old.cliente_id;

    delete seleccion 
    where cliente_id = :old.cliente_id;
   
end;
/
SHOW ERRORS


