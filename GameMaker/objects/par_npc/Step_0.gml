
//Change depth based players location in relation to ours
if y < obj_player.y depth = obj_player.depth + 1;
else depth = obj_player.depth - 1

//Display our dialogue and lock the player in place while talking
if press(ENTER)  and pause == 0 and !instance_exists(obj_battle_transition){
	//audio_play_sound(snd_menu_blip_01, 1, 0);
	if talking == true{
		
		//Reset needed vars
		if (scrolling){
			if drawn_text != dialogue[msg]{
				drawn_text = dialogue[msg];
				exit;}
			else drawn_text = "";
			}
		
		//Cycle through the list of messages
		if msg < msgs msg++;
		else{
			//If we're done talking, reset "msg" to 0 and allow player movement again
			msg = 0;
			talking = false;
			interacting = 0;
			
			//Additionally, if we have a list of actions, perform them as needed based on our character value
			if is_array(actions){
				script_execute_ext(actions[characters[char]].scr, actions[characters[char]].args);
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
			scr_check_quests();
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