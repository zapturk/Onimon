//Set the player's default speed

run_anim_spd = 4;
walk_anim_spd = 6;

//In "Beginner" scripts, player customization
setup_player();

spd = 1;
run_spd = 2;
walk_spd = spd;
og_walk_anim_spd = walk_anim_spd;

action = 1;
moving = 0;
target_x = x;
target_y = y;

encounter_steps = 0;
step_tracker = 0;
move_held = 0;

walk_hold = 0;
walk_timer = 0;
dir = 0;

enum pl_dir{
	pl_down, pl_left, pl_up, pl_right
	}

if !(grid_based){
	xmove = 0;
	ymove = 0;
	xvel = 0;	//Velocity, for knockback
	yvel = 0;	//Same
	}
depth--;


//Experimental
global.z = 0;