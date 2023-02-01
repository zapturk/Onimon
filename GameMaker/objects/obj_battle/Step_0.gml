RELOAD

if room != rm_battle exit;

#region Increment Health Up/Down

//We use two separate healths so that the health drawn to the screen can slowly increase or decrease when we heal or take damage.
//The below statements perform the actual incrementation that players will see on screen.
if GET_STAT(PLAYER, MON_HEALTH_CURR) != new_health[0]{
	if new_health[0] < GET_STAT(PLAYER, MON_HEALTH_CURR) monsters[battler, party.health] = lerp(monsters[battler, party.health], new_health[0], 0.05);
	}
if new_health[0] > 0{
	if mon_scale[0] < 1 mon_scale[0] += 0.05;
	}
else if mon_scale[0] > 0 mon_scale[0] -= 0.05;

if GET_STAT(ENEMY, MON_HEALTH_CURR) != new_health[1]{
	if new_health[1] < GET_STAT(ENEMY, MON_HEALTH_CURR) eparty[ebattler, party.health] = lerp(eparty[ebattler, party.health], new_health[1], 0.05);
	}
if new_health[1] > 0{
	if mon_scale[1] < 1 mon_scale[1] += 0.05;
	}
else if mon_scale[1] > 0 mon_scale[1] -= 0.05;

new_health_prev[0] = 0;
new_health_prev[1] = 0;
new_health_prev_count[0] = 0;
new_health_prev_count[1] = 0;
#endregion

if menu == battl.intro{
	
	if alarm[1] == -1 and ui_offset != 0{
		ui_offset-=3;
		}
		
	if ui_offset == 96{
		create(80-32, 73-32, depth-1, obj_monster_spawn);
		var _enemy_spawner = create(180+32, -10+32-8, depth-1, obj_monster_spawn);
		with _enemy_spawner image_xscale = -1;
		}
		
	if ui_offset == 0{
		flash = 1;			//Alpha to draw the flash at from the start
		menu = battl.main;		//Start the battle after the intro scene has played
		battle_msg[0] = "";
		}
	}

if menu == battl.main{
	
//Check for directional input
sel[0] = GET_VERTICAL_INPUTS_2x2(sel[0]);

if press(ENTER){
	switch sel[0]{
		case 0: menu = battl.fight;	break;
		case 1: menu = battl.mons; 	break;
		case 2: if !(trainer) menu = battl.captr;	break;
		case 3: if !(trainer) menu = battl.flee;	break;
		}
	if menu == battl.mons sel[2] = -1;
	clear(ENTER);
	}

//If we just selected the 'Flee' option, set it up
if menu == battl.flee{
	flee = -1;
	alarm_set(0, 180);
	battle_msg[0] = "Attempting to get away...";
	}
	
//If we just selected the 'Capture' option, set it up
if menu == battl.captr{
	capture = -1;
	alarm_set(0, 2);
	create(0, 0, obj_monster_capture);
	battle_msg[0] = "Attempting to capture the enemy monsters...";
	}

if menu == battl.mons mon_sel = 0;

}

if menu == battl.fight{
	
//Check for directional input
battle_sel = GET_VERTICAL_INPUTS_2x2(battle_sel);

if press(ENTER){

	//Check Mana
	var MANA = GET_STAT(PLAYER, MON_MANA_01+battle_sel);
	if MANA < 1{
		battle_msg[0] = "You don't have enough mana for this move to use it!";
		menu = battl.wait;
		alarm[0] = 180;
		exit;
		}

	monster_attack[0] = monsters[battler, party.move1+battle_sel];
	if monster_attack[0] == -1 exit;
	
	monster_attack[1] = CHOOSE_ENEMY_ATTACK();

	//Subtract Mana from both monsters
	monsters[battler, (party.mana1+battle_sel)]--;
	eparty[ebattler, (party.mana1+enemy_battle_sel)]--;

	move_msg[0] = string(GET_DEX(PLAYER, DEX_NAME)) + " used " + string(GET_MOVE(PLAYER, MOVE_NAME)) + "!";
	move_msg[1] = string(GET_DEX(ENEMY, DEX_NAME)) + " used " + string(GET_MOVE(ENEMY, MOVE_NAME)) + "!";
	
	//Now that we have the moves, let's check priority and speed to see who goes first
	var player_priority =	movedex[monster_attack[0], move.priority];
	var enemy_priority =	movedex[monster_attack[1], move.priority];
	
	//If move priority is the same, check speed
	if player_priority == enemy_priority{
		if GET_STAT(PLAYER, SPEED_SUM) >= GET_STAT(ENEMY, SPEED_SUM) menu = battl.p_atk;
		else menu = battl.e_atk;
	}
	else if player_priority > enemy_priority  menu = battl.p_atk;
	else menu = battl.e_atk;
	
	if menu == battl.p_atk battle_msg[0] = move_msg[0];
	if menu == battl.e_atk battle_msg[0] = move_msg[1];
	
	alarm_set(0, 180);
	clear(ENTER);
	
	//Here we are checking move priority and player/enemy speeds to determine who will attack first
	//The alarm is to provide time for animations and messages to appear on screen
	}
	
if press(BACK) or press(ESCAPE){
	menu = battl.main;
	sel[0] = 0;
	}	
	
}

