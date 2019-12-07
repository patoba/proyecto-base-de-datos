--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: DDL empleado para crear las tablas del caso de estudio


-- Indices Non-Unique

prompt creando indices non-unique

CREATE INDEX emp_empleados_ix
ON empleado(nombre,apellido_paterno,apellido_materno);

CREATE INDEX cli_clientes_ix
ON cliente(nombre,apellido_paterno,apellido_materno);

-- Indices Unique

prompt creando indices unique

CREATE UNIQUE INDEX GRADO_ACADEMICO_cedula_profesional_uix
ON GRADO_ACADEMICO(cedula_profesional);

CREATE UNIQUE INDEX centro_operativo_codigo_uix
ON centro_operativo(codigo);

CREATE UNIQUE INDEX mascota_folio_uix 
ON mascota(folio);

CREATE UNIQUE INDEX empleado_username_uix
ON empleado(username);

CREATE UNIQUE INDEX empleado_email_uix
ON empleado(email);

CREATE UNIQUE INDEX empleado_curp_uix
ON empleado(curp);

CREATE UNIQUE INDEX cliente_username_uix
ON cliente(username);

CREATE UNIQUE INDEX cliente_email_uix
ON cliente(email);

--no valida username igual usar trigger

-- Indice unique compuesto

prompt creando indice compuesto

CREATE UNIQUE INDEX REVISION_mascota_revision_uix
ON revision(mascota_id, numero_revision);

CREATE UNIQUE INDEX SELECCION_mascota_cliente_uix
ON seleccion(mascota_id, cliente_id);


-- Indice basado en funcion

prompt creando indices basados en funcion

CREATE index mascota_fecha_ingreso_ix
ON mascota(extract(YEAR from fecha_ingreso));

CREATE INDEX mascota_nombre_ix
ON mascota(lower(nombre));

prompt script s-06-indices.sql ejecutado perfectamente 
