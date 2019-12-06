--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que valida que un empleado asignado a un centro operativo es un gerente

create or replace trigger trg_valida_mascota_veterinario
before insert or update of empleado_id on mascota
for each row
declare 
    v_es_veterinario number(1, 0);
begin
    select count(*) into v_es_veterinario
    from empleado 
    where empleado_id = :new.empleado_id
      and es_veterinario = 1;
    if v_es_veterinario = 0 then
        raise_application_error(-20001, 'El empleado que esta insertando en mascota no es un veterinario');
    end if;
end;