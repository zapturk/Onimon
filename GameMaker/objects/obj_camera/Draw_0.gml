/*
x / y = center 
var cx = x + _cam_width/2, cy = y - _cam_height/2;
*/
RELOAD

if alarm[4] != -1{
	paint(x-_cam_width/2, y-_cam_height/2, spr_new_area);
	
	format(col[COL_RED, 3], 1, fn_yana, 0, 0);
	text(x-122, y-72, string(area));
	}

if (battle_start){
	alph += 0.03;
	alpha(alph);
	color(c_black);
	draw_rectangle(x-500, y-500, x+500, y+500, 0);
	alpha();
	
	if alph >= 1{
		start_x = px;
		start_y = py;
		curr_rm = room;
		room_goto(rm_battle);
		}
	}
if flash > 0{
	flash -= 0.075;
	alpha(flash);
	color(c_white);
	draw_rectangle(x-500, y-500, x+500, y+500, 0);
	alpha();
	}

if pause == 1{
	var cx = x + _cam_width/2, cy = y - _cam_height/2;
	paint(cx, cy, spr_pause);
	
	halign(0);
	valign(0);
	font(fn_yana);
	color(hex($2E222F));
	draw_text_ext(cx-42, cy+2, "D-Tech\nParty\nItems\nID Card\nSaving\nLog off", 14, -1);
	color();

	paint(cx-48, cy+6 + (sel[0] * 14), spr_cursor_pause);
	}

if pause == _pause.dtech{
	var cx = x, cy = y;
	paint(cx, cy, spr_smartwatch, sel[1]);
	}

