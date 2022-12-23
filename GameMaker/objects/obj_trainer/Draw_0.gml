///@desc Draw trainer from index

//If I'm just facing down (aka, using spr_npcs sprite) draw myself
if sprite_index == spr_trainers_keys{
	draw_self();
	
	//Uncomment below in-case of Collision issues
	//paint(x, y, spr_npcs_collision);
	exit;
	}
	
//Otherwise, draw the part of the npc_index sprite that relates to my character and direction
draw_sprite_part(spr_trainers_index, 0, npc_image*20, dir*22, 20, 22, x-2, y-6);

//Uncomment below in-case of Collision issues
//paint(x, y, spr_npcs_collision);