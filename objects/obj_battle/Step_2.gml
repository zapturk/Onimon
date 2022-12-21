
//Increment the "count" variable if our new_health value hasn't change recently.
//If it reaches 10 frames, set the health to an integral value. This is because
//our method of lerping the health bar up and down creates non-integral numbers

if new_health_prev[0] != new_health[0]{
	new_health_prev[0] = new_health[0];
	new_health_prev_count[0] = 0;
	}
else new_health_prev_count[0]++;
if new_health_prev_count[0] == 10 monsters[battler, party.health] = round(new_health[0]);

/////////////////////////////////////////////////////////////////////////////////

if new_health_prev[1] != new_health[1]{
	new_health_prev[1] = new_health[1];
	new_health_prev_count[1] = 0;
	}
else new_health_prev_count[1]++;
if new_health_prev_count[1] == 10 eparty[ebattler, party.health] = round(new_health[1]);