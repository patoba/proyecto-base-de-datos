--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Usuarios y roles del proyecto


prompt Creando a los usuarios
create user fb_proy_admin identified by asdf quota unlimited on users;

create user fb_proy_invitado identified by asdf;

prompt Creando los roles
create role rol_admin;

grant create session, create synonym, create view, create table,
create sequence, create trigger, create procedure to rol_admin;

create role rol_invitado;

grant create session to rol_invitado;

prompt Asignando roles
grant rol_admin to fb_proy_admin;

grant rol_invitado to fb_proy_invitado;

prompt s-01-usuarios.sql se ejecuto a la perfeccion