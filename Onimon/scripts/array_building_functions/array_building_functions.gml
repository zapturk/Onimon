function BUILD_MONDEX_ARRAY(){
//Create a new monster in a single line using the BUILD_MONDEX_ARRAY script!

///@arg Name
///@arg Health
///@arg Attack
///@arg Defense
///@arg Magic_Attack
///@arg Magic_Defense
///@arg Speed
///@arg Element			- First Elemental Type
///@arg Element			- Second Elemental Type (-1 if none)
///@arg Evolution		- Level that the monster should evolve at (-1 if none)
///@arg Capture_Rate
///@arg Sub_Description
///@arg Description
//13 Arguments ^^

//If Desired:
/*
///@arg Weight
///@arg Weight
///@arg Cry
//etc
*/

//How to use:
//BUILD_MONDEX_ARRAY("Burnsby",		74, 18, 53, 88, 40, 71,			element.fire, -1, 16, 1);
//BUILD_MONDEX_ARRAY("Burnsby",		74, 18, 53, 88, 40, 71,			element.fire, -1, 16, 1, "Teddy Bear Dokimon", "He hides with other plushies to surprise attack enemies!");


//If this is our first entry in this array
if is_undefined(mondex){
	mondex[0, dex.sub_descrip] = "";
	mondex[0, dex.descrip] = "";
	
	for (var i = 0; i < argument_count; i++;){
		mondex[0, i] = argument[i];
		}
	}
else{
	var m = array_length(mondex);
	
	//Set description and sub-description to "" (empty) just in case we don't have them (to avoid crashes later)
	mondex[m, dex.sub_descrip] = "";
	mondex[m, dex.descrip] = "";
	
	//Assign the data from 
	for (var i = 0; i < argument_count; i++;){
		mondex[m, i] = argument[i];
		}
	}
}

function SET_MOVES(){
///@desc Set the moves and levels at which a monster learns them
///@arg monster_name
///@arg move_name
///@arg level_learned

var m = array_length(mondex);
for (var i = 0; i < m; i++;){
	if argument[0] == mondex[i, DEX_NAME]{
		for (var o = 1; o < argument_count; o++;){
			movepool[i, o] = argument[o];
			movepool[i, o+1] = argument[o+1];
			}
		return;
		}
	}
}

