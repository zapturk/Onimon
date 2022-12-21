function GET_VERTICAL_INPUTS(){

///@arg choices
///@arg sel_var

var _choices = 4, _sel = argument[0];
if argument_count == 1{
	if press(UP){
		if _sel > 0 return _sel-1;
		}	
	
	if press(DOWN){
		if _sel < _choices-1 return _sel+1;
		}
	}
if argument_count == 2{
	var _choices = argument[0], _sel = argument[1];
	
	if press(UP){
		if _sel > 0 return _sel-1;
		}	
	
	if press(DOWN){
		if _sel < _choices-1 return _sel+1;
		}
	}
return _sel;
}

function GET_VERTICAL_INPUTS_2x2(){
	
///@arg sel_var

var _sel = argument[0];
if press(UP){
	switch _sel{
		case 2: return _sel-2;	break;
		case 3: return _sel-2;	break;
		}
	}	
if press(DOWN){
	switch _sel{
		case 0: return _sel+2;	break;
		case 1: return _sel+2;	break;
		}
	}
if press(RIGHT){
	switch _sel{
		case 0: return _sel+1;	break;
		case 2: return _sel+1;	break;
		}
	}
if press(LEFT){
	switch _sel{
		case 1: return _sel-1;	break;
		case 3: return _sel-1;	break;
		}
	}

return _sel;
}

function ADD_ENEMY_MONSTER(){

///@arg Monster
///@arg Level
///@arg Move_1
///@arg Move_2
///@arg Move_3
///@arg Move_4


var i = 0;
eparty[i, 0] = argument[0];		//Monster
eparty[i, 1] = argument[1];		//Level
eparty[i, party.health] = GET_STAT(ENEMY, MAX_HEALTH_SUM, i);


//EV's should be set randomly based on our level


//If we've set moves for this monster, assign them and skip the automatic moveset compiler
if argument_count > 2{
	for (var o = 3; o < argument_count; o++;){
		var move_num = party.move1+(o-3);
		eparty[i, move_num] = argument[o];
		}
	exit;
	}

possible_moves = ds_list_create();
var monster = argument[0];
		
//Loop through the entirety of the movepool array and add all move indexes to the ds_list
//However, if in our loop, the level of the movepool index surpass the monster we're addings
//Level, exit the loop to ensure those moves aren't added into the "possible moves" ds_list
for (var o = 1; o < array_length(movepool[monster]); o+=2;){
	var move_id = o-1, move_level = movepool[monster, o];
			
	//Stop looking for moves if the required level for this move is higher than that of the monster we're adding 
	if move_level > eparty[i, party.level] break;
	ds_list_add(possible_moves, movepool[monster, move_id]);
	}
		
//Suffle up the moves that we compiled into the ds_list :)
ds_list_shuffle(possible_moves);
		
//Grab the 4 moves at the top of the ds_list and add them to our monster :)
//Just in case we found less than 4 moves (like in cases of low level monsters), we will exit
//the loop if o becomes greater than the size of the ds_list (which has our list of moves).
//In that case, all moves that we found would have been added to the monster in a random order^^
for (var o = 0; o < 4; o++;){
	if (o+1) > ds_list_size(possible_moves) break;
			
	var move_num = party.move1+o, move_id = ds_list_find_value(possible_moves, o);
	eparty[i, move_num] = move_id;
	}
return;

}

