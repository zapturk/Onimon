
cursor_sprite = spr_;
window_set_cursor(cr_default);


//Check our debug settings to see if we will run the Visual Editor check or not. If not, start the game
if (debug_settings()) exit;

//If we've set it to -1, skip right in to the game
else if (debug_settings()) > 1{
	
	if (debug_settings()) == 2{
		load();
		exit;
		}
	
	//If we have a save file, load it
	if file_exists("save.sav"){
		if !instance_exists(obj_startgame) create(obj_startgame);
		exit;
		}
	
	//Otherwise, go to the prologue room and start the game fresh
	else room_goto(rm_prologue);

	}
	
//Otherwise, start normally (from the mode selection screen)
else room_goto(rm_splash);

/*
if os_type == os_browser{
	window_set_size(768, 432);
	}

image_index = 1;
image_speed = 0;
alarm_set(0, 120);