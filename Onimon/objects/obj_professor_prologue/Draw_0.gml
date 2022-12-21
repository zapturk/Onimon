RELOAD

//Draw our background at all times
paint(0, 0, spr_professor_prologue, frame);


color(col[COL_RED, 3]);
if dialogue[msg] != ""{
	paint(128, 108, spr_textbox_36);
	text(128, 114, dialogue[msg], 244);
	}

//Get the players name, and then destroy this object, and move on to the next one
if msg == array_length(dialogue)-1{
	start_game();
	}