RELOAD

window_set_size(1440, 810);
window_set_cursor(cr_none);
cursor_sprite = spr_mouse_cursor;
image_speed = 0.1;

enum monmae{
	_player, _monsters, _monster_info, _monsters_stats, _monster_moves, _monster_moves_info, _monsters_movepools
	}

//Player Menu Vars
action = 0;
run_action = 0
walk_spd = 4;
run_spd = 6;
walk_timer = 0;
run_timer = 0;
playable_character = 0;

//MonDex Editing Vars
menu = 1;
typing = -1;
instruction = -1;
user_string = -1;
del_tmr = 30;

//MonDex Variables
hobble[0] = 0;
hobble[1] = 0;
incr[0] = 1;
incr[1] = 1;
timer = 0;
scroll = 0;

flash = 0;
mon_hop = 1;
alarm_set(0, 5);

//Menu stuff
sel[0] = 0;		//Main menu
sel[1] = 0;		//Monster
sel[2] = 0;		//Menu 3
sel[3] = 0;		//Menu 4
sel[4] = 0;		//Menu 5

draw_message = "";
editing_pool_val = -1;

//Stats Editing Strings Array
var i = 0;
stat_arg_string[i] = "Health:";				i++;
stat_arg_string[i] = "Attack:";				i++;
stat_arg_string[i] = "Defense:";			i++;
stat_arg_string[i] = "Sp. Atk:";			i++;
stat_arg_string[i] = "Sp. Def:";			i++;
stat_arg_string[i] = "Speed:";				i++;
stat_arg_string[i] = "Cap. Rate";			i++;
editing_stat_val = -1;	

//Moves "Editing" Strings Array
var i = 0;
move_arg_string[i] = "Name:";				i++;	//String
move_arg_string[i] = "Descr:";				i++;	//String
move_arg_string[i] = "Sprite:";				i++;	//Exception*
move_arg_string[i] = "Animation:";			i++;	// -> Real
move_arg_string[i] = "Move Power:";			i++;
move_arg_string[i] = "Move Healing:";		i++;
move_arg_string[i] = "Accuracy:";			i++;	// <-
move_arg_string[i] = "Element:";			i++;	//Exception*
move_arg_string[i] = "Type";				i++;
move_arg_string[i] = "Uses";				i++;
move_arg_string[i] = "Priority";			i++;
////////////////////////////////////////////////
move_arg_string[i] = "Status Chance";		i++;
move_arg_string[i] = "Status";				i++;	//Exception*
////////////////////////////////////////////////
move_arg_string[i] = "Flinch Chance";		i++;	// -> Real
move_arg_string[i] = "Flinch";				i++;
////////////////////////////////////////////////
move_arg_string[i] = "Hi-Crit";				i++;
move_arg_string[i] = "Stat Chance";			i++;
move_arg_string[i] = "My ATK";				i++;
move_arg_string[i] = "My DEF";				i++;
move_arg_string[i] = "My MAT";				i++;
move_arg_string[i] = "My MDF";				i++;
move_arg_string[i] = "My SPD";				i++;
move_arg_string[i] = "My EVA";				i++;
move_arg_string[i] = "My ACC";				i++;
////////////////////////////////////////////////
move_arg_string[i] = "Enemy ATK";			i++;
move_arg_string[i] = "Enemy DEF";			i++;
move_arg_string[i] = "Enemy MAT";			i++;
move_arg_string[i] = "Enemy MDF";			i++;
move_arg_string[i] = "Enemy SPD";			i++;
move_arg_string[i] = "Enemy EVA";			i++;
move_arg_string[i] = "Enemy ACC";			i++;	// <-
////////////////////////////////////////////////
move_arg_string[i] = "Protect";				i++;	// -> Boolean
move_arg_string[i] = "1st Turn Only";		i++;
move_arg_string[i] = "Require Recharge";	i++;
move_arg_string[i] = "One Hit KO";			i++;
////////////////////////////////////////////////
move_arg_string[i] = "Recoil";				i++;	//	<-
move_arg_string[i] = "Recoil % Amount";		i++;
////////////////////////////////////////////////
move_arg_string[i] = "Flat Damage";			i++;
move_arg_string[i] = "Flat Damage Amount";	i++;

