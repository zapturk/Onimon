function tile_meeting(x_coord, y_coord, layer){
//Used for checking collision from a tileset instead of an object

///@description tile_meeting_precise(x,y,layer)
///@param x_coord
///@param y_coord
///@param layer

if !layer_exists(layer) return;
var _tm = layer_tilemap_get_id(layer);
var _checker = obj_tile_checker;
if (!instance_exists(_checker)) instance_create_depth(0,0,0,_checker); 


var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (x_coord - x), y),
    _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (y_coord - y)),
    _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (x_coord - x), y),
    _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (y_coord - y));

for (var _x = _x1; _x <= _x2; _x++){
    for (var _y = _y1; _y <= _y2; _y++){
	    var _tile = tile_get_index(tilemap_get(_tm, _x, _y));
	    if (_tile){
	        if(_tile == 1) return true;

	        _checker.x = _x * tilemap_get_tile_width(_tm);
	        _checker.y = _y * tilemap_get_tile_height(_tm);
	        _checker.image_index = _tile;

	        if (place_meeting(x_coord,y_coord,_checker)) return true;
			}
	    }
	}

return false;
}
