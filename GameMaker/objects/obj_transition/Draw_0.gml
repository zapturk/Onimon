
if trigger == 1{
	if alph > 0 alph -= 0.015;
	else destroy();
	}
else{
	if alph < 1 alph += 0.015;
	else if alarm[0] = -1{
		alarm_set(0, 30);
		}
	}
alpha(alph);
draw_set_color(c_black);
draw_rectangle(x-200, y-200, x+200, y+200, 0);
alpha();