
if os_type == os_browser{
	var scale = 3;
	
	//768 x 432
	window_set_size(_cam_width * scale, _cam_height * scale);
	surface_resize(application_surface, _cam_width * scale, _cam_height * scale);
	alarm_set(1, 2);
	exit;
	}

var scale = 6;
window_set_size(_cam_width * scale, _cam_height * scale);
surface_resize(application_surface, _cam_width * scale, _cam_height * scale);
alarm_set(1, 2);