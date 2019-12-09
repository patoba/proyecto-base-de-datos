--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Guarda los logos del centro refugio

create or replace trigger guarda_centro_refugio_logo
after insert or update on centro_refugio
for each row
declare
    v_blob blob;
    v_nombre_directorio varchar2(30) := 'DATA_SERVER';
    v_nombre_archivo varchar2(30);
    v_file utl_file.FILE_TYPE;
    v_buffer_size number := 32767;
    v_buffer RAW(32767);
    v_position number := 1;
    v_longitud number(10,0);
begin
    v_blob := :new.logo;
    v_nombre_archivo := 'cr_' || to_char(:new.centro_operativo_id) || '.jpg';
    v_file := utl_file.fopen(upper(v_nombre_directorio), v_nombre_archivo, 'wb', v_buffer_size);

    v_longitud := dbms_lob.getlength(v_blob);

    while v_position < v_longitud loop
        dbms_lob.read(v_blob, v_buffer_size, v_position, v_buffer);
        utl_file.put_raw(v_file, v_buffer, true);
        v_position := v_position + v_buffer_size;
    end loop;

    utl_file.fclose(v_file);

exception
    when others then 
        if utl_file.is_open(v_file) then
            utl_file.fclose(v_file);
        end if;

        dbms_output.put_line(dbms_utility.format_error_backtrace);

        v_longitud := -1;
        raise;
end;
/
show errors