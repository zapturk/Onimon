

//GMLive
function reload(){
	return 1;
	}
#macro RELOAD reload();
//#macro RELOAD if (live_call()) return live_result;

//Pixel Pope's Palette Swapper
#macro PALSWAP_INIT reload();
//#macro PALSWAP_INIT pal_swap_init_system(shd_pal_swapper);


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


#region General Init

globalvar pause, debug;
pause = 0;
debug = -1;

globalvar CAPS_LOCKED;
CAPS_LOCKED = 0;

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


//Initialize quests
globalvar quest;

//Write how many quests your game will have. Quests not started should be "-1"
var quest_count = 10;
for (var i = 0; i <quest_count; i++;){
	quest[i] = -1;
	}
	
//Start the Main Quest "quest[0]" by setting it to 0.
quest[0] = 0;

//Use an enumerator to keep track of what quests are stored in our "quest[]" array
enum _quest{
	main, coupons
	}

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
	name, health, atk, def, mgk_atk, mgk_def, spd, element1, element2, ability, cap_rate, sub_descrip, descrip, evolve
	//if desired, you can also include these:
	//weight, height, cry, artist, designer, etc
	}
enum element{
	fire, grass, water, electric, dark, light, flying, fight, poison, dragon, fairy, ghost, ice
	}

//Input your monsters base statistics
//Tutorial video: https://www.youtube.com/watch?v=sdfgsdf

//Order of monster name enumerators must match the order at which the monsters are assigned below
//In example, if your enum is Charmander, Charmeleon, Charizard, then Charmader must be the first
//Monster you create using the "BUILD_MONDEX_ARRAY", and Charizard must be the third (and etc)

#region Starters
//Fire Starter
BUILD_MONDEX_ARRAY("Burnsby",		74, 18, 53, 88, 40, 71,			element.fire, -1, 1, 1, "Teddy Bear Dokimon", "It's said they often hide amongst other plushies in hopes to torch unsuspecting prey that might pass by.");
BUILD_MONDEX_ARRAY("Felt",			95, 14, 66, 110, 52, 89,		element.fire, -1, 1, 1);
BUILD_MONDEX_ARRAY("Braveheart",	117, 18, 79, 144, 64, 108,		element.fire, -1, -1, 1);

//Grass Starter
BUILD_MONDEX_ARRAY("Bulbapod",		45, 60, 40, 70, 50, 45,		element.grass, -1, 1, 1);
BUILD_MONDEX_ARRAY("Scytherin",		45, 60, 40, 70, 50, 45,		element.grass, -1, 1, 1);
BUILD_MONDEX_ARRAY("Slytharot",		45, 60, 40, 70, 50, 45,		element.grass, -1, -1, 1);

//Water Starter
BUILD_MONDEX_ARRAY("Squibbly",		79, 65, 80, 29, 45, 44,		element.water, -1, 1, 1);
BUILD_MONDEX_ARRAY("Squibbly",		97, 80, 94, 38, 58, 56,		element.water, -1, 1, 1);
BUILD_MONDEX_ARRAY("Squibbly",		122, 106, 115, 42, 70, 68,	element.water, -1, -1, 1);
#endregion

#region 1st Row of Monsters
BUILD_MONDEX_ARRAY("Furreal",		23, 67, 48, 32, 51, 80,			element.light, -1, 1, 1, "Troublemaker Dokimon", "Never seen alone, these lively little Dokimon are always causing trouble for people.");
BUILD_MONDEX_ARRAY("Jolleek",		33, 80, 64, 42, 61, 101,		element.light, -1, 1, 1, "Babysitter Dokimon", "The leaders of the group, and the only ones that can keep furreal in line. They take pride in being role models.");
BUILD_MONDEX_ARRAY("Leeksword",		50, 104, 87, 58, 88, 135,		element.light, element.dark, -1, 1, "Ferocious Dokimon", "Violent and filled with rage, some people claim they are controlled by dark spirits.");

