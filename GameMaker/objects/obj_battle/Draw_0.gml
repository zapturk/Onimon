RELOAD

//Draw the background and UI
paint(0, 0, spr_battlebacks);
paint(0, 0, spr_battle, 1);

//Draw Player: 0 ; And Enemy: 1 Nameplates
paint(144 + ui_offset, 80, spr_battle_nameplates, 0);
paint(7 - ui_offset, 3, spr_battle_nameplates, 1);

#region Draw player info
halign(0);
valign(fa_top);
font(fn_yana5x5);
color(hex($7F3D3F));

//Draw the party indicator
for (var i = 0; i < 6; i++;){
	var frame = 0;
	//0 = Healthy
	//1 = Unhealthy
	//2 = Fainted
	//3 = No Monsters
	if monsters[i, 0] == -1 frame = 3;
	//paint(176 + (i * 13), 64, spr_monster_battle_icon);
	}

//Define anchors, so we can freely move everything as needed
var _xx = 50, _yy = -16, ui_offset_reverse = 144 - ui_offset;
if menu != battl.intro paint_from_index(80 + hobble[0], 73 + vobble[0], spr_monsters_battle, GET_STAT(PLAYER, MON_NUMBER), mon_scale[0], mon_scale[0]);
else paint_from_index(80 - ui_offset_reverse, 73, spr_trainers_battle, 0);

if instance_exists(obj_move){
	if obj_move.x > 100{
		if vobble[0] > 0 vobble[0] -= 1;
		if vobble[0] < 0 vobble[0] += 1;
		if vobble[0] == 0{
			hobtmr[0]++;
			if hobtmr[0] > 6{
				hobtmr[0] = 0;
				hobble[0] += hobinc[0];
				if hobble[0] >= 2 hobinc[0] = -1;
				if hobble[0] <= -2 hobinc[0] = 1;
				}
			}
		}
	}
else{
	vobtmr[0]++;
	if hobble[0] > 0 hobble[0]--;
	if hobble[0] < 0 hobble[0]++;
	if vobtmr[0] > 10{
		vobtmr[0] = 0;
		vobble[0] += vobinc[0];
		if vobble[0] >= 3 vobinc[0] = -1;
		if vobble[0] <= 0 vobinc[0] = 1;
		}
	}

var mon_name = string(GET_DEX(PLAYER, DEX_NAME));
var mon_level = string(GET_STAT(PLAYER, MON_LEVEL));

var _xx = 69 + ui_offset, _yy = 28;

//Paint name and level
text(_xx+91, _yy+50, mon_name);
color(col[COL_RED, 1]);
text(_xx+91 + string_width(mon_name), _yy+50, " L" + mon_level);
color(col[COL_RED, 2]);

//Paint healthbar
var _health = percentage(GET_STAT(PLAYER, MAX_HEALTH_SUM), GET_STAT(PLAYER, MON_HEALTH_CURR));
var pHPFrame = 0;

if(_health < .50){
	pHPFrame = 1;
}

if(_health < .25){
	pHPFrame = 2;	
}

paint_healthbar(_xx+109, _yy+64, spr_health, _health, pHPFrame);

var _xp = percentage(GET_STAT(PLAYER, MON_EXP_MAXI), GET_STAT(PLAYER, MON_EXP_CURR));
paint_healthbar(_xx+98, _yy+71, spr_xp, _xp);

halign(2);
text(_xx+182, _yy+63, string(round(GET_STAT(PLAYER, MON_HEALTH_CURR))) + "/" + string(GET_STAT(PLAYER, MAX_HEALTH_SUM)));
#endregion

#region Draw enemy info
halign(0);
valign(fa_top);
font(fn_yana5x5);

//Define anchors, so we can freely move everything as needed
var _xx = 118 - ui_offset, _yy = -56;

#region Dokimon Movement
if instance_exists(obj_monster_capture){
	var cap_spr = obj_monster_capture.sprite_index, cap_ind = obj_monster_capture.image_index;
	if (cap_spr == spr_monster_capture_fail and cap_ind > 3) or (cap_spr == spr_monster_capture and cap_ind < 11){
		if menu != battl.intro and capture != 1 paint_from_index(180 + hobble[1], -10 + vobble[1], spr_monsters_battle, GET_STAT(ENEMY, MON_NUMBER), -mon_scale[1], mon_scale[1]);
		else paint_from_index(180 + hobble[1] + ui_offset_reverse, -10, spr_trainers_battle, trainer_img, -1, 1);
		}
	}
else{
	if menu != battl.intro and menu != battl.outro and capture != 1 paint_from_index(180 + hobble[1], -10 + vobble[1], spr_monsters_battle, GET_STAT(ENEMY, MON_NUMBER), -mon_scale[1], mon_scale[1]);
	else paint_from_index(180 + hobble[1] + ui_offset_reverse - trainer_offset, -10, spr_trainers_battle, trainer_img, -1, 1);
	}
		

