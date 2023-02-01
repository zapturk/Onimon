///@desc Get Global Controls

if room == rm_MonMae exit;

//Update global player location variables
if instance_exists(obj_player){
	px = obj_player.x;
	py = obj_player.y;
	}

//Caps Lock infinite run lock
if press(20){
	if CAPS_LOCKED == 1 CAPS_LOCKED = 0;
	else CAPS_LOCKED = 1;
	}

if press(ord("F")){
	if !window_get_fullscreen(){
		window_set_fullscreen(1);
		}
	}

if press(ord("O")){
	screen_save("Dokimon_Screenshot_" + string(screenshots) + ".png");
	screenshots++;
	}


//Should not be included in your finished game. Uncomment the /* to comment those lines and remove
//access to them from your game
///*

//Restart the game
if press(ord("R")) game_restart();


//Start a wild battle
if press(ord("B")){

	RESET_ENEMY();
	ADD_ENEMY_MONSTER(m.MONSTER_13, 1);
	
	interacting = 1;

	with obj_camera{
		battle_start = 1;
		flash = 1;
		}
	}

//Start a trainer battle
if press(ord("V")){

	RESET_ENEMY();
	ADD_ENEMY_MONSTER(m.MONSTER_13, 1);
	
	trainer = 1;
	interacting = 1;

	with obj_camera{
		battle_start = 1;
		flash = 1;
		}
	}


/*
//Quick open the PC
if press(ord("P")){
	start_x = px;
	start_y = py;
	curr_rm = room;

	pause = _pause.pc;
	room_goto(rm_pc);
	}