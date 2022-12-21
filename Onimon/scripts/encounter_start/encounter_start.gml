function encounter_start(){
//This script handles random battles from the tall grass
//First, check the area, and then assign the mon based on that

//if list(area, )

//Set Default
var _m = -1;
#region Monsters ENUM copy & paste
	/*	
	BURNSBY, FELT, BRAVEHEART, BULBAPOD, SCYTHERIN, SLYTHARAOT,
	SQUIBBLY, SQUIBBLY1, SQUIBBLY2, FURREAL, LEEKLOO, LEEKSWORD,
	NEKOSWORD, NEKOSWORD2, CARROTTI, KAKARATT, QUACKFIL, QUACKFEAR,
	CASPER, DEATHSCYE, NIMBIS, LLOUDIOUS, CRESYL, CRESSENTIA,
	EMPTY1, EMPTY2, EMPTY3, MOISEN, BIRZHEN, BUNDUST,
	JUSKITTEN, HARLEQUITTEN, NYAROLET, EMPTY4, EMPTY5, EMPTY6,
	FIREKITTY, FIRESTAND, EMPTY7,
	HARACKER, HAREATE, SOUL, JISTERY,
	LOOMLEAK, MARILLO, LUNA, ECLIPSE, EMPTY8, EMPTY9,
	KINDLE, EMPTY10, HAKU, BABYLLAMA, ELECTLLAMA,
	EMBEROX, GLACEIA, FLUROX, BOLTREX, YOROX,
	EMPTY11, EMPTY12, KYLEMAN, DANIEL, KNYFAGON,
	CORSAC, TKOB, TKOB2, XKOBOMA, DARTARGET,
	EMPTY13, EMPTY14, EMPTY15, EMPTY16, EMPTY17,
	URELIA, EMBUD, EMBELLIA, KTHUUNEVIRE, MAGMA,
	MIDNIGHT, */
#endregion

//Add what monsters can appear in each area your game has. The demo only has "Forest".
//The number after the monsters enum is how many times it's put into list. So in the following example:
// --> pick(m.FURREAL, 5, m.CASPER, 4, m.CARROTTI, 4, m.QUACKFIL, 3, m.NEKOSWORD, 1)

//There is a total of 16 items. The Nekosword only goes into the list once, so it's a 1 in 16 chance to find
//FURREAL on the otherhand has gone into the list 5 times, so you have a 5/16 chance to find him, and so on.

switch area{
	case "Twindle Forest":	_m = pick(m.FURREAL, 5, m.CASPER, 4, m.CARROTTI, 4, m.QUACKFIL, 3, m.NEKOSWORD, 1);		break;
	case "Route 01":		_m = pick(m.FURREAL, 5, m.CASPER, 4, m.CARROTTI, 4, m.QUACKFIL, 3, m.NEKOSWORD, 1);		break;
	
	//Add new areas here, can copy and paste the line below and use it as a template
	//case _area.area:				 _m = pick();		break;
	}
if _m = -1 exit;
	

var _l = 5;
//Assign the levels at which you can find monsters in the areas of your game
switch area{
	//This will give us monsters ranging from level 3, to 7, in the "forest" area
	case "Twindle Forest":		_l = range(2, 6);		break;
	case "Route 01":			_l = range(3, 7);		break;
	
	//Add new areas here, can copy and paste the line below and use it as a template
	//case _area.area:				_l = range();	break;
	}

//Reset the enemy monsters array (basically, clear out the data from who you battled last
RESET_ENEMY();

//Set the enemy to the monster and level we chose based on our area from above
ADD_ENEMY_MONSTER(_m, _l);


//Start the battle!
interacting = 1;
start_x = px;
start_y = py;
curr_rm = room;


//Create the transition object that will block the view while we're sent to the battle room
create(x, y, depth-1, obj_battle_transition);


}