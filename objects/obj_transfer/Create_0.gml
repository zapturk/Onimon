///@desc Used for transfering player between gamemaker rooms
fade = 0;
fade_incr = 0.05;
depth = obj_player.depth -1;

alarm_set(0, 2);
room_to_go_to = -1;