* ----------------------------------------------------------------------------------------------------------------------------------------------*
* Replication code for "The Impact of Foreign Aid on Child Labor" (Kanazawa, Goto, and Yamasaki)
* Stata 16.0
* ----------------------------------------------------------------------------------------------------------------------------------------------*

**------------------------------------------------
**		Settings for Main Analysis
**------------------------------------------------
use intermediate/China/China_final_data/Withparents_Allcountries_for_analysis.dta, clear

set scheme s2mono


*Label the values of variables
label value active_year2 active2
label value active_year3 active3
label value treat_5km treat5
label value treat treat10
label define active3 0 "2-3 years before" 1 "Right before" 2 "0-1 years after" 3 "2-3 years after" 4 "4-5 years after"
label define treat5 0 "Within 5km" 1 "Within 5km"
label define active2 1 "-5 years" 2 "-4 years" 3 "-3 years" 4 "-2 years" 5 "-1 year" 6 "Project start year" 7 "+1 year" 8 "+2 years" 9 "+3 years" 10 "+4 years" 11 "+5 years"
label define treat10 1 "Within 10km"

*Define control variables
gl varlist1 `"hv104 urban hv105 dist latitude longitude precision_code"'
gl varlist2 `"hv104 urban hv105 dist latitude longitude precision_code mother_age mother_edu father_edu father_age"'

*Keep only children from 7 to 14
keep if hv105<=14&hv105>=7 


* TBD
tab active_year2,gen(active_year2_)
foreach numlist in i 1/11{
gen active_year2_`i'_treat_5km = active_year2_`i'*treat_5km 
}

