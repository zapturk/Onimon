if file_exists("save.sav"){
	if show_question("Would you like to delete your save?"){
		file_delete("save.sav");	
		}
	}