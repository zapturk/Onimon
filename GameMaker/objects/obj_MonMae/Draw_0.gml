RELOAD

var xx = 0, yy = 0;

if menu == monmae._player{
	paint(xx, yy, spr_monmae);
	for (var i = 0; i < 6; i++;){
		paint(xx+32 + (i*16), yy+15, spr_grass);
		paint(xx+32 + (i*16), yy+15 + 16, spr_grass);
		}
	
	format(col[COL_RED, 0], 1, fn_yana5x5);
	
	#region Draw player previews
	paint(xx+25, yy+6, spr_player_preview);
	draw_sprite_part(spr_players_index, 0, action*20, (playable_character)*22, 20, 22, xx+38, yy+18);
	draw_sprite_part(spr_players_index, 0, (action+8)*20, (playable_character)*22, 20, 22, xx+70, yy+18);
	draw_sprite_part(spr_players_index, 0, (action+12)*20, (playable_character)*22, 20, 22, xx+100, yy+18);
	
	if mouse(){
		if point_in_rectangle(mouse_x, mouse_y, 116, 57, 126, 67) walk_spd++;
		if point_in_rectangle(mouse_x, mouse_y, 34, 57, 44, 67) walk_spd--;
		if walk_spd > 8 walk_spd = 0;
		if walk_spd < 1 walk_spd = 1;
		walk_timer = 0;
		}
	
	paint(xx+80, yy+56, spr_visual_editor_buttons);
	paint(xx+44, yy+56, spr_red_arrow, image_index, -1, 1);
	paint(xx+116, yy+56, spr_red_arrow, image_index);
	text(xx+107, yy+53, string(walk_spd));
	
	yy+=66;
	for (var i = 0; i < 6; i++;){
		paint(xx+32 + (i*16), yy+15, spr_grass);
		paint(xx+32 + (i*16), yy+15 + 16, spr_grass);
		}
	
	paint(xx+25, yy+6, spr_player_preview);
	draw_sprite_part(spr_players_index, 0, run_action*20, (playable_character)*22, 20, 22, xx+38, yy+18);
	draw_sprite_part(spr_players_index, 0, (run_action+8)*20, (playable_character)*22, 20, 22, xx+70, yy+18);
	draw_sprite_part(spr_players_index, 0, (run_action+12)*20, (playable_character)*22, 20, 22, xx+100, yy+18);
	
	if mouse(){
		if point_in_rectangle(mouse_x, mouse_y, 116, 123, 126, 133) run_spd++;
		if point_in_rectangle(mouse_x, mouse_y, 34, 123, 44, 133) run_spd--;
		if run_spd > 9 run_spd = 9;
		if run_spd < 2 run_spd = 2;
		run_timer = 0;
		}
	
	paint(xx+80, yy+56, spr_visual_editor_buttons, 1);
	paint(xx+44, yy+56, spr_red_arrow, image_index, -1, 1);
	paint(xx+116, yy+56, spr_red_arrow, image_index);
	text(xx+106, yy+53, string(run_spd));
	#endregion
	
	walk_timer++;
	if walk_timer == round(60 / walk_spd){
		action++;
		walk_timer = 0;
		if action > 3 action = 0;
		}
		
	run_timer++;
	if run_timer == round(60 / run_spd){
		run_action++;
		run_timer = 0;
		if run_action > 3 run_action = 0;
		}
	
	var xx = 172, yy = 36;
	//Draw playable characters
	for (var i = 0; i < 3; i++;){
		for (var o = 0; o < 3; o++;){
			draw_sprite_part(spr_players_index, 0, action*20, (i + o + o + o)*22, 20, 22, xx + (i*26), yy + (o * 28));
			if mouse(){
				if point_in_rectangle(mouse_x, mouse_y, xx + (i*26), yy + (o * 30), xx+20 + (i*26), yy+22 + (o * 28)){
					playable_character = (i + (o*3));
					}
				}
			}
		}
	
	format(col[COL_RED, 3], 1, fn_yana5x5, 1, 0);
	//text(208, 44, "This screen is currently just for looks as we prepare to add"
	//+ " many new characters, varying shadows, and also visualzing the start_game script.", 102);
	
	}

