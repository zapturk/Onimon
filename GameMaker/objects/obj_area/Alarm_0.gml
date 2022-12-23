///@desc Tell Camera to Draw New Area

if area == myarea exit;
area = myarea;

if instance_exists(obj_camera){
	with obj_camera{
		if alarm[4] == -1 alarm[4] = 240;
		}
	}