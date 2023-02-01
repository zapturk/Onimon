RELOAD



//If we have an editing window open over the main screen
if typing != -1{
	if press(ESCAPE){
	
		//If we press escape, just leave the data unchanged and reset the editing values
		instruction = -1;
		user_string = -1;
		typing = -1;
		
		}
	exit;
	}
if editing_move_val != -1{
	if press(ESCAPE){
		
		//If we press escape, just leave the data unchanged and reset the editing values
		instruction = -1;
		user_string = -1;
		editing_move_val = -1
		editing_move_exception = 0;
		if editing_move_val == move.sprite ds_list_clear(move_sprites);
		}
	
	if mouse(){
		if editing_move_val == move.element{
			for (var i = 0; i < 5; i++;){
				for (var o = 0; o < 3; o++;){
					
					if point_in_rectangle(mouse_x, mouse_y, 68 + (i * 31), 75 + (o * 11), 96 + (i * 31), 84 + (o * 11)){
						
						//Set the moves new element to the one that we've clicked from the list
						movedex[sel[2], sel[3]] = (i + (o * 5));
							
						instruction = -1;
						user_string = -1;
						editing_move_val = -1
						editing_move_exception = 0;
						break;
						}
					}
				}
			}
		}
	exit;
	}
if editing_stat_val != -1{
	if press(ESCAPE){
		
		//If we press escape, just leave the data unchanged and reset the editing values
		instruction = -1;
		user_string = -1;
		editing_stat_val = -1

		}
	exit;
	}
if editing_pool_val != -1{
	
	if instruction != -1 exit;
	
	if press(UP)sel[4]--;
	if press(DOWN) sel[4]++;
	if press(RIGHT) sel[4] += 10;
	if press(LEFT) sel[4] -= 10;
	if sel[4] < 0 sel[4] = 0;
	
	var _max = array_length(movepool)-1
	if sel[4] > _max sel[4] = _max;
	
	//If we click on an element, figure out which one, and jump to moves that have this element
	if mouse(){
		
		//Populate a temporary array based on the order of elements in the spr_monmae sprite
		var i = 0;
		_element_array[i] = element.light;		i++;
		_element_array[i] = element.grass;		i++;
		_element_array[i] = element.water;		i++;
		_element_array[i] = element.fire;		i++;
		_element_array[i] = element.electric;	i++;
		_element_array[i] = element.flying;		i++;
		_element_array[i] = element.fight;		i++;
		_element_array[i] = element.dark;		i++;
		_element_array[i] = element.poison;		i++;
		_element_array[i] = element.dragon;		i++;
		_element_array[i] = element.fairy;		i++;
		_element_array[i] = element.ice;		i++;
		_element_array[i] = element.ghost;		i++;
		
		for (var o = 0; o < 6; o++;){
			for (var i = 0; i < 2; i++;){
				if point_in_rectangle(mouse_x, mouse_y, 191 + (i*34), 22 + (o*12), 222 + (i*34), 32 + (o*12)){
					var ii = (o*2 + (i*1));
					
					for (var m = 0; m < array_length(movedex)-1; m++;){
						if movedex[m, move.element] == _element_array[ii]{
							sel[4] = m;
							break;
							}
						}
					}
				}
			}
		}
	
	if press(ENTER){
		movepool[sel[1], sel[3]*2] = sel[4];
		instruction = "What level should we learn this move?";
		user_string = "";
		exit;
		}
	
	if press(ESCAPE){
		
		//If we press escape, just leave the data unchanged and reset the editing values
		instruction = -1;
		user_string = -1;
		editing_pool_val = -1

		}
	exit;
	}

if press(ord("R")) game_restart();

if press(ord("F")){
	if window_get_fullscreen() == 1{
		window_set_fullscreen(0);
		}
	else window_set_fullscreen(1);
	}

