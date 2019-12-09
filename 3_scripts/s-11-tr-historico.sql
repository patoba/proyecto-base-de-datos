--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que inserta, actualiza o borra el historico dependiendo si cambia mascota

create or replace trigger trg_historico
for insert or update of status_mascota_id or delete on mascota compound trigger
  v_mascota_id seleccion.mascota_id%type;
  v_fecha_actual date;

  before each row is 
  begin 
    case 
     when deleting then
        delete from historico_status_mascota
        where mascota_id = :old.mascota_id;
    else 
        null;
    end case;
  end before each row;

after each row is
begin
    case 
      when inserting then 
        insert into historico_status_mascota
            (historico_status_mascota_id, fecha_status, mascota_id, status_mascota_id)
        values
            (historico_status_mascota_seq.nextval, sysdate, :new.mascota_id, :new.status_mascota_id);
      when updating('status_mascota_id') then 
        v_fecha_actual := sysdate; 
        insert into historico_status_mascota
            (historico_status_mascota_id, fecha_status, mascota_id, status_mascota_id)
        values
            (historico_status_mascota_seq.nextval, v_fecha_actual, :new.mascota_id, :new.status_mascota_id);
     
      else 
        null;
    end case;
  END AFTER EACH ROW;

  AFTER STATEMENT IS 
BEGIN
    CASE
        WHEN UPDATING('status_mascota_id') then
                update mascota
                set fecha_status = v_fecha_actual
                where mascota_id = v_mascota_id;
            
         else
            null;
   END CASE;
END AFTER STATEMENT;

end trg_historico;
/
SHOW ERRORS


