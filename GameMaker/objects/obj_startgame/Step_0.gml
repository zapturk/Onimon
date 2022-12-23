
//Fade out of title and into to first room 
if room == rm_title{
	alph += 0.025;
	if alph >= 1.5 load();
	exit;
	}

//Kill me after fading is complete
alph -= 0.015;
if alph <= 0 destroy();