BUILD_MONDEX_ARRAY("Whispurr",		32, 14, 38, 100, 74, 102,		element.fairy, -1, 1, 1, "Apprentice Dokimon", "Its sword is its greatest prize. It spends most of its time keeping the blade in tip top shape.");
BUILD_MONDEX_ARRAY("Excalifurr",	45, 16, 48, 147, 94, 133,		element.fairy, -1, -1, 1, "Hero Dokimon", "When it's done with fighting, it will pass on its skills on to a young Whispurr it deems worthy.");

BUILD_MONDEX_ARRAY("Carrotti",		41, 60, 67, 24, 48, 62,		element.grass, -1, 1, 1, "Sprout Dokimon", "Born with a stem to gather nutrients, it hibernates in soil until it has grown enough to evolve.");
BUILD_MONDEX_ARRAY("Kakaratt",		59, 78, 88, 34, 62, 81,		element.grass, element.dark, -1, 1, "Shuriken Dokimon", "It is able to spin at rapid speeds without making a noise. Its blades are so sharp they can even cut through steel.");

BUILD_MONDEX_ARRAY("Quackfil",		45, 60, 40, 70, 50, 45,		element.dark, -1, 1, 1, "Proud Dokimon", "It has a bossy nature, and has even been known to pick on its own trainer if displeased.");
BUILD_MONDEX_ARRAY("Quackfear",		45, 60, 40, 70, 50, 45,		element.dark, -1, -1, 1, "Arrogant Dokimon", "The bully of the forest, it often forces weaker Dokimon to work as its henchmen.");
#endregion

#region 2nd Row of Monsters
BUILD_MONDEX_ARRAY("Casper",		26, 7, 37, 96, 59, 78,		element.dark, -1, 1, 1, "Reaper Dokimon", "It's common for children to be told that if they don't behave, a Casper will kidnap them in the night.");
BUILD_MONDEX_ARRAY("Deathscye",		35, 17, 46, 121, 82, 106,	element.dark, -1, -1, 1, "Scythe Dokimon", "An old nursery rhyme says that if you feel a sharp chill,", "it means you are being stalked by a Deathscye.");

BUILD_MONDEX_ARRAY("Nimbis",		45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1, "Glowing Dokimon", "Its wool glows at night,", "making it a popular material for artisans.");
BUILD_MONDEX_ARRAY("Lloudious",		45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1);

BUILD_MONDEX_ARRAY("Pheonix",		45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1);
BUILD_MONDEX_ARRAY("Lucifeather",	45, 60, 40, 75, 50, 45,		element.light, -1, 1, 1);