if menu == battl.mons{

	//Get player input
	if press(ENTER){
		switch sel[2]{
			//If we click on a monster,
			case -1:
				sel[2] = 0;
				exit;
			case 0:
				//If we select "Switch", switch this monster into battle
				if sel[1] != battler{
					if monsters[sel[1], party.health] > 0{
						battler = sel[1];
						battler_dead = 0;
						new_health[0] = GET_STAT(PLAYER, MON_HEALTH_CURR);
						battle_msg[0] = "That's enough.. Go get em' " + string(GET_DEX(PLAYER, DEX_NAME)) + "!";
						menu = battl.swch;
						alarm_set(0, 180);
						clear(ENTER);
						}
					}
				break;
			case 1:
				menu = battl.info;
				sel[2] = 0;
				exit;
			}
		}

	//audio_play_sound(snd_menu_click, 0, 0);
				
	//Get player input for choosing a monster
	if sel[2] == -1 or sel[2] == 2{
		if press(UP) and sel[1] > 1 sel[1]-=2;
		if press(LEFT) and sel[1] > 0 sel[1]--;
		
		//Make sure we don't go into an empty spot for these two
		if press(DOWN) and sel[1] < 4{
			if monsters[sel[1]+2, 0] != -1 sel[1]+=2;
			}
		if press(RIGHT) and sel[1] < 5{
			if monsters[sel[1]+1, 0] != -1 sel[1]++;
			}
		}
	else{
		if press(BACK) sel[2] = -1;
		if press(RIGHT) or press(LEFT){
			sel[2]++;
			if sel[2] == 2 sel[2] = 0;
			}
		}

	if press(BACK) or press(ESCAPE){
	
		if sel[2] > -1{
			sel[2] = -1;
			exit;
			}
	
		//If our preivous battle died, don't let us back out without choosing a monster
		if battler_dead == 1 exit;
	
		menu = battl.main;
		for (var i = 0; i < 4; i++){
			sel[i] = 0;
			}
		sel[0] = 1;
		}
	
}

if menu == battl.info{

	if press(ESCAPE){
		if sel[4] > 0{
			sel[2] = -1;
			sel[4] = 0;
			}
		if sel[3] > 0{
			sel[3] = 0;
			exit;
			}
		sel[2] = -1;
		sel[3] = 0;
		sel[4] = 0;
		menu = battl.mons;
		}
		
	if press(RIGHT) or press(LEFT){
		if sel[4] == 0{
			sel[2]++;
			if sel[2] == 2 sel[2] = 0;
			sel[3] = 0;
			}
		}
	
	//If we're viewing a moves info
	if sel[3] != 0 and sel[4] == 0{
		if press(UP) sel[3]--;
		if press(DOWN) sel[3]++;
		if sel[3] < 1 sel[3] = 1;
		if sel[3] > 4 sel[3] = 4;
		if monsters[sel[1], (party.move1+(sel[3]-1))] = -1 sel[3]--;
		
		if press(ENTER){
			//sel[2] = 2;
			//sel[4] = 1;
			exit;
			}
		}
	
	//If we're changing a move
	if sel[4] != 0{
		if press(UP) sel[4]-=2;
		if press(DOWN) sel[4]+=2;
		if sel[4] < 1 sel[4] = 1;
		if (sel[4]-1) > array_length(movepool[monsters[sel[1], 0]])-2 sel[4]-=2;
		
		//We've chosen a new move to use~ Add it to our movepool from our broad movepool and then exit this menu
		if press(ENTER){
			monsters[sel[1], (party.move1+(sel[3]-1))] = movepool[monsters[sel[1], 0], sel[4]-1];
			
			//Don't forget to set this monsters MANA to the max mana of the move too :)
			var move_mana = movedex[movepool[monsters[sel[1], 0], sel[4]-1], move.mana];
			monsters[sel[1], (party.mana1+(sel[3]-1))] = move_mana;
			
			sel[2] = 1;
			sel[4] = 0;
			}
		
		}
	
	//If I pressed "A" for more info on moves screen
	if sel[2] == 1{
		if press(ENTER) sel[3] = 1;
		}
	}

