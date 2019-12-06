--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que valida que un centro operativo asociado a la entidad clinica sea una clinica

create or replace trigger trg_valida_clinica
before insert or update of centro_operativo_id on clinica
for each row
declare 
    es_pk_correcta number(1, 0);
begin
    select count(*) into es_pk_correcta
    from centro_operativo 
    where centro_operativo_id = :new.centro_operativo_id
      and es_clinica = 1;
    if es_pk_correcta = 0 then
        raise_application_error(-20002, 'El centro operativo que esta insertando en clinica no es una clinica');
    end if;
end;