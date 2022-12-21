RELOAD

var xx = 0, yy = 0;

if menu == monmae._player{
	paint(xx, yy, spr_monmae);
	for (var i = 0; i < 6; i++;){
		paint(xx+32 + (i*16), yy+15, spr_grass);
		paint(xx+32 + (i*16), yy+15 + 16, spr_grass);
		}
	
	//Draw player previews
	paint(xx+25, yy+6, spr_player_preview);
	paint(xx+40, yy+24, spr_player_walk_d, image_index);
	paint(xx+72, yy+24, spr_player_walk_u, image_index);
	paint(xx+101, yy+24, spr_player_walk_r, image_index);
	
	paint(xx+70, yy+56, spr_player_editor_buttons);
	paint(xx+120, yy+56, spr_editor_speed_box);
	paint(xx+36, yy+56, spr_red_arrow, image_index, -1, 1);
	paint(xx+104, yy+56, spr_red_arrow, image_index);

	
	yy+=66;
	for (var i = 0; i < 6; i++;){
		paint(xx+32 + (i*16), yy+15, spr_grass);
		paint(xx+32 + (i*16), yy+15 + 16, spr_grass);
		}
	
	paint(xx+25, yy+6, spr_player_preview);
	paint(xx+40, yy+24, spr_player_walk_d, image_index);
	paint(xx+72, yy+24, spr_player_walk_u, image_index);
	paint(xx+104, yy+24, spr_player_walk_r, image_index);
	
	paint(xx+70, yy+56, spr_player_editor_buttons);
	paint(xx+120, yy+56, spr_editor_speed_box);
	paint(xx+36, yy+56, spr_red_arrow, image_index, -1, 1);
	paint(xx+104, yy+56, spr_red_arrow, image_index);
	
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
			alpha();
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
			alpha();
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
			alpha();
			}
	
		var type1 = mondex[sel[1], dex.element1], type2 = mondex[sel[1], dex.element2];
		paint(cx+104, cy+45, spr_icon_types, type1);
		if type2 != -1 paint(cx+139, cy+45, spr_icon_types, type2);
	
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

format(c_white, 1, fn_yana5x5, 0, 0);
text(2, 108, round(mouse_x));
text(2, 114, round(mouse_y));

draw_text_ext(209, 141, draw_message, 7, 77);