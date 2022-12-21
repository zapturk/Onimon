RELOAD

font(fn_yana);
halign(fa_center);

color(c_white);
buffer += trigger;
if buffer = 1 or buffer = -1 trigger = -trigger;

//Blink "start" text
var xx, yy;
xx = x+64;
yy = y+90;

if draw = 1 text(xx, yy, start);

//Draw rectangle across the screen
alpha(alph);
color(c_black);
draw_rectangle(0, 0, room_width, room_height, 0);
alpha();
color();

//START THE GAME HERE
if press_any() or mouse(){
	
	//If we have a save file, load it
	if file_exists("save.sav"){
		if !instance_exists(obj_startgame) create(obj_startgame);
		exit;
		}
	
	//Otherwise, go to the prologue room and start the game fresh
	else room_goto(rm_prologue);
	}

//Control Screen Fading
if alph > 0{
	if alph < 1	alph -= 0.015;
	}
else alph = 0;