BUILD_MONDEX_ARRAY("Flounder",	44, 74, 22, 53, 22, 66,			element.flying, element.poison, 1, 1);
BUILD_MONDEX_ARRAY("Mudslip",	62, 103, 34, 85, 32, 106,		element.flying, element.poison, 1, 1);
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
	
	//Create the max limit of monsters we can have before filling in the information from our ini save file
	for (var o = 0; o < 366; o++;){
		for (var i = 1; i < 10; i++;){
			mondex[o, i] = 0;
			}
		mondex[o, 0]	 = "Mon Name";
		mondex[o, 11]	 = "Sub Descr"
		mondex[o, 12]	 = "Description";
		}

	//Loop through the default values and create a default file to load later (delete later)
	ini_open("mondex.ini");
	for (var o = 0; o < array_length(mondex); o++;){
		for (var i = 1; i < 10; i++;){
			mondex[o, i] = ini_read_real("Monster_" + string(o), "Val" + string(i), 0);
			}
		mondex[o, 0] = ini_read_string("Monster_" + string(o), "Val" + string(0), "");
		mondex[o, 11] = ini_read_string("Monster_" + string(o), "Val" + string(11), "");
		mondex[o, 12] = ini_read_string("Monster_" + string(o), "Val" + string(12), "");
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
	LIGHT_1, LIGHT_2, LIGHT_3, LIGHT_4, LIGHT_5, LIGHT_6, LIGHT_7, LIGHT_8, LIGHT_9, LIGHT_10, LIGHT_11, LIGHT_12, LIGHT_13, LIGHT_14, LIGHT_15, LIGHT_16, LIGHT_17, LIGHT_18,
	GRASS_1, GRASS_2, GRASS_3, GRASS_4, GRASS_5, GRASS_6, GRASS_7, GRASS_8, GRASS_9, GRASS_10, 
	WATER_1, WATER_2, WATER_3, WATER_4, WATER_5, WATER_6, WATER_7, WATER_8, 
	FIRE_1, FIRE_2, FIRE_3, FIRE_4, FIRE_5, FIRE_6, 
	ELECTR_1, ELECTR_2, ELECTR_3, ELECTR_4, ELECTR_5, ELECTR_6, ELECTR_7, 
	FLYING_1, FLYING_2, FLYING_3, FLYING_4, FLYING_5, FLYING_6, FLYING_7, 
	FIGHTN_1, FIGHTN_2, FIGHTN_3, FIGHTN_4, FIGHTN_5, FIGHTN_6,
	DARK_1, DARK_2, DARK_3, DARK_4, DARK_5, DARK_6, DARK_7, DARK_8, DARK_9, DARK_10,
	POISON_1, POISON_2, POISON_3, POISON_4, POISON_5, POISON_6, POISON_7,
	DRAGON_1, DRAGON_2, DRAGON_3, DRAGON_4, DRAGON_5, DRAGON_6,
	FAIRY_1, FAIRY_2, FAIRY_3, FAIRY_4
	}

#region Light Moves

/*1*/BUILD_MOVEDEX_ARRAY("Clobber",	"Throws a hefty swing at the enemy",
mov_impact_01,	40,	element.light,	type.physical,	95,		35);
/*2*/BUILD_MOVEDEX_ARRAY("Glimmer",	"Channels magical power through their body, increasing magical attack",
mov_impact_01,	-1,	element.light,	type.support,	-1,		30, move.chance_stat, 100, move.mgk_atk, 1);
/*3*/BUILD_MOVEDEX_ARRAY("Alarm",	"An intense sonic boom rings out, reducing enemy defenses",
mov_impact_01,	-1,	element.light,	type.support,	100,	40, move.chance_stat, 100, move.e_atk, -1);
/*4*/BUILD_MOVEDEX_ARRAY("Curl up",	"Caster readies themself for oncoming attacks, boosting defense",
mov_impact_01,	-1,	element.light,	type.support,	-1,		40, move.chance_stat, 100, move.atk, 1, move.def, 1);
/*5*/BUILD_MOVEDEX_ARRAY("Cut",		"Lashes out and slashes the enemy, small chance to flinch",
mov_slash_01,	30,	element.light,	type.physical,	100,	30, move.chance_flinch, 10);
/*6*/BUILD_MOVEDEX_ARRAY("Sharpen",	"Caster gets ready for a deadly attack, raises physical attack ",
mov_impact_01,	-1,	element.light,	type.support,	-1,		30, move.chance_stat, 100, move.atk, 1);
/*7*/BUILD_MOVEDEX_ARRAY("Swipe",	"An ferrocious slash that could leave some fatally wounded",
mov_impact_01,	60,	element.light,	type.physical,	100,	30);
/*8*/BUILD_MOVEDEX_ARRAY("Protect",	"Guards from nearly all enemy attacks",
mov_protect, -1, element.light,	type.support,	100,	15, move.protect, 1, move.priority, 1, move.animation, 1);
/*9*/BUILD_MOVEDEX_ARRAY("Purify",	"Clears the users body of any negative afflictions",
mov_impact_01,	-1,	element.light,	type.support,	100,	40);
/*10*/BUILD_MOVEDEX_ARRAY("Blinding Light",	"A bright blast of light, may leave the enemy blinded, with lowered accuracy",
mov_blast_01,	95,	element.light,	type.magical,	100,	15, move.chance_stat, 20, move.e_acc, -2);
/*11*/BUILD_MOVEDEX_ARRAY("Surprise Attack", "Getting the jump on the enemy, it causes flinch. Only usable on the user's first turn.",
mov_impact_01, 40, element.light, type.physical, 100, 40);
/*12*/BUILD_MOVEDEX_ARRAY("Juggle", "A fun trick turned into a capable attack. Power doubles with a held item.",
mov_impact_01, 40, element.light, type.physical, 100, 40);
/*13*/BUILD_MOVEDEX_ARRAY("Bright Claws", "A flurry of flashy slashes.",
mov_impact_01, 40, element.light, type.physical, 100, 40);
/*14*/BUILD_MOVEDEX_ARRAY("Stampede", "Bulldozes anything in their path, it raises the user's speed.",
mov_impact_01, 40, element.light, type.physical, 100, 40);
/*15*/BUILD_MOVEDEX_ARRAY("X-Slash", "Sharp! This attack does double damage for Dokimon with claws and blades",
mov_impact_01, 75, element.light, type.physical, 90, 15);
/*16*/BUILD_MOVEDEX_ARRAY("Smoke Bomb", "A clever distraction, the user swaps out with a party member",
mov_impact_01, 75, element.light, type.support, 70, 15);
/*17*/BUILD_MOVEDEX_ARRAY("Pep Talk", "Psychs themself up for battle, the user's next attack is super effective",
mov_impact_01, 75, element.light, type.support, 70, 15);
/*18*/BUILD_MOVEDEX_ARRAY("Sword Slash", "Simple to learn, near impossible to master.",
mov_impact_01, 75, element.light, type.physical, 90, 15);

