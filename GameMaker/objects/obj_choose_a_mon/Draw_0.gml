RELOAD

//Draw Background
paint(0, -20, spr_monsters_showcase_3);

//Draw our monsters
var i = 0, xx = 56, yy = 56;
for (var i = 0; i < 3; i++;){
	yy = 56;
	if sel == i yy -= 16;
	if sel != i paint_from_index(xx + (i*66), yy, spr_monsters_battle, _monsters[i], scale);
	else paint_from_index(xx + (i*66), yy, spr_monsters_battle, _monsters[i]);
	}
yy = 4;

paint(xx-8 + (sel*66), yy, spr_pc_cursor, 0);
paint(128, 99, spr_textbox);

//Zoom non-chosen monsters out of view while also fading to black before starting the game 
if scale != 1{
	if scale > 0 scale -= 0.025;
	alph += 0.01;
	}

//Collect user input
if press(LEFT) sel--;
if press(RIGHT) sel++;
if sel < 0 sel = 2;
if sel > 2 sel = 0;

if press(ENTER){
	if scale = 1{
		scale -= 0.025;
		alph += 0.015;
		ADD_A_MONSTER(_monsters[sel], 5);
		}
	}

//Draw text and other things
format(col[COL_RED, 2], 1, fn_yana, 1, 1);
text(room_width/2, 113, "Choose your partner!");

//Start the game!
if alph > 0 fill_screen(alph, c_black);
if alph > 1.3 start_game();