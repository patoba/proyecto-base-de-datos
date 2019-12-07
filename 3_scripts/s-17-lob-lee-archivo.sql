--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Gestión de datos BLOB (firma electrónica)

set serveroutput on

Prompt conectando como sys
connect sys as sysdba

Prompt creando objeto DATA_DIR
create or replace directory data_dir as '/tmp/bd';

grant read,write on directory data_dir to fb_proy_admin;

Prompt conectando como usuario fb_proy_admin
connect fb_proy_admin

Prompt creando procedimiento para insertar un archivo.
create or replace function lee_archivo(p_nombre_archivo in varchar2) 
return blob is
    v_bfile bfile;
    v_src_offset number := 1;
    v_dest_offset number := 1;
    v_dest_blob blob;
    v_src_length number;
    v_dest_length number;
begin
    v_src_offset := 1;
    v_dest_offset := 1;

    dbms_lob.createtemporary(v_dest_blob, true);
    dbms_output.put_line('cargando archivo para '|| p_nombre_archivo);

    v_bfile := bfilename('DATA_DIR', p_nombre_archivo);
    if dbms_lob.fileexists(v_bfile) = 1 and not dbms_lob.isopen(v_bfile) = 1 then 
        dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
    else raise_application_error(-20101, 'El archivo '
        || p_nombre_archivo
        ||' no existe en el directorio DATA_DIR'
        || ' o el archivo esta abierto');
    end if;

    dbms_lob.loadblobfromfile(
        dest_lob => v_dest_blob,
        src_bfile => v_bfile,
        amount => dbms_lob.getlength(v_bfile),
        dest_offset => v_dest_offset,
        src_offset => v_src_offset);

    dbms_lob.close(v_bfile);
    v_src_length := dbms_lob.getlength(v_bfile);
    v_dest_length := dbms_lob.getlength(v_dest_blob);

    if v_src_length = v_dest_length then
        dbms_output.put_line('Escritura correcta, bytes escritos: '
        || v_src_length);
        return v_dest_blob;
    else 
        raise_application_error(-20102, 'Error al escribir datos.\n'
        || ' Se esperaba escribir '
        || v_src_length
        || ' Pero solo se escribio '
        || v_dest_length);
    end if;
end;
/
show errors

create or replace procedure guarda_objeto_blob (
    v_nombre_directorio in varchar2,
    v_nombre_archivo    in varchar2,
    v_nombre_tabla      in out varchar2,
    v_nombre_col_blob   in out varchar2,
    v_nombre_col_pk     in out varchar2,
    v_valor_pk          in number,
    v_longitud          out number) is

    v_sql varchar2(2000);
    v_blob blob;
    v_file utl_file.FILE_TYPE;
    v_buffer_size number := 32767;
    v_buffer RAW(32767);
    v_position number := 1;
begin
    v_nombre_tabla := dbms_assert.simple_sql_name(v_nombre_tabla);
    v_nombre_col_blob := dbms_assert.simple_sql_name(v_nombre_col_blob);
    v_nombre_col_pk := dbms_assert.simple_sql_name(v_nombre_col_pk);

    v_sql := 'select ' || v_nombre_col_blob
             || ' into :ph_blob'
             || ' from '  || v_nombre_tabla
             || ' where ' || v_nombre_col_pk
             || ' = :ph_pk';

    execute immediate v_sql into v_blob using v_valor_pk; 

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

create or replace trigger guarda_mascota_foto
after insert or update on mascota
for each row
declare
    v_blob blob;
    v_nombre_directorio varchar2(30) := 'DATA_DIR';
    v_nombre_archivo varchar2(30);
    v_file utl_file.FILE_TYPE;
    v_buffer_size number := 32767;
    v_buffer RAW(32767);
    v_position number := 1;
    v_longitud number(10,0);
begin
    v_blob := :new.foto;
    v_nombre_archivo := ' m_' || to_char(:new.mascota_id) || '.jpg';
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

create or replace trigger guarda_centro_refugio_logo
after insert or update on centro_refugio
for each row
declare
    v_blob blob;
    v_nombre_directorio varchar2(30) := 'DATA_DIR';
    v_nombre_archivo varchar2(30);
    v_file utl_file.FILE_TYPE;
    v_buffer_size number := 32767;
    v_buffer RAW(32767);
    v_position number := 1;
    v_longitud number(10,0);
begin
    v_blob := :new.logo;
    v_nombre_archivo := ' cr_' || to_char(:new.centro_operativo_id) || '.jpg';
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

create or replace trigger guarda_oficina_firma_electronica
after insert or update on oficina
for each row
declare
    v_blob blob;
    v_nombre_directorio varchar2(30) := 'DATA_DIR';
    v_nombre_archivo varchar2(30);
    v_file utl_file.FILE_TYPE;
    v_buffer_size number := 32767;
    v_buffer RAW(32767);
    v_position number := 1;
    v_longitud number(10,0);
begin
    v_blob := :new.firma_electronica;
    v_nombre_archivo := ' o_' || to_char(:new.centro_operativo_id) || '.jpg';
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