#endregion

#region Grass Moves
/*1*/BUILD_MOVEDEX_ARRAY("Twig Blade",	"Small, but pointy, it has a high chance of a critical hit",
mov_grass_strike,40,element.grass,	type.physical,	100,	40, move.hi_crit, 1);
/*2*/BUILD_MOVEDEX_ARRAY("Healing Herbs",	"A blend of healthy herbs, it heals allies on the field",
mov_impact_01,	-1,	element.grass,	type.support,	100,	40);
/*3*/BUILD_MOVEDEX_ARRAY("Sticky Sap",	"Covers the enemy in sap, lowering their speed",
mov_impact_01,	-1,	element.grass,	type.support,	100,	30, move.chance_stat, 100, move.e_spd, -2);
/*4*/BUILD_MOVEDEX_ARRAY("Leaf Spin",	"Twirls a leaf, creating a sharp whirling blade",
mov_impact_01,	60,	element.grass,	type.physical,	100,	25)

//May need editing
/*5*/BUILD_MOVEDEX_ARRAY("Crush Root", "Smashes the enemy with a robust root",
mov_impact_01, 75, element.grass, type.physical, 95, 15);
/*6*/BUILD_MOVEDEX_ARRAY("Vine Snare", "Entangles the enemy in tight vines, it hurts the enemy each turn",
mov_impact_01, 75, element.grass, type.physical, 90, 15);
/*7*/BUILD_MOVEDEX_ARRAY("Shroom Shield", "A fungus defense, if attack it will put the enemy to sleep",
mov_impact_01, 75, element.grass, type.magical, 95, 15);
/*8*/BUILD_MOVEDEX_ARRAY("Seed Sling", "Shoots sharp seeds at the enemy, it hits 2-5 times",
mov_impact_01, 75, element.grass, type.physical, 85, 75);
/*9*/BUILD_MOVEDEX_ARRAY("Thorn Slice", "Sharp as a sword, with a toxic tip. It may poison the enemy",
mov_impact_01, 75, element.grass, type.physical, 90, 15);
/*10*/BUILD_MOVEDEX_ARRAY("Grass Scythe", "The finest blade found in nature, it has a high chance of a critical hit",
mov_impact_01, 75, element.grass, type.physical, 95, 15);

