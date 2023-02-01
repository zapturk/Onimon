

function scr_check_quests(){
//This script is ran while chatting with NPC's
//First, it checks if this NPC has any importance to quests or the story from the "quest_character" variable
//If this returns true, we should then check WHICH character this is, as well as what stage of the quest we are on,
//and make changes to the game as needed. For example, we can increment the quest to the next level, give the player
//items or monsters, teleport the player to a new location, and an array of other actions.

//Please see the example quests written below, and check out the Quests tutorial on YouTube once that is uploaded


//If this character has been assigned any actions, then it's possible it affects quests in one way or another.
//Therefore, see if we can find the character, and if we do, make whatever changes we want to the game as needed
if actions != -1{
	
	/*
	if interact.char == ch.coupon01{
		if quest[_quest.coupons] == 0{
			var _coupons = 0;
			if (scr_invcheck(spr_coupon_01)) _coupons++;
			if (scr_invcheck(spr_coupon_02)) _coupons++;
			if (scr_invcheck(spr_coupon_03)) _coupons++;
			if (scr_invcheck(spr_coupon_04)) _coupons++;
	
			if _coupons == 4{
				quest[_quest.coupons] = 1;
				character[ch.coupon01]++;
				scr_invremove(spr_coupon_01);
				scr_invremove(spr_coupon_02);
				scr_invremove(spr_coupon_03);
				scr_invremove(spr_coupon_04);
				}
			}
		}
	*/
	
	}
}
