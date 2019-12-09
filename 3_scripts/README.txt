Origen mascota:

'A' => abandonada
'D' => donada => donador_cliente_id
'R' => nacida en refugio => padre_mascota_id, madre_mascota_id, centro_refugio_id

INDICES DE CNETRO OPERATIVO 

oficina => 2,3,6,7,8,9,10, 12, 18, 19, 20
clinica => 1, 4, 11, 14, 15, 17
centro_refugio => 5, 13, 14, 16

STATUS MASCOTA 

1 EN_REFUGIO
2 DISPONIBLE_PARA_ADOPCION
3 ENFERMA
4 SOLICITADA_PARA_ADOPCION
5 ADOPCION
6 FALLECIDA_EN_REFUGIO
7 FALLECIDA_EN_HOGAR


CODIGO DE ERRORES:

1)
-20000 => s-11-tr-valida-empleado.sql 
    El empleado que esta insertando en centro operativo no es un gerente

2)
-20001 => s-11-tr-valida-mascota-veterinario.sql 
    El empleado que esta insertando en mascota no es un veterinario

3)
-20002 => s-11-tr-valida-clinica.sql 
    El centro operativo que esta insertando en clinica no es una clinica

4)
-20003 => s-11-tr-valida-centro-refugio.sql 
    El centro operativo que esta insertando en centro refugio no es un centro refugio

5)
-20004 => s-11-tr-valida-oficina.sql 
    El centro operativo que esta insertando en oficina no es una oficina

-20005 => s-11-tr-valida-seleccion.sql
    El cliente posee mas de 5 mascotas

-20006 => s-11-tr-valida-seleccion.sql
    Han pasado mas de 15 dias de la ultima seleccion

-20007 => s-11-tr-valida-seleccion.sql
    Mascota no disponible para adopcion

-20008 => s-13-p-entrar-seleccion.sql
    Username no existe

-20009 => s-13-p-entrar-seleccion.sql
    FOLIO no existe

-20010 => s-13-p-entrar-seleccion.sql
    mascota_id no existe

6)
-20200 =>
    Falla un trigger