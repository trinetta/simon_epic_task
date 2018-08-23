cd "/Users/simongreenhill/Dropbox/simon_epic_task/rawdata/"
use superfund_sample, clear

local price_control "lnmeanhs8"
local house_controls "firestoveheat80 noaircond80 nofullkitchen80 zerofullbath80 bedrms0_80occ bedrms1_80occ bedrms2_80occ bedrms3_80occ bedrms4_80occ bedrms5_80occ blt0_1yrs80occ blt2_5yrs80occ blt6_10yrs80occ blt10_20yrs80occ blt20_30yrs80occ blt30_40yrs80occ blt40_yrs80occ detach80occ mobile80occ"
local econ_controls "pop_den8 shrblk8 shrhsp8 child8 old8 shrfor8 ffh8 smhse8 hsdrop8 no_hs_diploma8 ba_or_better8 unemprt8 povrat8 welfare8 avhhin8 tothsun8 ownocc8 occupied80"

label var lnmdvalhs0 "Log med price"
label var npl2000 "2000 NPL status"

* regressions
eststo clear

* price control only
eststo: qui reghdfe lnmdvalhs0 npl2000 `price_control', noabsorb vce(robust)
estadd local FE "no", replace
estadd local Price "yes", replace 
estadd local House "no", replace 
estadd local Economic "no", replace 

* price and house controls
eststo: qui reghdfe lnmdvalhs0 npl2000 `price_control' `house_controls', noabsorb vce(robust)
estadd local FE "no", replace
estadd local Price "yes", replace 
estadd local House "yes", replace 
estadd local Economic "no", replace 

* price, house, economic
eststo: qui reghdfe lnmdvalhs0 npl2000 `price_control' `house_controls' `econ_controls', noabsorb vce(robust)
estadd local FE "no", replace
estadd local Price "yes", replace 
estadd local House "yes", replace 
estadd local Economic "yes", replace 

* add statefips FE
eststo: qui reghdfe lnmdvalhs0 npl2000 `price_control' `house_controls' `econ_controls', absorb(statefips) vce(robust)
estadd local FE "yes", replace
estadd local Price "yes", replace 
estadd local House "yes", replace 
estadd local Economic "yes", replace 

cd "/Users/simongreenhill/Dropbox/simon_epic_task/"
esttab using issue2_regs.tex, keep(npl2000) label scalars("FE Fixed Effects" "Price Price Controls" "House House Controls" "Economic Economic Controls") replace 