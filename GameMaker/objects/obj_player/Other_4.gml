if !instance_exists(obj_camera) create(x, y, obj_camera);

//Just in case
start_x = round(start_x/16)*16;
start_y = round(start_y/16)*16;

//Set starting points based on last save
x = start_x;
y = start_y;

curr_rm = room;
target_x = x;
target_y = y;

if (layer_get_visible("Collision")){
	layer_set_visible("Collision", 0);
	}