**------------------------------------------------
**	  Codes for Appendix Tables and Figures
**------------------------------------------------
use intermediate/China/China_final_data/Withparents_Allcountries_for_analysis, clear

set scheme s2mono



*Define control variables
gl varlist1 `"hv104 urban hv105 dist latitude longitude precision_code"'
gl varlist2 `"hv104 urban hv105 dist latitude longitude precision_code mother_age mother_edu father_edu father_age"'

*Keep only children from 7 to 14
keep if hv105<=14&hv105>=7 

*Create interaction terms
tab active_year2, gen(active_year2_)
forvalues i=1/11{
gen active_year2_`i'_treat_5km = active_year2_`i'*treat_5km 
}
forvalues i=3/5{
label var active_year2_`i'_treat_5km "`=`i'-6' years × Within 5km"
}
label var active_year2_6_treat_5km "Project start year × Within 5km"
label var active_year2_7_treat_5km "+1 year × Within 5km"
forvalues i=8/11{
label var active_year2_`i'_treat_5km "+`=`i'-6' years × Within 5km"
}

tab active_year3, gen(active_year3_)
forvalues i=1/5{
gen active_year3_`i'_treat_5km = active_year3_`i'*treat_5km 
}
label var active_year3_1_treat_5km "2~3 years before × Within 5km"
label var active_year3_2_treat_5km "Right before × Within 5km"
label var active_year3_3_treat_5km "0~1 years after × Within 5km"
label var active_year3_4_treat_5km "2~3 years after × Within 5km"
label var active_year3_5_treat_5km "4~5 years after × Within 5km"

forvalues i=1/5{
gen active_year3_`i'_treat_10km = active_year3_`i'*treat_10km 
}
label var active_year3_1_treat_10km "2~3 years before × Within 10km"
label var active_year3_2_treat_10km "Right before × Within 10km"
label var active_year3_3_treat_10km "0~1 years after × Within 10km"
label var active_year3_4_treat_10km "2~3 years after × Within 10km"
label var active_year3_5_treat_10km "4~5 years after × Within 10km"

forvalues i=1/5{
gen active_year3_`i'_persist_treat = active_year3_`i'*persist_treat 
}
label var active_year3_1_persist_treat "2~3 years before × Within 5km"
label var active_year3_2_persist_treat "Right before × Within 5km"
label var active_year3_3_persist_treat "0~1 years after × Within 5km"
label var active_year3_4_persist_treat "2~3 years after × Within 5km"
label var active_year3_5_persist_treat "4~5 years after × Within 5km"



**---------------------------------------
**	  Codes for Analysis in Appendix
**---------------------------------------

****Chinese ODA-like projects and paid work (Appendix Table A.1)****
est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 & flow_class=="ODA-like", absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2

esttab ex* using output/Results_in_appendix/Table_A1.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles("All projects" ODA-like) keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) replace


****Chinese aid and working hours (Appendix Table A.8)****
est clear
qui reghdfe paidworktime active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidworktime active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2

esttab ex* using output/Results_in_appendix/Table_A8.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles("Working hours" "Working hours") keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km)  replace


****Chinese aid and paid work with parents' characteristics (Appendix Table A.9)****
est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 &mother_age!=.&mother_edu!=.&father_age!=.&father_edu!=., absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km mother_age mother_edu father_age father_edu $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex3

esttab ex* using output/Results_in_appendix/Table_A9.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles("All children" "Children with parents" "Children with parents") keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km)  replace


****Chinese aid and paid work with 10km cutoff (Appendix Table A.10)****
est clear
qui reghdfe paidwork active_year3_1_treat_10km active_year3_3_treat_10km active_year3_4_treat_10km active_year3_5_treat_10km if china==1, absorb(active_year3 treat_10km crs_sector_code##transactions_start_year##treat_10km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_10km active_year3_3_treat_10km active_year3_4_treat_10km active_year3_5_treat_10km $varlist1 if china==1, absorb(active_year3 treat_10km crs_sector_code##transactions_start_year##treat_10km) vce(cluster hv001a) 
eststo ex2

esttab ex* using output/Results_in_appendix/Table_A10.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles(Paidwprk Paidwork) keep(active_year3_1_treat_10km active_year3_3_treat_10km active_year3_4_treat_10km active_year3_5_treat_10km) order(active_year3_1_treat_10km active_year3_3_treat_10km active_year3_4_treat_10km active_year3_5_treat_10km) replace


****Chinese projects with precise locations and paid work (Appendix Table A.11)****
est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 & precision_code<=1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 & precision_code<=2, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 & precision_code<=3, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex3
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 & precision_code<=4, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex4

esttab ex* using output/Results_in_appendix/Table_A11.tex, ar2 label  star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles("1st precise" "≤ 2nd precise" "≤ 3rd precise" "≤ 4th precise") keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) replace


