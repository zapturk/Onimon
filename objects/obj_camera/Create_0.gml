RELOAD

depth = 0;
alarm_set(2, 2);
cam = camera_create();

mon_hop = 1;
alarm_set(3, 5);

alarm_set(0, 1);
_cam_width = 256;
_cam_height = 144;
smooth_camera = 1;

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 50);
var pm = matrix_build_projection_ortho(_cam_width, _cam_height, depth, 10000);

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);

view_camera[0] = cam;

//Menu stuff
sel[0] = 0;		//Menu 1 - PC X
sel[1] = 0;		//Menu 2 - PC Y 
sel[2] = 0;		//Menu 3 - Box Sel
sel[3] = 0;		//Menu 4 = PC Party Menu
sel[4] = 0;		//Menu 5 = Party/Close Sel
function unpause(){
	pause = 0;
	for (var i = 0; i < 4; i++){
		sel[i] = 0;
		}
	}

//MonDex Variables
hobble[0] = 0;
hobble[1] = 0;
incr[0] = 1;
incr[1] = 1;
timer = 0;

battle_start = 0;
showinfo = 0;
float = -1;
float_mon = -1;
float_xpos = 0;
float_ypos = 0;
flash = 0;
alph = -0.5;
logoff_alpha = 0;

enum _pause{
	not_paused, paused, dtech, mondex, mondex_info, party, info, inventory, idcard, save, logoff, pc
	}

//Party Macros
#macro FILLED 0
#macro SELCT 1
#macro MOVTO 2
#macro MOVIN 3
#macro EMPTY 4
