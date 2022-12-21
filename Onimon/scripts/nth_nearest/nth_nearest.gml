function nth_nearest(argument0, argument1, argument2, argument3){

//Finds the "nth" nearest object. First closest, second closest, third, etc.
	
///@arg0 x
///@arg1 y
///@arg2 obj
///@arg3 nth

var pointx, pointy, object, n, _list, nearest;
pointx = argument0;
pointy = argument1;
object = argument2;
n = argument3;
n = min(max(1,n),instance_number(object));
list = ds_priority_create();
nearest = noone;
with (object) ds_priority_add(list,id,distance_to_point(pointx,pointy));
repeat (n) nearest = ds_priority_delete_min(_list);
ds_priority_destroy(_list);
return nearest;
	
}