//Check for player mouse input on bottom panel at all times
if mouse_x <= 16{
	
	//Check for player mouse input on load defaults button
	if point_in_rectangle(mouse_x, mouse_y, 0, 16, 16, 32){
	
		if mouse(){
			//Load save file
			var file = "default.ini";	

			ini_open(file);
			for (var o = 0; o < array_length(mondex); o++;){
				for (var i = 1; i < 10; i++;){
					mondex[o, i] = ini_read_real("Monster_" + string(o), "Val" + string(i), 0);
					}
				mondex[o, 0] = ini_read_string("Monster_" + string(o), "Val" + string(0), "");
				mondex[o, 11] = ini_read_string("Monster_" + string(o), "Val" + string(11), "");
				mondex[o, 12] = ini_read_string("Monster_" + string(o), "Val" + string(12), "");
				}
			ini_close();
			}
		draw_message = "Load Default Save Data";
		}
	
	//Check for player mouse input on close button
	if point_in_rectangle(mouse_x, mouse_y, 0, 0, 16, 16){
	
		if mouse(){
			//Loop through the current mondex values and save them to a new ini file
			ini_open("force_close_backup_mondex.ini");
			for (var o = 0; o < array_length(mondex); o++;){
				for (var i = 1; i < 10; i++;){
					ini_write_real("Monster_" + string(o), "Val" + string(i), mondex[o, i]);
					}
				ini_write_string("Monster_" + string(o), "Val" + string(0), mondex[o, 0]);
				ini_write_string("Monster_" + string(o), "Val" + string(11), mondex[o, 11]);
				ini_write_string("Monster_" + string(o), "Val" + string(12), mondex[o, 12]);
				}
			ini_close();
			game_end();
			}
		draw_message = "Save and exit MonMae";
		}
	
	//Check for player mouse input on new file button
	if point_in_rectangle(mouse_x, mouse_y, 0, 16, 16, 32){
		//if mouse() get_open_filename_ext("ini_file|*.ini", "", game_save_id, "View your save files! Note: OPEN does nothing here.");
		//draw_message = "Load default monster data";
		}
	
	//Check for player mouse input on explorer button
	if point_in_rectangle(mouse_x, mouse_y, 0, 32, 16, 48){
		if mouse() get_open_filename_ext("ini_file|*.ini", "", game_save_id, "View your save files! Note: OPEN does nothing here.");
		draw_message = "View Save File location";
		}
		
	//Check for player mouse input on explorer button
	if point_in_rectangle(mouse_x, mouse_y, 0, 48, 16, 64){
		if mouse(){
			//Loop through the current mondex values and save them to a new ini file
			ini_open("mondex_backup.ini");
			for (var o = 0; o < array_length(mondex); o++;){
				for (var i = 1; i < 10; i++;){
					ini_write_real("Monster_" + string(o), "Val" + string(i), mondex[o, i]);
					}
				ini_write_string("Monster_" + string(o), "Val" + string(0), mondex[o, 0]);
				ini_write_string("Monster_" + string(o), "Val" + string(1), mondex[o, dex.sub_descrip]);
				ini_write_string("Monster_" + string(o), "Val" + string(2), mondex[o,dex.descrip]);
				}
			ini_close();
			}
		draw_message = "Create backup save file";
		}
	
	//Check for player mouse input on music button
	if point_in_rectangle(mouse_x, mouse_y, 0, 112, 16, 128){
		if mouse(){
			if !audio_is_playing(snd_theme) audio_play_sound(snd_theme, 1, 1);
			else audio_stop_all();
			}
		draw_message = "pause or play music";
		}
	
	//Check for player mouse input on fullscreen button
	if point_in_rectangle(mouse_x, mouse_y, 0, 128, 16, 144){
		if mouse(){
			if !window_get_fullscreen() window_set_fullscreen(1);
			else{
				window_set_fullscreen(0);
				window_set_size(1440, 810);
				}
			}
		draw_message = "enter or exit fullscreen";
		}
	
	}