editing_move_exception = 0;
editing_move_val = -1;	/*	This varuable is used for controlling how we can/can't interact with editing every part of a move. -1 for editing nothing
enum move{		
	name, description, sprite, animation, power, healing, accuracy, element, type, mana, priority, chance_status, status, chance_flinch, flinch, hi_crit,
	chance_stat, atk, def, mgk_atk, mgk_def, spd, eva, acc, e_atk, e_def, e_mgk_atk, e_mgk_def, e_spd, e_eva, e_acc, protect, firstturn,
	recharge, onehitko, recoil, recoil_amnt, flat_dmg, flat_dmg_amnt
	}
*/

function get_move_value_strings(){
	
	///@arg moves_argument_value
	///@arg selected_movedex_move_argument
	
	//Setup our variables for checking and returing strings with
	move_value = argument[0];	//Compare moves movedex value for the currently selected move argument we're editing
	move_value_string = string(argument[0]);	//Prepare variable to be overwritten and returned
	
	switch (argument[1]){
		case move.name:
			move_value_string = movedex[sel[2], move.name];
			break;
	
		case move.description:
			move_value_string = "Seen Below";
			break;
	
		case move.sprite:
			var _string_name = GET_MOVE_STRING(sel[2], MOVE_SPRITE);
			_string_name = string_delete(_string_name, 1, 4);
			move_value_string = _string_name;
			break;
			
		case move.element:
			var element_string = GET_MOVE_STRING(sel[2], MOVE_ELEMENT);
			move_value_string = element_string;
			break;
			
		case move.type:
			if move_value == 0 move_value_string = "Physical";
			else move_value_string = "Magical";
			break;
		}
	}


//Load save files
if file_exists("player_setup.ini"){
	
	ini_open("player_setup.ini");
	
	playable_character =		ini_read_real("Playable Character", "Num", playable_character);
	walk_spd =					ini_read_real("Animation Speeds", "Walk Speed", walk_spd);
	run_spd =					ini_read_real("Animation Speeds", "Run Speed", run_spd);
	ini_close();
	}

if file_exists("mondex.ini") var file = "mondex.ini";
else if file_exists("default.ini") var file = "default.ini";
else exit;			

ini_open(file);
for (var o = 0; o < array_length(mondex); o++;){
	for (var i = 1; i < 10; i++;){
		mondex[o, i] = ini_read_real("Monster_" + string(o), "Val" + string(i), 0);
		}
	mondex[o, 0] = ini_read_string("Monster_" + string(o), "Val" + string(0), "");
	mondex[o, 11] = ini_read_string("Monster_" + string(o), "Val" + string(11), "");
	mondex[o, 12] = ini_read_string("Monster_" + string(o), "Val" + string(12), "");
	}
ini_close();


//Loop through the current movedex values and save them to a new ini file
if file_exists("movedex.ini"){
	ini_open("movedex.ini");
	for (var o = 0; o < array_length(movedex); o++;){
		for (var i = 3; i < array_length(movedex[0]); i++;){
			movedex[o, i] = ini_read_real("Move_" + string(o), "Val" + string(i), movedex[o, i]);
			}
		movedex[o, 0] = ini_read_string("Move_" + string(o), "Val" + string(0), movedex[o, 0]);
		movedex[o, 1] = ini_read_string("Move_" + string(o), "Val" + string(1), movedex[o, 1]);
		movedex[o, 2] = asset_get_index(ini_read_string("Move_" + string(o), "Val" + string(2), movedex[o, 2]));
		}
	ini_close();
	}
			

//Loop through the current movepools values and save them to a new ini file
if file_exists("movepools.ini"){
	ini_open("movepools.ini");
	
	for (var o = 0; o < array_length(movepool); o++;){
		var length = ini_read_real("Monster_" + string(o), "Movepool_Length", 0);
		for (var i = 0, ii = 0; i < length; i++;){
		
			movepool[o, ii] =	ini_read_real("Monster_" + string(o), "Move" + string(i), 0);
			movepool[o, ii+1] = ini_read_real("Monster_" + string(o), "Level" + string(i), 0);
			ii+=2;
			}
		}
	ini_close();
	}