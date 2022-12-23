
#region Macros
#macro UP 10000
#macro DOWN 10001
#macro RIGHT 10002
#macro LEFT 10003
#macro ENTER 10004
#macro BACK 10005
#macro ESCAPE 10006
#macro DELETE 10007
#macro SHIFT 10008

#macro KB_UP 10009
#macro KB_DOWN 10010
#macro KB_RIGHT 10011
#macro KB_LEFT 10012

#macro GP_UP 10013
#macro GP_DOWN 10014
#macro GP_RIGHT 10015
#macro GP_LEFT 10016

#macro mb_check 10001
#macro mb_pressed 10000
#macro mb_release 10002
#macro mb_clear 10003
#endregion


function mouse(){
	
#region Reference
///@arg mb_left
///@arg mb_pressed

//MUCH quicker than typing mouse_check_button_pressed(mb_left)
//Quickly access any mouse function from these macros using the mouse function

//Heres a few ways to use it:
//mouse();
//mouse(mb_left)
//mouse(mb_right, mb_pressed)

//https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Mouse_Input/Mouse_Input.htm
#endregion

//If there's no arguments
if argument_count = 0{
	if mouse_check_button_pressed(mb_left) or
	gamepad_button_check_pressed(0, gp_face1) return 1;
	else return 0;
	}

//If there's only 1 argument
if argument_count = 1{
	if argument[0] = (mb_left){
		if mouse_check_button_pressed(mb_left) or
		gamepad_button_check_pressed(0, gp_face1) return 1;}
	if argument[0] = (mb_right){
		if mouse_check_button_pressed(mb_right) return 1;}
	if argument[0] = (mb_middle){
		if mouse_check_button_pressed(mb_middle) return 1;}
	return 0;
	}
//Otheriwse, check everything else

#region Check Pressed
if argument[1] = mb_pressed{
	if argument[0] = (mb_left){
		if mouse_check_button_pressed(mb_left) or
		gamepad_button_check_pressed(0, gp_face1) return 1;}
	if argument[0] = (mb_right){
		if mouse_check_button_pressed(mb_right) return 1;}
	if argument[0] = (mb_middle){
		if mouse_check_button_pressed(mb_middle) return 1;}
	}
#endregion

#region Check	
if argument[1] = mb_check{
	if argument[0] = (mb_left){
		if mouse_check_button(mb_left) return 1;}
	if argument[0] = (mb_right){
		if mouse_check_button(mb_right) return 1;}
	if argument[0] = (mb_middle){
		if mouse_check_button(mb_middle) return 1;}
	}
#endregion
	
#region Released
if argument[1] = mb_release{
	if argument[0] = (mb_left){
		if mouse_check_button_released(mb_left) return 1;}
	if argument[0] = (mb_right){
		if mouse_check_button_released(mb_right) return 1;}
	if argument[0] = (mb_middle){
		if mouse_check_button_released(mb_middle) return 1;}
	}
#endregion

#region Clear
if argument[1] = mb_clear{
	if argument[0] = (mb_left){
		mouse_clear(mb_left);
		return 1;}
	if argument[0] = (mb_right){
		mouse_clear(mb_right)
		return 1;}
	if argument[0] = (mb_middle){
		mouse_clear(mb_middle)
		return 1;}
	}
#endregion
return 0;
}


