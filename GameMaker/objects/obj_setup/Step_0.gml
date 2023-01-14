///@desc Check for Input in Setup Screen

if mouse(){
	
	if mouse_x < room_width/2 room_goto(rm_MonMae);
	else room_goto(rm_splash);
	
	}

if press(ord("1")) room_goto(rm_MonMae);
if press(ord("2")) room_goto(rm_setup);


