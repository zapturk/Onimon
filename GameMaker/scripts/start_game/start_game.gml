
//Runs once each save, after professor dialogue (this is ignored if your game has a save file, and, game auto-saves after professor prologue)
function start_game(){
//This script runs directly after finishing the professor intro prologue, and sets the starting position of your player one time only
//at the beginning of the game. So please write where you would like your character to spawn here

//Assign the starting positions of your player, and write the name of your starting area.
curr_rm = rm_primeTownHouses;
area = "Prime Town";
px = 112;
py = 112;


//Don't edit these
start_x = px;
start_y = py;

//Assign the starter monster for your player (more advanced starter selection options coming ASAP)
ADD_A_MONSTER(m.NEKOSWORD, 100);

//Want your players to start with more than one starter? Uncomment the lines below
//ADD_A_MONSTER(m.XKOBOMA, 50);

//OR copy and paste this line and add whatever monster you want! (Make sure to give them a level too :))
//ADD_A_MONSTER();

//Save the game to create your save, and save the variables you just assigned above
save();

//Go to the starting room to start the game
room_goto(curr_rm);

}

//Allows you to ovewride your save and spawn in new areas, add monsters to your party, show the grid or collision masks, and so on.
function debug_settings(){

//If you want to skip the initial check, set this to 0
var RUN_VISUAL_EDITOR_CHECK = 1;

return RUN_VISUAL_EDITOR_CHECK;
if room == rm_setup exit;

//If you don't want run this script, set "RUN_THIS" to 0. Otherwise, set it to 1, and everything below this line will be ran
var RUN_THIS = 0;
if RUN_THIS == 0 return 1;

//If the above RUN_THIS variable is set to 1, the following code will run every start-up of the game.
//This lets you override your games save (which is automatically made after the professor prologue scene) as
//well as allowing you to do stuff like give your player monsters, and stuff like that. 

//Set your players starting position

//curr_rm = rm_worldmap;
area = "Lillywood";
start_x = 2800;
start_y = 2608;

//Add a new monster to your players party. (NOTE, if you save in-game after this script runs and then launch again, you
//will get duplicate monsters, so if you want to avoid that, either don't save, or comment out the monster below before
//running your game again).

ADD_A_MONSTER(m.NEKOSWORD, 5);

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