//Check for player mouse input on bottom panel at all times
if mouse() and mouse_y >= 144{
	
	for(var i = 0; i < 4; i++){
		if point_in_rectangle(mouse_x, mouse_y, 16 + (i*64), 144, 16+64 + (i*64), 144+16){
			break;
			}
		}
	
	switch (i){
		case 0:
			menu = monmae._player;
			image_speed = 0.075;
			break;
		case 1:
			menu = monmae._monsters;
			break;
		case 2:
			menu = monmae._monster_moves;
			image_speed = 0.2;
		}	
	
	}

//Get mouse controls for on screen buttons right side
if mouse() and mouse_x >= 256+16{

	//Check for player mouse input on save button
	if point_in_rectangle(mouse_x, mouse_y, 256+16, 64, 256+32, 80){
		if mouse(){
		
			//Loop through the current mondex values and save them to a new ini file
			ini_open("player_setup.ini");
		
			ini_write_real("Playable Character", "Num", playable_character);
			ini_write_real("Animation Speeds", "Walk Speed", walk_spd);
			ini_write_real("Animation Speeds", "Run Speed", run_spd);
			ini_close();
			
			//Loop through the current mondex values and save them to a new ini file
			ini_open("mondex.ini");
			for (var o = 0; o < array_length(mondex); o++;){
				for (var i = 1; i < 10; i++;){
					ini_write_real("Monster_" + string(o), "Val" + string(i), mondex[o, i]);
					}
				ini_write_string("Monster_" + string(o), "Val" + string(0), mondex[o, 0]);
				ini_write_string("Monster_" + string(o), "Val" + string(11), mondex[o, 11]);
				ini_write_string("Monster_" + string(o), "Val" + string(12), mondex[o, 12]);
				}
			ini_close();

			//Loop through the current movedex values and save them to a new ini file
			ini_open("movedex.ini");
			for (var o = 0; o < array_length(movedex); o++;){
				for (var i = 3; i < array_length(movedex[0]); i++;){
					ini_write_real("Move_" + string(o), "Val" + string(i), movedex[o, i]);
					}
				ini_write_string("Move_" + string(o), "Val" + string(0), movedex[o, 0]);
				ini_write_string("Move_" + string(o), "Val" + string(1), movedex[o, 1]);
				
				var sprite_string = sprite_get_name(movedex[o, 2]);
				ini_write_string("Move_" + string(o), "Val" + string(2), sprite_string);
				}
			ini_close();
			
			//Loop through the current movepools values and save them to a new ini file
			ini_open("movepools.ini");
			for (var o = 0; o < array_length(movepool); o++;){
				for (var i = 0, ii = 0; i < ((array_length(movepool[o])/2)); i++;){
					
					ini_write_real("Monster_" + string(o), "Move" + string(i), movepool[o, ii]);
					ini_write_real("Monster_" + string(o), "Level" + string(i), movepool[o, ii+1]);
					ii+=2;
					}
				ini_write_real("Monster_" + string(o), "Movepool_Length", ((array_length(movepool[o])/2)));
				}
			ini_close();
			
			}
		audio_play_sound(snd_save, 1, 0);
		flash = 1;
		}

	//Check for player mouse input on twitter button
	if point_in_rectangle(mouse_x, mouse_y, 256+16, 112, 256+32, 128){
		url_open("https://twitter.com/yanako_rpgs");
		}
		
	//Check for player mouse input on discord button
	if point_in_rectangle(mouse_x, mouse_y, 256+16, 128, 256+32, 144){
		url_open("https://discord.com/invite/4YUaYNvVHD");
		}
	}

if menu == monmae._player{

	//Check for player mouse input on save button
	if point_in_rectangle(mouse_x, mouse_y, 256+16, 64, 256+32, 80){
		draw_message = "save current player data";
		}
	}

