//GMLive
RELOAD

//Change depth based players location in relation to ours
if y < obj_player.y depth = obj_player.depth + 1;
else depth = obj_player.depth - 1

//Display our dialogue and lock the player in place while talking
if press(ENTER) and pause == 0 and !instance_exists(obj_battle_transition){
	//audio_play_sound(snd_menu_blip_01, 1, 0);
	if talking == true{
		
		//Reset needed vars
		if (scrolling){
			if drawn_text != dialogue[msg]{
				drawn_text = dialogue[msg];
				exit;
				}
			else drawn_text = "";
			}
		
		//Cycle through the list of messages
		if msg < msgs msg++;
		else{
			
			//If we haven't battled this trainer yes, or they are a rebattleable trainer, continue to the next set of checks.
			if rebattleable == 0{
				if trainers[trainer_num] >= 1{
					//If we've already battled this NPC, return movement to the player like a normal NPC
					msg = 0;
					talking = false;
					interacting = 0;
					exit;
					}
				}
			
			//If this trainer has been assigned a team, start the battle
			if my_team[0, 0] != -1{
				
				//Delete data from the last trainer
				RESET_ENEMY();
				
				var o = 0;
				//If we have a team, loop through my assigned team members, and add them to the global enemy array
				for (var i = 0; i < 6; i++;){
					if my_team[i, 0] != -1{
						for (var o = 0; o < array_length(eparty[0]); o++;){
							eparty[i, o] = my_team[i, o];
							}
						
						//Overwrite health with max health this monster has based on it's level and base stats
						eparty[i, party.health] = GET_STAT(ENEMY, MAX_HEALTH_SUM, i);
						}
					}
				
				trainer = 1;
				trainer_img = npc_image;
				TRAINER_assign_battle_text(TXT_message);
				talking = -1;
				rotate = -1;
				
				//If this trainer is not rebattleable, update their boolean in the "trainers" array to 1, so that we can't rebattle them later
				if rebattleable == 0{
					if trainer_num == -1 show_message("This trainer at X: " + string(x) + "Y: " + string(y) + " hasn't been given a \"trainer_num\" value.\n"
					+ "Please assign them a UNIQUE value between 0 and 99 from their instance variables by double clicking them in the room editor.\n"
					+ "This is essential for tracking what trainers have and haven't been battled yet. You can also set rebattleable to true instead.");
					else trainers[trainer_num]++;
					}
				
				//Start the battle
				with obj_camera{
					battle_start = 1;
					flash = 1;
					}
				}
			else{
				//Else, return movement to the player like a normal NPC
				msg = 0;
				talking = false;
				interacting = 0;
				show_message("Trainer has not been assigned a team.\nPlease see the \"Create a Trainer\""
				+ " and add monsters to this trainers team in their instance creation code from the room editor.");
				}
			}
		}
	else{
		//If we are not yet talking, start the cycle
		if interact == id{
		
			//Set my facing direction based on which side the player is on
			if py == y{
				if px > x dir = 3;
				else dir = 1;
				}
			if px == x{
				if py < y dir = 2;
				else dir = 0;
				}
			
			talking = true;
			interacting = 1;
			trainer_num = TXT_message;
			msgs = array_length(dialogue)-1;
			}
		}
	}

//If we are talking, don't let me rotate around
if (talking) exit;

//If we've set rotate to -1, don't rotate this NPC at all
if rotate == -1 exit;

//Rotate the character around randomly
if rotate == 0{
	dir = irandom_range(0, 3);
	rotate = irandom_range(60, 300);
	}
else if rotate > 0 rotate--;