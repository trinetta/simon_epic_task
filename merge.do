* merge all data files on var fips

cd /Users/simongreenhill/Documents/orientation/rawdata/

* open and save each file as .dta
local files "demographics house_age1 house_age2 house_chars1 house_chars2 sample82"
foreach file of local files {
	import delimited `file'.txt, clear
	save `file'.dta, replace 
}

* merge files one by one
use demographics, clear

local tomerge "house_age1 house_age2 house_chars1 house_chars2"
foreach file of local tomerge{
	merge 1:1 fips using `file'
	assert _merge == 3
	drop _merge 
}

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
save superfund_sample, replace