if menu == monmae._monsters{
	
	//Paint background and helper tools
	var cx = 16, cy = 0;
	paint(xx, yy, spr_monmae, 1);
	paint_from_index(cx + 58, cy+8 + 56 + hobble[0], spr_monsters_battle, sel[1], 2);

	format(c_white, 1, fn_yana5x5, 1, 1);
	text(280, 8, string(sel[1]+1));

	timer++;
	if timer >= 10{
		hobble[0] += incr[0];
		if abs(hobble[0]) == 2 incr[0] = -incr[0];
		timer = 0;
		}
	
	cx-=20;
	cy+=10;
	format(c_white, 1, fn_yana5x5, 0, 0);
	#region Draw currently selected monster
	paint(cx+142, cy+31, spr_dokitech_slot, 0);
	paint_from_index(cx+162, cy+40 + mon_hop, spr_monsters_mini, sel[1]);
	
	color(hex($ED474C));
	var mon_num = string(sel[1]+1);
	switch (string_length(sel[1]+1)){
		case 1: mon_num = string_insert("NO. 00", mon_num, 1); break;
		case 2: mon_num = string_insert("NO. 0", mon_num, 1); break;
		case 3: mon_num = string_insert("NO. ", mon_num, 1); break;
		}
	
	text(cx+192, cy+27, mon_num);
	var name = mondex[sel[1], DEX_NAME];
	
	color();
	text(cx+182, cy+35, name);
	#endregion
	
	#region Draw the rest of the monsters
	for (var i = 0; i < 3; i++;){
		var mon = 1+i+sel[1];
		if mon < array_length(mondex){
			paint(cx+142, cy+54 + (i*20), spr_dokitech_slot, 1);
			paint_from_index(cx+162, cy+63 + (i*20), spr_monsters_mini, mon);
	
			font(fn_yana5x5);
			color(hex($ED474C));
			
			var mon_num = string(mon+1);
			switch (string_length(mon+1)){
				case 1: mon_num = string_insert("NO. 00", mon_num, 1); break;
				case 2: mon_num = string_insert("NO. 0", mon_num, 1); break;
				case 3: mon_num = string_insert("NO. ", mon_num, 1); break;
				}
			
			text(cx+192, cy+50 + (i*20), mon_num);
	
			color();
			var name = mondex[mon, DEX_NAME];
			text(cx+182, cy+58 + (i*20), name);
			}
		}
	#endregion
	
	}