if menu == battl.swch{
	if alarm[0] = -1{
		monster_attack[0] = -1;
		RESET_BATTLE_STATS(PLAYER);
		monster_attack[1] = CHOOSE_ENEMY_ATTACK();
		move_msg[1] = string(GET_DEX(ENEMY, DEX_NAME)) + " used " + string(GET_MOVE(ENEMY, MOVE_NAME)) + "!";
		menu = battl.wait;
		}
	}

//Player and Enemy attack phase
if menu == battl.p_atk or menu == battl.e_atk{

if menu == battl.p_atk{
	attacker = 0;	//Player
	defender = 1;	//Enemy
	}
if menu == battl.e_atk{
	attacker = 1;	//Enemy
	defender = 0;	//Player
	}
	
var MY_NAME = GET_DEX(attacker, DEX_NAME), EN_NAME = GET_DEX(defender, DEX_NAME);

//If we are recharging or flinched, skip our turn.
if condition[attacker] == con.flinch{
	battle_msg[0] = string(MY_NAME) + " flinched, and was unable to move.";
	condition_message[attacker] = 1;
	monster_attack[attacker] = -1;
	condition[attacker] = -1;
	menu = battl.wait;
	alarm[0] = 180;
	exit;
	}

//Draw our move message. Ex: "Pichu used Scratch!"
battle_msg[0] = move_msg[attacker];

//If the attacker has a sleep status, we need to delay displaying the move battle message until we see if they wake up or not
if GET_STAT(attacker, MON_STATUS) == status.sleep battle_msg[0] = string(GET_DEX(attacker, DEX_NAME)) + " is very sleepy..";
else{

//As long as we're not asleep, create our moves
if (attacker == 1) and used_move[1] = 0{
	var move_spr = GET_MOVE(attacker, MOVE_SPRITE), move_anim = GET_MOVE(attacker, MOVE_ANIMATION), xx = 84, yy = 74;
	
	//Reposition the move if we aren't using the default animation type
	if move_anim != 0{
		switch (move_anim){
			case 1://Over Self
				xx = 84;
				break;
			case 2://Projectile
				xx = 84;
				//Add movement to obj_move;
				break;
			case 3://Whole Room
				xx = 0;
				yy = 0;
				break;
			}
		}
	
	with instance_create_layer(xx, 74, "Instances", obj_move) sprite_index = move_spr;
	used_move[1] = 1;
	}
if (attacker == 0) and used_move[0] = 0{
	var move_spr = GET_MOVE(attacker, MOVE_SPRITE), move_anim = GET_MOVE(attacker, MOVE_ANIMATION), xx = 186, yy = 40;
	
	//Reposition the move if we aren't using the default animation type
	if move_anim != 0{
		switch (move_anim){
			case 1://Over Self
				xx = 84;
				break;
			case 2://Projectile
				xx = 84;
				//Add movement to obj_move;
				break;
			case 3://Whole Room
				xx = 0;
				yy = 0;
				break;
			}
		}
	
	with instance_create_layer(xx, yy, "Instances", obj_move) sprite_index = move_spr;
	used_move[0] = 1;
	}
}

//Once the alarm ends, we will calculate damage (if the attack lands) and then reset the alarm to 3 seconds
//to allow for animations and text to display on screen before going on to the next step.
if alarm[0] = -1{
	//If we are dead, go to mons OR go to menu "you lost".
	if new_health[attacker] <= 0{
		monster_attack[attacker] = -1;
		menu = battl.mons;
		alarm_set(0, 180);
		battle_msg[0] = string(GET_DEX(attacker, DEX_NAME)) + " has been defeated..";
		
		//Cycle through and find all monsters that are still alive
		var _living_monsters = 0;
		for (var i = 0; i < 6; i++;){
			if monsters[i, 0] != -1{
				if monsters[i, party.health] > 0 _living_monsters++;
				}
			}
		
		//If we didn't find any living monsters, go to "you lost"
		if _living_monsters == 0{
			menu = battl.ulost;
			}
		}
	
	//If we have yet to perform our attack
	if monster_attack[attacker] != -1{
		
		//Check Accuracy
		var MISS = false;
		
		if condition[defender] == con.protected{
			battle_msg[0] = string(EN_NAME) + " protected itself.";
			condition[defender] = -1;
			MISS = true;
			}
		
		//If our accuracy is less than 100%, run an RNG to see if we miss or land this attack. If the ove accuracy is -1, this move always hits
		if GET_MOVE(attacker, MOVE_ACCURACY) != -1{
			if GET_MOVE(attacker, MOVE_ACCURACY) < 100{
				var _chance = irandom(100)+1;
				if _chance > GET_MOVE(attacker, MOVE_ACCURACY){
					//Set "miss" to true so that we don't use our move
					battle_msg[0] = "The attack missed!";
					MISS = true;
					}
				}
			}
		
		//Check if the move is effective or not (Example, Normal does not affect Ghost at all)
		var  MV_TYPE = GET_MOVE(attacker, MOVE_ELEMENT), EN_TYPE = GET_DEX(defender, DEX_ELEMENT_1);
		TYPE = TYPE_EFF(MV_TYPE, EN_TYPE);
		if TYPE == 0{
			battle_msg[0] = "There was no effect...";
			MISS = true;
			}
		
		//Check Status Conditions
		if condition != status.none{
			switch GET_STAT(attacker, MON_STATUS){
				case status.paralyze:
				
					//Roll a 25% chance RNG. If it returns true, paralyze the user and don't allow them to attack
					var _chance = chance(0.25);
					if (_chance){
						MISS = true;
						battle_msg[0] = string(MY_NAME) = " is paralyzed and cannot move!";	break;
						}
					break;
				case status.sleep:
				
					//Roll a 20% chance RNG. If it returns true, the attacker wakes up. Otherwise, stay asleep
					var _chance = chance(0.20);
					if !(_chance){
						MISS = true;
						battle_msg[0] = string(MY_NAME) + " didn't wanna wake up.";	break;
						}
					else{
						monsters[battler, party.status] = status.none;
						battle_msg[0] = move_msg[attacker];
						alarm[0] = 180;
						}
					break;
				}
			}

		//Check our conditions for stuff like "Flinched", or "Recharging"
		if condition[attacker] != -1{
			condition[attacker] = -1;
			//Set "miss" to true so that we don't use our move
			MISS = true;
			}
		
		if GET_MOVE(attacker, MOVE_FIRSTTURN) == 1 and turn != 1{
			battle_msg[0] = "It had no effect...";
			MISS = true;
			}
		
		if MISS == true{
			with obj_move destroy();
			monster_attack[attacker] = -1;
			menu = battl.wait;
			alarm[0] = 180;
			}
		
		if MISS == false{			
			//We've cleared all if's, let's use our move!
			
			//Prepare for multiple battle messages to be displayed
			var ms = 0;
			
			//Apply conditions if needed
			if GET_MOVE(attacker, MOVE_RECHARGE) == 1 condition[attacker] = con.recharge;
			if GET_MOVE(attacker, MOVE_FLINCH) == 1 condition[defender] = con.flinch;
			
			//Deal damage to the enemy!
			if GET_MOVE(attacker, MOVE_POWER) > 0{
				var MY_TYPE1 = GET_DEX(attacker, DEX_ELEMENT_1), EN_TYPE1 = GET_DEX(defender, DEX_ELEMENT_1), MY_TYPE2 = GET_DEX(attacker, DEX_ELEMENT_1), EN_TYPE2 = GET_DEX(defender, DEX_ELEMENT_2),
				MV_TYPE = GET_MOVE(attacker, MOVE_ELEMENT), RAND = random_range(0.85, 1.10), STAB = CHECK_STAB(MY_TYPE1, MY_TYPE2, MV_TYPE), LVL = GET_STAT(attacker, MON_LEVEL),
				ATK = GET_STAT(attacker, ATTACK_SUM), PWR = GET_MOVE(attacker, MOVE_POWER), DEF = GET_STAT(defender, DEFENSE_SUM), CRIT = CRIT_CHANCE(), TYPE = TYPE_EFF(MV_TYPE, EN_TYPE1, EN_TYPE2);
			
				//Get monsters attack stat (ATK), 
				ATK = CALCULATE_BATTLE_STATS(ATK, attacker, battl_stats.atk);
				DEF = CALCULATE_BATTLE_STATS(DEF, defender, battl_stats.def);
			
				if (GET_MOVE(attacker, MOVE_HI_CRIT)) == 1 CRIT = CRIT_CHANCE(1);
				var _damage = ceil(((((2*LVL)/5+2)*PWR*(ATK/DEF))/50+2) * CRIT * TYPE * RAND * STAB);
				new_health[defender] -= _damage;
				if new_health[defender] <= 0 new_health[defender] = 0;
				
				
				//If we crit, or have a super/not very effective message, extend the timer to show this message. Otherwise, just go on to the next turn.
				if CRIT == 2 or TYPE != 1{
					
					if TYPE == 1 battle_msg[ms] = "It was a critical hit!";
					else{
						if TYPE > 1 battle_msg[ms] = "It's super effective";
						if TYPE < 1 battle_msg[ms] = "It wasn't that effective";
						if (CRIT){
							if TYPE > 1 battle_msg[ms] = string_insert("!", battle_msg[ms], string_length(battle_msg[ms])+1);
							if TYPE < 1 battle_msg[ms] = string_insert("...", battle_msg[ms], string_length(battle_msg[ms])+1);
							}
						else{
							if TYPE > 1 battle_msg[ms] = string_insert(", and a critical hit!", battle_msg[ms], string_length(battle_msg[ms])+1);
							if TYPE < 1 battle_msg[ms] = string_insert(", yet landed a critical hit!", battle_msg[ms], string_length(battle_msg[ms])+1);
							}
						}
					alarm[0] = 180;
					ms++;
					}
				else alarm[0] = 60;
				//^^ If there was no other battle messages, just give a 1 second delay
				}
			
			//Use a move that applies protection, like "Protect"!
			if GET_MOVE(attacker, MOVE_PROTECT) == 1 condition[attacker] = con.protected;
			
			//Apply a status application!
			var status_type = GET_MOVE(attacker, MOVE_STATUS);
			if GET_MOVE(attacker, MOVE_CHANCE1) != 0{	//If our chance to apply a status condition to the defender is not 0
				
				var status_msg;
				switch status_type{
					case status.burn:		status_msg = " got burned.";				break;
					case status.poison:		status_msg = " got poisoned.";				break;
					case status.paralyze:	status_msg = " got paraylyzed.";			break;
					case status.confused:	status_msg = " is confused.";				break;
					case status.sleep:		status_msg = " has been put to sleep.";		break;
					default:				status_msg = " ISSUE SETTING STATUS";		break;
					}
				
				if GET_STAT(defender, MON_STATUS) == status.none{	//If the defender doesn't already have a status
					
					//If our chance to poison, burn, etc, is not a 100% chance, run an RNG to check whether or not we're applying the status. Otherwise, just do it (apply yhe status)
					if GET_MOVE(attacker, MOVE_CHANCE1) != 100 var RNG = chance(GET_MOVE(attacker, MOVE_CHANCE1));
					else var RNG = 1;
						
					//If our random number generator returned true
					if (RNG){
						
						SET_STATUS(defender, status_type);
						
						//If the alarm is not set, this means we did not deal damage, so this is a status application move.
						if alarm[0] == -1{
							battle_msg[ms] = (string(EN_NAME) + string(status_msg));
							alarm[0] = 180;
							ms++;
							}
						//If alarm is set, then we need to instead add this message to the list of possible messages we'll show after using the move
						else battle_msg[2] = (string(EN_NAME) + string(status_msg));
						}
					}
				else{ //If the defender DOES have a status already
					//If the alarm is not set, this means we did not deal damage, so this is a status application move. No need to send these message if it was just a chance status application
					if alarm[0] == -1{
						var status_type = GET_STAT(defender, MON_STATUS);
						switch status_type{
							case status.burn:		battle_msg[ms] = "The enemy is already burned!";		break;
							case status.poison:		battle_msg[ms] = "The enemy is already poisoned!";		break;
							case status.paralyze:	battle_msg[ms] = "The enemy is already paralyzed!";		break;
							case status.sleep:		battle_msg[ms] = "The enemy is already asleep!";		break;
							}
						alarm[0] = 180;
						}
					}
				}
			
			//Adjust battle stats! Battle stats reset on monster switch, or when the battle ends
			if GET_MOVE(attacker, MOVE_CHANCE3) != 0{
			
				if GET_MOVE(attacker, MOVE_CHANCE3) != 100 var RNG = chance(GET_MOVE(attacker, MOVE_CHANCE3));
				else var RNG = 1;

				if (RNG){
					//Apply all battle stat changes based on our move	
					battle_stats[0, 0] += GET_MOVE(attacker, MOVE_STAT_ATK);
					battle_stats[0, 1] += GET_MOVE(attacker, MOVE_STAT_DEF);
					battle_stats[0, 2] += GET_MOVE(attacker, MOVE_STAT_MGKATK);
					battle_stats[0, 3] += GET_MOVE(attacker, MOVE_STAT_MGKDEF);
					battle_stats[0, 4] += GET_MOVE(attacker, MOVE_STAT_SPEED);
					battle_stats[0, 5] += GET_MOVE(attacker, MOVE_STAT_EVASI);
					battle_stats[0, 6] += GET_MOVE(attacker, MOVE_STAT_ACC);
				
					battle_stats[1, 0] += GET_MOVE(attacker, MOVE_ENSTAT_ATK);
					battle_stats[1, 1] += GET_MOVE(attacker, MOVE_ENSTAT_DEF);
					battle_stats[1, 2] += GET_MOVE(attacker, MOVE_ENSTAT_MGKATK);
					battle_stats[1, 3] += GET_MOVE(attacker, MOVE_ENSTAT_MGKDEF);
					battle_stats[1, 4] += GET_MOVE(attacker, MOVE_ENSTAT_SPEED);
					battle_stats[1, 5] += GET_MOVE(attacker, MOVE_ENSTAT_EVASI);
					battle_stats[1, 6] += GET_MOVE(attacker, MOVE_ENSTAT_ACC);
				
					//Make sure no stats exceed the max/mins (which are -4, and 4)
					for (var i = 0; i < 6; i++;){
						if abs(battle_stats[0, i]) > 4{
							if battle_stats[0, i] > 4 battle_stats[0, i]--;
							if battle_stats[0, i] < -4 battle_stats[0, i]++;
							}
						if abs(battle_stats[1, i]) > 4{
							if battle_stats[1, i] > 4 battle_stats[1, i]--;
							if battle_stats[1, i] < -4 battle_stats[1, i]++;
							}
						}
				
					for (var i = 0; i < 14; i++;){
						if movedex[monster_attack[attacker], 16+i] != 0{
							switch i{
								case 0: battle_msg[ms] = string(MY_NAME) + "'s attack rose!";			break;
								case 1: battle_msg[ms] = string(MY_NAME) + "'s defense rose!";			break;
								case 2: battle_msg[ms] = string(MY_NAME) + "'s magic attack rose!";		break;
								case 3: battle_msg[ms] = string(MY_NAME) + "'s magic defense rose!";		break;
								case 4: battle_msg[ms] = string(MY_NAME) + "'s speed rose!";				break;
								case 5: battle_msg[ms] = string(MY_NAME) + "'s evasion rose!";			break;
								case 6: battle_msg[ms] = string(MY_NAME) + "'s accuracy rose!";			break;
								case 7: battle_msg[ms] = string(EN_NAME) + "'s attack fell.";			break;
								case 8: battle_msg[ms] = string(EN_NAME) + "'s defense fell.";			break;
								case 9: battle_msg[ms] = string(EN_NAME) + "'s magic attack fell.";		break;
								case 10: battle_msg[ms] = string(EN_NAME) + "'s magic defense fell.";	break;
								case 11: battle_msg[ms] = string(EN_NAME) + "'s speed fell.";			break;
								case 12: battle_msg[ms] = string(EN_NAME) + "'s evasion fell.";			break;
								case 13: battle_msg[ms] = string(EN_NAME) + "'s accuracy fell.";			break;
								}
							}
						}
					}
				}
			//Once we make it here, reset the monster_attacks to -1 as we've already used it 
			monster_attack[attacker] = -1;
			menu = battl.wait;
			}
		}
	}
}

