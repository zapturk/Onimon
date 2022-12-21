RELOAD

#region Camera
var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var pm = matrix_build_projection_ortho(_cam_width, _cam_height, depth, 10000);

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);

if instance_exists(obj_player){
	var tarx = obj_player.x, tary = obj_player.y;
	if (battle_start){
		tary = py - 160;
	
		if alph > 0{
			_cam_width -= 3;	//16
			_cam_height -= 2;	//9
			}
		exit;
		}

	view_camera[0] = cam;
	
	if (smooth_camera){
		x += (tarx - x)/5;
		y += (tary - y)/5;
		}
	else{
		x = (tarx);
		y = (tary);
		}
	}

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
camera_set_view_mat(cam, vm);


#endregion

#region Pause

if press(ESCAPE){
	//If we are not paused, pause the game
	if pause == 0{
	
		//If the player is not moving, pause the game
		if px == obj_player.target_x and py == obj_player.target_y{
			pause = 1;
			exit;
			}
		}
	
	//Otherwise, perform specific things based on which menu we are paused into
	else{
		switch (pause){
			case _pause.mondex:
				pause = _pause.dtech;
				sel[1] = 0;
				break;
			case _pause.mondex_info:
				pause = _pause.mondex;
				break;
			case _pause.party:
				if float_mon != -1{
					float_mon = -1;
					sel[2] = -1;
					float = -1;
					exit;
					}
				else{
					if sel[2] == -1 pause = _pause.paused;
					}
				if sel[2] > -1{
					sel[2] = -1;
					exit;
					}
				break;
			case _pause.info:
				if sel[4] > 0{
					sel[2] = -1;
					sel[4] = 0;
					break;
					}
				if sel[3] > 0{
					sel[3] = 0;
					break;
					}
				sel[2] = -1;
				sel[3] = 0;
				sel[4] = 0;
				pause = _pause.party;
				break;
			case _pause.pc:
				room_goto(curr_rm);
				pause = _pause.dtech
				sel[1] = 1;
				break;
			default:
				unpause();
			}
		}
	}

if pause == 1{
	if press(UP) and sel[0] > 0 sel[0]--;
	if press(DOWN) and sel[0] < 5 sel[0]++;
	if press(ENTER){
		if sel[0] == 0 pause = _pause.dtech;
		if sel[0] == 1 pause = _pause.party; sel[2] = -1;
		//if sel[0] == 2 pause = _pause.inventory;
		if sel[0] == 3 pause = _pause.idcard;
		if sel[0] == 4{
			save();
			//show_message("Game has been saved. Press DEL in Title screen to delete your save.");
			pause = 0;
			sel[0] = 0;
			}
		if sel[0] == 5 pause = _pause.logoff
		clear(ENTER);
		}
	}

if pause == _pause.dtech{
	if press(RIGHT) sel[1] = 1;
	if press(LEFT) sel[1] = 0;
	if press(UP) or press(DOWN){
		if sel[1] == 2 sel[1] = 0;
		else sel[1] = 2;
		}
	if press(ENTER){
		switch (sel[1]){
			case 0:
				pause = _pause.mondex;
				clear(ENTER);
				sel[1] = 0;
				break;
			case 1:
				//Only let us access our PC if we're in a safe area
				if (safe_areas() == 1){
					start_x = px;
					start_y = py;
					curr_rm = room;

					pause = _pause.pc;
					clear(ENTER);
					
					room_goto(rm_pc);
					}
				break;
			case 2:
				url_open("https://twitter.com/yanako_rpgs");
				clear(ENTER);
				break;
			}
		}
	}

if pause == _pause.mondex{

	//Allow us to move up and down in the DokiTech Monster Dex Screen
	if press(UP) and sel[1] > 0 sel[1]--;
	if press(DOWN) and sel[1] < array_length(mondex)-1 sel[1]++;
	if press(RIGHT){
		sel[1] += 10;
		if sel[1] > array_length(mondex) sel[1] = array_length(mondex) - 1;
		}
	if press(LEFT){
		sel[1] -= 10;
		if sel[1] < 0 sel[1] = 0;
		}
	
	if press(ENTER){
		pause = _pause.mondex_info;
		}
	}

if pause == _pause.mondex_info{
	if press(UP) and sel[1] > 0 sel[1]--;
	if press(DOWN) and sel[1] < array_length(mondex) sel[1]++;
	}

