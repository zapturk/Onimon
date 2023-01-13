RELOAD
grid_based = true;

#region Pause and other controls
if press(ord("P")) pause = _pause.pc;
#endregion
if pause != 0 exit;

#region Controls

var kup = 0, kown = 0, kight = 0, keft = 0,
	kup_rel = 0, kown_rel = 0, kight_rel = 0, keft_rel = 0,
	
	kinteract = 0, kmove = 0, kpress = 0, krelease = 0;

//If we have just entered a door or we're paused don't check for movement inputs
if !instance_exists(obj_transfer) and pause == 0 and interacting == 0{

	var kup = held(UP), kown = held(DOWN), kight = held(RIGHT), keft = held(LEFT),
		kup_rel = release(UP), kown_rel = release(DOWN), kight_rel = release(RIGHT), keft_rel = release(LEFT), 
		
		kinteract = press(ord("E")),
		kmove = max(kup, kown, kight, keft),
		kpress = max(press(UP), press(DOWN), press(RIGHT), press(LEFT));
		krelease = max(kup_rel, kown_rel, kight_rel, keft_rel);
		}
#endregion

#region Grid Based Movement

if (grid_based){

	//Allow Sprinting
	if (CAPS_LOCKED) == 0{
		if keyboard_check(vk_shift){
			if x/2 == round(x/2) and y/2 == round(y/2) spd = run_spd;	
			}
		else if spd == 2{
			if x/2 == round(x/2) and y/2 == round(y/2) spd = walk_spd;
			}
		}
		else if x/2 == round(x/2) and y/2 == round(y/2) spd = run_spd;
	
	//Walk_Hold is a timer that tracks how long/short we've been walking for
	if (kmove) walk_hold++;
	else if !(moving) walk_hold = 0;
	
	//Move_Held is a variable that just checks if we are holding any directional key 
	if (kmove) move_held++;
	else if !(moving) move_held = 0;
	
	//Directional Speed Application
	if (target_x > x) x += spd; //right
	if (target_x < x) x -= spd; //left
	if (target_y > y) y += spd; //down
	if (target_y < y) y -= spd; //up
	
	//Destination Checking
	if (target_x == x) && (target_y == y){
		
		//if moving == true step_tracker = 1;
		moving = false;
	
		//Don't touch this. I wrote it without any outside help yet still
		//have absolutely not idea how it works.
		if walk_hold > 10{
			//Do nothing
			}
		else{
			if (kmove) == 1{
				walk_anim_spd = og_walk_anim_spd;
				if step_tracker < 2 step_tracker = 2;
				else step_tracker = 0;
				action = step_tracker;
				}
			else{
				action = 1;
				walk_timer = 0;
				image_speed = 0;
				}
			}
	
		//Monster Encounters when in Bushes
		if layer_exists("Grass"){
			if tile_meeting(x, y, "Grass"){
				if x != xprevious encounter_steps++;
				xprevious = x;
		
				if encounter_steps >= 10{
					encounter_start();
					encounter_steps = 0;
					}
				}
			}
		}
	
	//Set the movement delay (in frames) before moving after pressing a key
	//This allows us to let the player rotate without forcibly walking 
	var move_delay = 8, move_dist = 16;
	
	//Movement
	if !interacting{
		if (kup){
		
			move_held++;
			image_speed = 1;
			
			//If I'm not moving (meaning I'm just starting movement, or landed on a grid space)
			if !moving{
				
				//Check for collisions with objects, the tileset, and the edge of the room
				if !place_meeting(x, y-17, par_coll) and
				!tile_meeting(x, y-17, "Collision") and y-17 > 0{
					if move_held >= move_delay or dir == pl_dir.pl_up{
					
						moving = true;
						dir = pl_dir.pl_up;
						target_y -= move_dist;
						}
					}
				else if walk_hold < 20{
					walk_hold = 20;
					step_tracker = 0;
					dir = pl_dir.pl_up;
					}
				}
			}
		if (kown){
			move_held++;
			image_speed = 1;
			
			//If I'm not moving (meaning I'm just starting movement, or landed on a grid space)
			if !moving{
				
				//Check for collisions with objects, the tileset, and the edge of the room
				if !place_meeting(x, y+16, par_coll) and
				!tile_meeting(x, y+16, "Collision") and y+16 < room_height{
					if move_held >= move_delay or dir == pl_dir.pl_down{
					
						moving = true;
						dir = pl_dir.pl_down;
						target_y += move_dist;
						}
					}
				else if walk_hold < 20{
					walk_hold = 20;
					step_tracker = 0;
					dir = pl_dir.pl_down;
					}
				}
			}
		if (kight){
			move_held++;
			image_speed = 1;
			
			//If I'm not moving (meaning I'm just starting movement, or landed on a grid space)
			if !moving{
				
				//Check for collisions with objects, the tileset, and the edge of the room
				if !place_meeting(x+16, y, par_coll) and
				!tile_meeting(x+16, y, "Collision") and
				x+16 < room_width{
					if move_held >= move_delay or dir == pl_dir.pl_right{
					
						moving = true;
						dir = pl_dir.pl_right;
						target_x += move_dist;
						}
					}
				else{
					if walk_hold < 20{
						walk_hold = 20;
						step_tracker = 0;
						dir = pl_dir.pl_right;
						}
					}
				}
			}
		if (keft){
			move_held++;
			image_speed = 1;
			
			//If I'm not moving (meaning I'm just starting movement, or landed on a grid space)
			if !moving{
				
				//Check for collisions with objects, the tileset, and the edge of the room
				if !place_meeting(x-1, y, par_coll) and
				!tile_meeting(x-1, y, "Collision") and x-1 > 0{
					if move_held >= move_delay or dir == pl_dir.pl_left{
						
						moving = true;
						dir = pl_dir.pl_left;
						target_x -= move_dist;
						}
					}
				else if walk_hold < 20{
					walk_hold = 20;
					step_tracker = 0;
					dir = pl_dir.pl_left;
					}
				}
			}
		if (krelease){
			if !(moving){
				walk_hold = 0;
				if (kup_rel) dir = pl_dir.pl_up;
				else if (kown_rel) dir = pl_dir.pl_down;
				else if (kight_rel) dir = pl_dir.pl_right;
				else if (keft_rel) dir = pl_dir.pl_left;
				}
			}
		}
	}