if menu == battl.wait{

//Once we're finished displaying the message, check for what we need to do next
if alarm[0] == -1{

	//If I'm just displaying my "no mana message"
	var MANA = GET_STAT(PLAYER, MON_MANA_01+battle_sel);
	if MANA == 0{
		battle_msg[0] = "";
		menu = battl.fight
		exit;
		}
		
	//If both monsters are alive
	var MY_NAME = GET_DEX(PLAYER, DEX_NAME), EN_NAME = GET_DEX(ENEMY, DEX_NAME);
	if new_health[0] > 0 and new_health[1] > 0{
		
		//Check all possible battle message slots for messages. If we find a message, set it to our drawn battle message, and then clear it, and reset the 3 second timer. Repat until all messages are drawn
		for (var i = 1; i < array_length(battle_msg); i++;){
			if battle_msg[i] != "" {
				battle_msg[0] = battle_msg[i];
				battle_msg[i] = "";
				alarm[0] = 180;
				exit;
				}
			}
			
		//If both monsters have attacked this turn, check for statuses
		if monster_attack[0] == -1 and monster_attack[1] == -1{
			if list(GET_STAT(PLAYER, MON_STATUS), status.burn, status.poison) and apply_status[0] = 0{
				if GET_STAT(PLAYER, MON_STATUS) == status.burn{
					battle_msg[0] = string(MY_NAME) + " took damage from it's burn.";
					new_health[0] -= (GET_STAT(PLAYER, MAX_HEALTH_SUM)/16);
					}
				if GET_STAT(PLAYER, MON_STATUS) == status.poison{
					battle_msg[0] = string(MY_NAME) + " took damage from it's poison.";
					new_health[0] -= (GET_STAT(PLAYER, MAX_HEALTH_SUM)/8);
					}
				apply_status[0] = 1;
				alarm[0] = 180;
				exit;
				}
			if list(GET_STAT(ENEMY, MON_STATUS), status.burn, status.poison) and apply_status[1] = 0{
				if GET_STAT(ENEMY, MON_STATUS) == status.burn{
					battle_msg[0] = string(EN_NAME) + " took damage from it's burn.";
					new_health[1] -= (GET_STAT(ENEMY, MAX_HEALTH_SUM)/16);
					}
				if GET_STAT(ENEMY, MON_STATUS) == status.poison{
					battle_msg[0] = string(EN_NAME) + " took damage from it's poison.";
					new_health[1] -= (GET_STAT(ENEMY, MAX_HEALTH_SUM)/8);
					}
				apply_status[1] = 1;
				alarm[0] = 180;
				exit;
				}
			
			//Reset these to false, since it's a new turn
			apply_status[0] = 0;
			apply_status[1] = 0;
			condition_message[0] = 0;
			condition_message[1] = 0;
			used_move[0] = 0;
			used_move[1] = 0;
			
			if condition[PLAYER] == con.recharge{
				battle_msg[0] = string(GET_DEX(PLAYER, DEX_NAME)) + " is recharging from their last turn!";
				monster_attack[1] = CHOOSE_ENEMY_ATTACK();
				condition[PLAYER] = -1;
				menu = battl.wait;
				alarm[0] = 180;
				turn ++;
				exit;
				}
			
			//Both players have attacked, reset the menu to default settings
			battle_msg[0] = "";
			menu = battl.main;
			turn ++;
			sel[0] = 0;
			}
		else{
			//One of the two monsters have yet to attack
			//If the player has already used his attack, go to the enemy turn. Otherwise, the enemy attacked first, so go to player turm
			if monster_attack[0] == -1 menu = battl.e_atk;
			else menu = battl.p_atk;
			alarm_set(0, 180);
		}
	}
	else{
		//Both monsters are not alive, find out who and go to the appropriate menu
		if new_health[1] == 0{
			//Enemy monster died, give us exp and show the correct message (assigned in battl.expr)
			
			//Give player monster xp
			var _exp, var _t = 1, _m = 1, rand = choose(0.8, 0.9, 1, 1, 1, 1.1, 1.2, 1.25);
			if trainer == 1 _t = 1.5;
			if trainer == 2 _t = 2.5;
			_exp = round(_t * rand * 1.25 * _m * eparty[ebattler, party.level]);
			monsters[battler, party.exp] += _exp;
			
			//Level up our monster if we meet the required EXP
			if monsters[battler, party.exp] > power(monsters[battler, party.exp], 3){
				monsters[battler, party.exp] = 0;
				monsters[battler, party.level]++;
				}
				
			battle_msg[0] = string(EN_NAME) + " has been defeated.";
			menu = battl.expr;
			alarm[0] = 180;
			}
		//Otherwise, YOUR monster lost, switch in a new one if you have any left
		else if new_health[0] == 0{
			for (var i = 0; i < 6; i++;){
				if monsters[i, 0] != -1{
					if monsters[i, party.health] > 1{
						battler_dead = 1;
						menu = battl.mons;
						exit;
						}
					}
				}
			//If we didn't find any living monsters, you lost.
			menu = battl.ulost;
			}
		}
	}
}