function ADD_TRAINER_MONSTER(){

///@arg Monster
///@arg Level
///@arg Move_1
///@arg Move_2
///@arg Move_3
///@arg Move_4

//Look through my team and add monsters in empty slots
for (var i = 0; i < 6; i++;){
	if my_team[i, 0] == -1{
		//If we find an empty slot, assign the monster and their level and break the loop
		my_team[i, 0] = argument[0];		//Monster
		my_team[i, 1] = argument[1];		//Level
		break;
		}
	}

//EV's should be set randomly based on our level


//If we've set moves for this monster, assign them and skip the automatic moveset compiler
if argument_count > 2{
	for (var o = 2; o < argument_count; o++;){
		var move_num = party.move1+(o-3);
		my_team[i, move_num] = argument[o];
		}
	//Exit to avoid automatically setting the moves (default)
	exit;
	}

possible_moves = ds_list_create();
var monster = argument[0];
		
//Loop through the entirety of the movepool array and add all move indexes to the ds_list
//However, if in our loop, the level of the movepool index surpass the monster we're addings
//Level, exit the loop to ensure those moves aren't added into the "possible moves" ds_list
for (var o = 1; o < array_length(movepool[monster]); o+=2;){
	var move_id = o-1, move_level = movepool[monster, o];
			
	//Stop looking for moves if the required level for this move is higher than that of the monster we're adding 
	if move_level > eparty[i, party.level] break;
	ds_list_add(possible_moves, movepool[monster, move_id]);
	}
		
//Suffle up the moves that we compiled into the ds_list :)
ds_list_shuffle(possible_moves);
		
//Grab the 4 moves at the top of the ds_list and add them to our monster :)
//Just in case we found less than 4 moves (like in cases of low level monsters), we will exit
//the loop if o becomes greater than the size of the ds_list (which has our list of moves).
//In that case, all moves that we found would have been added to the monster in a random order^^
for (var o = 0; o < 4; o++;){
	if (o+1) > ds_list_size(possible_moves) break;
			
	var move_num = party.move1+o, move_id = ds_list_find_value(possible_moves, o);
	my_team[i, move_num] = move_id;
	}
return;

}

function CHOOSE_ENEMY_ATTACK(){

enemy_battle_sel = 0;
return eparty[ebattler, party.move1];

enemy_battle_sel = choose(0, 1, 2, 3);
var _move = enemy_battle_sel;
return eparty[ebattler, party.move1+_move];

}

