function reload(){
return 1;
}

//GMLive 
#macro RELOAD reload();

//Init scripts
function init_colors(){
//Initiate colors array for using later (for text and other things)

globalvar col;
#macro COL_GREEN	0
col[0, 0] = hex($E2F3E4);
col[0, 1] = hex($86DD58);
col[0, 2] = hex($46878F);
col[0, 3] = hex($333650);
#macro COL_BLUE		1
col[1, 0] = hex($CCDDFF);
col[1, 1] = hex($4C81FF);
col[1, 2] = hex($4B519E);
col[1, 3] = hex($3A243D);
#macro COL_RED		2
col[2, 0] = hex($F2C1C3);
col[2, 1] = hex($ED474C);
col[2, 2] = hex($7F3D3F);
col[2, 3] = hex($44292A);
#macro COL_PINK		3
col[3, 0] = hex($F2C1D2);
col[3, 1] = hex($CC517C);
col[3, 2] = hex($8E455F);
col[3, 3] = hex($4F2B38);
#macro COL_PURPLE	4
col[4, 0] = hex($FFEFFF);
col[4, 1] = hex($F7B58C);
col[4, 2] = hex($876BB2);
col[4, 3] = hex($471E4C);
#macro COL_YELLOW	5
col[5, 0] = hex($F2F2F2);
col[5, 1] = hex($E5DB5B);
col[5, 2] = hex($E57F2D);
col[5, 3] = hex($59361A);
#macro COL_WHITE	6
col[6, 0] = hex($FFFFFF);
col[6, 1] = hex($B0ADB2);
col[6, 2] = hex($646366);
col[6, 3] = hex($191819);
}
function init_options(){

//Needed for player tracking (in the world and in between rooms)
globalvar px, py, start_x, start_y, curr_rm, area;
px = -1;
py = -1;
start_x = 2256;				//Set to first time startup location - X coordinate
start_y = 3120;				//Set to first time startup location - Y coordinate
curr_rm = rm_worldmap;		//Set to first time startup location - Room Index
area = "Undefined";

//Needed for talking to NPC's and interacting with other world objects and story/events
globalvar interacting, interact;
interacting = 0;	//True/False
interact = -1;		//Target object's ID

//Init story tracker global
globalvar player_name, story, badges, moni;
player_name = "Yana";
story = 0;
badges = 0;
moni = 500;

//Establish in-game camera/resolution 
//Edit these variables to change the IN-GAME resolution of your game (this is NOT the size of the game screen on a monitor)

#macro CAM_WIDTH 256		//Default: 256
#macro CAM_HEIGHT 144		//Default: 144


//Add language macros here
#macro ENGLISH	0			//Default: ENGLISH	0
#macro JAPANESE 1			//Default: JAPANESE 1

globalvar language, screenshots, volume;
language = ENGLISH;
screenshots = 0;

volume = 0;
audio_set_master_gain(1, volume);


//Ignore these errors
#region General Init
globalvar pause, debug;
pause = 0;
debug = -1;
#endregion

#region Controller stuff
globalvar stk_u, stk_d, stk_r, stk_l, stk_x, stk_y, stk_dlay, stk_act;
stk_u = 0;
stk_d = 0;
stk_r = 0;
stk_l = 0;
stk_x = room_width/2;
stk_y = room_height/2;
stk_dlay = 30; //Frames
stk_act = 0.3;
gamepad_set_axis_deadzone(0, 0.3);
#endregion
}
function init_inventory(){

globalvar inv, itemdex;
for (var i = 0; i < 99; i++;){
	inv[i, 0] = -1;	//item
	inv[i, 1] = -1;	//item quantity 
	}
itemdex = undefined;

//Define starting items
inv[0, 0] = 0;	//Captals
inv[0, 1] = 5;
inv[1, 0] = 5;	//Potions
inv[1, 1] = 3;

//Item categorical macros
#macro CONSUMABLE 0

//Item usage macros
#macro ITEM_NONE 0
#macro ITEM_CAPT 1
#macro ITEM_HEAL 2

//Capture items 0-4
BUILD_ITEMDEX_ARRAY("Captal", "A razer sharp card that calms Dokimon making them easier to capture.", 0, ITEM_CAPT, 200);
BUILD_ITEMDEX_ARRAY("Great Captal", "An upgraded Captal with strong sedative properties.", 0, ITEM_CAPT, 400);
BUILD_ITEMDEX_ARRAY("Super Captal", "A premium Captal with powerful tranquillizing abilities.", 0, ITEM_CAPT, 900);
BUILD_ITEMDEX_ARRAY("Lightning Captal", "A curiously swift Captal, that makes capturing easier when uses on the first turn.", 0, ITEM_CAPT, 1000);
BUILD_ITEMDEX_ARRAY("Medical Captal", "A remedial Captal fused with medical herbs to induce healing.", 0, ITEM_CAPT, 300);

//Healing items 5
BUILD_ITEMDEX_ARRAY("Potion", "A medical remedy prodouced by combining rare herbs and minerals", 0, ITEM_HEAL, 300);
BUILD_ITEMDEX_ARRAY("Hi-Potion", "A medical remedy prodouced by combining rare herbs and minerals", 0, ITEM_HEAL, 300);
BUILD_ITEMDEX_ARRAY("Super Potion", "A medical remedy prodouced by combining rare herbs and minerals", 0, ITEM_HEAL, 300);

}
function init_characters(){
//Used for initialzing character trackers (for progessionable dialogue),
//trainer trackers (if we've battled them yet or not), and so on

globalvar characters;
for (var i = 0; i < 99; i++;){

	//Start at zero, as we haven't yet spoke with this character, so we should show their first message.
	//After we talk to them (or after story events take place), increase this by 1. Then when speaking
	//to the NPC that has progressionable dialogue, display their messages based their respective value
	//in this array. For example, if their "char" is 1, and this is their third set of messages, then
	//display the messages assigned to character[1] when character[1] = 2 (since we start at 0. "0, 1, 2" = 3
	characters[i] = 0;
	}

//0 for false, didn't battle yet, so start a battle! 1 for true, DID battle, so don't start a battle.
//If a trainer has "rebattleable" checked, this check is ignored, and they will always be battleable
globalvar trainers;
for (var i = 0; i < 99; i++;){
	trainers[i] = 0;
	}

}