if menu == battl.flee{
	if alarm[0] = -1{
		if flee = -1{
			var _flee = 0;
			//If health is above 60%, comapare speeds
			if percentage(GET_STAT(PLAYER, MAX_HEALTH_SUM), GET_STAT(PLAYER, MON_HEALTH_CURR)) > 0.60{
				if GET_STAT(PLAYER, SPEED_SUM) >= GET_STAT(ENEMY, SPEED_SUM){
					_flee = 1;
					}
				}
			else{
				//If health is less than 20%, run a 1 in 4 (25% chance) RNG to see if we can flee
				if percentage(GET_STAT(PLAYER, MAX_HEALTH_SUM), GET_STAT(PLAYER, MON_HEALTH_CURR)) < 0.20 if chance(0.25) _flee = 1;
				
				//If health is between 20% and 60%, run a 1 in 2 (50% chance) RNG instead
				else if chance(0.5) _flee = 1;
				}
			
			//Set messages and reset timer
			if _flee = 1 flee = 1;
			else flee = 0;
			if flee != -1{
				alarm_set(0, 180);
				battle_msg[0] = "Successfully got away!";
				if flee = 0 battle_msg[0] = "You couldn't get away!";
				}
			}
		else{
			//If we failed, let the enemy attack and go on to the next turn. Otherwise, return to the active room
			if flee == 0{
				monster_attack[0] = -1;
				monster_attack[1] = CHOOSE_ENEMY_ATTACK();
				move_msg[1] = string(GET_DEX(ENEMY, DEX_NAME)) + " used " + string(GET_MOVE(ENEMY, MOVE_NAME)) + "!";
				menu = battl.e_atk;
				}
			if flee == 1{
				interacting = 0;
				room_goto(curr_rm);
				}
			}
		}
	}