if instance_exists(obj_move){
	if obj_move.x < 100{
		if vobble[1] > 0 vobble[1] -= 1;
		if vobble[1] < 0 vobble[1] += 1;
		if vobble[1] == 0{
			hobtmr[1]++;
			if hobtmr[1] > 6{
				hobtmr[1] = 0;
				hobble[1] += hobinc[1];
				if hobble[1] >= 2 hobinc[1] = -1;
				if hobble[1] <= -2 hobinc[1] = 1;
				}
			}
		}
	}
else{
	vobtmr[1]++;
	if hobble[1] > 0 hobble[1]--;
	if hobble[1] < 0 hobble[1]++;
	if vobtmr[1] > 10{
		vobtmr[1] = 0;
		vobble[1] += vobinc[1];
		if vobble[1] >= 3 vobinc[1] = -1;
		if vobble[1] <= 0 vobinc[1] = 1;
		}
	}
#endregion
	
//Define anchors, so we can freely move everything as needed
var _xx = 9 - ui_offset, _yy = 1;

var en_mon_name = string(GET_DEX(ENEMY, DEX_NAME));
var en_mon_level = string(GET_STAT(ENEMY, MON_LEVEL));

text(_xx+3, _yy, en_mon_name);

color(col[COL_RED, 1]);
text(_xx+3 + string_width(en_mon_name), _yy, " L" + en_mon_level);
color(col[COL_RED, 2]);

var _health = percentage(GET_STAT(ENEMY, MAX_HEALTH_SUM), GET_STAT(ENEMY, MON_HEALTH_CURR));

var eHPFrame = 0;

if(_health < .50){
	eHPFrame = 1;
}

if(_health < .25){
	eHPFrame = 2;	
}

paint_healthbar(_xx+21, _yy+14, spr_health, _health, eHPFrame);
#endregion

alpha(1);
font(fn_yana);
var _xx = 20, _yy = 113;

if battle_msg[0] != ""{
	halign(1);
	text(room_width/2, _yy, battle_msg[0], 212);
	}

halign(0);
if menu == battl.main{
	_xx += 48;
	paint(_xx+76, _yy-4, spr_battle_main);
	text(_xx +  93, _yy,		"Fight");
	text(_xx + 150, _yy,		"Switch");
	text(_xx +  93, _yy + 11,	"Capture");
	text(_xx + 150, _yy + 11,	"Flee");
	text(_xx-60, _yy, "What should " + string(mon_name) + " do next?", 140);
	switch sel[0]{
		case 0:	paint(_xx+86, _yy+7,		spr_cursor_b);	break;
		case 1:	paint(_xx+142, _yy+7,		spr_cursor_b);	break;
		case 2:	paint(_xx+86, _yy+7+11,		spr_cursor_b);	break;
		case 3:	paint(_xx+142, _yy+7+11,	spr_cursor_b);	break;
		}
	}
if menu == battl.fight{
	paint(_xx+124, _yy-4, spr_battle_main, 1);
	var _move_01 = GET_MOVE(PLAYER, MOVE_NAME, 1), _move_02 = GET_MOVE(PLAYER, MOVE_NAME, 2);
	var _move_03 = GET_MOVE(PLAYER, MOVE_NAME, 3), _move_04 = GET_MOVE(PLAYER, MOVE_NAME, 4);
	if _move_02 == "" _move_02 = "---";
	if _move_03 == "" _move_03 = "---";
	if _move_04 == "" _move_04 = "---";
	
	text(_xx, _yy,				_move_01);
	text(_xx + 90, _yy,			_move_02);
	text(_xx, _yy + 11,			_move_03);
	text(_xx + 90, _yy + 11,	_move_04);
	switch battle_sel{
		case 0:	paint(_xx-6, _yy+7,			spr_cursor_b);	break;
		case 1:	paint(_xx-6+90, _yy+7,		spr_cursor_b);	break;
		case 2:	paint(_xx-6, _yy+7+11,		spr_cursor_b);	break;
		case 3:	paint(_xx-6+90, _yy+7+11,	spr_cursor_b);	break;
		}
	
	//If we have a move in this slot, draw it's element and mana
	if monsters[battler, party.move1+battle_sel] != -1{
		var move_num = monsters[battler, party.move1+battle_sel];
		var mon_mana = string(GET_STAT(PLAYER, MON_MANA_01+battle_sel));
		var move_mana = string(movedex[monsters[battler, party.move1+battle_sel], move.mana]);
		var move_element = GET_MOVE_STRING(move_num, MOVE_ELEMENT);
	
		text(_xx+182, _yy,	mon_mana + "/" + move_mana);
		text(_xx+182, _yy+11, move_element);
		}
	}