function GET_STAT(){
///@desc Find the monsters base stat from 'mondex', and their EV from 'monsters', and return the stat value
///@arg player/enemy
///@arg stat
///@arg number	(if specification is needed)

//How to use:
//GET_STAT(PLAYER, SPEED);		//Check the monster currently in battle
//GET_STAT(ENEMY, SPEED, 2);	//Checks a specific monster in the party (starts at 0)

#macro NONE				-1
#macro PLAYER			0
#macro ENEMY			1

#macro MAX_HEALTH_SUM	0
#macro ATTACK_SUM		1
#macro DEFENSE_SUM		2
#macro MGK_ATK_SUM		3
#macro MGK_DEF_SUM		4
#macro SPEED_SUM		5
#macro MON_LEVEL		6
#macro MON_HEALTH_CURR	7
#macro MON_EXP_CURR		8
#macro MON_EXP_MAXI		9
#macro MON_NUMBER		10
#macro MON_MANA_01		11
#macro MON_MANA_02		12
#macro MON_MANA_03		13
#macro MON_MANA_04		14
#macro MON_MANAPOOL		14
#macro MON_STATUS		16


if argument_count == 2{
	if argument[0] == 0{	//Player
		switch argument[1]{
		case 0:		var LVL = monsters[battler, party.level], IV = 31, EV = monsters[battler, party.hp],			BASE = mondex[monsters[battler, party.number], dex.health];				break;
		case 1:		var LVL = monsters[battler, party.level], IV = 31, EV = monsters[battler, party.atk],			BASE = mondex[monsters[battler, party.number], dex.atk];				break;
		case 2:		var LVL = monsters[battler, party.level], IV = 31, EV = monsters[battler, party.def],			BASE = mondex[monsters[battler, party.number], dex.def];				break;
		case 3:		var LVL = monsters[battler, party.level], IV = 31, EV = monsters[battler, party.mgk_atk],		BASE = mondex[monsters[battler, party.number], dex.mgk_atk];			break;
		case 4:		var LVL = monsters[battler, party.level], IV = 31, EV = monsters[battler, party.mgk_def],		BASE = mondex[monsters[battler, party.number], dex.mgk_def];			break;
		case 5:		var LVL = monsters[battler, party.level], IV = 31, EV = monsters[battler, party.spd],			BASE = mondex[monsters[battler, party.number], dex.spd];				break;
		case 6:		return monsters[battler, party.level];
		case 7:		return monsters[battler, party.health];
		case 8:		return monsters[battler, party.exp];
		case 9:		return round(power(monsters[battler, party.level], 3));
		case 10:	return monsters[battler, party.number];
		case 11:	return monsters[battler, party.mana1];
		case 12:	return monsters[battler, party.mana2];
		case 13:	return monsters[battler, party.mana3];
		case 14:	return monsters[battler, party.mana4];
		case 15:	return monsters[battler, party.manapool];
		case 16:	return monsters[battler, party.status];
		}
	if argument[1] == MAX_HEALTH_SUM var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + LVL + 10);
	else var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + 5);	//This doesn't include NATURE, we'll need to add this later
	return floor(STAT);
	}
	else{					//Enemy
		switch argument[1]{
		case 0:		var LVL = eparty[ebattler, party.level], IV = 31, EV = eparty[ebattler, party.hp],			BASE = mondex[eparty[ebattler, party.number], dex.health];			break;
		case 1:		var LVL = eparty[ebattler, party.level], IV = 31, EV = eparty[ebattler, party.atk],			BASE = mondex[eparty[ebattler, party.number], dex.atk];				break;
		case 2:		var LVL = eparty[ebattler, party.level], IV = 31, EV = eparty[ebattler, party.def],			BASE = mondex[eparty[ebattler, party.number], dex.def];				break;
		case 3:		var LVL = eparty[ebattler, party.level], IV = 31, EV = eparty[ebattler, party.mgk_atk],		BASE = mondex[eparty[ebattler, party.number], dex.mgk_atk];			break;
		case 4:		var LVL = eparty[ebattler, party.level], IV = 31, EV = eparty[ebattler, party.mgk_def],		BASE = mondex[eparty[ebattler, party.number], dex.mgk_def];			break;
		case 5:		var LVL = eparty[ebattler, party.level], IV = 31, EV = eparty[ebattler, party.spd],			BASE = mondex[eparty[ebattler, party.number], dex.spd];				break;
		case 6:		return eparty[ebattler, party.level];
		case 7:		return eparty[ebattler, party.health];
		case 8:		return eparty[ebattler, party.exp];
		case 9:		return round(power(eparty[ebattler, party.level], 3));
		case 10:	return eparty[ebattler, party.number];
		case 11:	return eparty[battler, party.mana1];
		case 12:	return eparty[ebattler, party.mana2];
		case 13:	return eparty[ebattler, party.mana3];
		case 14:	return eparty[ebattler, party.mana4];
		case 15:	return eparty[ebattler, party.manapool];
		case 16:	return eparty[ebattler, party.status];
		}
	if argument[1] == MAX_HEALTH_SUM var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + LVL + 10);
	else var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + 5);	//This doesn't include NATURE, we'll need to add this later
	return floor(STAT);
	}
}