if pause == _pause.party{
	var mon = sel[1];
	
	//Get player input
	if press(ENTER){
		switch sel[2]{
			case -1:
				sel[2] = 0;
				exit;
			case 0:
				sel[2] = 2;
				break;
				//exit;
			case 1:
				pause = _pause.info;
				sel[2] = 0;
				exit;
			}

		//audio_play_sound(snd_menu_click, 0, 0);
					
		//If our float array is empty
		if !is_array(float){
						
			//If the slot is not empty, select this monster to soon be moved
			if monsters[mon, 0] != -1 SELECT(mon);
			}
					
		//If our float array IS populated and we have selected a monster, switch them
		else{
			SWITCH(mon);
			sel[2] = -1;
			}
		}
	//Get player input
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
	}

if pause == _pause.info{

	if press(BACK){
		sel[2] = -1;
		sel[3] = -1;
		pause = _pause.party
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
			sel[2] = 2;
			sel[4] = 1;
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

if pause == _pause.pc{
	
	if press(ENTER){
		//If we're selecting the box, do nothing
		if sel[1] == -1 exit;
		
		//If we're selecting Party/Close, perform the appropriate action
		if sel[1] == -2{
			//If we click "CLOSE PC"
			if sel[4] == 0{
				
				//Reset PC sel's to default
				for (var i = 0; i < 5; i++;){
					sel[i] = 0;		
					}
					
				room_goto(curr_rm);
				pause = _pause.dtech
				sel[1] = 1;
				}
			//If we click PARTY, open the party
			if sel[4] == 1{
				sel[1] = 0;
				sel[3] = 1;
				}
			exit;
			}
		
		// + 6 because first six slots are for party. Sel[2] * 30 for PC boxes	
		if sel[3] == 0 var mon = (6 + sel[0] + (sel[1] * 6)) + (sel[2]*30);
		else mon = sel[3]-1;
		
		//If our float array is empty
		if !is_array(float){
			//Don't let use remove the last monster in our party
			if mon == 0 and monsters[1, 0] == -1 exit;
			
			//If the slot is not empty, pick up the monster
			if monsters[mon, 0] != -1 PICKUP(mon);
			}
					
		//If our float array IS populated and we are holding a monster
		else DROP(mon);
		}
	if press(ESCAPE){
		if (showinfo){
		showinfo = 0;
		exit;
		}
		
		if float == -1{
			pause = 0;
			room_goto(curr_rm);
			}
		else exit;
		for (var i = 0; i < array_length(sel); i++;){
			sel[i] = 0;
			}
		exit;
		}
	
	//If we're selecting the party or close menu boxes
	if sel[1] == -2{
		if press(UP) sel[4] = 0;
		if press(RIGHT) or press(LEFT){
			if sel[4] == 0 sel[4] = 1;
			else sel[4] = 0;
			}
		if press(DOWN) sel[1]++;
		exit;
		}
	
	//If we are in the PC's PARTY Menu
	if sel[3] != 0{
		if press(UP){
			sel[3] --;
			if sel[3] = 0 sel[3] = 6;
			}
		if press(DOWN){
			sel[3] ++;
			if sel[3] > 6 sel[3] = 1;
			}
		if press(LEFT) or press(RIGHT){
			sel[0] = 5;
			sel[1] = 0;
			sel[3] = 0;
			}
		exit;
		}
	
	//Get Player Directional Input
	//Welcome to Sphagetti Junction, made and manufactured by Yanako RPGs
	if press(RIGHT){
		if (showinfo){
			showinfo++;
			//if showinfo > 2 showinfo--;
			exit;
			}
		//If we're hovering over the boxes slider
		if sel[1] == -1{
			sel[2]++;
			if sel[2] > 5 sel[2] = 0;
			exit;
			}
		sel[0]++;
		if sel[0] == 6 sel[0] = 0;
		}
	if press(LEFT){
		//If we're hovering over the boxes slider
		if sel[1] == -1{
			sel[2]--;
			if sel[2] < 0 sel[2] = 5;
			exit;
			}
		sel[0]--;
		if sel[0] == -1 sel[0] = 5;
		}
	if press(UP){
		sel[1]--;
		if sel[1] == -1 sel[0] = 2;
		if sel[1] == -2{
			if !is_array(float){
				sel[4] = 1;
				}
			else{
				sel[1] = 0;
				sel[3] = 1;
				}
			}
		}
	if press(DOWN){
		sel[1]++;
		if sel[1] == 5 sel[1]++;
		if sel[1] > 5{
			sel[0] = 3;
			sel[1] = -1;
			}
		if sel[1] == 5 sel[0] = 0;
		}	
	}
#endregion