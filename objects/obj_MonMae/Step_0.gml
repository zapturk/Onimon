RELOAD

draw_message = "";

if typing != -1{
	if press(ESCAPE){
		instruction = -1;
		user_string = -1;
		typing = -1;
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
			menu = i;
			break;
			}
		}
	}

//Get mouse controls for on screen buttons right side
if mouse() and mouse_x >= 256+16{

	//Check for player mouse input on twitter button
	if point_in_rectangle(mouse_x, mouse_y, 256+16, 112, 256+32, 128){
		url_open("https://twitter.com/yanako_rpgs");
		}
		
	//Check for player mouse input on discord button
	if point_in_rectangle(mouse_x, mouse_y, 256+16, 128, 256+32, 144){
		url_open("https://discord.com/invite/4YUaYNvVHD");
		}
	}


if menu == monmae._monsters{
	
	if press(DOWN) sel[1]++;
	if sel[1] > 0{
		if press(UP) sel[1]--;
		}
	
	if press(ENTER){
		menu = monmae._monster_info;
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
			if mouse(){
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
				}
			draw_message = "save current monster data";
			}
		
		//Check for player mouse input on erase button
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 80, 256+32, 96){
			if mouse(){
				for (var o = 0; o < 356; o++;){
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
	
	if press(DOWN) sel[1]++;
	if sel[1] > 0{
		if press(UP) sel[1]--;
		}
	
	if press(ENTER){
		menu = monmae._monster_info;
		}
	if press(ESCAPE) menu = monmae._monsters;
	
	//Get mouse controls for on screen buttons
	if mouse() and mouse_x >= 256+16{
	
		if sel[1] > 0{
			//Check for player mouse input on right arrows for incrementing monster num
			if point_in_rectangle(mouse_x, mouse_y, 256+16, 16, 256+32, 32){
				sel[1]--;
				}
			
			}
		//Check for player mouse input on right arrows for incrementing monster num
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 48, 256+32, 64){
			sel[1]++;
			}
		
		//Check for player mouse input on save button
		if point_in_rectangle(mouse_x, mouse_y, 256+16, 64, 256+32, 80){
		
			//Loop through the current mondex values and save them to a new ini file
			var o = sel[1];
			ini_open("mondex.ini");
			for (var i = 1; i < 10; i++;){
				ini_write_real("Monster_" + string(o), "Val" + string(i), mondex[o, i]);
				}
			ini_write_string("Monster_" + string(o), "Val" + string(0), mondex[o, 0]);
			ini_write_string("Monster_" + string(o), "Val" + string(1), mondex[o, dex.sub_descrip]);
			ini_write_string("Monster_" + string(o), "Val" + string(2), mondex[o,dex.descrip]);
			ini_close();
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
			mondex[o, 11] = ini_read_string("Monster_" + string(o), "Val" + string(1), "");
			mondex[o, 12] = ini_read_string("Monster_" + string(o), "Val" + string(2), "");
			ini_close();
			}
		}
	}