function held(argument0){
	
#region Reference
///@arg ENTER/"E"/vk_space

//Works like keyboard_check();
//https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_check.htm
#endregion

var key = argument0;
//if is_string(key) key = string_lower(argument0);

#region Directions. WASD/Arrows
if key = RIGHT{
	if keyboard_check(vk_right) or
	keyboard_check(ord("D")) or 
	(gamepad_axis_value(0, gp_axislh) > stk_act) return 1;
	}
if key = LEFT{
	if keyboard_check(vk_left) or
	keyboard_check(ord("A")) or
	(gamepad_axis_value(0, gp_axislh) < -stk_act) return 1;
	}
if key = UP{
	if keyboard_check(vk_up) or
	keyboard_check(ord("W")) or
	(gamepad_axis_value(0, gp_axislv) < -stk_act) return 1;
	}
if key = DOWN{
	if keyboard_check(vk_down) or
	keyboard_check(ord("S")) or
	(gamepad_axis_value(0, gp_axislv) > stk_act) return 1;
	}
#endregion
	
#region Directions. (Gamepad Only)
if key = GP_RIGHT{
	if (gamepad_axis_value(0, gp_axislh) > stk_act) return 1;
	}
if key = GP_LEFT{
	if (gamepad_axis_value(0, gp_axislh) < -stk_act) return 1;
	}
if key = GP_UP{
	if (gamepad_axis_value(0, gp_axislv) < -stk_act) return 1;
	}
if key = GP_DOWN{
	if (gamepad_axis_value(0, gp_axislv) > stk_act) return 1;
	}
#endregion
	
#region Directions. (Keyboard Only)
if key = KB_RIGHT{
	if keyboard_check(vk_right) or
	keyboard_check(ord("D")) return 1;
	}
if key = KB_LEFT{
	if keyboard_check(vk_left) or
	keyboard_check(ord("A")) return 1;
	}
if key = KB_UP{
	if keyboard_check(vk_up) or
	keyboard_check(ord("W")) return 1;
	}
if key = KB_DOWN{
	if keyboard_check(vk_down) or
	keyboard_check(ord("S")) return 1
	}
#endregion

#region Misc. Update as prefferred
if key = ENTER{
	if keyboard_check(vk_enter) or
	keyboard_check(vk_space) or
	keyboard_check(ord("E")) or
	gamepad_button_check(0, gp_face1) return 1;
	}
if key = ESCAPE{
	if keyboard_check(vk_escape) or 
	gamepad_button_check(0, gp_start) return 1;
	}
if key = SHIFT{
	if keyboard_check(vk_shift) or
	gamepad_button_check(0, gp_stickl) return 1;
	}
if key = BACK{
	if keyboard_check(vk_backspace) or
	keyboard_check(ord("Q")) or
	keyboard_check(ord("Z")) or
	keyboard_check(vk_escape) or
	gamepad_button_check(0, gp_face2) return 1;
	}
#endregion


if is_string(key) if keyboard_check(ord(key)) return 1;
if keyboard_check(key) return 1;
	
return 0;
}


