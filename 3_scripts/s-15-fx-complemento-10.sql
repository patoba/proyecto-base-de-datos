set serveroutput on

Prompt creando procedimiento para insertar un archivo.
create or replace function complemento_10(p_cadena in varchar2) 
return varchar2 is
declare
    v_longitud number;
    v_completa varchar2(10);
begin
    v_longitud := 10 - length(p_cadena);

    for i in 0..v_longitud loop
        v_completa := '0' || p_cadena;
    end loop;
end;
/
show errors