if argument_count == 3{
	if argument[0] == 0{	//Player
		
		switch argument[1]{
		case 0:	var LVL = monsters[argument[2], party.level], IV = 31, EV = monsters[argument[2], party.hp],			BASE = mondex[monsters[argument[2], party.number], dex.health];				break;
		case 1:	var LVL = monsters[argument[2], party.level], IV = 31, EV = monsters[argument[2], party.atk],			BASE = mondex[monsters[argument[2], party.number], dex.atk];				break;
		case 2:	var LVL = monsters[argument[2], party.level], IV = 31, EV = monsters[argument[2], party.def],			BASE = mondex[monsters[argument[2], party.number], dex.def];				break;
		case 3:	var LVL = monsters[argument[2], party.level], IV = 31, EV = monsters[argument[2], party.mgk_atk],		BASE = mondex[monsters[argument[2], party.number], dex.mgk_atk];			break;
		case 4:	var LVL = monsters[argument[2], party.level], IV = 31, EV = monsters[argument[2], party.mgk_def],		BASE = mondex[monsters[argument[2], party.number], dex.mgk_def];			break;
		case 5:	var LVL = monsters[argument[2], party.level], IV = 31, EV = monsters[argument[2], party.spd],			BASE = mondex[monsters[argument[2], party.number], dex.spd];				break;
		case 6:	return monsters[argument[2], party.level];
		case 7:	return monsters[argument[2], party.health];
		case 8:	return monsters[argument[2], party.exp];
		case 9:	return round(power(monsters[argument[2], party.level], 3));
		case 10: return monsters[argument[2], party.number];
		case 11: return monsters[argument[2], party.mana1];
		case 12: return monsters[argument[2], party.mana2];
		case 13: return monsters[argument[2], party.mana3];
		case 14: return monsters[argument[2], party.mana4];
		case 15: return monsters[argument[2], party.manapool];
		case 16: return monsters[argument[2], party.status];
		}
	if argument[1] == MAX_HEALTH_SUM var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + LVL + 10);
	else var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + 5);	//This doesn't include NATURE, we'll need to add this later
	return floor(STAT);
	}
	else{					//Enemy
		switch argument[1]{
		case 0:	var LVL = eparty[argument[2], party.level], IV = 31, EV = eparty[argument[2], party.hp],			BASE = mondex[eparty[argument[2], party.number], dex.health];			break;
		case 1:	var LVL = eparty[argument[2], party.level], IV = 31, EV = eparty[argument[2], party.atk],			BASE = mondex[eparty[argument[2], party.number], dex.atk];				break;
		case 2:	var LVL = eparty[argument[2], party.level], IV = 31, EV = eparty[argument[2], party.def],			BASE = mondex[eparty[argument[2], party.number], dex.def];				break;
		case 3:	var LVL = eparty[argument[2], party.level], IV = 31, EV = eparty[argument[2], party.mgk_atk],		BASE = mondex[eparty[argument[2], party.number], dex.mgk_atk];			break;
		case 4:	var LVL = eparty[argument[2], party.level], IV = 31, EV = eparty[argument[2], party.mgk_def],		BASE = mondex[eparty[argument[2], party.number], dex.mgk_def];			break;
		case 5:	var LVL = eparty[argument[2], party.level], IV = 31, EV = eparty[argument[2], party.spd],			BASE = mondex[eparty[argument[2], party.number], dex.spd];				break;
		case 6:	return eparty[argument[2], party.level];
		case 7:	return eparty[argument[2], party.health];
		case 8:	return eparty[argument[2], party.exp];
		case 9:	return round(power(eparty[argument[2], party.level], 3));
		}
	if argument[1] == MAX_HEALTH_SUM var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + LVL + 10);
	else var STAT = ((((BASE * 2) + IV + (floor(EV/4))) * LVL) / 100 + 5);	//This doesn't include NATURE, we'll need to add this later
	return floor(STAT);
	}
}


	
}

