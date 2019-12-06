--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: DDL empleado para crear las tablas del caso de estudio

create table empleado (
    empleado_id number(10,0)
    constraint empleado_pk primary key,
    nombre varchar2(20) not null,
    apellido_paterno varchar2(20) not null,
    apellido_materno varchar2(20) not null,
    curp varchar2(18) not null,
    email varchar2(40) not null,
    sueldo_mensual number(8,2) not null,
    fecha_ingreso date default sysdate not null,
    es_administrativo number(1,0) not null,
    es_veterinario number(1,0) not null,
    es_gerente number(1,0) not null,
    CONSTRAINT CO_es_administrativo_CHK
    CHECK es_administrativo in (0, 1),
    CONSTRAINT CO_es_veterinario_CHK
    CHECK es_veterinario in (0, 1),
    CONSTRAINT CO_es_gerente_CHK
    CHECK es_gerente in (0, 1)
);

create table cliente (
    cliente_id number(10,0)
    constraint cliente_pk primary key,
    username varchar2(20) not null,
    password varchar2(20) not null,
    nombre varchar2(20) not null,
    apellido_paterno varchar2(20) not null,
    apellido_materno varchar2(20) not null,
    direccion varchar2(40) not null,
    ocupacion varchar2(40) not null
);

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
    codigo varchar2(5) not null,
    nombre varchar2(20) not null,
    direccion varchar2(80) not null,
    latitud number(10, 7) not null,
    longitud number(10, 7) not null,
    es_oficina number(1, 0) not null,
    es_clinica number(1, 0) not null,
    es_centro_refugio number(1, 0) not null,
    empleado_id number(10, 0) not null,
    CONSTRAINT centro_operativo_empleado_id_fk 
    FOREIGN KEY (empleado_id)
    REFERENCES empleado(empleado_id),
    CONSTRAINT CO_es_oficina_CHK
    CHECK es_oficina in (0, 1),
    CONSTRAINT CO_es_clinica_CHK
    CHECK es_clinica in (0, 1),
    CONSTRAINT CO_es_centro_refugio_CHK
    CHECK es_centro_refugio in (0, 1),
    CONSTRAINT CO_es_CHK
    CHECK es_oficina = 1
      AND es_clinica = 0
      AND es_centro_refugio = 0
     
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
    REFERENCES centro_operativo(centro_operativo_id),
    CONSTRAINT CLINICA_hora_CHK
    CHECK hora_inicio < hora_fin
);

CREATE TABLE direccion_web(
    direccion_web_id number(10, 0) primary key,
    url varchar2(40) not null,
    centro_operativo_id number(10, 0) not null,
    CONSTRAINT direccion_web_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_refugio(centro_operativo_id)
);

create table tipo_mascota (
    tipo_mascota_id number(10,0)
    constraint tipo_mascota_pk primary key,
    nombre varchar2(20) not null,
    subcategoria varchar2(20) not null,
    nivel_cuidados number(1,0) not null,
    constraint tipo_mascota_nivel_cuidados_ck check (
        nivel_cuidados between 1 and 5
    )
);

create table status_mascota (
    status_mascota_id number(10,0)
    constraint status_mascota_pk primary key,
    clave varchar2(20) not null,
    descripcion varchar2(40) not null
)

create table mascota (
    mascota_id number(10,0)
    constraint mascota_pk primary key,
    folio varchar2(8) not null,
    nombre varchar2(20) not null,
    fecha_nacimiento date not null,
    fecha_ingreso date default sysdate not null,
    fecha_status default sysdate not null,
    origen char(1) not null,
    estado_salud varchar2(40) not null
    descripcion_muerte varchar2(40),
    foto blob not null,
    centro_operativo_id number(10,0),
    tipo_mascota_id number(10,0) not null,
    status_mascota_id number(10,0) not null,
    empleado_id number(10,0) not null,
    padre_id number(10,0),
    madre_id number(10,0),
    cliente_id number(10,0),
    donador_id number(10,0),
    constraint mascota_origen_ck check (
        origen in ('D', 'A', 'R') -- D: Donada, A: Abandonada, R: Nacida en Cautiverio
    ),
    constraint mascota_centro_operativo_id_fk
    foreign key (centro_operativo_id)
    references centro_refugio(centro_operativo_id),
    constraint mascota_tipo_mascota_id_fk
    foreign key (tipo_mascota_id)
    references tipo_mascota(tipo_mascota_id),
    constraint mascota_status_mascota_id_fk
    foreign key (status_mascota_id)
    references status_mascota(status_mascota_id),
    constraint mascota_empleado_id_fk
    foreign key (empleado_id)
    references empleado(empleado_id),
    constraint mascota_padre_id_fk
    foreign key (padre_id)
    references mascota(mascota_id),
    constraint mascota_madre_id_fk
    foreign key (madre_id)
    references mascota(mascota_id),
    constraint mascota_cliente_id_fk
    foreign key (cliente_id)
    references cliente(cliente_id),
    constraint mascota_donador_id_fk
    foreign key (donador_id)
    references cliente(cliente_id)
);

create table historico_status_mascota (
    historico_status_mascota_id number(10,0)
    constraint historico_status_mascota_pk primary key,
    fecha_status date default sysdate not null,
    mascota_id number(10,0) not null,
    status_mascota_id number(10,0) not null,
    constraint historico_mascota_id_fk 
    foreign key (mascota_id)
    references mascota(mascota_id),
    constraint historico_status_mascota_id_fk
    foreign key (status_mascota_id)
    references status_mascota(status_mascota_id)
);

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