****Chinese aid and paid work controlling for the number of close projects (Appendix Table A.12)****
replace num_project2=0 if num_project2==. 

est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 num_project if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 num_project2 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex3
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 & num_project2<=1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a)  
eststo ex4 

esttab ex* using output/Results_in_appendix/Table_A12.tex, ar2 label  star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles(Paidwprk Paidwork Paidwork Paidwork) keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) replace


****Chinese aid and paid work with weighting (Appendix Table A.13)****
gen weight=hv005/1000000
egen hv023a=group(hv007 country_id2 hv023)
svyset [pweight=weight], psu(hv001a) strata(hv023a) singleunit(certainty) //Weight by the sampling probability of household clusters in the DHS Program 
svydescribe

est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 & country_id2!=4, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2
svy: qui reg paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km i.active_year3 i.treat_5km crs_sector_code##transactions_start_year##treat_5km $varlist1 if china==1
eststo ex3
esttab ex* using output/Results_in_appendix/Table_A13.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km)  mtitles(Baseline "Gabon omitted" Weighted) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) replace


****Chinese aid and paid work with other fixed effects (Appendix Table A.15)****
est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km if china==1, absorb(active_year3 treat_5km crs_sector_code##treat_5km) vce(cluster hv001a)
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##treat_5km) vce(cluster hv001a)
eststo ex2

esttab ex* using output/Results_in_appendix/Table_A15.tex, ar2 label  star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles(Paidwprk Paidwork) keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km)  replace


****The size of Chinese projects (in US$) (Appendix Table A.16)****
est clear
egen project=seq(), by(project_location_id china)
keep if project==1
estpost tabstat even_split_commitments if china==1, by(crs_sector_code) stat(count mean range min max sd) columns(statistics)
eststo ex1
esttab ex1 using output/Results_in_appendix/Table_A16_1.tex, replace label cells("count(fmt(a3)) mean(fmt(a3)) sd(fmt(a3)) min(fmt(a3)) max(fmt(a3))")  nonumber f noobs alignment(S) booktabs //Our sample Chinese projects

insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear
keep if recipients=="Benin"|recipients=="Burundi"|recipients=="Cameroon"|recipients=="Gabon"|recipients=="Liberia"|recipients=="Sierra Leone"|recipients=="Uganda"
est clear
estpost tabstat even_split_commitments, by(crs_sector_code) stat(count mean range min max sd) columns(statistics)
eststo ex1
esttab ex1 using output/Results_in_appendix/Table_A16_2.tex, replace cells("count(fmt(a3)) mean(fmt(a3)) sd(fmt(a3)) min(fmt(a3)) max(fmt(a3))") label nonumber f noobs alignment(S) booktabs //All Chinese projects


****Chinese and World Bank's aid and paid work with projects' size (Appendix Table A.18)****
use intermediate/China/China_final_data/Withparents_Allcountries_for_analysis, clear

set scheme s2mono

*Define control variables
gl varlist1 `"hv104 urban hv105 dist latitude longitude precision_code"'
gl varlist2 `"hv104 urban hv105 dist latitude longitude precision_code mother_age mother_edu father_edu father_age"'

*Create interaction terms
tab active_year3, gen(active_year3_)
forvalues i=1/5{
gen active_year3_`i'_treat_5km = active_year3_`i'*treat_5km 
}
label var active_year3_1_treat_5km "2~3 years before × Within 5km"
label var active_year3_2_treat_5km "Right before × Within 5km"
label var active_year3_3_treat_5km "0~1 years after × Within 5km"
label var active_year3_4_treat_5km "2~3 years after × Within 5km"
label var active_year3_5_treat_5km "4~5 years after × Within 5km"