function GET_MOVE(){
///@arg player/enemy
///@arg move_data
///@arg move_number
///@arg battler	(if specification is needed)

//Ex: GET_MOVE(PLAYER, MOVE_DATA);
//Ex: GET_MOVE(PLAYER, MOVE_DATA, MOVE_03);
//Ex: GET_MOVE(PLAYER, MOVE_DATA, MOVE_03, BATTLER_02);

//How to use:
//Ex: GET_MOVE(PLAYER, MOVE_POWER, 4, 2);
//This gives us the players third monsters fourth moves power

#macro MOVE_NAME			0
#macro MOVE_DESC			1
#macro MOVE_SPRITE			2
#macro MOVE_ANIMATION		3
#macro MOVE_POWER			4
#macro MOVE_HEAL			5
#macro MOVE_ACCURACY		6
#macro MOVE_ELEMENT			7
#macro MOVE_TYPE			8
#macro MOVE_MANA			9
#macro MOVE_PRIORITY		10

#macro MOVE_CHANCE1			11
#macro MOVE_STATUS			12
#macro MOVE_CHANCE2			13
#macro MOVE_FLINCH			14
#macro MOVE_HI_CRIT			15

#macro MOVE_CHANCE3			16

#macro MOVE_STAT_ATK		17
#macro MOVE_STAT_DEF		18
#macro MOVE_STAT_MGKATK		19
#macro MOVE_STAT_MGKDEF		20
#macro MOVE_STAT_SPEED		21
#macro MOVE_STAT_EVASI		22
#macro MOVE_STAT_ACC		23

#macro MOVE_ENSTAT_ATK		24
#macro MOVE_ENSTAT_DEF		25
#macro MOVE_ENSTAT_MGKATK	26
#macro MOVE_ENSTAT_MGKDEF	27
#macro MOVE_ENSTAT_SPEED	28
#macro MOVE_ENSTAT_EVASI	29
#macro MOVE_ENSTAT_ACC		30

#macro MOVE_PROTECT			31
#macro MOVE_FIRSTTURN		32
#macro MOVE_RECHARGE		33
#macro MOVE_OHKO			34
#macro MOVE_RECOIL			35
#macro MOVE_RECOIL_AMNT		36
#macro MOVE_FLAT			37
#macro MOVE_FLAT_AMNT		38

#macro MOVE_01			1
#macro MOVE_02			2
#macro MOVE_03			3
#macro MOVE_04			4


if argument_count == 2{
	
	//Player
	if argument[0] == 0 return movedex[monster_attack[0], argument[1]];
	
	//Enemy
	if argument[0] == 1 return movedex[monster_attack[1], argument[1]];
	}
	
//if agument count is 3 - 4 we'll do this:

if argument[0] == 0{
	
	//Player
	if argument_count == 3 var _battler = battler;
	if argument_count == 4 var _battler = argument[3];
	var _move_num = monsters[_battler, (party.move1+argument[2]-1)];
	if _move_num = -1 return "";

	//Find the battle, and the move number we are checking, and then return the value we are seeking for
	return movedex[_move_num, argument[1]];
	}
else{
	
	//Enemy
	if argument_count == 3 var _battler = ebattler;
	if argument_count == 4 var _battler = argument[3];
	var _move_num = eparty[_battler, party.move1+argument[2]-1];
	if _move_num = -1 return "";

	//Find the battle, and the move number we are checking, and then return the value we are seeking for
	return movedex[_move_num, argument[1]];
	}
	
return 0;
}

function GET_MOVE_NAME(){
///@arg move_number
///@arg move_data

switch argument[1]{
	case MOVE_ELEMENT:
		var move_element = movedex[argument[1], move.element];
		switch (move_element){
			case element.fire:		return "Fire";
			case element.grass:		return "Grass";
			case element.water:		return "Water";
			case element.electric:	return "Electric";
			case element.dark:		return "Dark";
			case element.light:		return "Light";
			case element.flying:	return "Flying";
			case element.poison:	return "Poison";
			case element.dragon:	return "Dragon";
			case element.fairy:		return "Fairy";
			default: return "Move Element Error";
			}
	case MOVE_TYPE:
		var move_type = movedex[argument[1], move.type];
		switch (move_type){
			case type.support:	return "Support";
			case type.physical: return "Physical";
			case type.magical:	return "Magic";
			default: return "Move Type Error";
			}
	default: return 0;
	}

}
	
function GET_DEX(){
///@arg player/enemy
///@arg dex_data
///@arg dex_num	(if specification is needed)

//Ex: GET_DEX(PLAYER, DEX_NAME);

#macro DEX_NAME				0
#macro DEX_HEALTH			1
#macro DEX_ATTACK			2
#macro DEX_DEFENSE			3
#macro DEX_MGK_ATK			4
#macro DEX_MGK_DEF			5
#macro DEX_SPEED			6
#macro DEX_ELEMENT_1		7
#macro DEX_ELEMENT_2		8
#macro DEX_ABILITY			9
#macro DEX_CAPTURE_R8		10
#macro DEX_SUB_DESCR		11
#macro DEX_DESCRIPTION		12


//if argument_count == 2 return mondex[argument[1], argument[0]];
if argument[0] == NONE		return mondex[argument[2], argument[1]];
if argument[0] == PLAYER	return mondex[monsters[battler, 0], argument[1]];
if argument[0] == ENEMY		return mondex[eparty[ebattler, 0], argument[1]];

}
	
