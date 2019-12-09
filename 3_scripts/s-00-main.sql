--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Ejecuta los scripts importantes del proyecto

prompt conectando como usuario sys

connect sys/system as sysdba

prompt Verificando usuario administrador
declare
    v_count number(1,0);
begin
  select count(*) into v_count
  from dba_users
  where username = 'FB_PROY_ADMIN';
  if v_count > 0 then
    dbms_output.put_line('Eliminando usuario administrador.');
    execute immediate 'drop user FB_PROY_ADMIN cascade';
  end if;
end;
/

prompt Elminando usuario invitado (en caso de que exista)
declare
    v_count number(1,0);
begin
  select count(*) into v_count
  from dba_users
  where username = 'FB_PROY_INVITADO';
  if v_count > 0 then
    dbms_output.put_line('Eliminando usuario invitado.');
    execute immediate 'drop user FB_PROY_INVITADO cascade';
  end if;
end;
/

prompt Elminando rol administrador (en caso de que exista)
declare
    v_count number(1,0);
begin
  select count(*) into v_count
  from dba_roles
  where role = 'ROL_ADMIN';
  if v_count > 0 then
    dbms_output.put_line('Eliminando role admin.');
    execute immediate 'drop role ROL_ADMIN';
  end if;
end;
/

prompt Elminando rol invitado (en caso de que exista)
declare
    v_count number(1,0);
begin
  select count(*) into v_count
  from dba_roles
  where role = 'ROL_INVITADO';
  if v_count > 0 then
    dbms_output.put_line('Eliminando role invitado.');
    execute immediate 'drop role ROL_INVITADO';
  end if;
end;
/

prompt creando usuarios

@s-01-usuarios.sql

connect fb_proy_admin/asdf;

prompt creando entidades

@s-02-entidades.sql

prompt crenado tablas temporales

@s-03-tablas-temporales.sql

prompt creando tablas_externas
@s-04-tablas-externas.sql

prompt creando secuencias

@s-05-secuencias.sql

prompt creando indices

@s-06-indices.sql

prompt creando sinonimos
@s-07-sinonimos.sql

prompt creando vistas
@s-08-vistas.sql

prompt creando triggers

prompt creando trigger borra_cliente
@s-11-tr-borra-cliente.sql
prompt creando trigger respaldo_seleccion
@s-11-tr-respaldo-seleccion.sql
prompt creando trigger valida-centro-refugio
@s-11-tr-valida-centro-refugio.sql
prompt creando trigger valida-clinica
@s-11-tr-valida-clinica.sql
prompt creando trigger valida-mascota-veterinario
@s-11-tr-valida-mascota-veterinario.sql
prompt creando trigger valida-oficina
@s-11-tr-valida-oficina.sql
prompt creando trigger validar-empleado
@s-11-tr-validar-empleado.sql
prompt creando trigger valida-seleccion
@s-11-tr-valida-seleccion.sql
prompt creando trigger respaldo seleccion
@s-11-tr-respaldo-seleccion.sql

prompt creando procedimientos
prompt entrar seleccion
@s-13-p-entrar-seleccion.sql
prompt expediente a archivo
@s-13-p-expediente-a-archivo.sql
prompt macota va al medico
@s-13-p-mascota-va-al-medico.sql

prompt creando funciones

prompt cargando funcion_lee_archivo
@s-15-fx-lee-archivo.sql
prompt cargando funcion complemento 
@s-15-fx-complemento.sql
prompt funcion dame mascota
@s-15-fx-dame-mascota.sql
prompt funcion dame cliente
@s-15-fx-dame-cliente.sql
prompt funcion dame veterinario
@s-15-fx-dame-veterinario.sql
prompt funcion dame centro refugio
@s-15-fx-dame-centro-refugio.sql
prompt funcion dame_centro_refugio_no_asignada
@s-15-fx-dame-centro-refugio-no-asignado.sql
prompt funcion dame_clinica_no_asignada
@s-15-fx-dame-clinica-no-asignado.sql
prompt funcion dame_gerente_sin_centro_operativo
@s-15-fx-dame-gerente-sin-centro-operativo.sql
prompt funcion dame_oficina_no_asignada
@s-15-fx-dame-oficina-no-asignada.sql
prompt funcion dame foto
@s-15-fx-dame-foto.sql

prompt cargando triggers para guardar lob en servidor
@s-17-lob-guarda-centro-refugio-logo.sql
@s-17-lob-guarda-firma-electronica.sql
@s-17-lob-guarda-mascota-foto.sql

prompt realizando carga inicial

@s-09-carga-inicial.sql