*Keep only children from 7 to 14
keep if hv105<=14&hv105>=7 


est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 c.even_split_commitments##treat_5km if china==1, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==0, absorb(active_year3 treat_5km sector1code1##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex3
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 c.even_split_commitments##treat_5km if china==0, absorb(active_year3 treat_5km sector1code1##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex4
esttab ex* using output/Results_in_appendix/Table_A18.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) replace


****Descriptive statistics of the children around World Bank's projects (Appendix Table A.14)****
replace mother_age=. if mother_age==99 | mother_age==98
replace mother_edu=. if mother_edu==99 | mother_edu==98
replace father_age=. if father_age==99 | father_age==98
replace father_edu=. if father_edu==99 | father_edu==98

est clear
estpost tabstat paidwork nonpaidwork housework otherfalilywork dropout repeat paidworktime hv104 hv105 urban dist precision_code transactions_start_year mother_age father_age mother_edu father_edu if china==0, stat(count mean sd min max) columns(statistics)
eststo ex1
esttab ex1 using output/Results_in_appendix/Table_A14.tex, replace cells("count mean(fmt(a3)) sd(fmt(a3)) min(fmt(a3)) max(fmt(a3))")  booktabs label noobs


****World Bank's construction projects and paid work (Appendix Table A.19)****
gen precise_edu2=1 if sector==3&precision_code==1&location_class==3
replace precise_edu2=0 if precise_edu==.
gen precise_health2=1 if sector==6&precision_code==1&location_class==3
replace precise_health2=0 if precise_health==.

est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==0, absorb(active_year3 treat_5km sector1code1##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==0 & (sector==9|sector==1 |precise_edu2==1|precise_health2==1), absorb(active_year3 treat_5km sector1code1##treat_5km) vce(cluster hv001a) //transactions_start_yearはどうする？
eststo ex2

esttab ex* using output/Results_in_appendix/Table_A19.tex, ar2 label  star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles("All projects" Construction) keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) replace



//ここから
****The size of World Bank's projects (in US$) (Appendix Table A.17)****
*Defining the name of the sectors
est clear
//keep if china==1
egen project=seq(), by(project_location_id china)
keep if project==1
estpost tabstat even_split_commitments if china==0, by(sector) stat(count mean range min max sd) columns(statistics)
eststo ex1
esttab ex1 using output/Results_in_appendix/Table_A17_1.tex, replace cells("count(fmt(a3)) mean(fmt(a3)) sd(fmt(a3)) min(fmt(a3)) max(fmt(a3))") label nonumber f noobs alignment(S) booktabs //Our sample World Bank's projects


use intermediate/China/China_intermediate_results/0-Aid_Data/allcountry_chinese_WB_aid, clear
keep if china==0
**Create the same clasification of targeted sectors as Chinese aid
//keep if recipients=="Benin"|recipients=="Burundi"|recipients=="Cameroon"|recipients=="Gabon"|recipients=="Liberia"|recipients=="Sierra Leone"|recipients=="Uganda"
gen sector=0
replace sector=1 if sector1code=="WT"| sector1code=="TC"|sector1code=="TP"|sector1code=="BV" //"Transport & Storage"
replace sector=2 if sector1code=="AB"|sector1code=="AH"|sector1code=="AT"| sector1code=="AZ" //"Agri,Forestry,and Fishing"
replace sector=3 if sector1code=="EP"|sector1code=="ET" //"Education"
replace sector=4 if sector1code=="LH"|sector1code=="LC"|sector1code=="LD"| sector1code=="LT"|sector1code=="LG" //"Energy generation & supply"
replace sector=5 if sector1code=="BC"|sector1code=="BZ"|sector1code=="BH" //"Government & Civil society"
replace sector=6 if sector1code=="BQ"|sector1code=="JA" //"Health"
replace sector=7 if sector1code=="YZ"|sector1code=="LS"|sector1code=="BT" //"Industry, mining, construction"
replace sector=8 if sector1code=="WD" //"Other multisector"
replace sector=9 if sector1code=="JB"|sector1code=="BS"|sector1code=="TW"| sector1code=="TA"|sector1code=="TI" //"Other social infrastructure & service"
replace sector=10 if sector1code=="WZ"|sector1code=="WC" //"Water supply & sanitation"


