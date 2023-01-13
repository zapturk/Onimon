RELOAD

if editing_move_exception != 0{

	var xx = display_get_gui_width()/2, yy = display_get_gui_height()/2;
	var sc = window_get_width()/room_width, tsc = sc/2;
	
	format(c_black, 0.33);
	draw_rectangle(0, 0, xx*2, yy*2, 0);
	format(c_white, 1, fn_yana);
	
	switch (editing_move_val){
		
		case move.sprite:
			var o = 0, l = ds_list_size(move_sprites);
			for (var i = 0; i < l+1; i++;){
				var move_to_draw = asset_get_index(string(ds_list_find_value(move_sprites, l-i-1)));
				if sprite_exists(move_to_draw){
					paint(56*sc + ((i-(o*4)) * (64*sc)), scroll+32*sc + (o * (64*sc)), move_to_draw, -1, sc, sc);
					if point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), (56-28)*sc + ((i-(o*4)) * (64*sc)), scroll+(32-28)*sc + (o * (64*sc)), (56+28)*sc + ((i-(o*4)) * (64*sc)), scroll+(32+28)*sc + (o * (64*sc))){
						
						//Set this moves sprite to the one we clicked
						if mouse(){
							movedex[sel[2], sel[3]] = (asset_get_index(string(ds_list_find_value(move_sprites, (l-i-1)))));
							ds_list_clear(move_sprites);
							
							instruction = -1;
							user_string = -1;
							editing_move_val = -1
							editing_move_exception = 0;
							
							exit;
							}
													
						alpha(0.25);
						draw_rectangle((56-28)*sc + ((i-(o*4)) * (64*sc)), scroll+(32-28)*sc + (o * (64*sc)), (56+28)*sc + ((i-(o*4)) * (64*sc)), scroll+(32+28)*sc + (o * (64*sc)), 0);
						alpha();
						}
					}
				if (i+1) == 4 or (divisible_by((i+1), 4) == 1) o++;
				}
			
			if mouse_wheel_up() and scroll < 0 scroll += 50;
			if mouse_wheel_down() scroll -= 50;
			break;
	
		case move.element:
		//Paint the information window and what we're typing
		paint(xx, yy - (22*sc), spr_get_type, 0, sc, sc);
		text(xx - (82*sc), yy - (20*sc), instruction, tsc+1);
		break;
		}

	exit;
	}

if instruction != -1{
	var xx = display_get_gui_width()/2, yy = display_get_gui_height()/2;
	var sc = window_get_width()/room_width, tsc = sc/2;
	sc *= 1.25;
	tsc *= 1.25;
	
	format(c_black, 0.33);
	draw_rectangle(0, 0, xx*2, yy*2, 0);
	
	format(col[COL_RED, 3], 1, fn_yana, 0);
	//Paint the information window and what we're typing
	paint(xx, yy - (22*sc), spr_get_string, 0, sc, sc);
	text(xx - (66*sc), yy - (20*sc), instruction, tsc+1);
	
	var default_message = "";
	if user_string == ""{
		switch (typing){
			case -1: break;
			case dex.evolve:
				default_message = "Start Typing..\nMin: 2\nMax 99";
				break;
			default:
				default_message = "Start Typing..";
			}
		switch (editing_move_val){
				
				case move.animation:
					default_message = "Start Typing..\n- 0: Animate over Enemy    1: Animation Over Self\n"
					+ "- 2: Projectile              3: Whole Room";
					break;
				
				case move.priority:
					default_message = "Start Typing..\nDefault is 0, with a Range from -4 to +4\nHigher priority moves always go first";
					break;
				
				case move.chance_status: case move.chance_flinch:
					default_message = "Start Typing..\nRange from 0 to 100% chance";
					break;
					
				case move.chance_stat:
					default_message = "Start Typing..\nRange from 0 to 100% chance\nChance is applied to all stat changes";
					break;
					
				case move.recoil_amnt:
					default_message = "Start Typing..\nRecoil Damage is based Max Health";
					break;
				
				default:
					default_message = "Start Typing..";
				}
		text(xx - (64*sc), yy - (8*sc), default_message	, tsc);
		}
	else text(xx - (64*sc), yy - (8*sc), user_string, tsc, 130*2);
	
	//Set the string maximum based on what we're editing
	switch (typing){
		case dex.name:
			user_string = get_name(user_string, 16);
			break;
		case dex.sub_descrip:
			user_string = get_name(user_string, 32);
			break;
		case dex.descrip:
			user_string = get_name(user_string, 128);
			break;
		case dex.evolve:
			user_string = get_number(user_string, 3);
			break;
		default:
			//Do nothing;
			}
		
	switch (editing_move_val){
		
		case move.name:
			user_string = get_name(user_string, 16);
			break;
		case move.description:
			user_string = get_name(user_string, 32);
			break;
		
		case move.power: case move.healing: case move.accuracy: case move.chance_status:
		case move.chance_flinch: case move.chance_stat: case move.flat_dmg_amnt: case move.recoil_amnt:
			user_string = get_number(user_string, 4);
			break;
		
		case move.mana:
			user_string = get_number(user_string, 3);
			break;
		
		//priority, ally stats, enemy stats, 
		default:
			user_string = get_number(user_string, 2);
			break;
		
		}
		
	//Apply user string to the monsters DEX data upon pressing enter 
	if press(vk_enter){
		switch(typing){
			
			case -1: break;
				
			case dex.name: case dex.sub_descrip: case dex.descrip:
				mondex[sel[1], typing] = user_string;
				break;
				
			case dex.evolve:
				mondex[sel[1], dex.evolve] = real(user_string);
				break;
			
			}
		switch(editing_move_val){
		
			case -1: case move.sprite: case move.element: case move.status: break;
		
			case move.name: case move.description:
				 movedex[sel[2], sel[3]] = user_string;
				 break;

			default: movedex[sel[2], sel[3]] = real(user_string);
			}
		
		editing_move_val = -1;
		instruction = -1;
		user_string = -1;
		del_tmr = 30;
		typing = -1;
		}
	
	}

