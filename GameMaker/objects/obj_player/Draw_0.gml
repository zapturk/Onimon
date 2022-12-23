if pause < 2 or pause == _pause.logoff{
	draw_self();
	if tile_meeting(x, y, "Grass") paint(x, y, spr_grass_overlay, image_index);
	}

/*
var _cx = camera_get_view_x(view_camera[0]), _cy = camera_get_view_y(view_camera[0]);
