function generate_numbers(){

color(c_white);
font(fn_yana5x5);
for (var o = 0; o < 10; o++;){
	for (var i = 0; i < 100; i++;){
		text(0 + (i * 16), 0 + (o * 16), i+(o*100));
		}
	}
room_width = i * 16;
room_height = o * 16;
}