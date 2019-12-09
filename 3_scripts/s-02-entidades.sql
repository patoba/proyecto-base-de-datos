--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: DDL empleado para crear las tablas del caso de estudio

prompt creando tabla empleado
create table empleado (
    empleado_id number(10,0)
    constraint empleado_pk primary key,
    nombre varchar2(40) not null,
    apellido_paterno varchar2(30) not null,
    apellido_materno varchar2(30) not null,
    curp varchar2(18) not null,
    username varchar2(30) not null,
    contrasena varchar2(20) not null,
    email varchar2(60) not null,
    sueldo_mensual number(8,2) not null,
    fecha_ingreso date default sysdate not null,
    es_administrativo number(1,0) not null,
    es_veterinario number(1,0) not null,
    es_gerente number(1,0) not null,
    CONSTRAINT CO_es_administrativo_CHK
    CHECK (es_administrativo in (0, 1)),
    CONSTRAINT CO_es_veterinario_CHK
    CHECK (es_veterinario in (0, 1)),
    CONSTRAINT CO_es_gerente_CHK
    CHECK (es_gerente in (0, 1)),
    CONSTRAINT CO_existencia_CHK
    CHECK (es_administrativo = 1 OR es_veterinario = 1 OR es_gerente = 1)
);

prompt creando tabla cliente

create table cliente (
    cliente_id number(10,0)
    constraint cliente_pk primary key,
    username varchar2(30) not null,
    contrasena varchar2(20) not null,
    email varchar2(50) not null,
    nombre varchar2(20) not null,
    apellido_paterno varchar2(20) not null,
    apellido_materno varchar2(20) not null,
    direccion varchar2(40) not null,
    ocupacion varchar2(40) not null
);

prompt creando tabla grado_academico

CREATE TABLE GRADO_ACADEMICO(
    grado_academico_id number(10, 0) 
    constraint grado_academico_pk primary key,
    cedula_profesional varchar(10) not null,
    titulo varchar2(60) not null,
    fecha_titulacion date not null,
    empleado_id number(10, 0) not null,
    CONSTRAINT GA_cedula_profesional_CHK
    CHECK (cedula_profesional like '__________'),
    CONSTRAINT grado_academico_empleado_id_fk 
    FOREIGN KEY (empleado_id)
    REFERENCES empleado(empleado_id)
);

prompt creando tabla centro_operativo


CREATE TABLE centro_operativo(
    centro_operativo_id number(10, 0) 
    constraint centro_operativo_pk  primary key,
    codigo varchar2(5) not null,
    nombre varchar2(60) not null,
    direccion varchar2(120) not null,
    latitud number(10, 7) not null,
    longitud number(10, 7) not null,
    es_oficina number(1, 0) not null,
    es_clinica number(1, 0) not null,
    es_centro_refugio number(1, 0) not null,
    gerente_empleado_id number(10, 0) not null,
    CONSTRAINT centro_operativo_gerente_empleado_id_fk 
    FOREIGN KEY (gerente_empleado_id)
    REFERENCES empleado(empleado_id),
    CONSTRAINT CO_es_oficina_CHK
    CHECK (es_oficina in (0, 1)),
    CONSTRAINT CO_es_clinica_CHK
    CHECK (es_clinica in (0, 1)),
    CONSTRAINT CO_es_centro_refugio_CHK
    CHECK (es_centro_refugio in (0, 1)),
    CONSTRAINT CO_es_CHK
    CHECK (es_oficina != 1
      OR es_clinica = 0
      OR es_centro_refugio = 0),
    CONSTRAINT CO_empleado_id_UK 
    UNIQUE (gerente_empleado_id),
    CONSTRAINT CO_5_exactos_CH
    CHECK (codigo like '_____')
);

prompt creando tabla oficina


CREATE TABLE oficina(
    centro_operativo_id number(10, 0) 
    constraint oficina_pk primary key,
    rfc varchar2(13) not null,
    firma_eletronica blob default empty_blob() not null,
    responsable_legal varchar2(40),
    CONSTRAINT O_rfc_CHK
    CHECK (rfc like '_____________'),
    CONSTRAINT oficina_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_operativo(centro_operativo_id)
);


CREATE TABLE centro_refugio(
    centro_operativo_id number(10, 0) 
    constraint centro_refugio_pk primary key,
    numero_registro number(10, 0) not null, 
    capacidad number(3, 0) not null,
    lema varchar2(40) not null,
    logo blob default empty_blob() not null,
    CONSTRAINT centro_refugio_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_operativo(centro_operativo_id)
);

prompt creando tabla clinica

CREATE TABLE clinica(
    centro_operativo_id number(10, 0) 
    constraint clinica_pk primary key,
    hora_inicio date not null,
    hora_fin date not null,
    telefono_atencion varchar2(20) not null,
    telefono_emergencia varchar2(20) not null,
    CONSTRAINT clinica_centro_operativo_id_fk 
    FOREIGN KEY (centro_operativo_id)
    REFERENCES centro_operativo(centro_operativo_id),
    CONSTRAINT CLINICA_hora_CHK
    CHECK (hora_inicio < hora_fin)
);

prompt creando tabla direccion_web

CREATE TABLE direccion_web(
    direccion_web_id number(10, 0) 
    constraint direccion_Web_pk primary key,
    url varchar2(150) not null,
    centro_refugio_id number(10, 0) not null,
    CONSTRAINT direccion_web_centro_refugio_id_fk 
    FOREIGN KEY (centro_refugio_id)
    REFERENCES centro_refugio(centro_operativo_id)
);


prompt creando tabla tipo_mascota