#endregion

#region Water Moves
/*1*/BUILD_MOVEDEX_ARRAY("Splash Bash",	"A splash that packs a punch, may cause the enemy to flinch",
mov_bubble_burst,	35,	element.water,	type.physical,	95,	30, move.chance_flinch, 20);
/*2*/BUILD_MOVEDEX_ARRAY("High Tide",	"Floods the battlefield, increasing the speed of water element Dokimon",
mov_bubble_burst,	-1,	element.water,	type.support,	100,	40, move.chance_stat, 100, move.spd, 2);

//May need editing
/*3*/BUILD_MOVEDEX_ARRAY("Anchor Bash", "A smash of sunken strength, it may cause the enemy to flinch",
mov_impact_01, 75, element.water, type.physical, 90, 15);
/*4*/BUILD_MOVEDEX_ARRAY("Sea Salts", "Throws a pinch of sea salts into the enemy's eyes, lowering accuracy.",
mov_impact_01, 75, element.water, type.magical, 85, 15);
/*5*/BUILD_MOVEDEX_ARRAY("Rain Rush", "A slippery sprint to the enemy, it usually goes first",
mov_impact_01, 75, element.water, type.physical, 95, 15);
/*6*/BUILD_MOVEDEX_ARRAY("Still Waters", "Channels the calmness of water, before an unleashing a forceful wave",
mov_impact_01, 75, element.water, type.magical, 90, 15);
/*7*/BUILD_MOVEDEX_ARRAY("Submarine", "Delves under the surface, before springing up into an attack the next turn",
mov_impact_01, 75, element.water, type.physical, 90, 15);
/*8*/BUILD_MOVEDEX_ARRAY("Cannonball", "Slams the enemy with oceanic power, the user takes recoil damage",
mov_impact_01, 75, element.water, type.physical, 95, 15);

#endregion

#region Fire Moves
/*1*/BUILD_MOVEDEX_ARRAY("Sizzle",	"A tiny fireball that singes the target, it may cause burn",
mov_smolder,	-1,	element.fire,	type.physical,	100,	40);
/*2*/BUILD_MOVEDEX_ARRAY("Ignite",	"Bursts the user's surroundings into flames, the opponent may catch on fire",
mov_impact_01,	60,	element.fire,	type.magical,	100,	20, move.chance_status, 30, move.status, status.burn);
/*3*/BUILD_MOVEDEX_ARRAY("Searing Claws",	"Launches an attack with strong, flaming claws. It may cause burn",
mov_impact_01,	95,	element.fire,	type.physical,	95,		15, move.chance_status, 30, move.status, status.burn);
/*4*/BUILD_MOVEDEX_ARRAY("Wildfire",	"A destructive wave of fire, the user takes recoil damage",
mov_fireblast,	120,	element.fire,	type.magical,	100,	15, move.recoil, 1, move.recoil_amnt, 25);

//May need Editing
/*5*/BUILD_MOVEDEX_ARRAY("Rocket Burst", "Launches forward with blazing boosters, it usually goes first",
mov_impact_01, 75, element.fire, type.physical, 95, 15);
/*6*/BUILD_MOVEDEX_ARRAY("Fireball", "A barrage of burning balls of fire. Hits 2-5 times",
mov_impact_01, 75, element.fire, type.magical, 85, 15);

#endregion

