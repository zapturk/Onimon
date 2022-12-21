

//Fade screen in from black
color(c_black);
alpha(alph);
draw_rectangle(0, 0, room_width, room_height, 0);
alpha(1);
color();

//Allow mouse input to skip the fade
if (mouse()) or (press_any()){	
	if room == rm_splash room_goto(rm_splash_2);
	if room == rm_splash_2 room_goto(rm_title);
	}

if alarm[1] != -1 exit;

if alarm[0] != -1{
	if alph > 0 alph -= 0.025;
	exit;
	}

//Go to the next room once completely black
alph += 0.015;
if alph > 1.5{
	if room == rm_splash room_goto(rm_splash_2);
	if room == rm_splash_2 room_goto(rm_title);
	}