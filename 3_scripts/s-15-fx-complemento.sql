set serveroutput on

Prompt creando procedimiento para insertar un archivo.
create or replace function complemento(p_cadena in varchar2, p_n in number) 
return varchar2 is v_completa varchar2(10);
    
begin
    v_longitud integer;

    if length(p_cadena) >= p_n then
        v_completa := p_cadena;
        return(v_completa);
    end if;

    v_longitud := p_n - length(p_cadena);

    for i in 0..v_longitud loop
        v_completa := '0' || p_cadena;
    end loop;

    return(v_completa);
end;
/
show errors