else //Else; If Free movement is true
#endregion

#region Free Movement
{
	//Reset movement vars
	xmove = 0;
	ymove = 0;
	xprevious = x;
	yprevious = y;

	//Apply shifting sprinting
	if xvel = 0 and yvel = 0 and interacting = 0{
		if held(SHIFT)spd = run_spd;
		else spd = walk_spd;

		ymove = (kown - kup) * spd;
		xmove = (kight - keft) * spd;
		}
	
	//Apply Velocity to x/y movement
	xmove += xvel;
	ymove += yvel;

	//Horizontal Collision
	if xmove != 0{
		if place_meeting(x+xmove, y, par_coll) or tile_meeting(x+xmove, y, "Collision"){
			repeat (abs(xmove)){
				if !place_meeting(x+sign(xmove), y, par_coll) and !tile_meeting(x+sign(xmove), y, "Collision"){
					//xmove+=xvel;
					x += sign(xmove);
					}
				else break;
				}
			//Experimental, use at risk of crashes and weird behavior
			if (buttery_smooth){
				if xmove = -1{
					if !position_meeting(x-4, y-8, par_coll) ymove = -1;
					if !position_meeting(x-4, y+24, par_coll) ymove = 1;
					}
				if xmove = 1{
					if !position_meeting(x+20, y-8, par_coll) ymove = -1;
					if !position_meeting(x+20, y+24, par_coll) ymove = 1;
					}
				}
			xmove = 0;
			}
		}
	
	//Vertical Collision
	if ymove != 0{
		if place_meeting(x, y+ymove, par_coll) or tile_meeting(x, y+ymove, "Collision"){
			repeat (abs(ymove)){
				if !place_meeting(x, y+sign(ymove), par_coll) and !tile_meeting(x, y+sign(ymove), "Collision"){
					//ymove+=yvel;
					y += sign(ymove);
					}
				else break;
				}
			//Experimental, use at risk of crashes and weird behavior
			if (buttery_smooth){
				if ymove = -1{
					if !position_meeting(x-8, y-4, par_coll) xmove = -1;
					if !position_meeting(x+24, y-4, par_coll) xmove = 1;
					}
				if ymove = 1{
					if !position_meeting(x-8, y+20, par_coll) xmove = -1;
					if !position_meeting(x+24, y+20, par_coll) xmove = 1;
					}
				}
			ymove = 0;
			}
		}
	
	//Apply movement after all checks have been made
	x += xmove;
	y += ymove;

	//Decrease velocity
	if xvel != 0 xvel += (0.5 * -sign(xvel));
	if yvel != 0 yvel += (0.5 * -sign(yvel));

	//Check movement based on x/y previous position
	if x != xprevious or y != yprevious moving = true;
	else moving = false;
	
	//Set sprite based on movement values (prioritizing up/down)
	if xmove > 0 dir = pl_dir.pl_right;
	if xmove < 0 dir = pl_dir.pl_left;
	if ymove > 0 dir = pl_dir.pl_down;
	if ymove < 0 dir = pl_dir.pl_up;

	//Update image speed and index as needed
	if xmove = 0 and ymove = 0{
		image_speed = 0;
		image_index = 1;
		}
	else image_speed = 1;
	if kpress image_index = 0;
	}
#endregion

#region Interaction Checking
if dir == pl_dir.pl_right{
	if collision_rectangle(x, y+1, x+31, y+15, par_interaction, 1, 1) interact = instance_nearest(x+16, y, par_interaction);
	else interact = -1;
	}
if dir == pl_dir.pl_left{
	if collision_rectangle(x-15, y+1, x, y+15, par_interaction, 1, 1) interact = instance_nearest(x-16, y, par_interaction);
	else interact = -1;
	}
if dir == pl_dir.pl_up{
	if collision_rectangle(x+1, y, x+15, y-20, par_interaction, 1, 1) interact = instance_nearest(x, y-16, par_interaction);
	else interact = -1;
	}
if dir == pl_dir.pl_down{
	if collision_rectangle(x+1, y, x+15, y+31, par_interaction, 1, 1) interact = instance_nearest(x, y+24, par_interaction);
	else interact = -1;
	}
#endregion


//Reset player collision mask in case of sprite changes
mask_index = spr_player_coll;