if menu == monmae._monsters{
	
	if mouse_wheel_up() and sel[1] > 0 sel[1]--;
	if mouse_wheel_down() and sel[1] < array_length(mondex)-1 sel[1]++;
	
	if press(DOWN) and sel[1] < array_length(mondex)-1 sel[1]++;
	if press(UP) and sel[1] > 0 sel[1]--;
	
	if press(ENTER){
		menu = monmae._monster_info;
		}
	
	if mouse(){
		if point_in_rectangle(mouse_x, mouse_y, 20, 8, 128, 116) menu = monmae._monster_info;
		}
	
	//Get mouse controls for on screen buttons
	if mouse_x >= 256+16{
		//Check for player mouse input on right arrows for incrementing monster num
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 16, 256+32, 32){
			if mouse() and sel[1] > 0 sel[1]--;
			draw_message = "go to the prev monster";
			}
			
		//Check for player mouse input for resetting sel
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 32, 256+32, 48){
			if mouse() sel[1] = 0;
			draw_message = "Jump to the first monster";
			}
			
		//Check for player mouse input on right arrows for incrementing monster num
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 48, 256+32, 64){
			if mouse() sel[1]++;
			draw_message = "go to the next monster";
			}
			
		//Check for player mouse input on save button
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 64, 256+32, 80){
			draw_message = "save current monster data";
			}
		
		//Check for player mouse input on erase button
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 80, 256+32, 96){
			if mouse(){
				for (var o = 0; o < 366; o++;){
					for (var i = 0; i < 12; i++;){
						mondex[o, i] = 0;
						}
					mondex[o, 0] = "";
					mondex[o, 11] = "";
					mondex[o, 12] = "";
				
					mondex[o, 7] = element.light;
					mondex[o, 8] = -1;
					mondex[o, 10] = 1.00;
					}
				}
			draw_message = "Erase all monster data";
			}
		
		//Check for player mouse input on reload button
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 96, 256+32, 112){
			
			if mouse(){
				//Load save file
				if file_exists("mondex.ini") var file = "mondex.ini";
				else var file = "default.ini";
			
				ini_open(file);

				for (var o = 0; o < array_length(mondex); o++;){
					for (var i = 1; i < 10; i++;){
						mondex[o, i] = ini_read_real("Monster_" + string(o), "Val" + string(i), 0);
						}
					mondex[o, 0] = ini_read_string("Monster_" + string(o), "Val" + string(0), "");
					mondex[o, 11] = ini_read_string("Monster_" + string(o), "Val" + string(11), "");
					mondex[o, 12] = ini_read_string("Monster_" + string(o), "Val" + string(12), "");
					}
				ini_close();
				}
			draw_message = "Reload last saved data";
			}
		}
	}

if menu == monmae._monster_info{
	
	if press(DOWN) and (sel[1] < array_length(mondex)-1) sel[1]++;
	if sel[1] > 0{
		if press(UP) sel[1]--;
		}
	
	if press(ENTER){
		menu = monmae._monster_info;
		}
	if press(ESCAPE) menu = monmae._monsters;

	if mondex[sel[1], dex.evolve] < 1 draw_message = "mon won't evo by leveling"
	else draw_message = "mon will evolve at " + string(mondex[sel[1], dex.evolve]);

	//Get mouse controls for on screen buttons
	if mouse(){
	
		if sel[1] > 0{
			//Check for player mouse input on right arrows for incrementing monster num
			if point_in_rectangle(mouse_x, mouse_y, 256+16, 16, 256+32, 32){
				sel[1]--;
				}
			}
			
		//Check for player mouse input on MOVEPOOLS button
		if point_in_rectangle(mouse_x, mouse_y, 191, 46, 244, 55){
			menu = monmae._monsters_movepools
			}
		
		//Check for player mouse input on BASE STATS button
		if point_in_rectangle(mouse_x, mouse_y, 192, 58, 250, 68){
			menu = monmae._monsters_stats
			}
		
		//Check for player mouse input on right arrows for incrementing monster num
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 48, 256+32, 64){
			sel[1]++;
			}
		
		//Check for player mouse input on erase button
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 80, 256+32, 96){
		
			var o = sel[1];
			for (var i = 0; i < 12; i++;){
				mondex[o, i] = 0;
				}
			mondex[o, 0] = "";
			mondex[o, 11] = "";
			mondex[o, 12] = "";
				
			mondex[o, 7] = element.light;
			mondex[o, 8] = -1;
			mondex[o, 10] = 1.00;
			}
		
		//Check for player mouse input on reload button
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 96, 256+32, 112){
			
			//Load save file
			if file_exists("mondex.ini") var file = "mondex.ini";
			else var file = "default.ini";
			
			var o = sel[1];
			ini_open(file);
			for (var i = 1; i < 10; i++;){
				mondex[o, i] = ini_read_real("Monster_" + string(o), "Val" + string(i), 0);
				}
			mondex[o, 0] = ini_read_string("Monster_" + string(o), "Val" + string(0), "");
			mondex[o, 11] = ini_read_string("Monster_" + string(o), "Val" + string(11), "");
			mondex[o, 12] = ini_read_string("Monster_" + string(o), "Val" + string(12), "");
			ini_close();
			}
		}
	}