if menu == battl.captr{
	if alarm[0] = -1{
		if capture = -1{
			//Base capture rate of 30% chance, add _health_bonus (maximum 0.5 or 50%) for a total possible 80% chance of capture
			var _cap = 0.30, _health_bonus;
			_health_bonus = 1 - ((GET_STAT(ENEMY, MON_HEALTH_CURR) / GET_STAT(ENEMY, MAX_HEALTH_SUM)) / 2);
			_cap += _health_bonus;
			
			var _rng = random_range(0, 1);
			if _cap >= _rng{
				capture = 1;
				alarm_set(0, 120);
				with obj_monster_capture{
					image_index = 0;
					sprite_index = spr_monster_capture_success;
					}
				ADD_A_MONSTER(eparty[0, 0], eparty[0, party.level]);
				battle_msg[0] = "The monster has been caught, congratulations!";
				}
			else{
				capture = 0;
				alarm_set(0, 120);
				with obj_monster_capture{
					image_index = 0;
					sprite_index = spr_monster_capture_fail;
					}
				battle_msg[0] = "The monster was unable to be captured!";
				}
			}
		else{
			if capture = 1{
				battle_msg[0] = "The monster has been caught, congratulations!";
				if press(ENTER){
					interacting = 0;
					room_goto(curr_rm);
					}
				}
			if capture = 0{
				monster_attack[0] = -1;
				monster_attack[1] = CHOOSE_ENEMY_ATTACK();
				move_msg[1] = string(GET_DEX(ENEMY, DEX_NAME)) + " used " + string(GET_MOVE(ENEMY, MOVE_NAME)) + "!";
				menu = battl.e_atk;
				}
			}
		}
	}

