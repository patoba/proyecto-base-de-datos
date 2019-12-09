--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Usuarios y roles del proyecto


prompt Creando a los usuarios
create user fb_proy_admin identified by asdf quota unlimited on users;

create user fb_proy_invitado identified by asdf;

prompt Creando los roles
create role rol_admin;

grant create session, create synonym, create public synonym, create view, create table,
create sequence, create trigger, create procedure to rol_admin;

create role rol_invitado;

grant create session, create synonym to rol_invitado;

prompt Asignando roles
grant rol_admin to fb_proy_admin;

grant rol_invitado to fb_proy_invitado;

prompt permisos para directorios

create or replace directory data_dir as '/tmp/bd';
grant read,write on directory data_dir to fb_proy_admin;

Prompt creando objeto DATA_LOGOS
create or replace directory data_server as '/tmp/server/';
grant read,write on directory data_server to fb_proy_admin;
prompt s-01-usuarios.sql se ejecuto a la perfeccion