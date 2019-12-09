--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Script de prueba para validar el procedimiento entrar_seleccion_prueba

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt 
Prompt ========================================

declare
    mascota_id number := 8;
    v_codigo number;
	v_mensaje varchar2(1000);
begin
    p_expediente_a_archivo(mascota_id);
        dbms_output.put_line('OK, prueba 1 Exitosa.');

    -- if v_insercion_correcta = 1 then
    -- else
    --     dbms_output.put_line('Error, fallo en prueba 1');
    --     raise_application_error(-20200, 'Error');
    -- end if;
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    raise;
end;
/
show errors;



Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;