function BUILD_MOVEDEX_ARRAY_EXT(){

///@arg Name
///@arg Descr
///@arg Sprite				The sprite_index we use for this moves animations
///@arg Animation			Animation type. Currently implemented: 0 Play animation over enemy (default), 1 Play over Self, 2 Projectile from self to enemy, 3 Whole Room
///@arg Power			
///@arg Healing				Set to 1 for TRUE to convert Power/Damage to Healing. Can also be used with Flat_Damage
///@arg Accuracy
///@arg Element
///@arg Type
///@arg Mana				Max uses of the move
///@arg Priority			Default 0 - Used for moves like Quick Attack (+1), Extreme Speed (+2), Protect (+3), etc

///@arg Chance_status		This is used for, "Chance to leave a burn" and etc, Should be a value between 1 and 100
///@arg Status				What status effect we should apply (0 if none)
	
///@arg Chance_flinch				This is used for flinching only, Should be a value between 1 and 100
///@arg Flinch				0 or 1 (True or False) - If the enemy flinches, there'll be unable to move that turn
///@arg Hi-Crit				0 or 1 (True or False) - If true, crit chance turns into 35% chance instead of 10% chance

///@arg Chance_stats		Chance to affect our/enemy stat, Should be a value between 1 and 100
///@arg Atk					Change my own stat (0 for don't chance, or -2, -1 for reducing, or 1, or 2 for increasing. Max stat changes are -6 and +6)
///@arg Def
///@arg M_Atk
///@arg M_Def
///@arg Spd
///@arg Eva
///@arg Acc

///@arg e_Atk				Change defenders stat
///@arg e_Def
///@arg e_M_Atk
///@arg e_M_Def
///@arg e_Spd
///@arg e_Eva
///@arg e_Acc

///@arg Protect				0 or 1 (True or False) - 100% chance to protect, then 50$ chance, then 25% chance, then 0%
///@arg Firstturn			0 or 1 (True or False) - 100% that the user must use on turn one only, like "Fake Out"
///@arg Recharge			0 or 1 (True or False) - 100% that the user must recharge next turn if this move lands
///@arg OHKO				0 or 1 (True or False) - Whether or not the move is a one hit knock-out

///@arg Recoil				0 or 1 (True or False) - Whether or not our move damages (recoils) the user
///@arg Recoil_Amnt			What percent of our health to recoil by (0-100)%
///@arg Flat_Damage			0 or 1 (True or False) - Whether or not we apply a flat amount of damage regardless of stats/formulae
///@arg Damage_Amnt			The amount of flat damage we will deal


//If this is our first entry in this array
if is_undefined(movedex) var m = 0;
else var m = array_length(movedex);

//Set default values in case we mess up or don't want to fill in anything after PP
for (var i = 0; i < 37; i++;){
	movedex[m, i] = 0;
	}
movedex[m, move.name]			= "Name";					//Default Name
movedex[m, move.description]	= "Description";			//Default Description
movedex[m, move.sprite]			= spr_scratch;				//Default Animation
movedex[m, move.animation]		= move_ani.over_enemy;		//Default Animation
movedex[m, move.power]			= 80;						//Default Power
movedex[m, move.element]		= element.light;			//Default Element
movedex[m, move.type]			= type.physical;			//Default Move Type
movedex[m, move.accuracy]		= 100;						//Default Accuracy
movedex[m, move.mana]			= 25;						//Default Uses
	
//Replace the just assigned default values with the values assigned in the arguments
if argument_count mod 2 == 0{
	show_message("Issue initilizing a move. Incorrect arguments amount"); 
	exit;
	}

//Replace the just assigned default values with the values assigned in the arguments
for (var i = 0; i < argument_count; i++;){
	movedex[m, i] = argument[i];
	}
}
	
function BUILD_MOVEDEX_ARRAY(){
//Use this array when the move has few or no additional effects outside what's needed for the bare minumum of a move

//Bare Minimum Move Values

//-----------------------------------------------/
///@arg Name
///@arg Descr
///@arg Sprite
///@arg Power
///@arg Element
///@arg Type
///@arg Accuracy
///@arg Uses (PP - Max uses available by default)
//-----------------------------------------------/

//Additional move values (like chance to burn, flinch, recharge, etc)
///@arg stat_to_modify
///@arg modified_value


//How to use:
//BUILD_MOVEDEX_ARRAY("Tackle",	"",		spr_impact_01,	30,		element.light,	type.physical, 100,	40);
//BUILD_MOVEDEX_ARRAY("Ember",	"",		spr_fireblast,	40,		element.fire,	type.magic,		95,		35,		move.chance1, 10, move.status, status.burn);

//As you can see, "Tackle" uses the bare minimum needed for a move since it has no additional effects.
//Ember, on the other hand, uses the bare minimum + "move.chance 10%" + "move.status BURN" to make it so that the move has a 10% chance to burn on use


//Assign everything to 0 so our array values aren't undefined (avoids crashes)
var m = array_length(movedex);
for (var i = 0; i < 37; i++;){
	movedex[m, i] = 0;
	}
	
//Assign the following values for every move
movedex[m, move.name]			= argument[0];
movedex[m, move.description]	= argument[1];
movedex[m, move.sprite]			= argument[2];
movedex[m, move.power]			= argument[3];
movedex[m, move.element]		= argument[4];
movedex[m, move.type]			= argument[5];
movedex[m, move.accuracy]		= argument[6];
movedex[m, move.mana]			= argument[7];
	
//If we hav any additional move specifics to add outside of the bare minimum,
//check for them and add them in from here (used in the ember example above)
for (var i = 8; i < argument_count; i+=2;){
	//Set to 2 to skip name and description
	movedex[m, argument[i]] = argument[i+1];
	}
}
	
