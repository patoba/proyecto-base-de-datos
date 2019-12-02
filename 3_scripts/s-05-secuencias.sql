--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Contiene la definición de todas las secuencias necesarias para poder insertar registros en tablas que requieran la generación de valores secuenciales.

create sequence GRADO_ACADEMICO_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence empleado_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence tipo_mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence historico_status_mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence status_mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence centro_operativo_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence cliente_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence seleccion_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence revision_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

create sequence direccion_web_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;
