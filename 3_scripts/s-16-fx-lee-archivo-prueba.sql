--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 08/12/2019
--@Descripción: Script de prueba para validar la función leer archivo

set serveroutput on

create table test_lee_archivo (
    mascota_id number(10,0),
    foto blob
);

create sequence test_seq
start with 1
increment by 1;

Prompt =======================================
Prompt Prueba 1.
prompt Pasando parametros correctos
Prompt ========================================

declare
    p_nombre_archivo varchar2(30) := 'starling_cape.jpg';
begin
    insert into test_lee_archivo values (test_seq.nextval, lee_archivo(p_nombre_archivo));
    dbms_output.put_line('OK, prueba 1 correcta.');
end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Pasando parametro de un archivo que no existe
Prompt ========================================

declare
    p_nombre_archivo varchar2(30) := 'oso_polar.jpg';
    v_codigo number;
    v_mensaje varchar2(1000);
begin
    insert into test_lee_archivo values (test_seq.nextval, lee_archivo(p_nombre_archivo));
exception
  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    if v_codigo = -20101 then
        dbms_output.put_line('OK, prueba 2 correcta.');
    else
        raise;
    end if;
end;
/

drop table test_lee_archivo;
drop sequence test_seq;