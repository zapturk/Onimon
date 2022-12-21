if !collision_rectangle(x, y, x+256, y+144, obj_player, 0, 1){
	for (var o = 0; o < room_height/144; o++;){
		for (var i = 0; i < room_width/256; i++;){
		x = (i*256);
		y = (o*144);
		if collision_rectangle(x, y, x+256, y+144, obj_player, 1, 1) exit;
		}
	}
}
