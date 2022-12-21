
#region Pause and other controls
if press(ord("P")) pause = _pause.pc;
#endregion
if pause != 0 exit;

#region Controls
var kup = 0,
	kown = 0,
	kight = 0,
	keft = 0,
	kinteract = 0,
	kmove = 0,
	kpress = 0;

//If we have just entered a door or we're paused don't check for movement inputs
if !instance_exists(obj_transfer) and pause = 0 and interacting = 0{
	var kup = held(UP),
		kown = held(DOWN),
		kight = held(RIGHT),
		keft = held(LEFT),
		kinteract = press(ord("E")),
		kmove = max(kup, kown, kight, keft),
		kpress = max(press(UP), press(DOWN), press(RIGHT), press(LEFT));
		}
#endregion

#region Grid Based Movement

if (grid_based){

	//Allow Sprinting
	if keyboard_check(vk_shift){
		if x/2 == round(x/2) and y/2 == round(y/2) spd = run_spd;	
		}
	else if spd == 2{
		if x/2 == round(x/2) and y/2 == round(y/2) spd = walk_spd;
		}
	
	if moving == false{
		if kmove == 1 image_index = 0;
		else{
			image_speed = 0;
			image_index = 1;
			}
		}
	
	//Directional Speed Application
	if (target_x > x) x += spd; //right
	if (target_x < x) x -= spd; //left
	if (target_y > y) y += spd; //down
	if (target_y < y) y -= spd; //up
	
	//Destination Checking
	if (target_x == x) && (target_y == y){
		moving = false;
	
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
	
	var move_delay = 10, move_dist = 16;
	
	//Movement
	if !interacting{
		if (kup){
			move_held++;
			if !moving{
				if !place_meeting(x, y-17, par_coll) and
				!tile_meeting(x, y-17, "Collision") and y-17 > 0{
					if move_held >= move_delay or sprite_index = spr_wu{
						moving = true;
						target_y -= move_dist;
						image_speed = 1;
						}
					}
				sprite_index = spr_wu;
				}
			}
		if (kown){
			move_held++;
			if !moving{
				if !place_meeting(x, y+16, par_coll) and
				!tile_meeting(x, y+16, "Collision") and
				y+16 < room_height{
					if move_held >= move_delay or sprite_index = spr_wd{
						moving = true;
						target_y += move_dist;
						image_speed = 1;
						}
					}
				sprite_index = spr_wd;
				}
			}
		if (kight){
			move_held++;
			if !moving{
				if !place_meeting(x+16, y, par_coll) and
				!tile_meeting(x+16, y, "Collision") and
				x+16 < room_width{
					if move_held >= move_delay or sprite_index = spr_wr{
						moving = true;
						target_x += move_dist;
						image_speed = 1;
						}
					}
				sprite_index = spr_wr;
				}
			}
		if (keft){
			move_held++;
			if !moving{
				if !place_meeting(x-1, y, par_coll) and
				!tile_meeting(x-1, y, "Collision") and x-1 > 0{
					if move_held >= move_delay or sprite_index = spr_wl{
						moving = true;
						target_x -= move_dist;
						image_speed = 1;
						}
					}
				sprite_index = spr_wl;
				}
			}
		}
	if kmove == 0 move_held = 0;
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
		if place_meeting(x+xmove, y, par_coll){
			repeat (abs(xmove)){
				if !place_meeting(x+sign(xmove), y, par_coll){
					//xmove+=xvel;
					x += sign(xmove);
					}
				else break;
				}
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
		if place_meeting(x, y+ymove, par_coll) or place_meeting(x, y+ymove, par_npc){
			repeat (abs(ymove)){
				if !place_meeting(x, y+sign(ymove), par_coll) and !place_meeting(x, y+ymove, par_npc){
					//ymove+=yvel;
					y += sign(ymove);
					}
				else break;
				}
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
	if xmove > 0 sprite_index = spr_wr;
	if xmove < 0 sprite_index = spr_wl;
	if ymove > 0 sprite_index = spr_wd;
	if ymove < 0 sprite_index = spr_wu;

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
if sprite_index = spr_wr{
	if collision_rectangle(x, y+1, x+31, y+15, par_interaction, 1, 1) interact = instance_nearest(x+16, y, par_interaction);
	else interact = -1;
	}
if sprite_index = spr_wl{
	if collision_rectangle(x-15, y+1, x, y+15, par_interaction, 1, 1) interact = instance_nearest(x-16, y, par_interaction);
	else interact = -1;
	}
if sprite_index = spr_wu{
	if collision_rectangle(x+1, y, x+15, y-20, par_interaction, 1, 1) interact = instance_nearest(x, y-16, par_interaction);
	else interact = -1;
	}
if sprite_index = spr_wd{
	if collision_rectangle(x+1, y, x+15, y+31, par_interaction, 1, 1) interact = instance_nearest(x, y+24, par_interaction);
	else interact = -1;
	}
#endregion

//Reset player collision mask in case of sprite changes
mask_index = spr_player_coll;

