

function HEAL_PARTY(){

for (var i = 0; i < 6; i++;){
	if monsters[i, 0] != -1{
		monsters[i, party.health] = GET_STAT(PLAYER, MAX_HEALTH_SUM, i);
		}
	}
	
}

//PC Party Functions
function PICKUP(mon){
///@arg Monster_Num

//Copy the data to the "Float Array"
for (var i = 0; i < array_length(monsters[mon]); i++){
	float[i] = monsters[mon, i];
	}

//Clear the old spot out
for (var i = 0; i < array_length(monsters[mon]); i++){
	monsters[mon, i] = -1;
	}
float_mon = -1;
}

function MOVE(mon){
///@desc Switches data in the Float and Monster arrays
///@arg Monster_Num

//Create a temporary array to save the "switch to" monster
temp = 0;
for (var i = 0; i < array_length(monsters[mon]); i++){
	temp[i] = monsters[mon, i];
	}
				
//Overwrite the "switch to" monsters data with the monster in float 
for (var i = 0; i < array_length(monsters[mon]); i++){
	monsters[mon, i] = float[i];
	}

if float_mon == -1{
	//Populate "float" monster with the temp array
	for (var i = 0; i < array_length(monsters[mon]); i++){
		float[i] = temp[i];
		}
	//Clear temp array as we're no longer using it
	temp = -1;
	return;
	}

//Overwrite "switch from" monster with the "switch to" monster that we stored in the temp array
for (var i = 0; i < array_length(monsters[mon]); i++){
	monsters[float_mon, i]  = temp[i];
	}

//Clear float and temp as we no longer need it.
temp = 0;
float = -1;
float_mon = -1;
	
}
	
function DROP(mon){
///@desc Drops a monster we're holding into a free slot
///@arg Monster_Num

//If there is a monster in the slot, switch the monster we are holding with the one in the slot
if monsters[mon, 0] != -1{
	MOVE(mon);
	return;
	}

//Overwrite "switch from" monster with the "switch to" monster that we stored in the temp array
for (var i = 0; i < array_length(monsters[mon]); i++){
	monsters[mon, i]  = float[i];
	}

//Organize party in case of gaps
for (var z = 0; z < 5; z++;){
	for (var i = 0; i < 5; i++;){
		if monsters[i, 0] == -1{
			for (var o = 0; o < array_length(monsters[i]); o++;){
				monsters[i, o] = monsters[i+1, o];
				}
			for (var o = 0; o < array_length(monsters[i]); o++;){
				monsters[i+1, o] = -1;
				}
			}
		}
	}

//Clear float as we are not using it anymore
float = -1;
	
}

//Party Menu Functions
function SELECT(mon){
///@arg Monster_Num

//If float is empty, pickup the monster
if float == -1{
	//Copy the data to the "Float Array"
	for (var i = 0; i < array_length(monsters[mon]); i++){
		float[i] = monsters[mon, i];
		}
	//Save the pickup location to clear out later
	float_mon = mon;
	}
}

function SWITCH(mon){
///@desc Switches data in the Float and Monster arrays
///@arg Monster_Num

//Create a temporary array to save the "switch to" monster
temp = 0;
for (var i = 0; i < array_length(monsters[mon]); i++){
	temp[i] = monsters[mon, i];
	}
				
//Overwrite the "switch to" monsters data with the monster in float 
for (var i = 0; i < array_length(monsters[mon]); i++){
	monsters[mon, i] = float[i];
	}

//Overwrite "switch from" monster with the "switch to" monster that we stored in the temp array
for (var i = 0; i < array_length(monsters[mon]); i++){
	monsters[float_mon, i]  = temp[i];
	}

//Clear float and temp as we no longer need it.
temp = 0;
float = -1;
float_mon = -1;
	
}