function ADD_A_MONSTER(){

///@arg Monster
///@arg Level
///@arg PC?

var a = 0;
if argument_count == 3 a = 6;

for (var i = a; i < 366; i++;){
	if monsters[i, 0] == -1{
		monsters[i, party.number] = argument[0];	//Monster
		monsters[i, party.level] = argument[1];		//Level
		monsters[i, party.health] = GET_STAT(PLAYER, MAX_HEALTH_SUM, i);
		monsters[i, party.trainer] = player_name;
		
		//Give monsters a random amount of exp
		var lvl = monsters[i, party.level];
		monsters[i, party.exp] = (irandom_range(5, (power(lvl, 3)))-1);
		
		//EV's should be set randomly based on our level
		
		#region Assign this monster moves based on it's level
		possible_moves = ds_list_create();
		var monster = argument[0];
		
		//Loop through the entirety of the movepool array and add all move indexes to the ds_list
		//However, if in our loop, the level of the movepool index surpass the monster we're addings
		//Level, exit the loop to ensure those moves aren't added into the "possible moves" ds_list
		for (var o = 1; o < array_length(movepool[monster]); o+=2;){
			var move_id = o-1, move_level = movepool[monster, o];
			
			//Stop looking for moves if the required level for this move is higher than that of the monster we're adding 
			if move_level > monsters[i, party.level] break;
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
			
			//Assign the chosen moves to the monsters and give the monster mana for those moves
			var move_num = party.move1+o, move_id = ds_list_find_value(possible_moves, o);
			var mana_num = party.mana1+o, move_mana = movedex[move_id, move.mana];
			monsters[i, move_num] = move_id;
			monsters[i, mana_num] = move_mana;
			}
		#endregion
		return;
		}
	}
}

function BUILD_MONSTER_MOVEPOOL(){
///@arg monster_num
///@arg move_name
///@arg level_learned
///@arg move_name
///@arg level_learned

//How it works:
//Compiles your list of moves and the levels at which their learned into an array
//that we will pull from later when checking if monsters learn new moves, and also
//when assigning random encounter monsters movesets (based on their level)

//How to use:
//BUILD_MONSTER_MOVEPOOL(m.BURNSBY,	moves.clobber, 1, moves.curl_up, 4, moves.sizzle, 8);

//Note: There's virtually no limit to how many moves a monster can have.

var monster = argument[0];
//Loop through the total list of moves and assign the move ID's and levels at
//which they are learned for the designated monsters (argument[0]) movepool
for (var i = 0; i < (argument_count-2); i+=2;){
	var move_name = i, level_learned = i+1;
	movepool[monster, move_name] = argument[move_name+1];
	movepool[monster, level_learned] = argument[level_learned+1];
	}

}

function CAPTURE_MONSTER(){

for (var i = 0; i < 366; i++;){
	if monsters[i, 0] == -1{
		monsters[i, party.number] =	eparty[0, 0];				//Monster
		monsters[i, party.level] =		eparty[0, party.level];	//Level
		monsters[i, party.health] = GET_STAT(ENEMY, MAX_HEALTH_SUM, i);
		
		//EV's should be set randomly based on our level
		
		//Moves should also be set randomly based on our monster and it's level
		monsters[i, party.move1] = 1;	//Scratch
		monsters[i, party.move2] = 2;	//Growl
		return;
		}
	}




}

function BUILD_ITEMDEX_ARRAY(){

///@arg name
///@arg description
///@arg category
///@arg usage
///@arg price

//If this is our first entry in this array
if (is_undefined(itemdex)) var n = 0;
else var n = array_length(itemdex);

for (var i = 0; i < argument_count; i++;){
	itemdex[n, i] = argument[i];
	}
}