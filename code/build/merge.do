* merge all data files on var fips

cd 
clear all 
set more off 
capture log close 


// Set local git directory and local dropbox directory
if c(username) == "simongreenhill" {
    global dbdir = "/Users/simongreenhill/Dropbox/simon_epic_task"
    global gitdir = "/Users/simongreenhill/Documents/simon_epic_task"
	}
else if c(username) == "" { // put trin's stuff here 
    global dbdir = ""
    global gitdir = ""
	}
	
// Input and output directories
global outdir = "$dbdir/intermediatedata"
global codedir = "$gitdir/code"
global logdir = "$codedir/logs"

// Create a plain text log file to record output
// Log file has same name as do-file
* log using "$logdir/merge.txt", replace text


* open and save each file as .dta
local files "demographics house_age1 house_age2 house_chars1 house_chars2 sample82"
foreach file of local files {
	pwd
	cd "$dbdir/rawdata"
	import delimited `file'.txt, clear
	cd $outdir
	save `file'.dta, replace 
}

* merge files one by one
cd $outdir
use demographics, clear

local tomerge "house_age1 house_age2 house_chars1 house_chars2 sample82"
foreach file of local tomerge{
	merge 1:1 fips using `file'
	drop _merge 
}

merge 1:1 fips using sample82


* create statefips var

* divide by 1000000 so it's easier to turn to a string (only care about first two digits anyway)
gen statefips=int(fips/1000000)
tostring statefips, replace
replace statefips=substr(statefips, 1, 1) if strlen(statefips) == 4
replace statefips=substr(statefips, 1, 2) if strlen(statefips) > 4
destring statefips, replace 

* drop some stuff
keep if npl2000 != .

* save
cd $outdir
save superfund_sample, replace

* add an hrs dummy and add binned variable (per issue 4) 
gen hrs = (hrs_82 > 28.5)

gen byte hrs_bin = 2.375 if hrs_82 < 4.75

local i 4.75
while `i' <= 75 {
	local j `i'+4.75
	replace hrs_bin=(`i' + `j')/2 if hrs_82 >= `i' & hrs_82 < `j'
	local i `j'
}

* drop and save 
drop if hrs_bin==.
cd$outdir
save superfund_sample_restricted

































