
--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Trigger que realiza una copia de la tabla seleccion en seleccion_respaldo y borra todos los registros asociados a una mascota seleccionada, en la tabla seleccion, cuando se elige un ganador

 CREATE OR REPLACE TRIGGER trg_respaldo_seleccion
  FOR INSERT or DELETE or UPDATE OF es_ganador, descripcion ON seleccion COMPOUND TRIGGER
  v_mascota_id seleccion.mascota_id%type;
  v_cambiar_ganador number default 0;

  AFTER EACH ROW IS
  BEGIN
    CASE 
        WHEN INSERTING THEN
            INSERT INTO seleccion_respaldo
                (seleccion_respaldo_id, cliente_id, mascota_id, fecha_seleccion,
                descripcion, es_ganador)
            VALUES
                (:new.seleccion_id, :new.cliente_id, :new.mascota_id, :new.fecha_seleccion,
                :new.descripcion, :new.es_ganador);
        WHEN DELETING THEN
            DELETE FROM seleccion_respaldo
            WHERE seleccion_respaldo_id = :old.seleccion_id
              and es_ganador = 0;
        WHEN UPDATING('descripcion') THEN
            UPDATE seleccion_respaldo
            SET descripcion = :new.descripcion
            where seleccion_respaldo_id = :new.seleccion_id;
        WHEN UPDATING('es_ganador') THEN
            if :new.es_ganador = 1 THEN
                UPDATE seleccion_respaldo
                SET es_ganador = 1
                where seleccion_respaldo_id = :new.seleccion_id;
                UPDATE seleccion_respaldo
                SET es_ganador = 0
                where seleccion_respaldo_id != :new.seleccion_id;
                v_mascota_id := :new.mascota_id;
                v_cambiar_ganador := 1;
            else 
                v_cambiar_ganador := 0;
            end if;
        else
            null;
    END CASE;
  END AFTER EACH ROW;

-- Ejecución despues de cada fila, variables :NEW, :OLD son permitidas
AFTER STATEMENT IS 
BEGIN
    CASE
        WHEN UPDATING('es_ganador') then
            IF v_cambiar_ganador = 1 then
                
                DELETE FROM seleccion 
                WHERE mascota_id = v_mascota_id;

                update mascota
                set status_mascota_id = 5
                where mascota_id = v_mascota_id;
            END IF;
         else
            null;
   END CASE;
END AFTER STATEMENT;


END trg_respaldo_seleccion;
/
show errors;