//Init all init scripts
function init_all(){
//Execute all the major initiation functions

init_colors();
init_options();
init_inventory();
init_characters();

//0 = Wild Battle (default), 1 = trainer battle
globalvar trainer, trainer_img, trainer_end_msg;
trainer = 0;
trainer_img = 0;
trainer_end_msg = "";

}


//Battle init scripts
function init_monster_data(){

//Monster static Data (non-variable); used for your monster index
globalvar mondex;
mondex = undefined;

//Enumerators to help us keep track of where specific data is in their matching arrays
enum dex{
	name, health, atk, def, mgk_atk, mgk_def, spd, element1, element2, ability, cap_rate, sub_descrip, descrip
	//if desired, you can also include these:
	//weight, height, cry, artist, designer, etc
	}
enum element{
	fire, grass, water, electric, dark, light, flying, fight, poison, dragon, fairy
	}

//Input your monsters base statistics
//Tutorial video: https://www.youtube.com/watch?v=sdfgsdf

//Order of monster name enumerators must match the order at which the monsters are assigned below
//In example, if your enum is Charmander, Charmeleon, Charizard, then Charmader must be the first
//Monster you create using the "BUILD_MONDEX_ARRAY", and Charizard must be the third (and etc)

//Pleaes keep this in mind if you start re-ordering monsters.
monsters_enum();

#region 1st Row of Monsters
BUILD_MONDEX_ARRAY("Furreal",		23, 67, 48, 32, 51, 80,			element.light, -1, 1, 1);
BUILD_MONDEX_ARRAY("Leekloo",		33, 80, 64, 42, 61, 101,		element.light, -1, 1, 1);
BUILD_MONDEX_ARRAY("Leeksword",		50, 104, 87, 58, 88, 135,		element.light, element.dark, -1, 1);

BUILD_MONDEX_ARRAY("Nekosword",		32, 14, 38, 100, 74, 102,		element.fairy, -1, 1, 1);
BUILD_MONDEX_ARRAY("Nekosword 2",	45, 16, 48, 147, 94, 133,		element.fairy, -1, -1, 1);
BUILD_MONDEX_ARRAY("Carrotti",		41, 60, 67, 24, 48, 62,		element.grass, -1, 1, 1);

BUILD_MONDEX_ARRAY("Kakaratt",		59, 78, 88, 34, 62, 81,		element.grass, element.dark, -1, 1);
BUILD_MONDEX_ARRAY("Quackfil",		45, 60, 40, 70, 50, 45,		element.dark, -1, 1, 1);
BUILD_MONDEX_ARRAY("Quackfear",		45, 60, 40, 70, 50, 45,		element.dark, -1, -1, 1);
#endregion

#region 2nd Row of Monsters
BUILD_MONDEX_ARRAY("Casper",		26, 7, 37, 96, 59, 78,		element.dark, -1, 1, 1);
BUILD_MONDEX_ARRAY("Deathscye",		35, 17, 46, 121, 82, 106,	element.dark, -1, -1, 1);
BUILD_MONDEX_ARRAY("Nimbis",		45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1);

BUILD_MONDEX_ARRAY("Lloudious",		45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1);
BUILD_MONDEX_ARRAY("Cresyl",		45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1);
BUILD_MONDEX_ARRAY("Cressentia",	45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1);

BUILD_MONDEX_ARRAY("Moisen",	44, 74, 22, 53, 22, 66,			element.flying, element.poison, 1, 1);
BUILD_MONDEX_ARRAY("Birzhen",	62, 103, 34, 85, 32, 106,		element.flying, element.poison, 1, 1);
BUILD_MONDEX_ARRAY("Bundust",		32, 63, 38, 71, 67, 70,		element.fairy, -1, 1, 1);
#endregion

#region 3rd Row of Monsters
BUILD_MONDEX_ARRAY("Juskitten",		32, 63, 38, 71, 67, 70,		element.light, -1, 1, 1);
BUILD_MONDEX_ARRAY("Harlequitten",	40, 82, 52, 92, 88, 88,		element.light, -1, 1, 1);
BUILD_MONDEX_ARRAY("Nyarlolet",		46, 86, 56, 100, 92, 102,	element.light, -1, 1, 1);

BUILD_MONDEX_ARRAY("FireKitty",	38, 12, 41, 91, 72, 89,			element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("FireStand",	52, 16, 49, 119, 93, 114,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Haracker",	45, 60, 40, 75, 50, 45,		element.fight, -1, 1, 1);

BUILD_MONDEX_ARRAY("Hareate",	45, 60, 40, 75, 50, 45,		element.fight, -1, 1, 1);
BUILD_MONDEX_ARRAY("Soul",		45, 60, 40, 75, 50, 45,		element.dark, -1, 1, 1);
BUILD_MONDEX_ARRAY("Jistery",	45, 60, 40, 75, 50, 45,		element.dark, -1, 1, 1);
#endregion

#region 4th Row of Monsters
BUILD_MONDEX_ARRAY("Loomleak",	84, 69, 55, 10, 73, 31,		element.water, -1, 1, 1);
BUILD_MONDEX_ARRAY("Marillo",	120, 92, 74, 14, 100, 42,	element.water, -1, 1, 1);
BUILD_MONDEX_ARRAY("Luna",			45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);

BUILD_MONDEX_ARRAY("Eclipse",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Kindle",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Hiku",			45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);

BUILD_MONDEX_ARRAY("Electro Llama",			45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Emberox",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Glaceia",		45, 60, 40, 75, 50, 45,		element.water, -1, 1, 1);
#endregion

#region 5th Row of Monsters
BUILD_MONDEX_ARRAY("Flurox",		45, 60, 40, 75, 50, 45,		element.grass, -1, 1, 1);
BUILD_MONDEX_ARRAY("Boltrex",		45, 60, 40, 75, 50, 45,		element.electric, -1, 1, 1);
BUILD_MONDEX_ARRAY("Yorox",			45, 60, 40, 75, 50, 45,		element.dark, -1, 1, 1);

BUILD_MONDEX_ARRAY("Kyle Man",				45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Daniel",				45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Corsac",		90, 97, 85, 97, 98, 95,		element.fire, -1, 1, 1);

BUILD_MONDEX_ARRAY("Knyfagon",		89, 101, 100, 88, 91, 92,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("T-Kob",            65, 30, 35, 80, 70, 20,        element.fire, element.poison, 1, 1);
BUILD_MONDEX_ARRAY("T-Kobom",        85, 50, 90, 85, 90, 80,        element.fire, element.electric, 1, 1);
#endregion

#region 6th Row of Monsters
BUILD_MONDEX_ARRAY("X-Koboma",      90, 60, 70, 140, 110, 120,    element.fire, element.dark, 1, 1);
BUILD_MONDEX_ARRAY("Dartarget",		45, 60, 40, 75, 50, 45,		element.dark, -1, 1, 1);
BUILD_MONDEX_ARRAY("",				45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);

BUILD_MONDEX_ARRAY("",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);

BUILD_MONDEX_ARRAY("",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
#endregion

#region Psuedo Legendaries + Whisps + Gods
BUILD_MONDEX_ARRAY("Urelia",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);

BUILD_MONDEX_ARRAY("Embud",			43, 9, 36, 94, 62, 98,			element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Embellia",		55, 10, 46, 138, 85, 133,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Kthuunevire",	70, 21, 56, 177, 110, 176,		element.fire, -1, 1, 1);

BUILD_MONDEX_ARRAY("",		45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);
#endregion

//BUILD_MONDEX_ARRAY("",	45, 60, 40, 75, 50, 45,		element.fire, -1, 1, 1);

//Load MonMae Monster Dex Data if we have it 
#region MonDex.ini Check / Load

if file_exists("mondex.ini"){

	//Loop through the default values and create a default file to load later (delete later)
	ini_open("default.ini");
	for (var o = 0; o < array_length(mondex); o++;){
		for (var i = 1; i < 10; i++;){
			ini_write_real("Monster_" + string(o), "Val" + string(i), mondex[o, i]);
			}
		ini_write_string("Monster_" + string(o), "Val" + string(0), mondex[o, 0]);
		ini_write_string("Monster_" + string(o), "Val" + string(11), mondex[o, 11]);
		ini_write_string("Monster_" + string(o), "Val" + string(12), mondex[o, 12]);
		}
	ini_close();
	}
#endregion


//Party and PC Data (variable)
globalvar monsters;
monsters = undefined;

enum party{
	number, level, exp, health, hp, atk, def, mgk_atk, mgk_def, spd, move1, move2, move3, move4,
	mana1, mana2, mana3, mana4, manapool, status, held_item, trainer, seed
	
	//if desired, you can include the following, "born" stats (aka "IV's" in Pokemon).
	//Simply uncomment the line below this one
	//born_atk, born_def, born_mgk_atk, born_mgk_def, born_spd,		//Delete the last comma on this line (After born_spd) if you're not using gender/nature
	
	//Same with these two
	//gender, nature, 
	}
//"Number" will point to an entry in the mondex array shown above for the mons base stats and other stuff

#region Initialize "monsters" and "eparty" arrays

var o = 0;
//Set default values for your monsters. 360 is equal to 12 PC boxes each holding 30 monsters, + 6 for your party. You may increase it if desired.
//Matching enumerator for this array is "party"
for (var i = 0; i < 366; i++;){
	monsters[i, o] = -1;	o++;		//Number (Monster)
	monsters[i, o] = 0;		o++;		//Current Level
	monsters[i, o] = 0;		o++;		//Current Experience (Max EXP will be calculated elsewhere)
	monsters[i, o] = 0;		o++;		//Current Health
	monsters[i, o] = 0;		o++;		//Health stat EV's
	monsters[i, o] = 0;		o++;		//Attack EV's to add to this monsters base attack (which is found in mondex)
	monsters[i, o] = 0;		o++;		//Defense EV's
	monsters[i, o] = 0;		o++;		//Magic Attack EV's
	monsters[i, o] = 0;		o++;		//Magic Defense EV's
	monsters[i, o] = 0;		o++;		//Speed EV's
	monsters[i, o] = -1		o++;		//First Move
	monsters[i, o] = -1;	o++;		//Second Move
	monsters[i, o] = -1;	o++;		//Third Move
	monsters[i, o] = -1;	o++;		//Fourth Move
	monsters[i, o] = -1;	o++;		//Mana 1st Move
	monsters[i, o] = -1;	o++;		//Mana 2nd Move
	monsters[i, o] = -1;	o++;		//Mana 3rd Move
	monsters[i, o] = -1;	o++;		//Mana 4th Move
	monsters[i, o] = 0;		o++;		//Manapool
	monsters[i, o] = -1;	o++;		//Current Status Alignment
	monsters[i, o] = -1;	o++;		//Held Item
	monsters[i, o] = "";	o++;		//Trainer Name
	monsters[i, o] = 0;		o++;		//Seed (Randomly generated)
	o = 0;
}

var o = 0;
//Repeat this step for the enemy party. No enemy trainer should have more than 6 monsters so we'll just do 6 loops.
globalvar eparty;
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
	o = 0;
	}
#endregion
	
//The enum helps us keep track of the monsters assigned in the DEX/MONDEX array, and allow us to
//type a name instead of a number to check this monsters DEX data (stats, movepool, etc)
}
function init_moves_data(){
globalvar movedex;
movedex = [];
enum move{		//This makes up all data for moves. For now, we can deal damage, heal, protect, use priority, flinch enemies, apply statuses, apply stat buffs/nerfs, require recharging, and/or access higher crit chance
	name, description, sprite, animation, power, healing, accuracy, element, type, mana, priority, chance_status, status, chance_flinch, flinch, hi_crit,
	chance_stat, atk, def, mgk_atk, mgk_def, spd, eva, acc, e_atk, e_def, e_mgk_atk, e_mgk_def, e_spd, e_eva, e_acc, protect, firstturn,
	recharge, onehitko, recoil, recoil_amnt, flat_dmg, flat_dmg_amnt
	}
enum move_ani{
	over_enemy, over_self, projectile, whole_room
	}
enum status{
	none, burn, poison, sleep, paralyze, confused
	}
enum type{
	physical, magical, support	
	}

//Populate the data for your moves. For Tackle and Scratch, nothing after PP is used, so we can leave it blank
//BUILD_MOVEDEX_ARRAY("Tackle",	"",		spr_impact_01,	30,	element.light,	type.physical,	100,	40);
//BUILD_MOVEDEX_ARRAY("Ember",	"",		spr_fireblast,	40,	element.fire,	type.magic,		95,		35,		move.chance1, 10, move.status, status.burn);

//Similarly to the monsters enumerator, this enumerator MUST match the order of the moves at which they are created 
//from using the "BUILD_MOVEDEX_ARRAY" script.
enum moves{

	clobber, glimmer, alarm, curl_up, cut, sharpen, swipe, protect, purify,
	blinding_light,
	
	twig_blade, healing_herbs, sticky_sap, leaf_spin,
	
	splash_bash, high_tide,
	
	sizzle, ignite, searing_claws, wildfire,
	
	static_shock, lightning, battery_bolt, overclock,
	
	swoop, talon_slash, beak_bomb, 
	
	quick_jab, combo_hit, heavy_swing, teardown,
	
	snicker, low_blow, sly_shot,
	
	ink_spray, plague,
	
	dragons_rage,
	
	peekaboo, simple_spell, sweet_song, heavy_heart
	}

#region Light Moves
BUILD_MOVEDEX_ARRAY("Clobber",	"Throws a hefty swing at the enemy",
	spr_impact_01,	40,	element.light,	type.physical,	95,		35);
BUILD_MOVEDEX_ARRAY("Glimmer",	"Channels magical power through their body, increasing magical attack",
	spr_impact_01,	-1,	element.light,	type.support,	-1,		30, move.chance_stat, 100, move.mgk_atk, 1);
BUILD_MOVEDEX_ARRAY("Alarm",	"An intense sonic boom rings out, reducing enemy defenses",
	spr_impact_01,	-1,	element.light,	type.support,	100,	40, move.chance_stat, 100, move.e_atk, -1);
BUILD_MOVEDEX_ARRAY("Curl up",	"Caster readies themself for oncoming attacks, boosting defense",
	spr_impact_01,	-1,	element.light,	type.support,	-1,		40, move.chance_stat, 100, move.atk, 1, move.def, 1);
BUILD_MOVEDEX_ARRAY("Cut",		"Lashes out and slashes the enemy, small chance to flinch",
	spr_slash_01,	30,	element.light,	type.physical,	100,	30, move.chance_flinch, 10);
BUILD_MOVEDEX_ARRAY("Sharpen",	"Caster gets ready for a deadly attack, raises physical attack ",
	spr_impact_01,	-1,	element.light,	type.support,	-1,		30, move.chance_stat, 100, move.atk, 1);
BUILD_MOVEDEX_ARRAY("Swipe",	"An ferrocious slash that could leave some fatally wounded",
	spr_impact_01,	60,	element.light,	type.physical,	100,	30);
BUILD_MOVEDEX_ARRAY("Protect",	"Guards from nearly all enemy attacks", spr_protect, -1,
	element.light,	type.support,	100,	15, move.protect, 1, move.priority, 1, move.animation, 1);
BUILD_MOVEDEX_ARRAY("Purify",	"Clears the users body of any negative afflictions",
	spr_impact_01,	-1,	element.light,	type.support,	100,	40);
BUILD_MOVEDEX_ARRAY("Blinding Light",	"A bright blast of light, may leave the enemy blinded, with lowered accuracy",
	spr_blast_01,	95,	element.light,	type.magical,	100,	15, move.chance_stat, 20, move.e_acc, -2);

#endregion

#region Grass Moves
BUILD_MOVEDEX_ARRAY("Twig Blade",	"Small, but pointy, it has a high chance of a critical hit",
	spr_impact_01,	40,	element.grass,	type.physical,	100,	40, move.hi_crit, 1);
BUILD_MOVEDEX_ARRAY("Healing Herbs",	"A blend of healthy herbs, it heals allies on the field",
	spr_impact_01,	-1,	element.grass,	type.support,	100,	40);
BUILD_MOVEDEX_ARRAY("Sticky Sap",	"Covers the enemy in sap, lowering their speed",
	spr_impact_01,	-1,	element.grass,	type.support,	100,	30, move.chance_stat, 100, move.e_spd, -2);
BUILD_MOVEDEX_ARRAY("Leaf Spin",	"Twirls a leaf, creating a sharp whirling blade",
	spr_impact_01,	60,	element.grass,	type.physical,	100,	25)
#endregion

#region Water Moves
BUILD_MOVEDEX_ARRAY("Splash Bash",	"A splash that packs a punch, may cause the enemy to flinch",
	spr_bubble_burst,	35,	element.water,	type.physical,	95,	30, move.chance_flinch, 20);
BUILD_MOVEDEX_ARRAY("High Tide",	"Floods the battlefield, increasing the speed of water element Dokimon",
	spr_bubble_burst,	-1,	element.water,	type.support,	100,	40, move.chance_stat, 100, move.spd, 2);
#endregion

#region Fire Moves
BUILD_MOVEDEX_ARRAY("Sizzle",	"A tiny fireball that singes the target, it may cause burn",
	spr_smolder,	-1,	element.fire,	type.physical,	100,	40);
BUILD_MOVEDEX_ARRAY("Ignite",	"Bursts the user's surroundings into flames, the opponent may catch on fire",
	spr_impact_01,	60,	element.fire,	type.magical,	100,	20, move.chance_status, 30, move.status, status.burn);
BUILD_MOVEDEX_ARRAY("Searing Claws",	"Launches an attack with strong, flaming claws. It may cause burn",
	spr_impact_01,	95,	element.fire,	type.physical,	95,		15, move.chance_status, 30, move.status, status.burn);
BUILD_MOVEDEX_ARRAY("Wildfire",	"A destructive wave of fire, the user takes recoil damage",
	spr_impact_01,	120,	element.fire,	type.magical,	100,	15, move.recoil, 1, move.recoil_amnt, 25);
#endregion

#region Electric Moves
BUILD_MOVEDEX_ARRAY("Static Shock",	"Shoots a small shock through their opponent, it may cause paralysis",
	spr_impact_01,	20,	element.electric,	type.magical,	100,	40, move.chance_status, 100, move.status, status.paralyze);
BUILD_MOVEDEX_ARRAY("Lightning",	"Zaps their opponent with electricity, it may cause paralysis",
	spr_impact_01,	50,	element.electric,	type.magical,	95,		40, move.chance_status, 10, move.status, status.paralyze);
BUILD_MOVEDEX_ARRAY("Battery Bolt",	"Blasts their opponent with a powerful charge, it may cause paralysis",
	spr_impact_01,	-1,	element.electric,	type.physical,	100,	40);
BUILD_MOVEDEX_ARRAY("Overclock ",	"Pushing its electric power past the limits, the user's magical attack sharply increases",
	spr_impact_01,	-1,	element.electric,	type.support,	100,	20, move.chance_stat, -1, move.mgk_atk, 2);
#endregion

#region Flying Moves
BUILD_MOVEDEX_ARRAY("Swoop",	"Swoops at the opponent, scratching them",
	spr_impact_01,	35,	element.flying,	type.physical,	100,	30);
BUILD_MOVEDEX_ARRAY("Talon Slash",	"Slices at the opponent with sharp claws",
	spr_impact_01,	60,	element.flying,	type.physical,	100,	20);
BUILD_MOVEDEX_ARRAY("Beak Bomb",	"Creates an explosive blast with their beak, it may cause burn",
	spr_impact_01,	80,	element.flying,	type.physical,	90,		10, move.chance_status, 30, move.status, status.burn);
#endregion

#region Fighting Moves
BUILD_MOVEDEX_ARRAY("Quick Jab",	"An agile attack at their opponent, it usually hits first",
	spr_impact_01,	50,	element.fight,		type.physical,	100,	30, move.priority, 1);
BUILD_MOVEDEX_ARRAY("Combo Hit",	"A flurry of quick punches, it hits 2-5 times",
	spr_impact_01,	15,	element.fight,		type.physical,	100,	20);
BUILD_MOVEDEX_ARRAY("Heavy Swing",	"A powerful blow, it leaves both fighters with weakened defense",
	spr_impact_01,	85,	element.fight,		type.physical,	100,	20, move.chance_stat, 100, move.def, -1, move.e_def, -1);
BUILD_MOVEDEX_ARRAY("Teardown",	"Destroying anything in their way, the user even attacks through protect",
	spr_impact_01,	65,	element.fight,		type.physical,	100,	25);
#endregion

#region Dark Moves
BUILD_MOVEDEX_ARRAY("Snicker",	"Smiles sinisterly, striking fear in their target. It harshly lowers the opponents attack",
	spr_impact_01,	20,	element.dark,		type.magical,	100,	25, move.chance_stat, 100, move.e_atk, -2);
BUILD_MOVEDEX_ARRAY("Low Blow",	"A shady attack is never expected. It has a chance to make the opponent flinch",
	spr_impact_01,	80,	element.dark,		type.physical,	100,	15, move.chance_flinch, 20);
BUILD_MOVEDEX_ARRAY("Sly Shot",	"Makes a sneak attack on their opponent, it has a high chance of a critical hit",
	spr_impact_01,	70,	element.dark,		type.physical,	100,	20, move.hi_crit, 1);
#endregion

#region Poison Moves
BUILD_MOVEDEX_ARRAY("Ink Spray",	"Blinds their opponent with ink, lowering their accuracy",
	spr_impact_01,	50,	element.poison,		type.magical,	70,		30, move.chance_stat, 40, move.e_acc, -1);
BUILD_MOVEDEX_ARRAY("Plague",	"A vile concoction, the user poison's their opponent",
	spr_impact_01,	-1,	element.poison,		type.support,	75,		30, move.chance_status, 100, move.status, status.poison);
#endregion

#region Dragon Moves
BUILD_MOVEDEX_ARRAY("Dragon Fire",	"Breathes the flames of a dragon, it may cause burn",
	spr_impact_01,	100,element.dragon,		type.magical,	85,	10, move.chance_status, 20, move.status, status.burn);
#endregion

#region Fairy Moves
BUILD_MOVEDEX_ARRAY("Peek-a-boo",	"An ancient technique, it usually hits first",
	spr_impact_01,	40,	element.fairy,		type.magical,	100,	30, move.priority, 1);
BUILD_MOVEDEX_ARRAY("Simple Spell",	"A simple spell, yet quite unbreakable",
	spr_impact_01,	50,	element.fairy,		type.magical,	100,	30);
BUILD_MOVEDEX_ARRAY("Sweet Song",	"Sings to their opponent with grace, it may leave them infatuated",
	spr_impact_01,	80,	element.fairy,		type.magical,	100,	15, move.chance_stat, 20, move.mgk_atk, 1);
BUILD_MOVEDEX_ARRAY("Heavy Heart",	"Slams their opponent with the weight of love",
	spr_impact_01,	90,	element.fairy,		type.physical,	100,	20);
#endregion

/*Copy and paste the below two lines and fill in the data to create new moves
BUILD_MOVEDEX_ARRAY("",	"",
	spr_impact_01,	-1,	element.fairy,		type.physical,	100,	40);
*/

}
function init_movepools(){
//Monsters possible moves and the levels at which they learn them
globalvar movepool;
movepool[0, 0] = undefined;

#region Monsters Enumerator Guide
/*Copy and pasted from "init_monster_data" so that you don't have to memorize your monsters names, can reference them from here

enum m{
	BURNSBY, FELT, BRAVEHEART, BULBAPOD, SCYTHERIN, SLYTHARAOT,
	SQUIBBLY, SQUIBBLY1, SQUIBBLY2, FURREAL, LEEKLOO, LEEKSWORD,
	NEKOSWORD, NEKOSWORD2, CARROTTI, KAKARATT, QUACKFIL, QUACKFEAR,
	CASPTER, DEATHSCYE, NIMBIS, LLOUDIOUS, CRESYL, CRESSENTIA,
	EMBUD, EMBELLIA, KTHUUNEVIRE, MOISEN, BIRZHEN, BUNDUST,
	JUSKITTEN, HARLEQUITTEN, NYAROLET, 
	FIREKITTY, FIRESTAND,
	HARACKER, HAREATE, SOUL, JISTERY,
	LOOMLEAK, MARILLO, LUNA, ECLIPSE,
	DARTARGET, URELIA, KINDLE, 
	EMBEROX, GLACEIA, FLUROX, BOLTRX, YOROX
	}*/
#endregion

#region Moves Enumerator Guide
	/*
	clobber, glimmer, alarm, curl_up, cut, sharpen, swipe, protect, purify,
	blinding_light,
	
	twig_blade, healing_herbs, sticky_sap, leaf_spin,
	
	splash_bash, high_tide,
	
	sizzle, ignite, searing_claws, wildfire,
	
	static_shock, lightning, battery_bolt, overclock,
	
	swoop, talon_slash, beak_bomb, 
	
	quick_jab, combo_hit, heavy_swing, teardown,
	
	snicker, low_blow, sly_shot,
	
	ink_spray, plague,
	
	dragons_rage,
	
	peekaboo, simple_spell, sweet_song, heavy_heart
	*/
#endregion

//Asign every monster an extremely basic movepool just so that no monsters have empty movepools. We will overwrite them manually below
for (var i = 0; i < array_length(monsters); i++;){
	BUILD_MONSTER_MOVEPOOL(i, moves.clobber, 1, moves.alarm, 4, moves.curl_up, 8, moves.protect, 11, moves.swipe, 15, moves.blinding_light, 20);
	}


//Assign monsters movepools based on the created moves above
BUILD_MONSTER_MOVEPOOL(m.FURREAL,	moves.clobber, 1, moves.twig_blade, 6, moves.sharpen, 9);
BUILD_MONSTER_MOVEPOOL(m.QUACKFIL,	moves.cut, 1, moves.sharpen, 4, moves.swoop, 9);
BUILD_MONSTER_MOVEPOOL(m.NEKOSWORD,	moves.cut, 1, moves.sharpen, 4, moves.peekaboo, 8);
BUILD_MONSTER_MOVEPOOL(m.CASPER,	moves.protect, 1, moves.snicker, 5, moves.alarm, 8);

//Copy and paste the line below to create new movepools for new monsters
//BUILD_MONSTER_MOVEPOOL(m., , );
}
function init_battle_data(){

globalvar priority;
enum _priority{
	def, plus_1, plus_2, plus_3, neg_1
	}
//Priority is used for moves that take speed priority. For example:
//Tackle has default priority, quick attack has +1, extreme speed has +2, and protect has +3

}


//Init all battle init scripts
function init_battles(){

battle_functions();
init_monster_data();
init_moves_data();
init_movepools();
init_battle_data();

}