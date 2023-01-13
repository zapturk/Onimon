
cursor_sprite = spr_;
window_set_cursor(cr_default);


//Check our debug settings to see if we will run the Visual Editor check or not. If not, start the game
if (debug_settings()) exit;
room_goto(rm_splash);