label var active_year2_`i'_treat_5km
label var active_year2_`i'_treat_5km
label var active_year2_`i'_treat_5km


**------------------------------------------------
**   Main figures and their tables in appendix
**------------------------------------------------

****Descriptive statistics of the children around World Bank's projects (Table 1)****
replace mother_age=. if mother_age==99 | mother_age==98
replace mother_edu=. if mother_edu==99 | mother_edu==98
replace father_age=. if father_age==99 | father_age==98
replace father_edu=. if father_edu==99 | father_edu==98

est clear
estpost tabstat paidwork nonpaidwork housework otherfalilywork dropout repeat paidworktime hv104 hv105 urban dist precision_code transactions_start_year mother_age mother_edu father_age father_edu, stat(count mean sd min max) columns(statistics)
eststo ex1
esttab ex1 using output/Main_results/Table_1.tex, replace cells("count mean(fmt(a3)) sd(fmt(a3)) min(fmt(a3)) max(fmt(a3))") booktabs label noobs


****Graphical exhibition of estimates on paid work and dropout (Figure 1a)****
est clear
qui reghdfe paidwork ib5.active_year2##i.treat_5km $varlist1, absorb(active_year2 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe dropout ib5.active_year2##i.treat_5km $varlist1, absorb(active_year2 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2

*Figure 1a
coefplot ex* , keep(1.active_year2*treat_5km 2.active_year2*treat_5km 3.active_year2*treat_5km 4.active_year2*treat_5km 5.active_year2*treat_5km 6.active_year2*treat_5km 7.active_year2*treat_5km 8.active_year2*treat_5km 9.active_year2*treat_5km 10.active_year2*treat_5km 11.active_year2*treat_5km) order(1.active_year2*treat_5km 2.active_year2*treat_5km 3.active_year2*treat_5km 4.active_year2*treat_5km 5.active_year2*treat_5km 6.active_year2*treat_5km 7.active_year2*treat_5km 8.active_year2*treat_5km 9.active_year2*treat_5km 10.active_year2*treat_5km 11.active_year2*treat_5km) yline(0, lpattern(dash)) xline(3, lpattern(dash)) vertical baselevels ytitle("Effects on outcome") xtitle("Relative timings × Within 5km") ylabel(-0.05(0.05)0.2) xlabel( , angle(30) labsize(vsmall)) legend( label (2 "Paidwork") label (4 "Dropout")) coeflabel( , interaction("×"))

graph export output/Main_results/Figure_1a.png,replace

*Appendix Table A.4
esttab ex* using output/Results_in_appendix/Table_A4.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) se(3) b(3) brackets nogaps  mtitles(Paidwork Dropout) keep(3.active_year2*1.treat_5km 4.active_year2*1.treat_5km 6.active_year2*1.treat_5km 7.active_year2*1.treat_5km 8.active_year2*1.treat_5km 9.active_year2*1.treat_5km 10.active_year2*1.treat_5km 11.active_year2*1.treat_5km) order(1.active_year2*1.treat_5km 2.active_year2*1.treat_5km 3.active_year2*1.treat_5km 4.active_year2*1.treat_5km 6.active_year2*1.treat_5km 7.active_year2*1.treat_5km 8.active_year2*1.treat_5km 9.active_year2*1.treat_5km 10.active_year2*1.treat_5km 11.active_year2*1.treat_5km) replace


****Construction vs Non-construction (Figure 1b)****
gen precise_edu2=1 if crs_sector_code==110&precision_code==1&location_class==3 //Create a dummy variable which denotes construction projects in the education sector
replace precise_edu2=0 if precise_edu==.
gen precise_health2=1 if crs_sector_code==120&precision_code==1&location_class==3 //Create a dummy variable which denotes construction projects in the health sector
replace precise_health2=0 if precise_health==.

gen construction=(crs_sector_code==210|crs_sector_code==160 |precise_edu2==1|precise_health2==1) //Create a dummy variable which denotes construction projects

est clear
qui reghdfe paidwork ib1.active_year3##i.treat_5km $varlist1 if construction==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork ib1.active_year3##i.treat_5km $varlist1 if construction==0, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2

*Figure 1b
coefplot ex*, keep(0.active_year3*treat_5km 1.active_year3*treat_5km 2.active_year3*treat_5km 3.active_year3*treat_5km 4.active_year3*treat_5km) order(0.active_year3*treat_5km 1.active_year3*treat_5km 2.active_year3*treat_5km 3.active_year3*treat_5km 4.active_year3*treat_5km) yline(0, lpattern(dash)) xline(2, lpattern(dash)) vertical baselevels ytitle("Effects on paid work") xtitle("Relative timings × Within 5km") ylabel(-0.05(0.05)0.2) xlabel( , angle(30) labsize(vsmall)) legend( label (2 "Construction") label (4 "Non-construction")) coeflabel( , interaction("×"))
graph export output/Main_results/Figure_1b.png,replace

*Appendix Table A.5
esttab ex* using output/Results_in_appendix/Table_A5.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) se(3) b(3) brackets nogaps  mtitles(Construction Non-construction) keep(0.active_year3*1.treat_5km 2.active_year3*1.treat_5km 3.active_year3*1.treat_5km 4.active_year3*1.treat_5km) order(0.active_year3*1.treat_5km 2.active_year3*1.treat_5km 3.active_year3*1.treat_5km 4.active_year3*1.treat_5km) replace



****China vs WB (Figure 1c)****
est clear
qui reghdfe paidwork ib1.active_year3##i.treat_5km $varlist1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1

use intermediate/WB/WB_final_data/Withparents_WB_Allcountries_for_analysis, clear


*Label the values of variables
label value active_year2 active2
label value active_year3 active3
label value treat_5km treat5
label value treat treat10
label define active3 0 "2-3 years before" 1 "Right before" 2 "0-1 years after" 3 "2-3 years after" 4 "4-5 years after"
label define treat5 0 "Within 5km" 1 "Within 5km"
label define active2 1 "-5 years" 2 "-4 years" 3 "-3 years" 4 "-2 years" 5 "-1 year" 6 "project year" 7 "+1 year" 8 "+2 years" 9 "+3 years" 10 "+4 years" 11 "+5 years"
label define treat10 1 "Within 10km"

*Define control variables
gl varlist1 `"hv104 urban hv105 dist latitude longitude precision_code"'
gl varlist2 `"hv104 urban hv105 dist latitude longitude precision_code mother_age mother_edu father_edu father_age"'

*Keep only children from 7 to 14
keep if hv105<=14&hv105>=7 


qui reghdfe paidwork ib1.active_year3##i.treat_5km $varlist1, absorb(active_year3 treat_5km sector1code1##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2

*Figure 1c
coefplot ex* , keep(0.active_year3*treat_5km 1.active_year3*treat_5km 2.active_year3*treat_5km 3.active_year3*treat_5km 4.active_year3*treat_5km) order(0.active_year3*treat_5km 1.active_year3*treat_5km 2.active_year3*treat_5km 3.active_year3*treat_5km 4.active_year3*treat_5km) yline(0, lpattern(dash)) xline(2, lpattern(dash)) vertical baselevels ytitle("Effect on paid work") xtitle("Relative timings × Within 5km") ylabel(-0.05(0.05)0.2) xlabel( , angle(30) labsize(vsmall)) legend( label (2 "China") label (4 "World Bank")) coeflabel( , interaction("×"))
graph export output/Main_results/Figure_1c.png,replace

*Appendix Table A.6
esttab ex* using output/Results_in_appendix/Table_A6.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) se(3) b(3) brackets nogaps  mtitles(China "World Bank") keep(0.active_year3*1.treat_5km 2.active_year3*1.treat_5km 3.active_year3*1.treat_5km 4.active_year3*1.treat_5km) order(0.active_year3*1.treat_5km 2.active_year3*1.treat_5km 3.active_year3*1.treat_5km 4.active_year3*1.treat_5km) replace