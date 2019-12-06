--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: DDL empleado para crear las tablas del caso de estudio


--Se desea ver todos los datos de los clientes que seleccionaron a una mascota

CREATE GLOBAL TEMPORARY TABLE seleccion_cliente(
    seleccion_id number(10, 0) not null,
    mascota_id number(10, 0) not null,
    cliente_id number(10, 0) not null,
    fecha_seleccion date not null,
    descripcion varchar2(40) not null,
    username varchar2(20) not null,
    email varchar2(50) not null,
    nombre varchar2(20) not null,
    apellido_paterno varchar2(20) not null,
    apellido_materno varchar2(20) not null,
    direccion varchar2(40) not null,
    ocupacion varchar2(40) not null
    CONSTRAINT SELECCION_cliente_id_fk 
    FOREIGN KEY (cliente_id)
    REFERENCES cliente(cliente_id),
    CONSTRAINT SELECCION_mascota_id_fk 
    FOREIGN KEY (mascota_id)
    REFERENCES mascota(mascota_id),
    CONSTRAINT SELECCION_es_ganador_CHK
    CHECK es_ganador in (0, 1)
) on COMMIT PRESERVE ROWS;
