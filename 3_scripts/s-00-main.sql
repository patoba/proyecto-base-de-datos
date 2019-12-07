--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Ejecuta los scripts importantes del proyecto

--EJECUTAR EL SCRIPT COMO USUARIO SYS

prompt creando usuarios

@s-01-usuarios.sql

connect fb_proy_admin/asdf;

prompt creando entidades

@s-02-entidades.sql

prompt creando secuencias

@s-05-secuencias.sql

prompt creando indices

@s-06-indices.sql

prompt creando triggers

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

prompt creando procedimientos

--@

prompt creando funciones

--@

prompt realizando carga inicial

@s-09-carga-inicial.sql