est clear
estpost tabstat even_split_commitments, by(sector) stat(count mean range min max sd) columns(statistics)
eststo ex1
esttab ex1 using output/Results_in_appendix/Table_A17_2.tex, replace cells("count(fmt(a3)) mean(fmt(a3)) sd(fmt(a3)) min(fmt(a3)) max(fmt(a3))") label nonumber f noobs alignment(S) booktabs //All World Bank's projects


****Graphical exhibition of estimates on paid work for each 5km distance (Appendix Figure A.1)****
use intermediate/China/China_final_data/Withparents_Allcountries_for_analysis, clear

set scheme s2mono

*Define control variables
gl varlist1 `"hv104 urban hv105 dist latitude longitude precision_code"'
gl varlist2 `"hv104 urban hv105 dist latitude longitude precision_code mother_age mother_edu father_edu father_age"'

*Keep only children from 7 to 14
keep if hv105<=14&hv105>=7 


gen distance_category=0

forvalues i=5(5)100{
    replace distance_category=`i' if dist<=`i' & dist>`=`i'-5'
}
forvalues i=5(5)100{
	gen dist_`i'=(distance_category==`i')
} //Create dummy variables which denote diatance categories for each 5km distance

gen after=(active_year3>1)
label value after after
label define after 0"Before" 1"After"
forvalues i=5(5)100{
    label value dist_`i' dist_`i'
label define dist_`i' 0"Other" 1 "`=`i'-5'~`i'km" 
}

*Create interaction terms
tab active_year2, gen(active_year2_)
forvalues i=1/11{
gen active_year2_`i'_treat_5km = active_year2_`i'*treat_5km 
}
forvalues i=1/5{
label var active_year2_`i'_treat_5km "`=`i'-6' years × Within 5km"
}
label var active_year2_6_treat_5km "Project start year × Within 5km"
label var active_year2_7_treat_5km "+1 year × Within 5km"
forvalues i=8/11{
label var active_year2_`i'_treat_5km "+`=`i'-6' years × Within 5km"
}


forvalues i=5(5)100{
	gen after_dist`i'=after*dist_`i'
} //Create interaction terms between After and each 5km distance category
forvalues i=5(5)100{
label value after_dist`i' after_dist`i'
label define after_dist`i' 0"Other" 1 "After×`=`i'-5'~`i'km"
} 

gen before=(active_year3<=1)
forvalues i=5(5)100{
	gen before_dist`i'=before*dist_`i'
} //Create interaction terms between Before and each 5km distance category
forvalues i=5(5)100{
label value before_dist`i' before_dist`i'
label define before_dist`i' 0"Other" 1 "Before×`=`i'-5'~`i'km"
} 