function press(argument0){

#region Reference
///@arg ENTER/ord("E")/vk_space/etc

//Works like keyboard_check_pressed();
//https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_check_pressed.htm
#endregion

var key = argument0;
#region Directions. WASD/Arrows/Axis
if key = RIGHT{
	if keyboard_check_pressed(vk_right) or
	keyboard_check_pressed(ord("D")) return 1;
	if (gamepad_axis_value(0, gp_axislh) > stk_act) and stk_r = 0{
		stk_r = stk_dlay;	
		return 1;
		}
	}
if key = LEFT{
	if keyboard_check_pressed(vk_left) or
	keyboard_check_pressed(ord("A")) return 1;
	if (gamepad_axis_value(0, gp_axislh) < -stk_act) and stk_l = 0{
		stk_l = stk_dlay;	
		return 1;
		}
	}
if key = UP{
	if keyboard_check_pressed(vk_up) or
	keyboard_check_pressed(ord("W")) return 1;
	if (gamepad_axis_value(0, gp_axislv) < -stk_act) and stk_u = 0{
		stk_u = stk_dlay;
		return 1;
		}
	}
if key = DOWN{
	if keyboard_check_pressed(vk_down) or
	keyboard_check_pressed(ord("S")) return 1
	if (gamepad_axis_value(0, gp_axislv) > stk_act) and stk_d = 0{
		stk_d = stk_dlay;
		return 1;
		}
	}
#endregion
	
#region Directions. (Keyboard Only)
if key = KB_RIGHT{
	if keyboard_check_pressed(vk_right) or
	keyboard_check_pressed(ord("D")) return 1;
	}
if key = KB_LEFT{
	if keyboard_check_pressed(vk_left) or
	keyboard_check_pressed(ord("A")) return 1;
	}
if key = KB_UP{
	if keyboard_check_pressed(vk_up) or
	keyboard_check_pressed(ord("W")) return 1;
	}
if key = KB_DOWN{
	if keyboard_check_pressed(vk_down) or
	keyboard_check_pressed(ord("S")) return 1
	}
#endregion

#region Misc. Update as prefferred
if key = ENTER{
	if keyboard_check_pressed(vk_enter) or
	keyboard_check_pressed(vk_space) or
	keyboard_check_pressed(ord("E")) or
	gamepad_button_check_pressed(0, gp_face1) return 1;
	}
if key = ESCAPE{
	if keyboard_check_pressed(vk_escape) or 
	gamepad_button_check_pressed(0, gp_start) return 1;
	}
if key = DELETE{
	if keyboard_check_pressed(vk_delete) or
	gamepad_button_check_pressed(0, gp_select) return 1;
	}
if key = SHIFT{
	if keyboard_check_pressed(vk_shift) or
	gamepad_button_check_pressed(0, gp_stickl) return 1;
	}
if key = BACK{
	if keyboard_check_pressed(vk_backspace) or
	keyboard_check_pressed(ord("Q")) or
	keyboard_check_pressed(ord("Z")) or
	//keyboard_check_pressed(vk_escape) or 
	gamepad_button_check_pressed(0, gp_face2) return 1;
	}
#endregion

if is_string(key) return 0;
if keyboard_check_pressed(key) return 1;
return 0;

}


function release(argument0){

#region Reference
///@arg ENTER/"E"/vk_space

//Works like keyboard_check_released();
//https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_check_released.htm
#endregion

var key = argument0;
if is_string(key) key = string_lower(argument0);

#region Directions. WASD/Arrows
if key = RIGHT{
	if keyboard_check_released(vk_right) or
	keyboard_check_released(ord("D")) return 1;
	}
if key = LEFT{
	if keyboard_check_released(vk_left) or
	keyboard_check_released(ord("A")) return 1;
	}
if key = UP{
	if keyboard_check_released(vk_up) or
	keyboard_check_released(ord("W")) return 1;
	}
if key = DOWN{
	if keyboard_check_released(vk_down) or
	keyboard_check_released(ord("S")) return 1;
	}
#endregion
	

#region Misc. Update as prefferred
if key = ENTER{
	if keyboard_check_released(vk_enter) or
	keyboard_check_released(vk_space) or
	keyboard_check_released(ord("E")) return 1;
	}
if key = BACK{
	if keyboard_check_released(vk_backspace) or
	keyboard_check_released(ord("Q")) or
	keyboard_check_released(ord("Z")) or
	keyboard_check_released(vk_escape) return 1;
	}
#endregion


if is_string(key) if keyboard_check(ord(key)) return 1;
if keyboard_check_released(key) return 1;
	
return 0;

}	


function clear(argument0){

#region Reference
///@arg ENTER/"E"/vk_space


//Clears a keyboard press so that you won't "double press"
//a key when checking for a key press twice in one step event

//https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/keyboard_clear.htm

#endregion

	
var key = argument0;
if is_string(key) key = string_lower(argument0);

#region Directions. WASD/Arrows
if key = RIGHT{
	if keyboard_clear(vk_right) or
	keyboard_clear(ord("D")) return 1;
	}
if key = LEFT{
	if keyboard_clear(vk_left) or
	keyboard_clear(ord("A")) return 1;
	}
if key = UP{
	if keyboard_clear(vk_up) or
	keyboard_clear(ord("W")) return 1;
	}
if key = DOWN{
	if keyboard_clear(vk_down) or
	keyboard_clear(ord("S")) return 1;
	}
#endregion
	

#region Misc. Update as prefferred
if key = ENTER{
	keyboard_clear(vk_enter);
	keyboard_clear(vk_space);
	keyboard_clear(ord("E"));
	return 1;
	}
	
if key = ESCAPE{
	keyboard_clear(vk_escape);
	return 1;
	}
	
if key = BACK{
	keyboard_clear(vk_backspace);
	keyboard_clear(ord("Q"));
	keyboard_clear(ord("Z"));
	keyboard_clear(vk_escape);
	return 1;
	}
#endregion


if is_string(key)
	{
	keyboard_check(ord(key));
	return 1;
	}
return 0;

}


