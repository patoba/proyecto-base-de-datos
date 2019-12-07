set serveroutput on

Prompt creando procedimiento para insertar un archivo.
create or replace function complemento(p_cadena in varchar2, p_numero in number) 
return varchar2 is 
    v_completa varchar2(10);
    v_longitud number;
begin

    v_longitud := p_numero - length(p_cadena) - 1;
    v_completa := p_cadena;

    for i in 0..v_longitud loop
        v_completa := '0' || v_completa;
    end loop;

    return v_completa;
end;
/
show errors

set serveroutput on
declare 
    v_cadena varchar2(10) := '678A';
    v_numero number := 10;
    v_dato varchar2(10);
begin
    v_dato := complemento(v_cadena, v_numero);
    dbms_output.put_line('Cadena: ' || v_dato);
end;
/