qui reghdfe paidwork dist_* after_dist* $varlist1 if china==1, absorb(crs_sector_code##transactions_start_year##dist_5) vce(cluster hv001a) noconstant
eststo ex1
coefplot ex1, keep(after_dist*) omitted yline(0, lpattern(dash)) xtitle(After × Distance category) xscale(titlegap(2)) ytitle(Effect on paid work) mlabsize(tiny) vertical baselevels label  xlabel( , angle(90) labsize(vsmall)) coeflabels(after_dist5="After × Within 0~5km" after_dist10="After × Within 5~10km" after_dist15="After × Within 10~15km" after_dist20="After × Within 15~20km" after_dist25="After × Within 20~25km" after_dist30="After × Within 25~30km" after_dist35="After × Within 30~35km" after_dist40="After × Within 35~40km" after_dist45="After × Within 40~45km" after_dist50="After × Within 45~50km" after_dist55="After × Within 50~55km" after_dist60="After × Within 55~60km" after_dist65="After × Within 60~65km" after_dist70="After × Within 65~70km" after_dist75="After × Within 70~75km" after_dist80="After × Within 75~80km" after_dist85="After × Within 80~85km" after_dist90="After × Within 85~90km" after_dist95="After × Within 90~95km" after_dist100="After × Within 95~100km")
graph export output/Results_in_appendix/Figure_A1.png,replace


****Graphical exhibition of estimates on paid work with other specifications (Appendix Figure A.2)****
est clear
qui reghdfe paidwork active_year2_1_treat_5km active_year2_2_treat_5km active_year2_3_treat_5km active_year2_4_treat_5km active_year2_6_treat_5km active_year2_7_treat_5km active_year2_8_treat_5km active_year2_9_treat_5km active_year2_10_treat_5km active_year2_11_treat_5km $varlist1 if china==1, absorb(active_year2 treat_5km crs_sector_code##treat_5km) vce(cluster hv001a) 
eststo ex1
qui reghdfe paidwork active_year2_1_treat_5km active_year2_2_treat_5km active_year2_3_treat_5km active_year2_4_treat_5km active_year2_6_treat_5km active_year2_7_treat_5km active_year2_8_treat_5km active_year2_9_treat_5km active_year2_10_treat_5km active_year2_11_treat_5km $varlist1 if china==1, absorb(active_year2 treat_5km country_id2##treat_5km) vce(cluster hv001a) 
eststo ex2
qui reghdfe paidwork active_year2_1_treat_5km active_year2_2_treat_5km active_year2_3_treat_5km active_year2_4_treat_5km active_year2_6_treat_5km active_year2_7_treat_5km active_year2_8_treat_5km active_year2_9_treat_5km active_year2_10_treat_5km active_year2_11_treat_5km $varlist1 if china==1, absorb(active_year2 treat_5km country_id2##hv007##treat_5km) vce(cluster hv001a) 
eststo ex3
coefplot ex*, keep(active_year2_1_treat_5km active_year2_2_treat_5km active_year2_3_treat_5km active_year2_4_treat_5km active_year2_6_treat_5km active_year2_7_treat_5km active_year2_8_treat_5km active_year2_9_treat_5km active_year2_10_treat_5km active_year2_11_treat_5km) order(active_year2_1_treat_5km active_year2_2_treat_5km active_year2_3_treat_5km active_year2_4_treat_5km active_year2_6_treat_5km active_year2_7_treat_5km active_year2_8_treat_5km active_year2_9_treat_5km active_year2_10_treat_5km active_year2_11_treat_5km) yline(0, lpattern(dash)) xline(4.5, lpattern(dash)) vertical baselevels  ytitle("Effect on paid work") xtitle("Relative timings × Within 5km") xlabel( , angle(30) labsize(vsmall)) legend( label (2 "Sector × Within 5km FEs") label (4 "Country × Within 5km FEs") label (6 "Country × Interview year × Within 5km FEs")) coeflabel( , interaction("×"))
graph export output/Results_in_appendix/Figure_A2.png,replace



****Chinese aid and paid work: cohort persistence (Appendix Table A.7)****
use intermediate/China/China_final_data/Withparents_Allcountries_for_analysis, clear

set scheme s2mono

*Define control variables
gl varlist1 `"hv104 urban hv105 dist latitude longitude precision_code"'
gl varlist2 `"hv104 urban hv105 dist latitude longitude precision_code mother_age mother_edu father_edu father_age"'

*Create interaction terms
tab active_year3, gen(active_year3_)
forvalues i=1/5{
gen active_year3_`i'_persist_treat = active_year3_`i'*persist_treat 
}
label var active_year3_1_persist_treat "2~3 years before × Within 5km"
label var active_year3_2_persist_treat "Right before × Within 5km"
label var active_year3_3_persist_treat "0~1 years after × Within 5km"
label var active_year3_4_persist_treat "2~3 years after × Within 5km"
label var active_year3_5_persist_treat "4~5 years after × Within 5km"

*Keep only children who were treated at the age of from 7 to 14
keep if treatage>=7 & treatage<=14
replace paidwork=. if hv105>=15 | hv105<=4

est clear
qui reghdfe paidwork active_year3_1_persist_treat active_year3_3_persist_treat active_year3_4_persist_treat active_year3_5_persist_treat $varlist1 if china==1, absorb(active_year3 persist_treat crs_sector_code##transactions_start_year##persist_treat) vce(cluster hv001a)
eststo ex2
qui reghdfe paidwork active_year3_1_persist_treat active_year3_3_persist_treat active_year3_4_persist_treat active_year3_5_persist_treat $varlist1 if china==1 & treatage>=7 & treatage<=8, absorb(active_year3 persist_treat crs_sector_code##transactions_start_year##persist_treat) vce(cluster hv001a)
eststo ex3
qui reghdfe paidwork active_year3_1_persist_treat active_year3_3_persist_treat active_year3_4_persist_treat active_year3_5_persist_treat $varlist1 if china==1 & treatage>=9 & treatage<=10, absorb(active_year3 persist_treat crs_sector_code##transactions_start_year##persist_treat) vce(cluster hv001a)
eststo ex4
qui reghdfe paidwork active_year3_1_persist_treat active_year3_3_persist_treat active_year3_4_persist_treat active_year3_5_persist_treat $varlist1 if china==1 & treatage>=11 & treatage<=12, absorb(active_year3 persist_treat crs_sector_code##transactions_start_year##persist_treat) vce(cluster hv001a)
eststo ex5
qui reghdfe paidwork active_year3_1_persist_treat active_year3_3_persist_treat active_year3_4_persist_treat active_year3_5_persist_treat $varlist1 if china==1 & treatage>=13 & treatage<=14, absorb(active_year3 persist_treat crs_sector_code##transactions_start_year##persist_treat) vce(cluster hv001a)
eststo ex6

esttab ex* using output/Results_in_appendix/Table_A7.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps keep(active_year3_1_persist_treat active_year3_3_persist_treat active_year3_4_persist_treat active_year3_5_persist_treat) order(active_year3_1_persist_treat active_year3_3_persist_treat active_year3_4_persist_treat active_year3_5_persist_treat) mtitles(Allcohort "Cohort7-8" "Cohort9-10" "Cohort11-12" "Cohort13-14") replace




****Chinese aid and paid work with other ages (Appendix Table A.2)****
use intermediate/China/China_final_data/Withparents_Allcountries_for_analysis, clear

set scheme s2mono

*Define control variables
gl varlist1 `"hv104 urban hv105 dist latitude longitude precision_code"'
gl varlist2 `"hv104 urban hv105 dist latitude longitude precision_code mother_age mother_edu father_edu father_age"'

*Create interaction terms
tab active_year3, gen(active_year3_)
forvalues i=1/5{
gen active_year3_`i'_treat_5km = active_year3_`i'*treat_5km 
}
label var active_year3_1_treat_5km "2~3 years before × Within 5km"
label var active_year3_2_treat_5km "Right before × Within 5km"
label var active_year3_3_treat_5km "0~1 years after × Within 5km"
label var active_year3_4_treat_5km "2~3 years after × Within 5km"
label var active_year3_5_treat_5km "4~5 years after × Within 5km"


*Use only children from 5 to 14
est clear
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1 &hv105<=14&hv105>=5, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex1

*Use only children from 7 to 14
qui reghdfe paidwork active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km $varlist1 if china==1&hv105<=14&hv105>=7, absorb(active_year3 treat_5km crs_sector_code##transactions_start_year##treat_5km) vce(cluster hv001a) 
eststo ex2

esttab ex2 ex1 using output/Results_in_appendix/Table_A2.tex, ar2 label star(* 0.1 ** 0.05 *** 0.01) noconstant se(3) b(3) brackets nogaps  mtitles(Age7~14 Age5~14) keep(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km) order(active_year3_1_treat_5km active_year3_3_treat_5km active_year3_4_treat_5km active_year3_5_treat_5km)  replace



****Check for the difference between project start year and end year of Chinese projects (Footnote ○○)****
gen diff= project_end_year-project_start_year
gen diff2=project_end_year-transactions_start_year

tabstat diff if china==1, by(crs_sector_name) stat(count mean range min max sd)
tabstat diff2 if china==1, by(crs_sector_name) stat(count mean range min max sd)
egen project=seq(), by(project_id)
keep if project==1
tabstat diff if china==1, by(crs_sector_name) stat(count mean range min max sd)
tabstat diff2 if china==1, by(crs_sector_name) stat(count mean range min max sd)
