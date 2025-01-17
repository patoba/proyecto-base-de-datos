set serveroutput on

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

