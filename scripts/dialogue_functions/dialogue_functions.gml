function draw_dialogue() {

//Set up text settings
draw_set_color(c_black);
draw_set_font(fn_yana);
draw_set_halign(fa_center);

//Set the coordinates we'll be using
var sc = display_get_gui_width()/CAM_WIDTH;
var wdth = CAM_WIDTH - 16;

//Set the coordinates we'll be using
var dx, dy;
dx = display_get_gui_width()/2;
dy = display_get_gui_height()/2 + 28*sc;

//Draw Text box sprite to screen
draw_sprite_ext(spr_textbox, 0, dx, dy, sc, sc, 0, -1, 1);

dx = display_get_gui_width()/2;
dy = display_get_gui_height()/2 + 32*sc;

if (scrolling){
	//If we have "scrolling/typing" text enabled (typewriter effect)
	var _message = dialogue[msg];
	if drawn_text != _message{
		if text_timer < 3 text_timer ++;
		else{
			var _str_pos = string_length(drawn_text)+1;
			var _char_at = string_char_at(_message, _str_pos);
		
			drawn_text = string_insert(_char_at, drawn_text, _str_pos);
			text_timer = 0;
			}
		}
	//Draw the text~
	draw_text_ext_transformed(dx, dy, drawn_text, 10, wdth, sc, sc, 0);
	exit;
	}

//Draw the text
draw_text_ext_transformed(dx, dy, dialogue[msg], 10, wdth, sc, sc, 0); 
		
}

function NPC_assign_text(){
//Used for grabbing an NPCs text from the dialogue txt file
//Can also create multiple files to localize your game

//Open the correct text file depending on the target language
var file;
switch language{
	case 0:
		file = file_text_open_read("Localization/english_npc.txt");
		break;
	case 1:
		file = file_text_open_read("Localization/japanese_npc.txt");
		break;
	}
	
//Loop through the text file
for (var i = 0; i < 9999; i ++;){
	var read_line = file_text_readln(file);
	
	//If we find the number in the text file
	if argument[0] == read_line{
		
		//Assign all of the messages to our NPCs dialogue array
		var o = 0, return_string = file_text_read_string(file);
		while return_string != "."{
			dialogue[o] = return_string;
			file_text_readln(file);
			return_string = file_text_read_string(file);
			o++;
			}
		file_text_close(file);
		return;
		}
	}
file_text_close(file);
}

function CHAR_assign_text(){

//Used for grabbing an NPCs text from the dialogue txt file
//Can also create multiple files to localize your game

//Open the correct text file depending on the target language
var file;
switch language{
	case 0:
		file = file_text_open_read("Localization/english_char.txt");
		break;
	case 1:
		file = file_text_open_read("Localization/japanese_char.txt");
		break;
	}

//Setup string compare to make sure we return the right set of messages
var string_to_check = string(char) + ", " + string(argument[0]);
	
//Loop through the text file
for (var i = 0; i < 9999; i ++;){
	var read_line = file_text_readln(file);
	
	//If we find the number in the text file
	if string_to_check == read_line{
		
		//Assign all of the messages to our NPCs dialogue array
		var o = 0, return_string = file_text_read_string(file);
		while return_string != "."{
			dialogue[o] = return_string;
			file_text_readln(file);
			return_string = file_text_read_string(file);
			o++;
			}
		file_text_close(file);
		return;
		}
	}
file_text_close(file);

}

function TRAINER_assign_text(){
//Used for grabbing an NPCs text from the dialogue txt file
//Can also create multiple files to localize your game

//Open the correct text file depending on the target language
var file;
switch language{
	case 0:
		file = file_text_open_read("Localization/english_trainer.txt");
		break;
	case 1:
		file = file_text_open_read("Localization/japanese_trainer.txt");
		break;
	}
	
//Loop through the text file
for (var i = 0; i < 9999; i ++;){
	var read_line = file_text_readln(file);
	
	//If we find the number in the text file
	if argument[0] == read_line{
		
		//Assign all of the messages to our NPCs dialogue array
		var o = 0, return_string = file_text_read_string(file);
		while return_string != "."{
			dialogue[o] = return_string;
			file_text_readln(file);
			return_string = file_text_read_string(file);
			o++;
			}
		file_text_close(file);
		return;
		}
	}
file_text_close(file);
}

function TRAINER_assign_battle_text(){
//Used for grabbing an NPCs text from the dialogue txt file
//Can also create multiple files to localize your game

//Open the correct text file depending on the target language
var file;
switch language{
	case 0:
		file = file_text_open_read("Localization/english_trainer.txt");
		break;
	case 1:
		file = file_text_open_read("Localization/japanese_trainer.txt");
		break;
	}
	
//Loop through the text file
for (var i = 0; i < 9999; i ++;){
	var read_line = file_text_readln(file);
	
	//If we find the number in the text file
	if argument[0] == read_line{
		
		//Assign all of the messages to our NPCs dialogue array
		var return_string = file_text_read_string(file);
		
		//Loop through and skip the first set of messages
		while return_string != "."{
			file_text_readln(file);
			return_string = file_text_read_string(file);
			}
		file_text_readln(file);
		return_string = file_text_read_string(file);
		
		//Assign trainer message before exiting the file
		while return_string != "."{
			trainer_end_msg = return_string;
			file_text_readln(file);
			return_string = file_text_read_string(file);
			}
		file_text_close(file);
		return;
		}
	}
file_text_close(file);
}