#region Electric Moves
/*1*/BUILD_MOVEDEX_ARRAY("Static Shock",	"Shoots a small shock through their opponent, it may cause paralysis",
mov_impact_01,	20,	element.electric,	type.magical,	100,	40, move.chance_status, 100, move.status, status.paralyze);
/*2*/BUILD_MOVEDEX_ARRAY("Lightning",	"Zaps their opponent with electricity, it may cause paralysis",
mov_impact_01,	50,	element.electric,	type.magical,	95,		40, move.chance_status, 10, move.status, status.paralyze);
/*3*/BUILD_MOVEDEX_ARRAY("Battery Bolt",	"Blasts their opponent with a powerful charge, it may cause paralysis",
mov_impact_01,	-1,	element.electric,	type.physical,	100,	40);
/*4*/BUILD_MOVEDEX_ARRAY("Overclock ",	"Pushing its electric power past the limits, the user's magical attack sharply increases",
mov_impact_01,	-1,	element.electric,	type.support,	100,	20, move.chance_stat, -1, move.mgk_atk, 2);

//May need editing
/*5*/BUILD_MOVEDEX_ARRAY("Light Lasso", "Ties the enemy with binding energy, it may cause paralysis.",
mov_impact_01, 40, element.electric, type.physical, 100, 40);
/*6*/BUILD_MOVEDEX_ARRAY("Charge Cannon", "Stores up electricity, then unleashes it the next turn",
mov_impact_01, 75, element.electric, type.magical, 90, 15);
/*7*/BUILD_MOVEDEX_ARRAY("Overclock", "Pushing its electric power past the limits, the user's magical attack sharply increases",
mov_impact_01, 75, element.electric, type.magical, 90, 15);

#endregion

#region Flying Moves
/*1*/BUILD_MOVEDEX_ARRAY("Swoop",	"Swoops at the opponent, scratching them",
mov_impact_01,	35,	element.flying,	type.physical,	100,	30);
/*2*/BUILD_MOVEDEX_ARRAY("Talon Slash",	"Slices at the opponent with sharp claws",
mov_impact_01,	60,	element.flying,	type.physical,	100,	20);
/*3*/BUILD_MOVEDEX_ARRAY("Beak Bomb",	"Creates an explosive blast with their beak, it may cause burn",
mov_impact_01,	80,	element.flying,	type.physical,	90,		10, move.chance_status, 30, move.status, status.burn);

//May need editing
/*4*/BUILD_MOVEDEX_ARRAY("Early Bird", "Plucks the enemy. It can only be used on the user's first turn, and always goes first",
mov_impact_01, 75, element.flying, type.physical, 95, 15);
/*5*/BUILD_MOVEDEX_ARRAY("Flurry Wind", "Casts gusts of wind at the enemy. Hits 2-5 times",
mov_impact_01, 75, element.flying, type.physical, 85, 15);
/*6*/BUILD_MOVEDEX_ARRAY("Sky Dance", "Disappears into the clouds, then dives at the enemy the next turn",
mov_impact_01, 75, element.flying, type.physical, 90, 15);
/*7*/BUILD_MOVEDEX_ARRAY("Feather Fan", "Slashes the enemy with sharpened feathers. It has a high chance of a critical hit",
mov_impact_01, 75, element.flying, type.physical, 95, 15);

#endregion

#region Fighting Moves
/*1*/BUILD_MOVEDEX_ARRAY("Quick Jab",	"An agile attack at their opponent, it usually hits first",
mov_impact_01,	50,	element.fight,		type.physical,	100,	30, move.priority, 1);
/*2*/BUILD_MOVEDEX_ARRAY("Combo Hit",	"A flurry of quick punches, it hits 2-5 times",
mov_impact_01,	15,	element.fight,		type.physical,	100,	20);
/*3*/BUILD_MOVEDEX_ARRAY("Heavy Swing",	"A powerful blow, it leaves both fighters with weakened defense",
mov_impact_01,	85,	element.fight,		type.physical,	100,	20, move.chance_stat, 100, move.def, -1, move.e_def, -1);
/*4*/BUILD_MOVEDEX_ARRAY("Teardown",	"Destroying anything in their way, the user even attacks through protect",
mov_impact_01,	65,	element.fight,		type.physical,	100,	25);