if menu == monmae._monsters_stats{
	
	if press(DOWN) and (sel[3] < 6) sel[3]++;
	if sel[3] > 0{
		if press(UP) sel[3]--;
		}
	
	if press(ESCAPE) menu = monmae._monster_info;
	
	if press(ENTER){
		if editing_stat_val == -1 editing_stat_val = sel[3];
		
		//Set up editing window data
		user_string = "";
		editing_stat_val = sel[3];
		instruction = "Type Stat Value";
		clear(ENTER);
		}
	
	//If we click the random button, randomize our stats based on our current total stats sum
	if mouse(){
		if point_in_rectangle(mouse_x, mouse_y, 207, 7, 245, 15){
			var i = 0, total_stats = 0;
			repeat(6){
				total_stats += mondex[sel[2], i+1];
				i++;
				}
			i = 0;
			randomize();
	
			//Reset Stats Array
			repeat(6){
				mondex[sel[2], i+1] = 0;
				i++;
				}
		
			//Randomly tally up stats
			for (var i = 0, o = 0; i < total_stats; i++;){
				var stat_increase = irandom_range(1, 3);
				mondex[sel[2], o+1] += stat_increase;
				i += stat_increase-1;
				o++;
				if o >= 6 o = 0;
				}
			}
		}	
	}

if menu == monmae._monster_moves{
	
	if press(ENTER){
		menu = monmae._monster_moves_info;
		clear(ENTER);
		sel[3] = 0;
		}

	if mouse_wheel_up() and sel[2] > 0 sel[2]--;
	if mouse_wheel_down() and sel[2] < array_length(movedex)-1 sel[2]++;

	if press(DOWN) and sel[2] < array_length(movedex)-1 sel[2]++;
	if sel[2] > 0{
		if press(UP) sel[2]--;
		}
	
	if mouse(){
		//Check for -10
		if point_in_rectangle(mouse_x, mouse_y, 214, 6, 223, 17){
			sel[2] -= 10;
			if sel[2] < 0 sel[2] = 0;
			}
		//Check for +10
		if point_in_rectangle(mouse_x, mouse_y, 226, 6, 235, 17){
			sel[2] += 10;
			if sel[2] > array_length(movedex) sel[2] = (array_length(movedex)-1);
			}
		
		//Check for "Add New Move"
		if point_in_rectangle(mouse_x, mouse_y, 254, 10, 270, 18){
			sel[2] = (array_length(movedex));
			BUILD_MOVEDEX_ARRAY("New Move",	"New Move Description", mov_impact_01,	40,	element.light,	type.physical,	95,	35);
			}
		
		//Check for "Top" and "Bot"
		if point_in_rectangle(mouse_x, mouse_y, 254, 25, 270, 33) sel[2] = 0;
		if point_in_rectangle(mouse_x, mouse_y, 254, 36, 270, 44) sel[2] = (array_length(movedex)-1);
		}
	
	}