function get_name(argument0, argument1){
//Used for getting a player's string input, to set a name or anything else

///@arg string
///@arg limit

//How to use:
//name = get_name(name, 8);

var _arg = argument0, _limit = argument1, _key = "";

//Check for pressed event
if press(vk_anykey){
	switch (keyboard_key){
		case ord("A"): _key = "A"; break;
		case ord("B"): _key = "B"; break;
		case ord("C"): _key = "C"; break;
		case ord("D"): _key = "D"; break;
		case ord("E"): _key = "E"; break;
		case ord("F"): _key = "F"; break;
		case ord("G"): _key = "G"; break;
		case ord("H"): _key = "H"; break;
		case ord("I"): _key = "I"; break;
		case ord("J"): _key = "J"; break;
		case ord("K"): _key = "K"; break;
		case ord("L"): _key = "L"; break;
		case ord("M"): _key = "M"; break;
		case ord("N"): _key = "N"; break;
		case ord("O"): _key = "O"; break;
		case ord("P"): _key = "P"; break;
		case ord("Q"): _key = "Q"; break;
		case ord("R"): _key = "R"; break;
		case ord("S"): _key = "S"; break;
		case ord("T"): _key = "T"; break;
		case ord("U"): _key = "U"; break;
		case ord("V"): _key = "V"; break;
		case ord("W"): _key = "W"; break;
		case ord("X"): _key = "X"; break;
		case ord("Y"): _key = "Y"; break;
		case ord("Z"): _key = "Z"; break;
		case ord("."): _key = "."; break;
		case ord(","): _key = ","; break;
		case ord("-"): _key = "-"; break;
		case ord(" "): _key = " "; break;
		}
	}
else return _arg;
	
var _str;
var _len = string_length(_arg)+1;

if _key != ""{
	//Check for caps
	if !held(vk_shift) _key = string_lower(_key);

	//Add text
	if _len < _limit{
		_str = string_insert(_key, _arg, _len);
		return _str;
		}
	else return _arg;
	}
else{
	if press(vk_backspace){
		_str = string_delete(_arg, _len-1, 1);
		return _str;
		}
	else return _arg;
	}
}


function press_any(){
//Welcome to the press any key function! Add every possible key
//you want an "any" key to pick up. I made this so that we can
//have an any key function without keys like alt, control, function
//keys and etc triggering the vk_anykey event.

switch (keyboard_key){
	case ord("A"): return 1;
	case ord("B"): return 1;
	case ord("C"): return 1;
	case ord("D"): return 1;
	case ord("E"): return 1;
	case ord("F"): return 1;
	case ord("G"): return 1;
	case ord("H"): return 1;
	case ord("I"): return 1;
	case ord("J"): return 1;
	case ord("K"): return 1;
	case ord("L"): return 1;
	case ord("M"): return 1;
	case ord("N"): return 1;
	case ord("O"): return 1;
	case ord("P"): return 1;
	case ord("Q"): return 1;
	case ord("R"): return 1;
	case ord("S"): return 1;
	case ord("T"): return 1;
	case ord("U"): return 1;
	case ord("V"): return 1;
	case ord("W"): return 1;
	case ord("X"): return 1;
	case ord("Y"): return 1;
	case ord("Z"): return 1;
	case ord("."): return 1;
	case ord(","): return 1;
	case ord("-"): return 1;
	case ord(" "): return 1;
	default: return 0;
	}
return 0;
	
}