RELOAD

window_set_size(1440, 810);
window_set_cursor(cr_none);
cursor_sprite = spr_mouse_cursor;
image_speed = 0.1;

enum monmae{
	_player, _monsters, _monster_info, _monster_moves
	}

menu = 1;
typing = -1;
instruction = -1;
user_string = -1;
del_tmr = 30;

//MonDex Variables
hobble[0] = 0;
hobble[1] = 0;
incr[0] = 1;
incr[1] = 1;
timer = 0;

mon_hop = 1;
alarm_set(0, 5);

//Menu stuff
sel[0] = 0;		//Main menu
sel[1] = 0;		//Monster
sel[2] = 0;		//Menu 3
sel[3] = 0;		//Menu 4
sel[4] = 1;		//Menu 5

//Load save file
if file_exists("mondex.ini") var file = "mondex.ini";
else if file_exists("default.ini") var file = "default.ini";
else exit;			

ini_open(file);
for (var o = 0; o < array_length(mondex); o++;){
	for (var i = 1; i < 10; i++;){
		mondex[o, i] = ini_read_real("Monster_" + string(o), "Val" + string(i), 0);
		}
	mondex[o, 0] = ini_read_string("Monster_" + string(o), "Val" + string(0), "");
	mondex[o, 11] = ini_read_string("Monster_" + string(o), "Val" + string(o), "");
	mondex[o, 12] = ini_read_string("Monster_" + string(o), "Val" + string(o), "");
	}
ini_close();