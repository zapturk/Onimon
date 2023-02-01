
//Runs once each save, after professor dialogue (this is ignored if your game has a save file, and, game auto-saves after professor prologue)
function start_game(){

//This script runs directly after finishing the professor intro prologue, and sets the starting position of your player one time only
//at the beginning of the game. So please write where you would like your character to spawn here

//Assign the starting positions of your player, and write the name of your starting area.
curr_rm = rm_primeTownHouses;
area = "Prime Town";
start_x = 112;
start_y = 112;


//Assign the starter monster for your player (more advanced starter selection options coming ASAP)
ADD_A_MONSTER(m.MONSTER_13, 5);

//Want your players to start with more than one starter? Uncomment the lines below
//ADD_A_MONSTER(m.MONSTER_10, 50);

//OR copy and paste this line and add whatever monster you want! (Make sure to give them a level too :))
//ADD_A_MONSTER();

//Save the game to create your save, and save the variables you just assigned above
save();

//Go to the starting room to start the game
room_goto(curr_rm);

}

//Allows you to ovewride your save and spawn in new areas, add monsters to your party, show the grid or collision masks, and so on.
function debug_settings(){

//If you want to skip the initial check, set this to 0. You can also set it to -1 to skip all screens before the gameplay

//Key: 0 == skip to splash; 1 == show selection screen in rm_setup; 2 == skip straight to room written below
var RUN_VISUAL_EDITOR_CHECK = 2;

if room == rm_setup{
	if RUN_VISUAL_EDITOR_CHECK < 2 return RUN_VISUAL_EDITOR_CHECK;
	}


//If you set the variable above to 2, we will overwide the save, and skip straight to the room and coordinates below
//Set your players starting position

//curr_rm = rm_worldmap;
//area = "Littlewood";
//start_x = 400;
//start_y = 352;

//Add a new monster to your players party. (NOTE, if you save in-game after this script runs and then launch again, you
//will get duplicate monsters, so if you want to avoid that, either don't save, or comment out the monster below before
//running your game again).

//ADD_A_MONSTER(m.STARTER_1, 5);
//ADD_A_MONSTER(m.STARTER_4, 5);
//ADD_A_MONSTER(m.STARTER_7, 5);
//ADD_A_MONSTER(m.MONSTER_13, 5);

return RUN_VISUAL_EDITOR_CHECK;

}



//Assign safe areas that you can heal and access PC in
function safe_areas(){
	//Assign your safe areas. These are the areas in which monster will automatically heal, and you'll be able
	//to change your monsters moves, or check your PC in. We don't want to allow this in routes because that would
	//make the game too easy, but of course there are exceptions, and you may allow it if you please too of course

	//How it works
	//Returns 0 (or FALSE) if we're in a combatant area
	//Returns 1 (or TRUE) if we're in a non-combatant area. 
	
	//Add your areas to the "case _area.lilly: line", please watch the YouTube tutorial for this if you need more guidance

	switch (area){
		case "Lillywood":	
		case "New Town":
		case "Prime Town":
			return 1;
		
		default: return 0;
		}
	}

//Customize player movement type and movement speeds (this is ignored if you made changes in the visual editor)
function setup_player(){

//Walking Options
//Assign the speeds at which your players move at
//For grid based movement, these MUST BE a whole number (an integer)

//Is overwritten if we have a save file from the visual editor
playable_character = 0;		//Default: 0
walk_spd	= 1;			//Default: 1
run_spd		= 2;			//Default: 2

//Load save files
if file_exists("player_setup.ini"){
	
	ini_open("player_setup.ini");
	
	playable_character =			ini_read_real("Playable Character", "Num", playable_character);
	
	run_anim_spd =					ini_read_real("Animation Speeds", "Run Speed", run_anim_spd);
	walk_anim_spd =					ini_read_real("Animation Speeds", "Walk Speed", walk_anim_spd);
	ini_close();
	}

//Grid Options
//True to have grid based movement (like pokemon), false to have free movement (like zelda)
//If you have grid based movement, set the distance in pixels for how far the player should move

grid_based	= true;		//Default: true
grid_size	= 16;		//Default: 16

//Experimental
//Buttery smooth movement for free movement (has no effect on grid based movement).
//Stops players from getting stuck on small corners while walking around

buttery_smooth = 0;		//Default: 0

//Overwrite with player visual editor data (if we have it)

}

