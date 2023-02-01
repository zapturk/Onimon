RELOAD

enum battl{
	main,		//First menu
	fight,		//Show moves
	mons,		//Show Party
	swch,		//Switch in new monster
	pack,		//Show inventory
	flee,		//Run Flee RNG
	p_atk,		//Use player's move
	e_atk,		//Use enemy's move
	wait,		//Used in between stages
	charg,		//Check for charging/recharging moves
	envir,		//Check for post-turn enviromental damage
	uwon,		//"You won!" Return to room
	ulost,		//"You lost.." Return to last healed nurse
	captr,		//Run rng for capture, goto atk 2
	expr,		//Add experience to your monster
	check,		//Used for checking trainers team
	intro,		//Intro cutscene for Trainer Battle
	outro,		//Outtro cutscene for Trainer Battle
	info		//If we're viewing detailed info about a monster
	}
	
debug = 1;
menu = battl.intro;

//Offset UI and/or trainer on or off the screen for "cutscenes"
ui_offset = 0;
trainer_offset = 0;
if (trainer) ui_offset = 144;

//Used for shrinking mons after they've been degeated
mon_scale[0] = 0;
mon_scale[1] = 0;

//Selection array for inner menus like monster switching and info
for (var i = 0; i < 5; i++){
	sel[i] = 0;				
	}
	
mon_sel = 0;			//Used for switching between monsters
mon_hop = 0;			//Used for monster hop "animation" in switch monsters screen
alarm[2] = 12;

party_sel = 0;			//Used for selection party monster in switch menu
battle_sel = 0;			//Save last move used (Battle Selection)
battler = 0;			//0-5, this points to the current party member we're battling with
battler_dead = 0;		//Used for forcing player to choose a monster after a monster died
ebattler = 0;			//this is the enemy's current battler
flash = 0;				//Used for creating screen flashes when needed
capture = 0;
turn = 1;
alph = 1;

new_health[0] = GET_STAT(PLAYER, MON_HEALTH_CURR);
new_health[1] = GET_STAT(ENEMY, MAX_HEALTH_SUM);

//Used for tracking new health 
new_health_prev[0] = 0;
new_health_prev[1] = 0;
new_health_prev_count[0] = 0;
new_health_prev_count[1] = 0;

//If for some reason we don't have a monster assigned, set the monster to a Level 5 Nekosword to avoid crashes
if eparty[0, 0] == -1 ADD_ENEMY_MONSTER(m.MONSTER_13, 5);

//Cycle through the party and set the Mana for all moves (if needed)

for (var o = 0; o < 6; o++;){

	//If we have a monster in this slot
	if monsters[o, 0] != -1{
	
		//Cycle through their moves and set their mana's
		for (var i = 0; i < 4; i++;){
			var ii = party.mana1;
			if monsters[o, ii+i] == -1{
				monsters[o, ii+i] = GET_MOVE(PLAYER, MOVE_MANA, i);
				}
			}
		}
	else break;
	}

battle_msg[0] = "";
battle_msg[1] = "";						//Recoil					Ex. "Pikachu took some damage from the attack!"
battle_msg[2] = "";						//Status					Ex. "Pikachu Became poisoned!"
battle_msg[3] = "";						//Stats						Ex. "Pikachu's Offense stats fell!"

if (trainer){
	battle_msg[0] = "An enemy trainer is looking for a battle!";
	alarm_set(1, 120);
	}

apply_status[0] = 0;	//Apply status damage for status like burn and poison
apply_status[1] = 0;	//False be default, set to true when applying damage

condition_message[0] = 0;	//Works the same as above but instead for display sleeping message before users move
condition_message[1] = 0;	

monster_attack[0] = -1;		//Store Player Attack this turn
monster_attack[1] = -1;		//Story Enemy Attack this turn (Both reset to -1 at the end of a turn)

used_move[0] = 0;
used_move[1] = 0;

//Vertical bobble
vobble[0] = 0;
vobble[1] = 0;
vobinc[0] = 1;	//Increment 1
vobinc[1] = 1;	//Increment 2
vobtmr[0] = 0;	//Timer 1
vobtmr[1] = 0;	//Timer 2

//Horizontal bobble
hobble[0] = 0;
hobble[1] = 0;
hobinc[0] = 1;
hobinc[1] = 1;
hobtmr[0] = 0;
hobtmr[1] = 0;

//Stat changes that only last this battle. Range from -4 to +4 (0.25x up to 4x)
for (var i = 0; i < 7; i++;){
	battle_stats[0, i] = 0;	//Player
	battle_stats[1, i] = 0;	//Enemy
	}
enum battl_stats{
	atk, def, mgk_atk, mgk_def, spd, eva, acc
	}

condition[0] = -1;
condition[1] = -1;
enum con{
	flinch, recharge, protected
	}

function RESET_BATTLE_STATS(){
///@arg PLAYER/ENEMY
	
for (var i = 0; i < 7; i++;){
	battle_stats[argument[0], i] = 0;	//Player
	}
}

audio_stop_all();
audio_play_sound(snd_battle, 1, 1);
audio_sound_gain(snd_battle, 1, 0);

_cam_width = 256;
_cam_height = 144;

//MonDex Variables
hobble[0] = 0;
hobble[1] = 0;
incr[0] = 1;
incr[1] = 1;
timer = 0;

showinfo = 0;
float = -1;
float_mon = -1;
float_xpos = 0;
float_ypos = 0;

scrolling_bg_x = 0;
scrolling_bg_y = 0;


/*
During "fight", we will get the players move, and the enemies.
Then we'll check priority, if the move priority's are the same,
we'll check speed. Whoever has the highest speed gets to go first.

First we'll then check check type, if the move type doesn't affect
the enemy, skip everything else. If it does, check statuses. If we
don't have a status, check accuracy. If accuracy
is less than 100, run an RNG to see if we're able to attack.

If we miss, miss. If we land, calculate damage taking in all stats, move
power, critical chance RNG, effectiveness, statuses, etc.

Once a move lands, check if we have a chance to apply a status. If we do
run an RNG to apply it.

After words, go to the enemy turn