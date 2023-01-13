fade += fade_incr;
if fade < 0{
	interacting = 0
	destroy();
	}

color(c_white);
alpha(fade);
draw_rectangle(0, 0, 2000, 2000, 0);
alpha();