RELOAD

if pause < 2 or pause == _pause.logoff{
	
	var kup = held(UP),
	kown = held(DOWN),
	kight = held(RIGHT),
	keft = held(LEFT),
	_walk_spd = walk_anim_spd,
	_moveheld = 0;
	
	_moveheld += (kup + kown + kight + keft);
	
	if _moveheld == 0{
		//Extend the current frame of walking if we're about to stop to avoid a millisecond walking frame change
		var dist_to_x = abs(px - target_x), dist_to_y = abs(py - target_y);
		if dist_to_x != 0 and dist_to_x < 6 image_speed = 0;
		if dist_to_y != 0 and dist_to_y < 6 image_speed = 0;
		}
	
	if image_speed != 0 walk_timer++;
	if walk_hold > 30 and !(moving) _walk_spd *= 0.5;
	if walk_timer == round(60 / _walk_spd){
		action++;
		walk_timer = 0;
		
		//Restart walk loop if we've surpassed 4 frames
		if action > 3 action = 0;
		}
		
	if moving && tile_meeting(target_x, target_y, "Grass") paint(target_x, target_y, spr_grass_bend, image_index);
		
	draw_sprite_part(spr_players_index, 0, (action+(dir*4))*20, playable_character*22, 20, 22, x-2, y-6);
	
	if moving && tile_meeting(target_x, target_y, "Grass") paint(x, y, spr_grass_walk_overlay, action);
	
	if !(moving) && tile_meeting(x, y, "Grass") paint(x, y, spr_grass_overlay, image_index);
	
	
}


/*
var _cx = camera_get_view_x(view_camera[0]), _cy = camera_get_view_y(view_camera[0]);
