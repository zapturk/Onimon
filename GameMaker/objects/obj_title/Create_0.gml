
//Define "start game" message
start = "Press any key to start!";

//Simulate animation if we have one
sel = 0;
anim = 0;
spr = spr_;
alarm_set(0, 20);

//Allow title to waver up and down
buffer = 0;
trigger = 0.05;

//Assign initial coordinates
depth = 10;
x = room_width/2;
y = 5;

//Set default alpha
alph = 1;
draw = 1;
alarm_set(1, 60);
alarm_set(2, 120);