if menu = battl.expr{
if alarm[0] == -1{

	var mon_level = monsters[battler, party.level];
	//Check if our EXP is higher than our MAX EXP. If it is, level up the monster and then show the message
	if monsters[battler, party.exp] >= ((mon_level * 10)-1){
	
		//Repeaat up to 10 times in case we leveled up several times
		for (var i = 0; i < 10; i++;){	
			if monsters[battler, party.exp] >= ((mon_level * 10)-1){
				monsters[battler, party.exp] -= ((mon_level * 10)-1);
				monsters[battler, party.level]++;
				}
			}
		
		var new_move = 0;
		//Loop through the movepool array, and see if we can learn a new move this level or not
		for (var i = 2; i < array_length(movepool[monsters[battler, 0]]); i+=2;){
			if movepool[monsters[battler, 0], i] == mon_level{
				new_move++;
				break;
				}
			if movepool[monsters[battler, 0], i] > mon_level break;
			}
			
		//Set the appropriate message and draw it for 3 seconds
		MY_NAME = GET_DEX(attacker, DEX_NAME);
		if new_move == 0 battle_msg[0] = string(MY_NAME) + " leveled up!";
		else battle_msg[0] = string(MY_NAME) + " leveled up!\n " + string(MY_NAME) + " is able to learn a new move!";
		menu = battl.check;
		alarm[0] = 180;
		}
	else{
		//If our EXP is not greater than our MAX EXP, just display out EXP message. Then, check if the enemy has any more monsters

		//Check player monster applied xp
		var _exp, var _t = 1, _m = 1, rand = choose(0.8, 0.9, 1, 1, 1, 1.1, 1.2, 1.25);
		if trainer == 1 _t = 1.5;
		if trainer == 2 _t = 2.5;
		MY_NAME = GET_DEX(attacker, DEX_NAME);
		_exp = round(_t * rand * 1.25 * _m * eparty[ebattler, party.level]);
			
		battle_msg[0] = string(MY_NAME) + " gained " + string(_exp) + " experience!";
		menu = battl.check
		alarm[0] = 180;
		}
	}
}

