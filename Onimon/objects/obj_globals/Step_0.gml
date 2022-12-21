///@desc Get Global Controls

if room == rm_MonMae exit;

if instance_exists(obj_player){
	px = round(obj_player.x);
	py = round(obj_player.y);
	}

//Restart the game
if press(ord("R")) game_restart();

if press(ord("O")){
	screen_save("Dokimon_Screenshot_" + string(screenshots) + ".png");
	screenshots++;
	}

//Start a wild battle
if press(ord("B")) and obj_player.target_x = px{
	
	RESET_ENEMY();
	ADD_ENEMY_MONSTER(m.NEKOSWORD, 1);
	
	interacting = 1;
	
	with obj_camera{
		battle_start = 1;
		flash = 1;
		}
	}

//Start a wild battle
if press(ord("F")){
	if !window_get_fullscreen(){
		window_set_fullscreen(1);
		}
	}

//Start a trainer battle
if press(ord("V")){
	interacting = 1;
	with obj_camera{
		battle_start = 1;
		trainer = 1;
		flash = 1;
		}
	}

//Mute or unmute the game
if press(ord("M")){
	if volume = 0 volume = 1;
	else volume = 0;
	audio_set_master_gain(0, volume);
	}

//Quick open the PC
if press(ord("P")){
	start_x = px;
	start_y = py;
	curr_rm = room;

	pause = _pause.pc;
	room_goto(rm_pc);
	}