function SET_STATUS(){
///@arg player/enemy
///@arg status
///@arg number	(if specification is needed)

//If the player is getting a status condition
if argument[0] == 0{
	if argument_count == 2 monsters[battler, party.status] = argument[1];
	else monsters[argument[2], party.status] = argument[1];
	}
else{
	if argument_count == 2 eparty[ebattler, party.status] = argument[1];
	else eparty[argument[2], party.status] = argument[1];
	}
	
	
}
	
function CRIT_CHANCE(){
///@arg Hi_Crit_0_1

var _crit_chance = irandom(100);
if argument_count == 0{
	if _crit_chance <= 10 return 2;
	return 1;
	}

if argument[0] == 0{
	if _crit_chance <= 10 return 2;
	return 1;
	}
if argument[1] == 1{
	if _crit_chance <= 30 return 2;
	return 1;
	}

return 1;
}
	
function TYPE_EFF(){

///@arg attacker
///@arg defender_type1
///@arg defender_type2

//Set your type effectivenesses here
var no_eff	 = 0;
var not_eff = 0.25;
var not_very = 0.5;
var super_ef = 2.0;
var hyper_ef = 4.0;

//Store arguments to local variables for easier use/legibility
var attacker = argument[0];
var defender1 = argument[1];
var defender2 = argument[2];

//Check the attackers type, and then once we find it, find the defenders type, and then return the damage multiplier based on what their type is. Otherwise return 1 for normal effectiveness
//Elements: --> fire, grass, water, electric, dark, light, flying, fight, poison, dragon, fairy

//Check Attackers type
switch attacker{
	//If my attacking monster is a using fire type move
	case element.fire:
		switch defender1{
			//Return "super effective" or "not very effective" values basaed on defenders element
			case element.grass:		return super_ef;
			case element.water:		return not_very;
			}
		
	//If my attacking monster is a using water type move
	case element.water:
		switch defender1{
			case element.fire:		return super_ef;
			case element.grass:		return not_very;
			}
	
	//If my attacking monster is a using grass type move
	case element.grass:
		switch defender1{
			case element.water:		return super_ef;
			case element.fire:
			
				//If the defending monsters types are both fire and flying, deal 0.25x damage, otherwise, deal 0.5x damage
				if defender2 == element.flying return not_eff;
				else return not_very;
			
			case element.flying:	return not_very;
			}
		
	//If my attacking monster is a using electric type move
	case element.electric:
		switch defender1{
			case element.water:		return super_ef;
			case element.flying:	return super_ef;
			case element.grass:		return not_very;
			}
		
	//If my attacking monster is a using dark type move
	case element.dark:
		switch defender1{
			case element.light:		return no_eff;
			case element.poison:	return super_ef;
			case element.electric:	return super_ef;
			case element.fairy:		return not_very;
			case element.fight:		return not_very;
			}
			
	//If my attacking monster is a using light type move
	case element.light:
		switch defender1{
			case element.dark:		return hyper_ef;
			case element.dragon:	return hyper_ef;
			case element.electric:	return not_very;
			case element.fairy:		return not_very;
			case element.fight:		return not_very;
			}

	//If my attacking monster is a using flying type move
	case element.flying:
		switch defender1{
			case element.poison:	return super_ef;
			case element.grass:		return super_ef;
			case element.fight:		return super_ef;
			case element.electric:	return not_very;
			case element.dragon:	return super_ef;
			}

	//If my attacking monster is a using fight type move
	case element.fight:
		switch defender1{
			case element.dark:		return super_ef;
			case element.light:		return super_ef;
			case element.fairy:		return not_very;
			case element.flying:	return not_very;
			}

	//If my attacking monster is a using posion type move
	case element.poison:
		switch defender1{
			case element.dark:		return not_very;
			case element.grass:		return super_ef;
			case element.flying:	return not_very;
			}

	//If my attacking monster is a using dragon type move
	case element.dragon:
		switch defender1{
			case element.fairy:		return not_very;
			case element.flying:	return super_ef;
			}
		
	//If my attacking monster is a using fairy type move
	case element.fairy:
		switch defender1{
			case element.dark:		return super_ef;
			case element.fight:		return super_ef;
			case element.flying:	return not_very;
			}
	}

return 1;

}
	