if menu == battl.check{
	if alarm[0] == -1{
		//Loop through enemies team and see if they have any monsters left. If they do, set up the new monster and go back to battl.wait
		for (var i = 0; i < 6; i++;){
			if round(eparty[i, party.health]) > 0{
				ebattler = i;
				menu = battl.wait;
				new_health[1] = GET_STAT(ENEMY, MAX_HEALTH_SUM);
				battle_msg[0] = "Enemy trainer sent out " + GET_DEX(ENEMY, DEX_NAME);
				create(obj_monster_spawn);
				monster_attack[0] = -1;
				monster_attack[1] = -1;
				condition[1] = -1;
				alarm[0] = 180;
				exit;
				}
			}
		
		//If the trainer party doesn't have any monsters remaining, check which message we need to send and apply it 
		if (trainer){
			battle_msg[0] = string(trainer_end_msg);
			menu = battl.outro;
			}
		else menu = battl.uwon;
		//If this is a trainer battle, display our trainer end message. Otherwise, end the battle on the next key press
		}
	}

if menu == battl.uwon or menu == battl.outro{
	
	if menu == battl.outro{
		if trainer_offset < 144 trainer_offset+=3;
		}
	
	if press(ENTER) room_goto(curr_rm);
	
}

if menu == battl.ulost{
	
	battle_msg[0] = "An utter defeat....";
	if press(ENTER) game_restart();

}

if alarm[0] > 0{
	if press(ENTER) alarm[0] = 10;
}