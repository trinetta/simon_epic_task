cd 
clear all 
set more off 
capture log close 


// Set local git directory and local dropbox directory
if c(username) == "simongreenhill" {
    global dbdir = "/Users/simongreenhill/Dropbox/simon_epic_task"
    global gitdir = "/Users/simongreenhill/Documents/orientation/simon_epic_task"
	}
else if c(username) == "" { // put trin's stuff here 
    global dbdir = ""
    global gitdir = ""
	}
	
// Input and output directories
global datadir = "$dbdir/intermediatedata"
global TeXdir = "$gitdir/code/TeX"
global codedir = "$gitdir/code"
global logdir = "$codedir/logs"

cd $datadir
use superfund_sample, clear

* picking controls that I think will be important or meaningful
local controls "shrblk8 shrhsp8 smhse8 no_hs_diploma8 ba_or_better8 unemprt8 povrat8 avhhin8 occupied80"

cd $TeXdir

* add labels
label var shrblk8 "% Black"
label var shrhsp8 "% Hispanic"
label var smhse8 "% pop. in same house 5 yrs ago"
label var no_hs_diploma8 "No HS diploma (age 25+)"
label var ba_or_better8 "BA or better (age 25+)"
label var unemprt8 "Unemployment rate"
label var povrat8 "Poverty rate"
label var avhhin8 "Avg. HH income"
label var occupied80 "% units owner-occupied"

balancetable npl2000 `controls' using issue3_table.tex, replace  ctitles("Not NPL" "NPL" "Difference") 

cd $outdir
use superfund_sample_restricted, clear 

cd $TeXdir
balancetable npl2000 `controls' using  balancetable_HRS.tex, replace  ctitles("HRS < 28.5" "HRS > 28.5" "Difference")  

* balance table for only the cutoff of HRS codes [16.5, 40.5]

keep if hrs_82 > 16.5 & hrs_82 < 40.5
cd $TeXdir
balancetable npl2000 `controls' using  balancetable_HRS_cutoff.tex, replace  ctitles("HRS < 28.5" "HRS > 28.5" "Difference")  

 /*
eststo clear

foreach c of local controls {
	eststo: qui mean `c' if npl2000 == 0
	eststo: qui mean `c' if npl2000 == 1
	eststo: qui reghdfe `c' i.npl2000, noabsorb
}

cd "/Users/simongreenhill/Documents/orientation/simon_epic_task"
esttab using issue3_table.tex, replace 

