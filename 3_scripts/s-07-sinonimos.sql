--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 03/12/2019
--@Descripción: Sínonimos publicos y privados

-- Sinónimo para ver los centros operativos
create or replace public synonym centro for centro_operativo;

-- Sinónimo para los status
create or replace public synonym status for status_mascota;

-- Sinónimo para el historico 
create or replace public synonym historico for historico_status_mascota;

-- Permisos para consultar tablas al usuario invitado
grant select on clinica to fb_proy_invitado;

grant select on mascota to fb_proy_invitado;

grant select on seleccion to fb_proy_invitado;

connect fb_proy_invitado/asdf

-- Sinónimo para ver las clínicos (Para que puedan llevar a sus mascota a consulta)
create or replace synonym clinica for fb_proy_admin.clinica;

-- Sinónimo para poder ver las mascotas
create or replace synonym mascota for fb_proy_admin.mascota;

-- Sinónimo para conocer la seleccion de las mascotas
create or replace synonym seleccion for fb_proy_admin.mascota;

-- Creación de sinónimos privados formado por dos caracteres
connect fb_proy_admin/asdf;

set serveroutput on
declare
    v_sql varchar2(2000);
    
    cursor cur_table_name is
    select table_name
    from user_tables;
begin
    for t in cur_table_name loop
        v_sql := 'create or replace synonym fb_'
                 || t.table_name || ' for ' || t.table_name;

        execute immediate v_sql;
    end loop;
end;
/