if menu == battl.mons{
	
	alpha(0.66);
	color(c_black);
	format(c_white, 1);
	paint(x+128, y+72, spr_party);
	var xx = x+32, yy = y+72;
	
	if sel[2] == -1 or sel[2] == 2{
		//paint(xx, y-16+_cam_height/2, spr_controls);
		}
	else{
		paint(x+128, y+72, spr_party, 1);
		paint(x+70+(sel[2]*66), y+131, spr_cursor_w);
		}
	
		
	//Draw Party
	format(c_white, 1, fn_yana5x5, 0, 1);
	for (var i = 0, ii = 0; i < 6; i++;){
		var xx = x-88, yy = y - _cam_height/2 + 2;
		
		//Draw background box
		var o = 0;
		if divisible_by(i+1, 2) o = 1;
		
		//Draw monsters IF we have them in these slots
		if monsters[i, 0] != -1{
			var num =  monsters[i, 0], name = mondex[monsters[i, 0], dex.name],
			level = monsters[i, party.level], hp = string(round(monsters[i, party.health])), max_hp = string(GET_STAT(PLAYER, MAX_HEALTH_SUM, i));
			var _healthbar = hp / max_hp;
			
			//Draw the monster and their name if one exists in this slot
			if float_mon != -1{
				if float_mon == i{
					if press(ENTER){
						float_xpos = o;
						float_ypos = ii;
						}
					if sel[1] == i paint(xx+1+(float_xpos*96), yy+18+(float_ypos*36), spr_party_monbox, MOVIN);
					else paint(xx+42+(o*96), yy+42+(ii*36), spr_party_monbox, MOVTO);
					}
				else{
				if sel[1] == i paint(xx+1+(o*96), yy+18+(ii*36), spr_party_monbox, MOVIN);
				else paint(xx+1+(o*96), yy+18+(ii*36), spr_party_monbox, FILLED);
				}
			}
			else{
				if sel[1] == i paint(xx+1+(o*96), yy+18+(ii*36), spr_party_monbox, SELCT);
				else paint(xx+1+(o*96), yy+18+(ii*36), spr_party_monbox, FILLED);	
				}
			paint_from_index(xx+18+(o*96), yy+30+(ii*36)+mon_hop, spr_monsters_mini, num);
			paint_healthbar(xx+46+(o*96), yy+42+(ii*36), spr_party_monbox_hp, _healthbar);
			
			format(col[COL_RED, 3], -1, -1, 2);
			text(xx+84+(o*96), yy+26 + (ii*36), name);
			halign(0);
			
			text(xx+8+(o*96), yy+44 + (ii*36), "Lv" + string(level));
			
			format(c_white, -1, -1, 2);
			text(xx+78+(o*96), yy+36 + (ii*36), hp + "/" + max_hp);
			halign(0);
			}
		else paint(xx+1+(o*96), yy+18+(ii*36), spr_party_monbox, EMPTY);
		if divisible_by(i+1, 2) ii++;
		}
	}

if menu == battl.info{
	var num =  monsters[sel[1], 0], name = mondex[monsters[sel[1], 0], dex.name], level = string(monsters[sel[1], party.level]);
	var cx = x, cy = y-8, mon_offset = 56/2;
	
	if sel[4] == 0{
		if sel[3] == 0 paint(x+128, y+72, spr_monster_info, sel[2]);
		else paint(x+128, y+72, spr_monster_info, 2);
		
		paint_from_index(cx+mon_offset+12, cy+mon_offset+50, spr_monsters_battle, monsters[sel[1], 0]);
		
		format(c_white, 1, fn_yana5x5, 2);
		text(cx+67, cy+23, name);
		color(col[COL_RED, 3]);
	
		halign(0);
		text(cx+26, cy+33, "level: " + level);
		}
	else paint(x+128, y+72, spr_monster_info, 3);
		
	
	halign(2);
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
		}
	if sel[2] == 1{
		
		cx+=100;
		cy+=24;
		
		if sel[3] != 0{
			paint(cx-12, cy+8 + ((sel[3]-1) * 13), spr_cursor_b);
			
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
					paint(cx+108, cy+4, spr_icon_types, move_type);
					}
				}
			
			cy+=13;
			}
		cx = x+128;
		cy+=43;
		halign(1);
		valign(0);
		var move_desc = movedex[monsters[sel[1], (party.move1+(sel[3]-1))], move.description];
		text(cx, cy, move_desc, 230);
		valign(1);
		}
	if sel[2] == 2{
	
		//Reposition
		cx = x+34;
		cy += 24;
		
		paint(cx-10, cy+22, spr_cursor_b);
		
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
		
		paint(cx+80, cy+3, spr_icon_types, move_type);
		
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
			
			paint(cx+80, cy+3, spr_icon_types, move_type);
			
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
	
		cx = x+128;
		cy+=32;
		halign(1);
		valign(0);
		font(fn_yana);
		var move_desc = movedex[movepool[monsters[sel[1], 0], sel[4]-1], move.description];
		text(cx, cy+8, move_desc, 224);
		valign(1);
		}

	}

if alph > 0{
	alph -= 0.05;
	alpha(alph);
	color(c_black);
	draw_rectangle(x-500, y-500, x+500, y+500, 0);
	alpha();
	}

//Screen flash when monsters spawn in
if flash > 0{
	color(c_white);
	draw_set_alpha(flash);
	draw_rectangle(0, 0, 256, 144, 0);
	flash -= 0.025;
	draw_set_alpha(1);
	}