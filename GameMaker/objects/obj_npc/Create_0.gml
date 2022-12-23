
//Inherit the parent event
event_inherited();

scrolling = 1;
if sprite_index != spr_npcs_index{
	npc_image = round(image_index);
	sprite_index = -1;
	mask_index = spr_npcs_collision;
	}