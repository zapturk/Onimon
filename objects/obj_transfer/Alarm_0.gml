
if room_to_go_to == -1{
	alarm_set(0, 2);
	exit;
	}

if room == room_to_go_to{
	with par_door{
		if num == other.num{
			obj_player.x = x+obj_transfer.x_offset;
			obj_player.y = y+obj_transfer.y_offset;
			obj_player.target_x = obj_player.x;
			obj_player.target_y = obj_player.y;
			}
		}
	exit;
	}
alarm_set(0, 2);