create table tipo_mascota (
    tipo_mascota_id number(10,0)
    constraint tipo_mascota_pk primary key,
    nombre varchar2(60) not null,
    subcategoria varchar2(60) not null,
    nivel_cuidados number(1,0) not null,
    constraint tipo_mascota_nivel_cuidados_ck check (
        nivel_cuidados between 1 and 5
    )
);

prompt creando tabla status_mascota

create table status_mascota (
    status_mascota_id number(10,0)
    constraint status_mascota_pk primary key,
    clave varchar2(40) not null,
    descripcion varchar2(80) not null
);

prompt creando tabla mascota

create table mascota (
    mascota_id number(10,0)
    constraint mascota_pk primary key,
    folio varchar2(8) not null,
    nombre varchar2(60) not null,
    fecha_nacimiento date not null,
    fecha_ingreso date default sysdate not null,
    fecha_status date default sysdate not null,
    origen char(1) not null,
    estado_salud varchar2(40) not null,
    descripcion_muerte varchar2(40),
    foto blob default empty_blob() not null,
    centro_refugio_id number(10,0),
    tipo_mascota_id number(10,0) not null,
    status_mascota_id number(10,0) not null,
    veterinario_empleado_id number(10,0) not null,
    padre_mascota_id number(10,0),
    madre_mascota_id number(10,0),
    dueno_cliente_id number(10,0),
    donador_cliente_id number(10,0),
    CONSTRAINT MASCOTA_muerta_CHK
    CHECK (status_mascota_id not in (6, 7) OR descripcion_muerte is not null),
    CONSTRAINT MASCOTA_fechas_CHK
    CHECK (fecha_nacimiento <= fecha_ingreso AND fecha_ingreso <= fecha_status),
    CONSTRAINT mascota_origen_ck
    CHECK (origen = 'D' AND donador_cliente_id is not null -- donada
            OR origen = 'A' --abandonada
            OR origen = 'R' AND padre_mascota_id is not null AND madre_mascota_id is not null AND centro_refugio_id is not null), --refugio
    CONSTRAINT M_folio_CHK
    CHECK (folio like '________'),
    constraint mascota_centro_refugio_id_fk
    foreign key (centro_refugio_id)
    references centro_refugio(centro_operativo_id),
    constraint mascota_tipo_mascota_id_fk
    foreign key (tipo_mascota_id)
    references tipo_mascota(tipo_mascota_id),
    constraint mascota_status_mascota_id_fk
    foreign key (status_mascota_id)
    references status_mascota(status_mascota_id),
    constraint mascota_veterinario_empleado_id_fk
    foreign key (veterinario_empleado_id)
    references empleado(empleado_id),
    constraint mascota_padre_mascota_id_fk
    foreign key (padre_mascota_id)
    references mascota(mascota_id),
    constraint mascota_madre_mascota_id_fk
    foreign key (madre_mascota_id)
    references mascota(mascota_id),
    constraint mascota_dueno_cliente_id_fk
    foreign key (dueno_cliente_id)
    references cliente(cliente_id),
    constraint mascota_donador_cliente_id_fk
    foreign key (donador_cliente_id)
    references cliente(cliente_id)
);

prompt creando tabla historico_status_mascota

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

prompt creando tabla revision

CREATE TABLE revision(
    revision_id number(10, 0) primary key,
    mascota_id number(10, 0) not null,
    numero_revision number(10, 0) not null,
    fecha_revision date default sysdate not null,
    costo number(7, 2) not null, 
    calificacion number(2, 0) not null,
    observaciones varchar2(40) not null,
    clinica_id number(10, 0) not null,
    constraint revision_calificacion_ck 
    check (calificacion between 1 and 10),
    CONSTRAINT REVISION_clinica_id_fk 
    FOREIGN KEY (clinica_id)
    REFERENCES clinica(centro_operativo_id),
    CONSTRAINT REVISION_mascota_id_fk 
    FOREIGN KEY (mascota_id)
    REFERENCES mascota(mascota_id)
);

prompt creando tabla seleccion

CREATE TABLE seleccion(
    seleccion_id number(10, 0) primary key,
    mascota_id number(10, 0) not null,
    cliente_id number(10, 0) not null,
    fecha_seleccion date default sysdate not null ,
    descripcion varchar2(40) not null,
    es_ganador number(1, 0) default 0 not null,
    CONSTRAINT SELECCION_cliente_id_fk 
    FOREIGN KEY (cliente_id)
    REFERENCES cliente(cliente_id),
    CONSTRAINT SELECCION_mascota_id_fk 
    FOREIGN KEY (mascota_id)
    REFERENCES mascota(mascota_id),
    CONSTRAINT SELECCION_es_ganador_CHK
    CHECK (es_ganador in (0, 1))
);

prompt creando tabla seleccion respaldo

CREATE TABLE seleccion_respaldo(
    seleccion_respaldo_id number(10, 0) primary key,
    mascota_id number(10, 0) not null,
    cliente_id number(10, 0) not null,
    fecha_seleccion date default sysdate not null ,
    descripcion varchar2(40) not null,
    es_ganador number(1, 0) default 0 not null,
    CONSTRAINT SELECCION_respaldo_cliente_id_fk 
    FOREIGN KEY (cliente_id)
    REFERENCES cliente(cliente_id),
    CONSTRAINT SELECCION_respaldo_mascota_id_fk 
    FOREIGN KEY (mascota_id)
    REFERENCES mascota(mascota_id),
    CONSTRAINT SELECCION_respaldo_es_ganador_CHK
    CHECK (es_ganador in (0, 1))
);
prompt s-02-entidades.sql se ejecuto a la perfeccion