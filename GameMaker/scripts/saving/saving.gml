function save(){

//Open or create save.sav in localappdata
ini_open("save.sav");

//Save Players information
ini_write_real("Player", "X", px);
ini_write_real("Player", "Y", py);
ini_write_string("Player", "RM", room_get_name(curr_rm));
ini_write_real("Player", "Story", story);
ini_write_real("Player", "Money", moni);
ini_write_real("Player", "Badges", badges);
ini_write_string("Player", "Area", area);

//Save players monsters data
for (var i = 0; i < array_length(monsters); i++;){
	for (var o = 0; o < array_length(monsters[i]); o++;){
		if o == party.trainer ini_write_string("Mon" + string(i), "Mon_stat" + string(o), monsters[i, o]);
		else ini_write_real("Mon" + string(i), "Mon_stat" + string(o), monsters[i, o]);
		}
	}

//Save inventory
for (var i = 0; i < array_length(inv); i++;){
	ini_write_string("inv0", "Inv" + string(i), inv[i, 0]);
	ini_write_real("inv1", "Inv" + string(i), inv[i, 1]);
	}
ini_close();

}
	
function load(){

//Load if a save exists
if (file_exists("save.sav")){
	ini_open("save.sav");

	//Load player data
	start_x =	ini_read_real("Player", "X", 144);
	start_y =	ini_read_real("Player", "Y", 112);
	curr_rm =	asset_get_index(ini_read_string("Player", "RM", "rm_houses"));
	story =		ini_read_real("Player", "Story", story);
	moni =		ini_read_real("Player", "Money", moni);
	badges =	ini_read_real("Player", "Badges", badges);
	area =		ini_read_string("Player", "Area", area);

	//Load players monsters data
	for (var i = 0; i < array_length(monsters); i++;){
		for (var o = 0; o < array_length(monsters[i]); o++;){
			if o == party.trainer monsters[i, o] = ini_read_string("Mon" + string(i), "Mon_stat" + string(o), monsters[i, o]);
			else monsters[i, o] = ini_read_real("Mon" + string(i), "Mon_stat" + string(o), monsters[i, o]);
			}
		}

	//Load inventory items and quantities
	for (var i = 0; i < array_length(inv); i++;){
		inv[i, 0] = ini_read_string("inv0", "Inv" + string(i), -1);
		inv[i, 1] = ini_read_real("inv1", "Inv" + string(i), inv[i, 1]);
		}
		
	ini_close();
	
	//Load our every time start-up settings from this function if we've set this function to 1 (true)
	debug_settings()
	
	//Go to current residing room
	if room_exists(curr_rm) room_goto(curr_rm);
	else show_debug_message("Room not found");
	}
}