if pause == _pause.mondex{
	var cx = x - _cam_width/2, cy = y - _cam_height/2;
	paint(cx, cy, spr_dokitech_dex);
	paint_from_index(cx + 58, cy+8 + 56 + hobble[0], spr_monsters_battle, sel[1], 2);
	
	timer++;
	if timer >= 10{
		hobble[0] += incr[0];
		if abs(hobble[0]) == 2 incr[0] = -incr[0];
		timer = 0;
		}
	
	halign(0);
	font(fn_yana5x5);
	color(hex($ED474C));
	text(cx+2, cy+123, "Seen: 80");
	text(cx+2, cy+130, "Caught: 36");
	//var type1 = mondex[sel[1], dex.element1], type2 = mondex[sel[1], dex.element2];
	//paint(cx+8, cy+130, spr_icon_types, type1);
	//if type2 != -1 paint(cx-12, cy+103, spr_icon_types, type2);
	
	cx-=20;
	cy+=10;
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

if pause == _pause.mondex_info{
	var cx = x - _cam_width/2, cy = y - _cam_height/2;
	paint(cx, cy, spr_dokitech_dex, 1);
	paint_from_index(cx + 50, cy+40 + hobble[0], spr_monsters_battle, sel[1]);
	
	var type1 = mondex[sel[1], dex.element1], type2 = mondex[sel[1], dex.element2];
	paint(cx+104, cy+45, spr_icon_types, type1);
	if type2 != -1 paint(cx+139, cy+45, spr_icon_types, type2);
	
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

if pause == _pause.party{
	
	//spr_party_monsters frame macros	
	alpha(0.66);
	color(c_black);
	format(col[COL_PURPLE, 3], 1);
	var xx = x-80, yy = y-_cam_height/2;
	
	draw_sprite_tiled(spr_purple_doublesquare, 0, xx + scrolling_bg_x, yy + scrolling_bg_y);
	paint(x, y, spr_party);
	
	if sel[2] == -1 or sel[2] == 2 text(xx-38, yy+131, "Choose a Dokimon");
	else{
		text(xx-27, yy+131, "Switch   Info");
		paint(x-116+(sel[2]*49), y-17+_cam_height/2, spr_cursor_w, 0, 1, 1, col[COL_PURPLE, 3]);
		}
	color();

	//Slowly scroll the looping background 
	scrolling_bg_x += 0.15;
	scrolling_bg_y += 0.15;
		
	//Draw Party
	format(c_white, 1, fn_yana5x5, 0, 1);
	for (var i = 0, ii = 0; i < 6; i++;){
		var xx = x-118, yy = y - _cam_height/2 - 12;
		
		//Elevate the monster we're hovering
		if sel[1] == i yy -= 2;
		
		//Draw background box
		var o = 0;
		if divisible_by(i+1, 2) o = 1;
		
		//Draw monsters IF we have them in these slots
		if monsters[i, 0] != -1{
			var num =  monsters[i, 0], name = mondex[monsters[i, 0], dex.name],
			level = monsters[i, party.level], hp = string(round(monsters[i, party.health])), max_hp = string(GET_STAT(PLAYER, MAX_HEALTH_SUM, i));
			var x_spacer = 120, y_spacer = 39, _healthbar = hp / max_hp, xp = string(round(monsters[i, party.exp])),
			max_xp = string(GET_STAT(PLAYER, MAX_EXP_SUM, i));
			var _expbar = xp / max_xp;
			
			alpha(0.8);
			//Draw the monster and their name if one exists in this slot
			if float_mon != -1{
				if float_mon == i{
					if sel[1] == i paint(xx+1+(o*x_spacer), yy+18+(ii*y_spacer), spr_party_monbox, MOVIN);
					else paint(xx+1+(o*x_spacer), yy+18+(ii*y_spacer), spr_party_monbox, MOVTO);
					}
				else{
				if sel[1] == i paint(xx+1+(o*x_spacer), yy+18+(ii*y_spacer), spr_party_monbox, MOVIN);
				else paint(xx+1+(o*x_spacer), yy+18+(ii*y_spacer), spr_party_monbox, FILLED);
				}
			}
			else{
				if sel[1] == i paint(xx+1+(o*x_spacer), yy+18+(ii*y_spacer), spr_party_monbox, SELCT);
				else paint(xx+1+(o*x_spacer), yy+18+(ii*y_spacer), spr_party_monbox, FILLED);	
				}
			alpha();
			paint_from_index(xx+22+(o*x_spacer), yy+30+(ii*y_spacer)+mon_hop, spr_monsters_mini, num);
			
			paint(xx+46+(o*x_spacer), yy+35+(ii*y_spacer), spr_party_monbox_hp);
			paint_healthbar(xx+46+(o*x_spacer), yy+35+(ii*y_spacer), spr_party_monbox_hp, _healthbar, 1);
			
			//paint(xx+46+(o*x_spacer), yy+40+(ii*y_spacer), spr_party_monbox_xp);
			paint_healthbar(xx+46+(o*x_spacer), yy+40+(ii*y_spacer), spr_party_monbox_xp, _expbar, 1);
			
			format(c_white, -1, -1, 2);
			text(xx+86+(o*x_spacer), yy+30 + (ii*y_spacer), name);
			halign(0);
			
			text(xx+8+(o*x_spacer), yy+44 + (ii*y_spacer), "Lv" + string(level));
			
			format(c_white, -1, -1, 2);
			text(xx+103+(o*x_spacer), yy+6+y_spacer + (ii*y_spacer), hp + "/" + max_hp);
			halign(0);
			}
		else paint(xx+1+(o*x_spacer), yy+18+(ii*y_spacer), spr_party_monbox, EMPTY);
		if divisible_by(i+1, 2) ii++;
		}
	}

if pause == _pause.inventory{
	var cx = x - _cam_width/2, cy = y - _cam_height/2;
	draw_sprite_tiled(spr_looping_backpack, 0, cx + scrolling_bg_x, cy + scrolling_bg_y);
	paint(cx, cy, spr_inventory);
	
	//Slowly scroll the looping background 
	scrolling_bg_x += 0.15;
	scrolling_bg_y += 0.15;
	
	var o = 0;
	for (var i = 0; i < 6; i++;){
		if monsters[i, 0] != -1{
			paint_from_index(cx+12 + ((i-(o*3))*20), cy+62 + (o*20), spr_monsters_mini, monsters[i, 0]);
			if i == 2 o++;
			}
		}
	
	

	}

if pause == _pause.info{
	var num =  monsters[sel[1], 0], name = mondex[monsters[sel[1], 0], dex.name], level = string(monsters[sel[1], party.level]);
	var cx = x - _cam_width/2, cy = y - _cam_height/2, mon_offset = 56/2;
	
	if sel[4] == 0{
		if sel[3] == 0 paint(x, y, spr_monster_info, sel[2]);
		else paint(x, y, spr_monster_info, 2);
		
		paint_from_index(cx+mon_offset+12, cy+mon_offset+42+hobble[0], spr_monsters_battle, monsters[sel[1], 0]);
		timer++;
		if timer >= 10{
			hobble[0] += incr[0];
			if abs(hobble[0]) == 2 incr[0] = -incr[0];
			timer = 0;
			}
		
		//Draw the monsters healthbar based on it's current health
		var hp = string(round(monsters[sel[1], party.health])), max_hp = string(GET_STAT(PLAYER, MAX_HEALTH_SUM, sel[1])), _healthbar = hp / max_hp;
		if sel[2] == 0 paint_healthbar(cx+204, cy+30, spr_monster_info_hp, _healthbar, 0);
		
		format(c_white, 1, fn_yana5x5, 2);
		text(cx+67, cy+23, name);
		color(col[COL_RED, 3]);
	
		halign(0);
		text(cx+26, cy+33, "level: " + level);
		}
	else paint(x, y, spr_monster_info, 3);
		
	
	halign(2);
	//If we're moving a monsters starts
	if sel[2] == 0{
		//Define local variables for the information we'll be drawing to the screen
		var hp = string(round(monsters[sel[1], party.health])), max_hp = string(GET_STAT(PLAYER, MAX_HEALTH_SUM, sel[1])), atk = string(GET_STAT(PLAYER, ATTACK_SUM, sel[1])),
		def = string(GET_STAT(PLAYER, DEFENSE_SUM, sel[1])), sp_atk = string(GET_STAT(PLAYER, MGK_ATK_SUM, sel[1])), sp_def = string(GET_STAT(PLAYER, MGK_DEF_SUM, sel[1])),
		spd = string(GET_STAT(PLAYER, SPEED_SUM, sel[1]));
	
		//Draw bottom row stats
		var _type1 = mondex[monsters[sel[1], 0], dex.element1];
		paint(cx+170, cy+110, spr_icon_types, _type1);
					
		text(cx+186, cy+127, monsters[sel[1], party.exp]);
		color();
		text(cx+192, cy+137, monsters[sel[1], party.trainer]);
	
		cx+=235;
		cy+=23;
		#region Draw Stats
		//Draw health / max health (and other stats)
		color(col[COL_RED, 0]);
		text(cx+1, cy, hp + "/" + max_hp);
		color(col[COL_RED, 3]);
		text(cx, cy, hp + "/" + max_hp);
	
		cy+=18;
		color(col[COL_RED, 0]);
		text(cx+1, cy, atk);
		color(col[COL_RED, 3]);
		text(cx, cy, atk);
	
		cy+=12;
		color(col[COL_RED, 0]);
		text(cx+1, cy, def);
		color(col[COL_RED, 3]);
		text(cx, cy, def);

		cy+=12;
		color(col[COL_RED, 0]);
		text(cx+1, cy, sp_atk);
		color(col[COL_RED, 3]);
		text(cx, cy, sp_atk);
	
		cy+=12;
		color(col[COL_RED, 0]);
		text(cx+1, cy, sp_def);
		color(col[COL_RED, 3]);
		text(cx, cy, sp_def);

		cy+=12;
		color(col[COL_RED, 0]);
		text(cx+1, cy, spd);
		color(col[COL_RED, 3]);
		text(cx, cy, spd);
		#endregion
		
		}
	
	//If we're viewing a monsters moves
	if sel[2] == 1{
		
		cx+=100;
		cy+=24;
		
		if sel[3] != 0{
			paint(cx-12, cy + ((sel[3]-1) * 13), spr_cursor_b);
			
			color();
			halign(0);
			text(cx+4, cy+53, "Power");
			text(cx+4, cy+65, "Accuracy");
			
			halign(1);
			color(col[COL_RED, 3]);
			var _power = movedex[monsters[sel[1], (party.move1+(sel[3]-1))], move.power], _accuracy = movedex[monsters[sel[1], (party.move1+(sel[3]-1))], move.accuracy];
			if _power == -1 _power = "---";
			if _accuracy == -1 _accuracy = "---";
			text(cx+120, cy+53, _power);
			text(cx+120, cy+65, _accuracy);
			}
		
		for (var i = 0; i < 4; i++;){
			var move_name = "---";
			if (monsters[sel[1], (party.move1 + i)] != -1) move_name = string(movedex[monsters[sel[1], (party.move1 + i)], move.name]);
			
			var _uses = "-", _max_uses = "-";
			if monsters[sel[1], (party.move1 + i)] != -1{
				_uses = string(monsters[sel[1], (party.mana1 + i)]);
				_max_uses = string(movedex[monsters[sel[1], (party.move1 + i)], move.mana]);
				}
				
			_uses = _uses + "/" + _max_uses;
			
			format(c_white, 1, fn_yana, 0);
		
			//Draw move names
			color(col[COL_RED, 0]);
			text(cx+3, cy, move_name);
			color(col[COL_RED, 3]);
			text(cx+2, cy, move_name);
			
			//Draw max and current mana (or type, if selecting a move)
			if sel[3] == 0{
				cx+=138;
				halign(2);
				//Draw move mana's
				color(col[COL_RED, 0]);
				text(cx+3, cy, _uses);
				color(col[COL_RED, 3]);
				text(cx+2, cy, _uses);
				cx-=138;
				}
			else{
				if monsters[sel[1], (party.move1 + i)] != -1{
					var move_type = movedex[monsters[sel[1], (party.move1 + i)], move.element];
					paint(cx+108, cy-4, spr_icon_types, move_type);
					}
				}
			
			cy+=13;
			}
		cx = x;
		cy+=35;
		halign(1);
		valign(0);
		if sel[3] == 0 var move_desc = movedex[monsters[sel[1], party.move1], move.description];
		else var move_desc = movedex[monsters[sel[1], party.move1+sel[3]-1], move.description];
		text(cx, cy, move_desc, 230);
		valign(1);
		}
	
	//If we're viewing a monsters movepools (assigning new moves)
	if sel[2] == 2{
	
		//Reposition
		cx = x - 94;
		cy += 24;
		
		paint(cx-10, cy+14, spr_cursor_b);
		
		#region Obtain data for the move we're changing and draw it
		var move_name = string(movedex[monsters[sel[1], (party.move1 + (sel[3]-1))], move.name]);
		var move_type = movedex[monsters[sel[1], (party.move1 + (sel[3]-1))], move.element];
		_uses = string(monsters[sel[1], (party.mana1 + (sel[3]-1))]);
		_max_uses = string(movedex[monsters[sel[1], (party.move1 + (sel[3]-1))], move.mana]);
		_uses = _uses + "/" + _max_uses;
		
		format(c_white, 1, fn_yana, 0);
		
		//Draw move names
		color(col[COL_RED, 0]);
		text(cx+3, cy, move_name);
		//text(cx+80, cy, move_name);
		color(col[COL_RED, 3]);
		text(cx+2, cy, move_name);
		
		paint(cx+80, cy-5, spr_icon_types, move_type);
		
		halign(2);
		//Draw move mana's
		color(col[COL_RED, 0]);
		text(cx+189, cy, _uses);
		color(col[COL_RED, 3]);
		text(cx+188, cy, _uses);
		#endregion
		
		cy+=14;
		
		var m = sel[4]-1;
		//Draw moves to new position
		for (var i = 0; i < 3; i++;){
			if i > array_length(movepool[monsters[sel[1], 0]]) break;
			
			var move_name = "---", move_type = sprite_get_number(spr_icon_types)-1, _uses = "";
			if round((sel[4]/2)+i) < round(array_length(movepool[monsters[sel[1], 0]])/2){
				move_name = string(movedex[movepool[monsters[sel[1], 0], m], move.name]);
				//var move_level = string(movepool[monsters[sel[1], 0], m+1]);
				var move_type = movedex[movepool[monsters[sel[1], 0], m], move.element];
				_uses = string(movedex[movepool[monsters[sel[1], 0], m], move.mana]);
				}

			format(c_white, 1, fn_yana, 0);
			
			//Draw move names
			color(col[COL_RED, 0]);
			text(cx+3, cy, move_name);
			//text(cx+80, cy, move_name);
			color(col[COL_RED, 3]);
			text(cx+2, cy, move_name);
			
			paint(cx+80, cy-4, spr_icon_types, move_type);
			
			halign(1);
			//Draw move mana's
			color(col[COL_RED, 0]);
			text(cx+174, cy, _uses);
			color(col[COL_RED, 3]);
			text(cx+173, cy, _uses);
			
			cy+=13;
			m+=2;
			}
	
		color();
		halign(0);
		font(fn_yana5x5);
		text(cx+6, cy+2, "Power");
		text(cx+6, cy+14, "Accuracy");
			
		halign(1);
		color(col[COL_RED, 3]);
		var _power = movedex[movepool[monsters[sel[1], 0], sel[4]-1], move.power], _accuracy = movedex[movepool[monsters[sel[1], 0], sel[4]-1], move.accuracy];
		if _power == -1 _power = "---";
		if _accuracy == -1 _accuracy = "---";
		text(cx+169, cy+2, _power);
		text(cx+169, cy+14, _accuracy);
	
		cx = x;
		cy+=32;
		halign(1);
		valign(0);
		font(fn_yana);
		var move_desc = movedex[movepool[monsters[sel[1], 0], sel[4]-1], move.description];
		text(cx, cy, move_desc, 224);
		valign(1);
		}
	
	}
	
if pause == _pause.idcard{
	var cx = x - _cam_width/2, cy = y - _cam_height/2;
	paint(cx, cy, spr_trainer_idcard);
	
	//Draw our players current trainer information
	paint_from_index(cx+199, cy+58, spr_trainers_battle, obj_player.playable_character);
	format(col[COL_BLUE, 3], 1, fn_yana, 0);
	text(cx+62, cy+25, player_name);
	
	//Draw 16x16 monsters at the bottom
	for (var i = 0; i < 6; i++;){
		if monsters[i, 0] != -1{
			paint_from_index(cx+63 + (i * 26), cy+114, spr_monsters_mini, monsters[i, 0]);
			}
		}
	
	}
	
if pause == _pause.pc{
	if (showinfo){
	var cx = x - _cam_width/2, cy = y - _cam_height/2;
	paint(cx, cy, spr_monster_info, showinfo-1);	
	exit;
	}
	
	var cx = x - _cam_width/2, cy = y - _cam_height/2;
	paint(x, y, spr_pc, sel[2]);
	paint(x+10, cy+21, spr_pc_box, sel[2]);
	cx += 48;
	
	var m = 0;
	//Draw all monsters in your PC + background
	for (var i = 0; i < 5; i++;){
		for (var o = 0; o < 6; o++;){									// + 6 because first six slots are for party. Sel[2] * 30 for PC boxes
			var xx = x - _cam_width/2 + 56 + 20, yy = y - _cam_height/2 + 28, mon = (6 + o + (i * 6)) + (sel[2]*30);
			if monsters[mon, 0] > -1 paint_from_index(xx+12 + (o*20), yy+20 + (i*20), spr_monsters_mini, monsters[mon, 0]);
			m++
			}
		}
	
	//Draw all monsters in your party menu
	for (var i = 0; i < 6; i++;){
		if monsters[i, 0] > -1 paint_from_index(xx+139, yy-13 + (i*23), spr_monsters_mini, monsters[i, 0]);
		
		if monsters[i, 0] == -1{
			paint(cx-46, cy+10, spr_pc_monster_bg);
			}
		}
		
	format(c_white, 1, fn_yana, 0, 0);
	//If the PC's Party Menu is NOT selected, draw our cursor normally
	if sel[3] == 0{
		//If we are not currently holding a monster
		if !is_array(float){
			//If we're on the BOX number selector
			if sel[1] == -1 paint(xx+52, yy-6 + (sel[1]*20), spr_pc_cursor);
			
			//If we're choosing the Party/Close PC boxes
			else if sel[1] == -2 paint(xx + (sel[4]*76)+20, yy+40 + (sel[1]*20), spr_pc_cursor, 0, 1, -1);
			else{
				//If we're in the PC box with all the monsters
				var mon = (6 + sel[0] + (sel[1] * 6)) + (sel[2]*30);
				paint(xx + (sel[0]*20)+6, yy-6 + (sel[1]*20), spr_pc_cursor);
				if monsters[mon, 0] > -1{
					//Show the monsters large sprite in the left info box
					paint_from_index(xx-41, yy+15, spr_monsters_battle, monsters[mon, 0]);
			
					//Paint the monsters name and nickname
					text(cx-46, cy+77, mondex[monsters[mon, 0], 0] + "/");
					text(cx-46, cy+88, mondex[monsters[mon, 0], 0]);
					text(cx-46, cy+113, "Lv" + string(monsters[mon, party.level]));
					
					var type1 = mondex[monsters[mon, 0], dex.element1], type2 = mondex[monsters[mon, 0], dex.element2];
					paint(cx-47, cy+103, spr_icon_types, type1);
					if type2 != -1 paint(cx-12, cy+103, spr_icon_types, type2);
					}
				}
			}
		else{
			//If we're holding a monster, also draw them 
			paint_from_index(xx+14 + (sel[0]*20), yy+12 + (sel[1]*20), spr_monsters_mini, float[0]);
			paint(xx + (sel[0]*20)+6, yy-10 + (sel[1]*20), spr_pc_cursor, 1);
			
			//Show the monsters large sprite in the left info box
			paint_from_index(xx-41, yy+15, spr_monsters_battle, float[0]);
			
			//Paint the monsters name and nickname
			text(cx-46, cy+77, mondex[float[0], 0] + "/");
			text(cx-46, cy+88, mondex[float[0], 0]);
			text(cx-46, cy+113, "Lv" + string(float[party.level]));
		
			var type1 = mondex[float[0], dex.element1], type2 = mondex[float[0], dex.element2];
			paint(cx-47, cy+103, spr_icon_types, type1);
			if type2 != -1 paint(cx-12, cy+103, spr_icon_types, type2);
			}
		}
	//Otherwise, Party menu is selected, draw cursor accordingly
	else{
		//If we're not holding a monster
		if !is_array(float){
			paint(xx+132, yy-60 + (sel[3]*23), spr_pc_cursor);
			if monsters[sel[3]-1, 0] > -1{
				//Show the monsters large sprite in the left info box
				paint_from_index(xx-41, yy+15, spr_monsters_battle, monsters[sel[3]-1, 0]);
				
				//Paint the monsters name and nickname
				text(cx-46, cy+77, mondex[monsters[sel[3]-1, 0], 0] + "/");
				text(cx-46, cy+88, mondex[monsters[sel[3]-1, 0], 0]);
				text(cx-46, cy+113, "Lv" + string(monsters[sel[3]-1, party.level]));
					
				var type1 = mondex[monsters[sel[3]-1, 0], dex.element1], type2 = mondex[monsters[sel[3]-1, 0], dex.element2];
				paint(cx-47, cy+103, spr_icon_types, type1);
				if type2 != -1 paint(cx-12, cy+103, spr_icon_types, type2);
				}
			}
		else{
			//If we're holding a monster, also draw them 
			paint_from_index(xx+140, yy-40 + (sel[3]*23), spr_monsters_mini, float[0]);
			paint(xx+132, yy-62 + (sel[3]*23), spr_pc_cursor, 1);
			
			//Show the monsters large sprite in the left info box
			paint_from_index(xx-41, yy+15, spr_monsters_battle, float[0]);
			
			//Paint the monsters name and nickname
			text(cx-46, cy+77, mondex[float[0], 0] + "/");
			text(cx-46, cy+88, mondex[float[0], 0]);
			text(cx-46, cy+113, "Lv" + string(float[party.level]));
			
			var type1 = mondex[float[0], dex.element1], type2 = mondex[float[0], dex.element2];
			paint(cx-47, cy+103, spr_icon_types, type1);
			if type2 != -1 paint(cx-12, cy+103, spr_icon_types, type2);
			}
		}
	}
	
if pause == _pause.logoff{
	
	//Cancel the "log off" if we press any key
	if press_any() and logoff_alpha > 0.3{
		logoff_alpha = 0;
		pause = 0;
		exit;
		}

	//Progress Flash (alpha value) increasingly towards pure black and quit the game shortly after 
	logoff_alpha += 0.0075;
	if logoff_alpha >= 1.2{
		game_end();
		}
	
	//Draw the screen progressively more black
	fill_screen(logoff_alpha, c_black);
	alpha(1);
	
	}
		
		
		