--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Contiene la definición de todas las secuencias necesarias para poder insertar registros en tablas que requieran la generación de valores secuenciales.

prompt creando secuencia GRADO_ACADEMICO_seq

create sequence GRADO_ACADEMICO_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia empleado_seq

create sequence empleado_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia tipo_mascota_seq

create sequence tipo_mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 30
    noorder
;

prompt creando secuencia historico_status_mascota_seq

create sequence historico_status_mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia status_mascota_seq

create sequence status_mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 7
    noorder
;

prompt creando secuencia mascota_seq

create sequence mascota_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia centro_operativo_seq

create sequence centro_operativo_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia cliente_seq

create sequence cliente_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia seleccion_seq

create sequence seleccion_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia revision_seq

create sequence revision_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

prompt creando secuencia direccion_web_seq

create sequence direccion_web_seq
    start with 1
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

commit;
prompt script s-05-secuencias.sql ejecutado perfectamente 
