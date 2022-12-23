
//Allow sprite assigned to "spr" to animate if desired
if anim >= sprite_get_number(spr) - 1 anim = 0;
else anim++;

//Reset alarm
alarm_set(0, 20);