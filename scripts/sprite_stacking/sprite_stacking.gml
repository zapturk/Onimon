

function scr_depth_3d() {
	//facing north
	if (global.z >= 315 and global.z < 360)
	{
	    z_axis = -y;
	}
	if (global.z >= 0 and global.z < 45)
	{
	    z_axis = -y;
	}
	//facing east
	if (global.z >= 45 and global.z < 135)
	{
	    z_axis = x;
	}
	//facing south
	if (global.z >= 135 and global.z < 225)
	{
	    z_axis = y;
	}
	//facing west
	if (global.z >= 225 and global.z < 315)
	{
	    z_axis = -x;
	}

	//update depth
	depth = z_axis;

	//numbers locked in at 0-360
	if (global.z < 0)
	{
		global.z = 360;	
	}
	if (global.z > 360)
	{
		global.z = 0;	
	}

	//global cam angle
	camera_set_view_angle(view_camera[0],global.z)


}

function scr_draw_sprite_3d() {

	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,-global.z,c_white,1);

}

function scr_draw_sprite_stacked() {
	//get the lengthdir x & y
	/*
	NOTE global.z-90 otherwise everything will go to the right
	*/
	var tilt = 90;
	tilt -= (x + sprite_width/2) - obj_player.x;
	if tilt < 80 tilt = 80;
	if tilt > 100 tilt = 100;
	x_axis = lengthdir_x(1,global.z-tilt)
	y_axis = lengthdir_y(1,global.z-tilt)
	//draw sprite 3d relative to z axis
	for (var i = 0; i < image_number; i++)
	{
	    draw_sprite_ext(sprite_index,i,x+(i*x_axis),y-(i*y_axis),image_xscale,image_yscale,direction,c_white,1);
	}

	//set image speed
	image_speed = 0;


}
