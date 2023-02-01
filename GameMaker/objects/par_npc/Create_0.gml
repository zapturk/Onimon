///@desc Default Settings

image_speed = 0;
talking = false;
dialogue = -1;
actions = -1;
msgs = 1;
msg = 0;

#region Typewriter effect
scrolling = 1; //Scrolling text. 0 = off. 1 = on.
drawn_text = "";
text_timer = 0;
#endregion

#region NPC rotation
//Make character spin around occasionally. Set to -1 to turn off
rotate = 0;
dir = 0;
//0 = down
//1 = left
//2 = up
//3 = right
#endregion

#region Assign NPC the correct dialogue
//If we haven't assigned our NPC's message yet, show a message, and then destroy ourself to avoid crashes.
if TXT_message == -1 and char == -1{
	show_message("NPC object at X:" + string(x) + ", Y:" + string(y) + " not set."
	+ "\nAssign a value to their NPC variable from the room editor.");
	destroy();
	}
else{//Assign text based on whether this is an normal NPC or Story Character (char)
	if object_index == obj_trainer{
		if TXT_message != -1 TRAINER_assign_text(TXT_message);
		}
	else if TXT_message != -1 NPC_assign_text(TXT_message);
	else if char != -1 CHAR_assign_text(char)
	}
#endregion