function CHECK_STAB(){

//Same Type Attack Bonus
//Deal bonus damage if your monsters using a move that's type matches their own elemental type

///@arg attackers_type1
///@arg attackers_type2
///@arg move_type

if argument[0] == argument[2] or argument[1] == argument[2] return 1.5;

return 1;	
}
	
function CALCULATE_BATTLE_STATS(){

///@arg FINAL_STAT
///@arg PLAYER/ENEMY
///@arg STAT_TO_MODIFY

//How to use:
//ATK = CALCULATE_BATTLE_STATS(ATK, PLAYER, battl_stat.atk);
//SPD = CALCULATE_BATTLE_STATS(SPD, PLAYER, battl_stat.spd);

//The final stat should already be calculated, this simply modifies that number and returns it
//based on that stats current battle stats stage value (which can range from -6, to +6, 0 being the default).
//For more info on how Pokemon does it check out: https://bulbapedia.bulbagarden.net/wiki/Stat#Stage_multipliers

//"Final stat" is the combined attack after calculating IV's, EV's, and Base attack for this monster at this level (before stat multiplication)
var final_stat	= argument[0];
var monster		= argument[1];
var battle_stat = argument[2];

//We multiply the stat by 1.5 to 4 times (or .70 to .25) for this attack only since battle_stat stages can change with any move use
switch battle_stats[monster, battle_stat]{	//+0 = 1.0x
	case 6: return (final_stat * 4.0);
	case 5: return (final_stat * 3.5);
	case 4: return (final_stat * 3.0);
	case 3: return (final_stat * 2.5);
	case 2: return (final_stat * 2.0);
	case 1: return (final_stat * 1.5);
	case 0: return (final_stat * 1.0);
	case -1: return (final_stat * 0.70);
	case -2: return (final_stat * 0.50);
	case -3: return (final_stat * 0.40);
	case -4: return (final_stat * 0.35);
	case -5: return (final_stat * 0.30);
	case -6: return (final_stat * 0.25);
	}
return 1;
}

function RESET_ENEMY(){
//Reset enemy team back to zero before or after a battle

var o = 0;
for (var i = 0; i < 6; i++;){
	eparty[i, o] = -1;	o++;	//Monster
	eparty[i, o] = 0;	o++;	//Level
	eparty[i, o] = 0;	o++;	//Exp (Always 0)
	eparty[i, o] = 0;	o++;	//Health
	eparty[i, o] = 0;	o++;	//HP EV's
	eparty[i, o] = 0;	o++;	//ATK EV's
	eparty[i, o] = 0;	o++;	//DEF EV's
	eparty[i, o] = 0;	o++;	//MGK ATK EV's
	eparty[i, o] = 0;	o++;	//MGK DEF EV's
	eparty[i, o] = 0;	o++;	//SPEED EV's
	eparty[i, o] = 0;	o++;	//First Move
	eparty[i, o] = 0;	o++;	//Second Move
	eparty[i, o] = 0;	o++;	//Third Move
	eparty[i, o] = 0;	o++;	//Fourth Move
	eparty[i, o] = 0;	o++;	//Mana 01
	eparty[i, o] = 0;	o++;	//Mana 02
	eparty[i, o] = 0;	o++;	//Mana 03
	eparty[i, o] = 0;	o++;	//Mana 04
	eparty[i, o] = 0;	o++;	//Manapool
	eparty[i, o] = 0;	o++;	//Status 
	eparty[i, o] = 0;	o++;	//Held Item
	}
}