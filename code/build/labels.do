cd "/Users/simongreenhill/Documents/orientation/rawdata"
use superfund_sample, clear

local vars "shrblk8 shrhsp8 smhse8 no_hs_diploma8 ba_or_better8 unemprt8 povrat8 avhhin8 occupied80"

local labs "% Black" "% Hispanic" "% pop. in same home 5 years ago" "% over 25 w/ no high school diploma" "% over 25 w/ BA or better" "Unemployment rate" "Poverty rate" "Avg. household income" "% Units owner occupied"

local i = 1
while `i' <= 9 {
	local this_var `:word `i' of `vars''
	local this_lab `:'
}

foreach var of local vars{

	local this_label `:word '
}