if menu == monmae._monster_moves_info{
	
	if press(ENTER){
		if editing_move_val == -1 editing_move_val = sel[3]+1;	//+1 to Skip Name and start from Health
		
		//enum dex{
		//	name, health, atk, def, mgk_atk, mgk_def, spd, element1, element2, ability, cap_rate, sub_descrip, descrip, evolve
		//	}
		
		switch (sel[3]){
			
			case move.name:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Name";
				break;
				
			case move.sprite:
				editing_move_val = sel[3];
				editing_move_exception = 1;
				
				var i = 0;
				move_sprites = ds_list_create();
				while sprite_exists(i){
					var find_move = sprite_get_name(i);
					if string_starts_with(find_move, "mov_"){
						ds_list_add(move_sprites, find_move);
						}
					i++;
					}
				scroll = 0;
				break;
			
			case move.description:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Description";
				break;
			
			case move.animation:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Animation Type";
				break;
			
			case move.power:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Power (Or -1)";
				break;
			
			case move.healing:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Healing Power (Or -1)";
				break;
				
			case move.accuracy:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Accuracy (Or -1)";
				break;
			
			case move.element:
				editing_move_val = sel[3];
				editing_move_exception = 1;
				instruction = "Choose an Element";
				break;
			
			case move.mana:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Max Uses";
				break;
				
			case move.priority:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Priority";
				break;
			
			case move.chance_status: case move.chance_flinch: case move.chance_stat:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Chance";
				break;
			
			case move.type: case move.flinch: case move.hi_crit: case move.protect: case move.firstturn: case move.recharge: case move.onehitko: case move.recoil:
				if movedex[sel[2], sel[3]] == 0 movedex[sel[2], sel[3]] = 1;
				else movedex[sel[2], sel[3]] = 0;
				editing_move_val = -1;
				break;
			
			case move.recoil_amnt:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Move Recoil % Amount";
				break;
			
			default:
				user_string = "";
				editing_move_val = sel[3];
				instruction = "Type Stat Change";
			}
		clear(ENTER);
		}
	if editing_move_val != -1 exit;
	else{
		switch (sel[3]){
			
			case move.power:
				if press(RIGHT)
				if press(LEFT) 
				break;
		
			}
		}
	
	if mouse_wheel_up() and sel[3] > 0 sel[3]--;
	if mouse_wheel_down() and sel[3] < array_length(movedex[0])-1 sel[3]++;
	
	if press(ESCAPE) menu = monmae._monster_moves;
	if press(DOWN) and sel[3] < array_length(movedex[0])-1 sel[3]++;
	if press(UP) and sel[3] > 0 sel[3]--;
	
	if press(RIGHT){
		
		}
	
	if mouse(){
		if point_in_rectangle(mouse_x, mouse_y, 214, 6, 223, 17){
			sel[3] -= 10;
			if sel[3] < 0 sel[3] = 0;
			}
		if point_in_rectangle(mouse_x, mouse_y, 226, 6, 235, 17){
			sel[3] += 10;
			if sel[3] > array_length(movedex[0])-6 sel[3] = (array_length(movedex[0])-6);
			}
			
		//Check for "Top" and "Bot"
		if point_in_rectangle(mouse_x, mouse_y, 254, 25, 270, 33) sel[3] = 0;
		if point_in_rectangle(mouse_x, mouse_y, 254, 36, 270, 44) sel[3] = (array_length(movedex[0])-6);
		}
	
	}

if menu == monmae._monsters_movepools{
	
	if press(DOWN) and sel[3] < (array_length(movepool[sel[1]])/2)-1 sel[3]++;
	if sel[3] > 0{
		if press(UP) sel[3]--;
		}
	
	if press(ENTER) editing_pool_val = sel[3];
	
	if press(ESCAPE){
		menu = monmae._monster_info;
		sel[3] = 0;
		}
		
	if mouse(){
		if point_in_rectangle(mouse_x, mouse_y, 253, 10, 269, 18){
			var l = array_length(movepool[sel[1]]);
			movepool[sel[1], l] = movepool[sel[1], 0];
			movepool[sel[1], l+1] = (movepool[sel[1], l-1]+1);
		}
		
	}
	
}