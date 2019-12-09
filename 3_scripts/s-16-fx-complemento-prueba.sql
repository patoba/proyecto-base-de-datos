--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 08/12/2019
--@Descripción: Script de prueba para validar la función complemento

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Pasando parametros correctos
Prompt ========================================

declare
    v_cadena varchar2(10) := '89aAX34';
    v_longitud number := 10;
    v_resultado varchar2(10);
begin
    v_resultado := complemento(v_cadena, 10);
    if length(v_resultado) = v_longitud then
        dbms_output.put_line('Se ha generado la cadena: ' || v_resultado);
        dbms_output.put_line('OK, prueba 1 correcta.');
    end if;
end;
/


