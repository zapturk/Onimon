/// @description Controls

if press(ord("D")){
	
	//Loop through the default values and create a default file to load later (delete later)
	ini_open("default.ini");
	for (var o = 0; o < array_length(mondex); o++;){
		for (var i = 1; i < 10; i++;){
			ini_write_real("Monster_" + string(o), "Val" + string(i), mondex[o, i]);
			}
		ini_write_string("Monster_" + string(o), "Val" + string(0), mondex[o, 0]);
		ini_write_string("Monster_" + string(o), "Val" + string(1), mondex[o, dex.sub_descrip]);
		ini_write_string("Monster_" + string(o), "Val" + string(2), mondex[o,dex.descrip]);
		}
	ini_close();
	
	}