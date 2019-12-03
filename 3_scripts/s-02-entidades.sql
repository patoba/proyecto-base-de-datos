--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: DDL empleado para crear las tablas del caso de estudio

--CREAR AQUI EMPLEADO

CREATE TABLE GRADO_ACADEMICO(
    grado_academico_id number(10, 0) primary key,
    cedula_profesional number(10, 0) not null,
    titulo varchar2(40) not null,
    fecha_titulacion date not null,
    empleado_id number(10, 0) not null,
    CONSTRAINT grado_academico_empleado_id_fk 
    FOREIGN KEY (empleado_id)
    REFERENCES empleado(empleado_id)
);

CREATE TABLE centro_operativo(
    centro_operativo_id number(10, 0) primary key,
    codigo varchar2(5) not null unique,
    nombre varchar2(20) not null,
    direccion varchar2(80) not null,
    latitud number(10, 7) not null,
    longitud number(10, 7) not null,
    es_oficina number(1, 0) not null,
    es_clinica number(1, 0) not null,
    empleado_id number(10, 0) not null,
    CONSTRAINT centro_operativo_empleado_id_fk 
    FOREIGN KEY (empleado_id)
    REFERENCES empleado(empleado_id)
);

CREATE TABLE oficina(
    centro_operativo_id number(10, 0) not null,
    rfc varchar2(13) not null,
    firma_eletronica blob not null,
    responsable_legal varchar2(40),
    CONSTRAINT oficina_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_operativo(centro_operativo_id)
);


CREATE TABLE centro_refugio(
    centro_operativo_id number(10, 0) not null,
    numero_registro number(10, 0) not null, 
    capacidad number(3, 0) not null,
    lema varchar2(40) not null,
    logo blob not null,
    CONSTRAINT centro_refugio_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_operativo(centro_operativo_id)
);


CREATE TABLE clinica(
    centro_operativo_id number(10, 0) not null,
    hora_inicio date not null,
    hora_fin date not null,
    telefono_atencion number(10, 0) not null,
    telefono_emergencia varchar2(10) not null,
    CONSTRAINT clinica_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_operativo(centro_operativo_id)
);

CREATE TABLE direccion_web(
    direccion_web_id number(10, 0) primary key,
    url varchar2(40) not null,
    centro_operativo_id number(10, 0) not null,
    CONSTRAINT direccion_web_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_refugio(centro_operativo_id)
);

--  CREAR MASCOTA AQUI


CREATE TABLE revision(
    revision_id number(10, 0) primary key,
    mascota_id number(10, 0) not null,
    numero_revision number(10, 0) not null,
    fecha_revision date not null default sysdate,
    costo number(7, 2) not null, 
    calificacion number(2, 0) not null,
    observaciones varchar2(40) not null,
    centro_operativo_id number(10, 0) not null,
    CONSTRAINT REVISION_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES clinica(centro_operativo_id),
    CONSTRAINT REVISION_mascota_id_fk 
    FOREIGN KEY (mascota_id)
    REFERENCES mascota(mascota_id)
);

CREATE TABLE seleccion(
    seleccion_id number(10, 0) primary key,
    mascota_id number(10, 0) not null,
    cliente_id number(10, 0) not null,
    fecha_seleccion date not null default sysdate,
    descripcion varchar2(40) not null,
    es_ganador number(1, 0) not null,
    CONSTRAINT SELECCION_cliente_id_fk 
    FOREIGN KEY (cliente_id)
    REFERENCES cliente(cliente_id),
    CONSTRAINT SELECCION_mascota_id_fk 
    FOREIGN KEY (mascota_id)
    REFERENCES mascota(mascota_id)
);