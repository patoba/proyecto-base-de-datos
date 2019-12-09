--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Situacion: Los clientes vinieron a ver informes sobre mascotas no contamos con sistema asi que dejaron sus datos para que les enviaramos la informacion por correo 
--@Descripción: Script que contiene acceso a csv donde se almacenaron los datos de los clientes 

create table cliente_ext (
    username varchar2(30) not null,
    contrasena varchar2(20) not null,
    email varchar2(50) not null,
    nombre varchar2(20) not null,
    apellido_paterno varchar2(20) not null,
    apellido_materno varchar2(20) not null,
    direccion varchar2(40) not null,
    ocupacion varchar2(40) not null
)
organization external (
--En oracle existen 2 tipos de drivers para parsear el archivo:
-- oracle_loader y oracle_datapump
    type oracle_loader
    default directory tmp_dir
    access parameters (
    records delimited by newline
    badfile tmp_dir:'cliente_ext_bad.log'
    logfile tmp_dir:'cliente_ext.log'
    fields terminated by '#'
    lrtrim
    missing field values are null
    (
    username,contrasena, email, nombre, apellido_paterno, 
    apellido_materno, direccion, ocupacion
    )
    )
    location ('cliente_ext.csv')
    )
reject limit unlimited;

!mkdir -p /tmp/bases
!chmod 777 /tmp/bases
!cp datos/cliente_ext.csv /tmp/bases

-- col username format a20
-- col email format a20
-- col nombre format a20
-- col apellido_paterno format a20
-- col apellido_materno format a20
-- col direccion format a20
-- col ocupacion format a20

--select * from cliente_ext;