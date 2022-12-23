RELOAD


if instruction != -1{
	var xx = display_get_gui_width()/2, yy = display_get_gui_height()/2;
	var sc = window_get_width()/room_width, tsc = sc/2;
	
	format(c_black, 0.33);
	draw_rectangle(0, 0, xx*2, yy*2, 0);
	
	format(col[COL_RED, 3], 1, fn_yana, 0);
	//Paint the information window and what we're typing
	paint(xx, yy, spr_get_string, 0, sc, sc);
	text(xx - (66*sc), yy - (20*sc), instruction, tsc+1);
	
	if user_string == "" text(xx - (64*sc), yy - (8*sc), "Start Typing..", tsc);
	else text(xx - (64*sc), yy - (8*sc), user_string, tsc, 138*2);
	
	//Set the string maximum based on what we're editing
	switch (typing){
		case dex.name:
			user_string = get_name(user_string, 16);
			break;
		case dex.sub_descrip:
			user_string = get_name(user_string, 32);
			break;
		default:
			user_string = get_name(user_string, 999);
			}
		
	//Apply user string to the monsters DEX data upon pressing enter 
	if press(vk_enter){
		switch(typing){
			case dex.name:
				mondex[sel[1], dex.name] = user_string;
				break;
			case dex.sub_descrip:
				mondex[sel[1], dex.sub_descrip] = user_string;
				break;
			case dex.descrip:
				mondex[sel[1], dex.descrip] = user_string;
				break;
			}
		instruction = -1;
		user_string = -1;
		del_tmr = 30;
		typing = -1;
		}
	
	}