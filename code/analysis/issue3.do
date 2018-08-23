cd 
clear all 
set more off 
capture log close 


// Set local git directory and local dropbox directory
if c(username) == "simongreenhill" {
    global dbdir = "/Users/simongreenhill/Dropbox/simon_epic_task"
    global hbpdir = "/Users/simongreenhill/DOcuments/simon_epic_task"
	}
else if c(username) == "" { // put trin's stuff here 
    global dbdir = ""
    global hbpdir = ""
	}
}
	
// Input and output directories
global outdir = "$dbdir/IntermediateData/Louisiana/output"
global codedir = "$hbpdir/code/build/Louisiana"
global logdir = "$codedir/Logfiles"

// Create a plain text log file to record output
// Log file has same name as do-file
log using "$logdir/construct_section_4_descript_log.txt", replace text

cd "/Users/simongreenhill/Dropbox/simon_epic_task/rawdata"
use superfund_sample, clear

* picking controls that I think will be important or meaningful
local controls "shrblk8 shrhsp8 smhse8 no_hs_diploma8 ba_or_better8 unemprt8 povrat8 avhhin8 occupied80"

cd "/Users/simongreenhill/Documents/orientation/simon_epic_task"
qui include$labels
balancetable npl2000 `controls' using issue3_table.tex, replace ctitles("Not NPL" "NPL" "Difference")

 /*
eststo clear

foreach c of local controls {
	eststo: qui mean `c' if npl2000 == 0
	eststo: qui mean `c' if npl2000 == 1
	eststo: qui reghdfe `c' i.npl2000, noabsorb
}

cd "/Users/simongreenhill/Documents/orientation/simon_epic_task"
esttab using issue3_table.tex, replace 

