RELOAD

//Which frame of the background to draw (can be used to show multiple different images as
//the professor is speaking)
frame = 0;

msg = 0;

//Configure text settings
halign(1);
font(fn_yana);
color(col[COL_RED, 3]);

//Assign the dialogue used for this cutscene
var i = 0;
//dialogue[i] = "Hello! Please pardon the intrusion."; i++;
//dialogue[i] = "My name is Akira. I'm a professor and I've made studying these monsters my lifes work."; i++;
//dialogue[i] = "As I'm sure you know, curious little creatures live with us in harmoney all over the world!"; i++;
//dialogue[i] = "Well, mostly..."; i++;
//dialogue[i] = "These monsters are anything from pets, to workers, to powerful battlers!"; i++;
//dialogue[i] = "However, we are still finding out about new monsters almost every day,"; i++;
//dialogue[i] = "and there seems to be a never ending supply of new information regarding them!"; i++;
//dialogue[i] = "I believe you are here to start your journey as a monster tamer, isn't that right?"; i++;
//dialogue[i] = "Well, you should probably get going then. Your slept past your alarm!"; i++;

dialogue[i] = "Oh sorry, I didn't see you there."; i++;
dialogue[i] = "My name is Chestnut. I'm a professor that studies the Oni we share our world with."; i++;
dialogue[i] = "Some use Oni to help with their daily life."; i++;
dialogue[i] = "Others use them to test their strength with battles."; i++;
dialogue[i] = "It looks like your journy is about to begin."; i++;
dialogue[i] = "Will you become the greatest Oni tamer or complete the Oni bestiary?"; i++;
dialogue[i] = "What you are ready to go?"; i++;
dialogue[i] = "Well, then you should probably wake up!"; i++;
dialogue[i] = "..."; i++;

//Copy and paste for new messages
//dialogue[i] = ""; i++;