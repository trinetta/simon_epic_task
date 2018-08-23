/* 
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
*/

label var shrblk8 "% Black"
label var shrhsp8 "% Hispanic"
label var smhse8 "% pop. in same house 5 yrs ago"
label var no_hs_diploma8 "No HS diploma (age 25+)"
label var ba_or_better8 "BA or better (age 25+)"
label var unemprt8 "Unemployment rate"
label var povrat8 "Poverty rate"
label var avhhin8 "Avg. HH income"
label var occupied80 "% units owner-occupied"

/*
local vars "shrblk8 shrhsp8 smhse8 no_hs_diploma8 ba_or_better8 unemprt8 povrat8 avhhin8 occupied80"

local labs ""% Black" "% Hispanic" "% pop. in same home 5 years ago" "% over 25 w/ no high school diploma" "% over 25 w/ BA or better" "Unemployment rate" "Poverty rate" "Avg. household income" "% Units owner occupied""


local i = 1
while `i' <= 9 {
	local this_var `:word `i' of `vars''
	di `this_var'
	local this_lab `:word `i' of `labs''
	di `this_lab'
	/* local this_lab `:word `i' of `labs''
	di `this_lab'
	label `this_var' "`this_lab'"
	
	*/
	local i = `i'+1
}
/*

