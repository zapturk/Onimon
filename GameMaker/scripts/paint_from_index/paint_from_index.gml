function paint_from_index(){
///@desc used for painting the correct image from an "index" sprite
///@desc an index might be one sprite with every monster, every trainer, etf

///@arg x
///@arg y
///@arg sprite
///@arg num
///@arg x_scale
///@arg y_scale

//How to use:
//paint_from_index(x, y, spr_monsters_battle, battler);
//paint_from_index(x, y, spr_monsters_battle, battler, 1);
//paint_from_index(x, y, spr_monsters_battle, ebattler, -1, 1);

// !! NOTICE !!
//Sprite must be 9 columns wide IF you have size set to the default. Default size is on line 28:
//DEFAULT: size = sprite_get_width(argument[2])/9;

//Compatible Sprites:
//spr_monsters_mini
//spr_monsters_battle
//spr_trainers_battle


//Change var "size" to set your monster and trainer sprite sizes.
var x_incr = 0, y_incr = 0, size = sprite_get_width(argument[2])/9;
for (var i = 0; i < argument[3]; i++;){
	x_incr++;
	if x_incr > 8{
		x_incr = 0;
		y_incr++;
		}
	}

var center = 1; //Set to 0 or 1 (0 = top_left corner origin)
var x_corner = x_incr * size, y_corner = y_incr * size;
if argument_count >= 5 var scale = argument[4];
else var scale = 1;
var xx = round(argument[0] + (center * ((scale*size)/-2))), yy = round(argument[1] + (center * ((scale*size)/-2)));

switch argument_count{
	case 4: draw_sprite_part(argument[2], 0, x_corner, y_corner, size, size, xx, yy);							break;
	case 5: draw_sprite_part_ext(argument[2], 0, x_corner, y_corner, size, size, xx, yy, scale, scale, -1, 1);	break;
	case 6:
		var x_scale = argument[4], y_scale = argument[5];
		draw_sprite_part_ext(argument[2], 0, x_corner, y_corner, size, size, xx, yy, x_scale, y_scale, -1, 1);	break;
	}
}