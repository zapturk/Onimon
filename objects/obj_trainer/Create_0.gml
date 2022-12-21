
//Inherit the parent event
event_inherited();

scrolling = 1;
if sprite_index != spr_trainers_index{
	npc_image = round(image_index);
	sprite_index = -1;
	mask_index = spr_npcs_collision;
	}

var o = 0;
for (var i = 0; i < 6; i++;){
	my_team[i, o] = -1;	o++;	//Monster
	my_team[i, o] = 0;	o++;	//Level
	my_team[i, o] = 0;	o++;	//Exp (Always 0)
	my_team[i, o] = 0;	o++;	//Health
	my_team[i, o] = 0;	o++;	//HP EV's
	my_team[i, o] = 0;	o++;	//ATK EV's
	my_team[i, o] = 0;	o++;	//DEF EV's
	my_team[i, o] = 0;	o++;	//MGK ATK EV's
	my_team[i, o] = 0;	o++;	//MGK DEF EV's
	my_team[i, o] = 0;	o++;	//SPEED EV's
	my_team[i, o] = 0;	o++;	//First Move
	my_team[i, o] = 0;	o++;	//Second Move
	my_team[i, o] = 0;	o++;	//Third Move
	my_team[i, o] = 0;	o++;	//Fourth Move
	my_team[i, o] = 0;	o++;	//Mana 01
	my_team[i, o] = 0;	o++;	//Mana 02
	my_team[i, o] = 0;	o++;	//Mana 03
	my_team[i, o] = 0;	o++;	//Mana 04
	my_team[i, o] = 0;	o++;	//Manapool
	my_team[i, o] = 0;	o++;	//Status 
	my_team[i, o] = 0;	o++;	//Held Item
	o = 0;
	}