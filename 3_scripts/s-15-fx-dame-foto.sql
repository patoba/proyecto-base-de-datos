--@Autores: Emanuel Flores, Adolfo Barrero
--@Fecha creación: 01/12/2019
--@Descripción: Funcion pra insertar una foto de la mascota de acuerdo al tipo

create or replace function dame_foto(p_tipo_mascota in number)
return blob is
begin
    if p_tipo_mascota = 1 then
        return lee_archivo('langur_gray.jpg');
    elsif p_tipo_mascota = 2 then
        return lee_archivo('cow_scotish.jpg');
    elsif p_tipo_mascota = 3 then
        return lee_archivo('red_shouldered_starling.jpg');
    elsif p_tipo_mascota = 4 then
        return lee_archivo('gecko_ring_tailed.jpg');
    elsif p_tipo_mascota = 5 then
        return lee_archivo('otter_asian_small.jpg');
    elsif p_tipo_mascota = 6 then
        return lee_archivo('jackal_black_backed.jpg');
    elsif p_tipo_mascota = 7 then
        return lee_archivo('varanus_lizard.jpg');
    elsif p_tipo_mascota = 8 then
        return lee_archivo('alaskan_malamute.jpg');
    elsif p_tipo_mascota = 9 then  
        return lee_archivo('vulture_king.jpg');
    elsif p_tipo_mascota = 10 then
        return lee_archivo('pintail_bahama.jpg');
    elsif p_tipo_mascota = 11 then
        return lee_archivo('monitor_white.jpg');
    elsif p_tipo_mascota = 12 then
        return lee_archivo('dabchick.jpg');
    elsif p_tipo_mascota = 13 then
        return lee_archivo('squirrel_mandras.jpg');
    elsif p_tipo_mascota = 14 then
        return lee_archivo('caribou.jpg');
    elsif p_tipo_mascota = 15 then
        return lee_archivo('colobus_white.jpg');
    elsif p_tipo_mascota = 16 then
        return lee_archivo('gose_spur_winged.jpg');
    elsif p_tipo_mascota = 17 then
        return lee_archivo('burmese_tortoise.jpg');
    elsif p_tipo_mascota = 18 then
        return lee_archivo('striped_hyena.jpg');
    elsif p_tipo_mascota = 19 then
        return lee_archivo('roadrunner_greater.jpg');
    elsif p_tipo_mascota = 20 then
        return lee_archivo('secretary_bird.jpg');
    elsif p_tipo_mascota = 21 then
        return lee_archivo('martucha.jpg');
    elsif p_tipo_mascota = 22 then
        return lee_archivo('brush_tailed_rat.jpg');
    elsif p_tipo_mascota = 23 then
        return lee_archivo('ringtail.jpg');
    elsif p_tipo_mascota = 24 then
        return lee_archivo('ww_black_tern.jpg');
    elsif p_tipo_mascota = 25 then
        return lee_archivo('little_grebe.jpg');
    elsif p_tipo_mascota = 26 then
        return lee_archivo('starling_cape.jpg');
    elsif p_tipo_mascota = 27 then
        return lee_archivo('wild_boar.jpg');
    elsif p_tipo_mascota = 28 then      
        return lee_archivo('catfish_blue.jpg');
    elsif p_tipo_mascota = 29 then 
        return lee_archivo('swordfish.jpg');
    elsif p_tipo_mascota = 30 then 
        return lee_archivo('kiskadee_great.jpg');
    end if;
end;
/
show errors