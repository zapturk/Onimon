RELOAD

if msg == 2 && frame != 8
	frame++;
if msg == 4 && frame != 0
	frame--;


if msg == array_length(dialogue)-1 exit;
if press(ENTER) msg++;