//May need editing
/*5*/BUILD_MOVEDEX_ARRAY("Mighty Mash", "A heroic show of strength, worthy of a protagonist. It may raise the user's attack.",
mov_impact_01, 40, element.fight, type.physical, 100, 40);
/*6*/BUILD_MOVEDEX_ARRAY("Double Cross", "Back to back swipes at the enemy. Hits twice",
mov_impact_01, 75, element.fight, type.physical, 90, 15);
#endregion

#region Dark Moves
/*1*/BUILD_MOVEDEX_ARRAY("Snicker",	"Smiles sinisterly, striking fear in their target. It harshly lowers the opponents attack",
mov_impact_01,	20,	element.dark,		type.magical,	100,	25, move.chance_stat, 100, move.e_atk, -2);
/*2*/BUILD_MOVEDEX_ARRAY("Low Blow",	"A shady attack is never expected. It has a chance to make the opponent flinch",
mov_impact_01,	80,	element.dark,		type.physical,	100,	15, move.chance_flinch, 20);
/*3*/BUILD_MOVEDEX_ARRAY("Sly Shot",	"Makes a sneak attack on their opponent, it has a high chance of a critical hit",
mov_impact_01,	70,	element.dark,		type.physical,	100,	20, move.hi_crit, 1);

//May need editing
/*4*/BUILD_MOVEDEX_ARRAY("First Blow", "An often decisive first strike. It can only be used on the user's first turn",
mov_impact_01, 75, element.dark, type.physical, 95, 15);
/*5*/BUILD_MOVEDEX_ARRAY("Shadow Box", "What's scarier than a fist? A fist you can't see. Super effective against fighting type",
mov_impact_01, 75, element.dark, type.physical, 90, 15);
/*6*/BUILD_MOVEDEX_ARRAY("Hijinx", "A cheeky trick, the user swaps a random stat with their opponent",
mov_impact_01, 75, element.dark, type.support, 70, 15);
/*7*/BUILD_MOVEDEX_ARRAY("Tail Trap", "Creates a tripwire with their tail, the opponent gets trapped in battle",
mov_impact_01, 75, element.dark, type.support, 70, 15);
/*8*/BUILD_MOVEDEX_ARRAY("Dark Bond", "Connects their fate to the opponent, reflecting any damage they take that turn",
mov_impact_01, 75, element.dark, type.support, 70, 15);
/*9*/BUILD_MOVEDEX_ARRAY("Dark Toll", "Sealing the enemy's fate, they will faint after 3 turns, unless swapped out",
mov_impact_01, 75, element.dark, type.magical, 85, 15);
/*10*/BUILD_MOVEDEX_ARRAY("Surprise Attack", "Getting the jump on the enemy, it causes flinch. Only usable on the user's first turn.",
mov_impact_01, 40, element.dark, type.physical, 100, 40);
#endregion

#region Poison Moves
/*1*/BUILD_MOVEDEX_ARRAY("Ink Spray",	"Blinds their opponent with ink, lowering their accuracy",
mov_impact_01,	50,	element.poison,		type.magical,	70,		30, move.chance_stat, 40, move.e_acc, -1);
/*2*/BUILD_MOVEDEX_ARRAY("Plague",	"A vile concoction, the user poison's their opponent",
mov_impact_01,	-1,	element.poison,		type.support,	75,		30, move.chance_status, 100, move.status, status.poison);