if menu == monmae._monster_info{

	//Paint background
	var cx = 0, cy = 0;
	paint(cx, cy, spr_monmae, 2);
	format(c_white, 1, fn_yana5x5, 1, 1);
	text(280, 8, string(sel[1]+1));
	
	cx+=16;
	format(c_white, 1, fn_yana5x5, 1, 0);
	paint_from_index(cx + 50, cy+40 + hobble[0], spr_monsters_battle, sel[1]);
	
	paint_from_index(cx + 112, cy+68, spr_monsters_mini, sel[1]);
	paint_from_index(cx + 144, cy+68, spr_monsters_mini, sel[1]+1);
	paint(cx + 123, cy+64, spr_red_arrow);
	
	if mondex[sel[1], dex.evolve] < 1 paint(cx + 155, cy+64, spr_checkbox, 0);
	else paint(cx + 155, cy+64, spr_checkbox, 1);
	
	if typing == -1{
		//Check for player mouse input for editing a monsters name
		if point_in_rectangle(mouse_x, mouse_y, 122, 11, 208, 20){
	
			color();
			alpha(0.33);
			draw_rectangle(122, 11, 208, 20, 0);
			if mouse(){
				user_string = "";
				typing = dex.name;
				instruction = "Type Monster Name";
				}
			}
		
		//Check for player mouse input for editing a monsters sub-description
		if point_in_rectangle(mouse_x, mouse_y, 124, 26, 240, 35){
	
			alpha(0.33);
			color(col[COL_RED, 1]);
			draw_rectangle(124, 26, 240, 35, 0);
			if mouse(){
				user_string = "";
				typing = dex.sub_descrip;
				instruction = "Type Monster Sub-Description";
				}
			}
		
		//Check for player mouse input for editing a monsters sub-description
		if point_in_rectangle(mouse_x, mouse_y, 32, 89, 255, 133){
	
			alpha(0.33);
			color(col[COL_RED, 1]);
			draw_rectangle(32, 89, 255, 133, 0);
			if mouse(){
				user_string = "";
				typing = dex.descrip;
				instruction = "Type Monster Main Description";
				}
			}
			
		//Check for player mouse input for evolving
		if mouse(){
			if point_in_rectangle(mouse_x, mouse_y, 172, 65, 182, 75){
				if mondex[sel[1], dex.evolve] < 1{
					user_string = "";
					typing = dex.evolve;
					instruction = "Type Level to Evolve at";
					}
				else mondex[sel[1], dex.evolve] = 0;
				}
			}

		alpha();
		var type1 = mondex[sel[1], dex.element1], type2 = mondex[sel[1], dex.element2];
		paint(cx+104, cy+45, spr_icon_types, type1);
		if type2 != -1 paint(cx+139, cy+45, spr_icon_types, type2);
		else paint(cx+139, cy+45, spr_icon_types, 13);
		paint(cx+202, cy+45, spr_visual_editor_buttons, 3);
	
		//Check for player mouse input for editing a monsters element
		if point_in_rectangle(mouse_x, mouse_y, 119, 44, 152, 56){
	
			format(c_white, 0.25);
			draw_rectangle(119, 44, 152, 56, 0);
			if mouse(){
				mondex[sel[1], dex.element1]++;
				if mondex[sel[1], dex.element1] == (element.fairy+1) mondex[sel[1], dex.element1] = 0;
				}
			alpha();
			}
		
		//Check for player mouse input for editing a monsters element
		if point_in_rectangle(mouse_x, mouse_y, 154, 44, 187, 56){
	
			format(c_white, 0.25);
			draw_rectangle(154, 44, 187, 56, 0);
			if mouse(){
				mondex[sel[1], dex.element2]++;
				if mondex[sel[1], dex.element2] == (element.fairy+1) mondex[sel[1], dex.element2] = -1;
				}
			alpha();
			}
		}
	else{
		//If we are typing, skip all the point_in_rectangle and mouse checks, but still draw our elements
		var type1 = mondex[sel[1], dex.element1], type2 = mondex[sel[1], dex.element2];
		paint(cx+104, cy+45, spr_icon_types, type1);
		if type2 != -1 paint(cx+139, cy+45, spr_icon_types, type2);
		else paint(cx+139, cy+45, spr_icon_types, 13);
		paint(cx+202, cy+45, spr_visual_editor_buttons, 3);
	}
	
	timer++;
	if timer >= 10{
		hobble[0] += incr[0];
		if abs(hobble[0]) == 2 incr[0] = -incr[0];
		timer = 0;
		}
	
	var mon_num = string(sel[1]+1);
	switch (string_length(sel[1]+1)){
		case 1: mon_num = string_insert("NO. 00", mon_num, 1); break;
		case 2: mon_num = string_insert("NO. 0", mon_num, 1); break;
		case 3: mon_num = string_insert("NO. ", mon_num, 1); break;
		}
		
	color();
	halign(0);
	font(fn_yana5x5);
	text(cx+202, cy+5, string(mon_num));
	
	font(fn_yana);
	var name = mondex[sel[1], DEX_NAME];
	text(cx+110, cy+8, string(name));
	
	color(hex($7F3D3F));
	var sub = mondex[sel[1], DEX_SUB_DESCR];
	var descr = mondex[sel[1], DEX_DESCRIPTION];
	text(cx+110, cy+23, string(sub));
	
	halign(1);
	text(cx+128, cy+88, string(descr), 212);
	
	}

