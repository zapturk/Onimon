// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function exists(argument0){
	
//Check if an instance exists. Even if it doesn't exist
//within your source code, the game won't crash
	
///@arg instance (as string)
	
myMap = ds_map_create();
argument0 = myMap[? "key"];

if !is_undefined(argument0)
    {
	if object_exists(argument0)
		{
	    if instance_exists(argument0)
	        {
			return 1;
	        }
		}
    }
if variable_instance_exists(self, argument0) return 1;
return 0;
}
