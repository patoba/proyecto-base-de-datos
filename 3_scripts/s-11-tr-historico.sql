--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que inserta, actualiza o borra el historico dependiendo si cambia mascota

create or replace trigger trg_historico
after insert or update of status_mascota_id or delete on mascota
for each row
declare 
    v_fecha_actual date;
begin
    case 
      when inserting then 
        insert into historico_status_mascota
            (historico_status_mascota_id, fecha_status, mascota_id, status_mascota_id)
        values
            (historico_status_mascota_seq.nextval, sysdate, :new.mascota_id, :new.status_mascota_id);
      when updating('status_mascota_id') then 
        v_fecha_actual := sysdate;
        update mascota
        set fecha_status = v_fecha_actual
        where mascota_id = :new.mascota_id; 
        insert into historico_status_mascota
            (historico_status_mascota_id, fecha_status, mascota_id, status_mascota_id)
        values
            (historico_status_mascota_seq.nextval, v_fecha_actual, :new.mascota_id, :new.status_mascota_id);
      when deleting then
        delete from historico_status_mascota
        where mascota_id = :old.mascota_id;
      else 
        null;
    end case;
end;
/
SHOW ERRORS