//May need Editing from this point on
/**/BUILD_MOVEDEX_ARRAY("Furball", "Ewww. It may lower the enemy's speed.",
mov_impact_01, 40, element.poison, type.physical, 100, 40);
/*3*/BUILD_MOVEDEX_ARRAY("Toxic Maw", "A vile bite, oozing with poison. It may cause poison",
mov_impact_01, 75, element.poison, type.physical, 90, 15);
/*4*/BUILD_MOVEDEX_ARRAY("Corrosion", "Dissolves it's defenses. Sharply increases attack.",
mov_impact_01, 75, element.poison, type.magical, 85, 15);
/*5*/BUILD_MOVEDEX_ARRAY("Poison Puff", "A breath of toxic fumes, it may cause poison",
mov_impact_01, 75, element.poison, type.magical, 85, 15);
/*6*/BUILD_MOVEDEX_ARRAY("Poison Darts", "Shoots dangerous darts at the enemy. Hits 2-5 times. It may cause poison",
mov_impact_01, 75, element.poison, type.magical, 85, 15);
/*7*/BUILD_MOVEDEX_ARRAY("Acid Storm", "Rain's poison on their opponent, it leaves the battlefield covered in acid",
mov_impact_01, 75, element.poison, type.magical, 85, 15);

#endregion

#region Dragon Moves
/*01*/ BUILD_MOVEDEX_ARRAY("Dragon Fire",	"Breathes the flames of a dragon, it may cause burn",
mov_impact_01,	100,element.dragon,		type.magical,	85,	10, move.chance_status, 20, move.status, status.burn);

//May need Editing
/*2*/ BUILD_MOVEDEX_ARRAY("Sharp Scale", "A dragon's scales are used for many things, including slashing.",
mov_impact_01, 75, element.dragon, type.physical, 90, 15);
/*3*/ BUILD_MOVEDEX_ARRAY("Draco Jaw", "Snaps at the enemy with its mighty fangs.",
mov_impact_01, 75, element.dragon, type.physical, 90, 15);
/*4*/ BUILD_MOVEDEX_ARRAY("Dragon Greed", "Always after gold, the user steals from the enemy",
mov_impact_01, 75, element.dragon, type.support, 70, 15);
/*5*/ BUILD_MOVEDEX_ARRAY("Fierce Gaze", "Strikes fear into the enemy, lowering attack and defense, but raising speed",
mov_impact_01, 75, element.dragon, type.support, 70, 15);
/*6*/ BUILD_MOVEDEX_ARRAY("Hydra Blast", "The user attacks last. If damaged, the move hits twice",
mov_impact_01, 75, element.dragon, type.magical, 85, 15);

#endregion

#region Fairy Moves
/*1*/BUILD_MOVEDEX_ARRAY("Peek-a-boo",	"An ancient technique, it usually hits first",
mov_impact_01,	40,	element.fairy,		type.magical,	100,	30, move.priority, 1);
/*2*/BUILD_MOVEDEX_ARRAY("Simple Spell",	"A simple spell, yet quite unbreakable",
mov_impact_01,	50,	element.fairy,		type.magical,	100,	30);
/*3*/BUILD_MOVEDEX_ARRAY("Sweet Song",	"Sings to their opponent with grace, it may leave them infatuated",
mov_impact_01,	80,	element.fairy,		type.magical,	100,	15, move.chance_stat, 20, move.mgk_atk, 1);
/*4*/BUILD_MOVEDEX_ARRAY("Heavy Heart",	"Slams their opponent with the weight of love",
mov_impact_01,	90,	element.fairy,		type.physical,	100,	20);
#endregion


#region Movedex.ini Check / Load

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

//Asign every monster an extremely basic movepool just so that no monsters have empty movepools. We will overwrite them manually below, in the assign_movepools script
for (var i = 0; i < array_length(monsters); i++;){
	BUILD_MONSTER_MOVEPOOL(i, moves.LIGHT_1, 1, moves.LIGHT_3, 4, moves.LIGHT_4, 8, moves.LIGHT_8, 11, moves.LIGHT_7, 15, moves.LIGHT_10, 20);
	}

//Non-visual Editor movepool assignment
assign_movepools();

#region Movepools.ini Check / Load

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
#endregion


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