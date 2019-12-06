--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: DDL empleado para crear las tablas del caso de estudio


-- Indices Non-Unique

CREATE INDEX emp_empleados_ix
ON empleado(nombre,apellido_paterno,apellido_materno);

CREATE INDEX cli_clientes_ix
ON cliente(nombre,apellido_paterno,apellido_materno);

CREATE INDEX empleado_email_ix
ON empleado(email);

-- Indices Unique

CREATE UNIQUE INDEX GRADO_ACADEMICO_cedula_profesional_uix
ON GRADO_ACADEMICO(cedula_profesional);

CREATE UNIQUE INDEX centro_operativo_codigo_uix
ON centro_operativo(codigo);

CREATE UNIQUE INDEX mascota_folio_uix 
ON mascota(folio);

CREATE UNIQUE INDEX status_mascota_clave_uix
ON status_mascota(clave);

CREATE UNIQUE INDEX centro_operativo_uix
ON centro_operativo(nombre);

--no valida username igual usar trigger

-- Indice unique compuesto

CREATE UNIQUE INDEX REVISION_mascota_revision_uix
ON revision(mascota_id, revision_id)

CREATE UNIQUE INDEX SELECCION_mascota_cliente_uix
ON mascota(mascota_id, cliente_id)


-- Indice basado en funcion

CREATE index mascota_fecha_ingreso_ix
ON mascota(extract(YEAR from fecha_ingreso));

CREATE index mascota_fecha_ingreso_ix
ON mascota(extract(YEAR from fecha_ingreso));

CREATE INDEX mascota_nombre_ix
ON mascota(lower(nombre));