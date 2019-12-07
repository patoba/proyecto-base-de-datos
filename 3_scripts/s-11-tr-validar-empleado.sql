--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que valida que un empleado asignado a un centro operativo es un gerente

create or replace trigger trg_valida_empleado_es_gerente
before insert or update of gerente_empleado_id on centro_operativo
for each row
declare 
    v_es_gerente number(1, 0);
begin
    select count(*) into v_es_gerente
    from empleado 
    where empleado_id = :new.gerente_empleado_id
      and es_gerente = 1;
    if v_es_gerente = 0 then
        raise_application_error(-20000, 'El empleado que esta insertando en centro operativo no es un gerente');
    end if;
end;
/
SHOW ERRORS