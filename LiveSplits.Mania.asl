
state("SonicMania")
{
    bool runStart : 0x662B28;
	
	int coolBonus : 0x650CAC;
	int ringBonus : 0x650CA8;
	int timeBonus : 0x650CA4;
	int finalBossHealth : 0x6649C4;

}

update
{
	//Checks to see if the bonuses have values other than 0
	//For some reason time bonus gets assigned different values under 1000 when loading
	if (current.coolBonus != 0 || (current.timeBonus != 0 && (current.timeBonus % 100 == 0) && current.timeBonus !=244) || current.ringBonus > 0) {
		vars.shouldSplit = true;
	}
	
	if (current.finalBossHealth == 16) {
		vars.finalSplitReady = true;
	}

	vars.framecount++; 
	if (vars.framecount % 30 == 0) {

	}	
	return true;
}

init
{
	vars.framecount = 0;
	vars.shouldSplit = false;
	vars.finalSplitReady = false;
}

split
{
	//Checks to see if the bonuses are currently 0 and were not 0 at one point.
	if (vars.shouldSplit && (current.coolBonus == 0 && current.timeBonus == 0 && current.ringBonus == 0)) {
		print(vars.shouldSplit.ToString());
		vars.shouldSplit = false;
		return true;
	}
	
	if (vars.finalSplitReady && current.finalBossHealth == 0) {
		vars.finalSplitReady = false;
		vars.shoulSplit = false;
		return true;
	}
    return false;
}

start
{
   return !current.runStart && old.runStart;
}
 
 