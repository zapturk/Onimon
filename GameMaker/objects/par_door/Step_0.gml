if place_meeting(x, y, obj_player){
	
	if obj_player.moving != 0 trigger = 1;
	if obj_player.moving == 0 and trigger == 1{
	
	interacting = 1;
	
	if !instance_exists(obj_transfer) create(obj_transfer);
	if obj_transfer.fade < 1 exit;

		if room_to_go_to == room{
			var _id = id;
			with par_door{
				if id != _id
				and num == other.num{
					other.trigger = 0;
					obj_player.x = x+other.x_offset;
					obj_player.y = y+other.y_offset;
					obj_player.target_x = obj_player.x;
					obj_player.target_y = obj_player.y;
					obj_transfer.fade_incr = -0.05;
					obj_camera.x = obj_player.x;
					obj_camera.y = obj_player.y;
					exit;
					}
				}
			}
		else{	//If the door is in a different room
			with obj_transfer{
				num = other.num;
				fade_incr = -0.05;
				x_offset = other.x_offset;
				y_offset = other.y_offset;
				room_to_go_to = other.room_to_go_to;
				}
			room_goto(room_to_go_to);
			}
		}
	}