if menu == monmae._monster_moves{

	//Paint background
	var cx = 0, cy = 0;
	paint(cx, cy, spr_monmae, 3);
	format(c_white, 1, fn_yana5x5, 1, 1);
	text(280, 8, string(sel[2]+1));
	
	cx+=16;
	format(c_white, 1, fn_yana5x5, 1, 0);
	paint_from_index(cx + 50, cy+40, spr_monsters_battle, sel[1]);
	
	paint(cx + 50, cy+40, movedex[sel[2], move.sprite], -1);
	color();
	halign(0);
	font(fn_yana);
	text(cx+110, cy+3, "Moves List");
	
	halign(1);
	color(col[COL_RED, 3]);
	var descr = movedex[sel[2], move.description];
	text(cx+128, cy+88, string(descr), 212);
	
	for (var i = 0; i < 5; i++;){
		halign(0);
		var ii = i + sel[2];
		
		if ii < array_length(movedex){
			color(col[COL_RED, 3]);
			text(cx+112, cy+18 + (i*10), string(movedex[ii, move.name]));
		
			halign(2);
			color(col[COL_RED, 1]);
			var element_string = GET_MOVE_STRING(ii, MOVE_ELEMENT);
			text(cx+228, cy+18 + (i*10), element_string);
			}
		}
	
	//Highlight the selected move (the one at the top) so we know what we're editing
	halign(0);
	color(col[COL_RED, 1]);
	text(cx+112, cy+18, string(movedex[sel[2], move.name]));
	}

if menu == monmae._monster_moves_info{

	//Paint background
	var cx = 0, cy = 0;
	paint(cx, cy, spr_monmae, 3);
	format(c_white, 1, fn_yana5x5, 1, 1);
	text(280, 8, string(sel[2]+1));
	
	cx+=16;
	format(c_white, 1, fn_yana5x5, 1, 0);
	paint_from_index(cx + 50, cy+40, spr_monsters_battle, sel[1]);
	
	if editing_move_exception == 0 paint(cx + 50, cy+40, movedex[sel[2], move.sprite], -1);
	
	timer++;
	if timer >= 10{
		hobble[0] += incr[0];
		if abs(hobble[0]) == 2 incr[0] = -incr[0];
		timer = 0;
		}
	
	color();
	halign(0);
	font(fn_yana);
	var name = movedex[sel[2], move.name];
	text(cx+110, cy+3, string(name));

	halign(1);
	color(col[COL_RED, 3]);
	var descr = movedex[sel[2], move.description];
	text(cx+128, cy+88, string(descr), 212);
	
	for (var i = 0; i < 5; i++;){
		halign(0);
		var ii = i + sel[3];
		
		if ii < array_length(movedex[0]){
			color(col[COL_RED, 3]);
			//Tell us what part of the move we are editing
			text(cx+112, cy+18 + (i*10), string(move_arg_string[ii]));
		
			//Run our ii information through a simple function to return us the proper values to draw
			get_move_value_strings(movedex[sel[2], ii], ii);
			
			halign(2);
			color(col[COL_RED, 3]);
			//Tell us what the current value of what we are editing is
			text(cx+228, cy+18 + (i*10), move_value_string);
			}
		}
		
	//Run similar code to the for loop but with edited values to only display once, and for our selected move
	get_move_value_strings(movedex[sel[2], sel[3]], sel[3]);
			
	halign(0);
	color(col[COL_RED, 1]);
	//Draw over this in red if this is what's selected
	text(cx+112, cy+18, string(move_arg_string[sel[3]]));
		
	halign(2);
	//Draw over this in red if this is what's selected
	text(cx+228, cy+18, move_value_string);
	
	if editing_move_exception != 0{
		
		}
	}

format(c_white, 1, fn_yana5x5, 0, 0);
text(2, 142, round(mouse_x));
text(2, 148, round(mouse_y));

draw_text_ext(209, 141, draw_message, 7, 77);

if flash > 0{
	
	color(c_white);
	alpha(flash*0.5);
	draw_rectangle(0, 0, room_width, room_height, 0);
	flash -= 0.05;
	alpha();
	}