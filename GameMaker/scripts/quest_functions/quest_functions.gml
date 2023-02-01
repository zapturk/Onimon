
function action_data(scr) constructor{
	self.scr = scr;
	self.args = [];
	}

function ADD_ACTION(){
//Adds an action to an NPC that can be executed while talking to them. 

///@arg script
///@arg arguments

//How to use:
//ADD_ACTION(action_basic, 1, _quest.coupons);
#region Greater Details
//Place ADD_ACTION lines into NPC's creation codes to build their list of actions.
//When adding an action, you should select which action scrip to use.
//In the below example, we'll use "action_basic" to just advance the characters dialogue, and also advance the quest "coupons" by one point.

//Example:
//ADD_ACTION(action_basic, 1, _quest.coupons);

//So in this action, we set action_basic's "progress" argument to 1, or TRUE, to advance the characters dialogue. We also advanced the coupon quest by one point.
//How this would look in-game could be something like this.. The NPC is explaining to you about the coupons, and after finishing talking with them, this action is
//ran, advanced their dialogue. Now the NPC's dialogue may have been updated to something like, "Did you find those coupons yet?"
//Additionally, we likely would have these coupons hidden in the world, but destroyed on creation if this quest wasn't started yet. If the coupons quest was originally
//set to -1, for not started, it would now be 0, for active. In the coupon items creation_code event, we would likely have a "if quest[_quest.coupons] == -1 destroy();
//Since this action incremented this quest, from -1 to 0, they will no longer destroy on create, allowing us to find them.

//We can make bigger changes to quests and NPC's in the scr_check_quests script. For example, we could check for the coupons, and if they're all found, we can remove them
//and increment the character's dialogue. This way, when you're talking to them they might instead say, "Oh, you found them all! Thanks, I'll take those from you."
//You could also give the player an item at the same time, in exchange for the coupons. You wouldn't want to repeat this conversation multiple times, so you'd also want to
//increment our characters dialogue, or, you could increment the quest, and add this to the NPC's creation code to remove them from the game from then on:

//if quest[_quest.coupons] == 1 destroy();

//Since we increment this quest once to start it, and once more once all coupons were found, the value would now be equal to 1, and this NPC will not spawn from now on.

#endregion

if !is_array(actions) var _l = 0;
else var _l = array_length(actions);
actions[_l] = new action_data(argument[0]);
	
	
for (var i = 1; i < argument_count; i++;){
	array_push(actions[_l].args, argument[i]);
	}
	
}

function action_basic(){

//Progress dialogue of a character, edit quest data, and set this characters trainer status

///@arg progress
///@arg quest
///@arg trainer

//How to use:
//action_basic(1);					//Set to "True" to progress dialogue
//action_basic(1, 2);				//Progress dialogue AND advance Quest 2 by one point
//action_basic(1, 1, 0);			//Progress dialogue, advance Quest 2 by one point, and make this NPC stop being a trainer from now


switch (argument_count){
	
	case 1:
		if (argument[0]) characters[char]++;
		break;
	
	case 2:
		if (argument[0]) characters[char]++;
		if (argument[1]) quest[argument[1]]++;
		break;

	case 3:
		if (argument[0]) characters[char]++;
		if (argument[1]) quest[argument[1]]++;
		if (argument[2]) my_team[0, 0] = -1;
		break;
	}
	
}

function action_give_item(){

}

function action_give_monster(){

	
}