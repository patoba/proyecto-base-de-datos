--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 08/12/2019
--@Descripción: Script de prueba para validar que un archivo se gaurda en el servidor

set serveroutput on

create table test_lee_archivo (
    mascota_id number(10,0),
    foto blob
);

create sequence test_seq
start with 1
increment by 1;

create or replace trigger guarda_foto_prueba
after insert or update on test_lee_archivo
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
    v_blob := :new.foto;
    v_nombre_archivo := 'prueba_' || to_char(:new.mascota_id) || '.jpg';
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

Prompt =======================================
Prompt Prueba 1.
prompt Insertando registros y ejecutando trigger
Prompt ========================================

begin
    insert into test_lee_archivo values (test_seq.nextval, lee_archivo('starling_cape.jpg'));
    insert into test_lee_archivo values (test_seq.nextval, lee_archivo('alaskan_malamute.jpg'));
    dbms_output.put_line('OK, prueba 1 correcta.');
end;
/


Prompt =======================================
Prompt Prueba 2
prompt Actualizando registros 
Prompt ========================================

begin
    update test_lee_archivo
    set foto = lee_archivo('swordfish.jpg')
    where mascota_id = 1;
    dbms_output.put_line('OK, prueba 2 correcta.');
end;
/

Prompt =======================================
Prompt Prueba 3
prompt Insertando un registro con error
Prompt ========================================
declare
    v_codigo number;
    v_mensaje varchar2(1000);
begin
    insert into test_lee_archivo values (test_seq.nextval, lee_archivo('patito.jpg'));
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    if v_codigo = -20101 then
        dbms_output.put_line('OK, prueba 3 correcta, no se guarda archivo en servidor.');
    else
        raise;
    end if;
end;
/

drop table test_lee_archivo;
drop sequence test_seq;