//Set the player's default speed

//In "Beginner" scripts, player customization
setup_player();


spd = 1;
moving = 0;
target_x = x;
target_y = y;
encounter_steps = 0;
move_held = 0;


if !(grid_based){
	xmove = 0;
	ymove = 0;
	xvel = 0;	//Velocity, for knockback
	yvel = 0;	//Same
	}
depth--;

//Set the player's walking sprites
spr_wu = spr_player_walk_u;
spr_wd = spr_player_walk_d;
spr_wl = spr_player_walk_l;
spr_wr = spr_player_walk_r;

//Experimental
global.z = 0;