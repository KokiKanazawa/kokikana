* ----------------------------------------------------------------------------------------------------------------------------------------------*
* Replication code for "The Impact of Foreign Aid on Child Labor" (Kanazawa, Goto, and Yamasaki)
* Stata 16.0
* ----------------------------------------------------------------------------------------------------------------------------------------------*
** Dataset Construction for Child Level Data of DHS Data

/* ----------------------------------------
	Country list
   *Benin ---------------------- Benin: Standard DHS, 2011-12
   *Burundi -------------------- Burundi: Standard DHS, 2010
   *Cameroon ------------------- Cameroon: Standard DHS, 2011
   *Gabon ---------------------- Gabon: Standard DHS, 2012
   *Liberia -------------------- Liberia: Standard DHS, 2007
   *Sierra Leone (2013) -------- Sierra Leone: Standard DHS, 2013
   *Sierra Leone (2008) -------- Sierra Leone: Standard DHS, 2008
   *Uganda --------------------- Uganda: Standard DHS, 2000-01
   
   *We picked up all African countries which have both the child labor module and GPS Datasets from DHS Data.
   *We also use project-level Chinese aid data from AidData.
   
	Definition of child labor: age of 7 to 14 based on Edmonds's handbook

  ---------------------------------------- */
 clear
 
  
**--------------------Preparation for constructing our datasets--------------------**

**------------------------------------------------
**  Create variables separately for each country
**------------------------------------------------
cd `"C:/Users/kokik/git/chinese_aid_child_labor"'

** ----Benin----
use rawdata/DHSdata/BJPR61FL.DTA, clear

** Variables about child labor
gen paidwork = (chl1==1) // Paidwork outside households
gen nonpaidwork= (chl1==2) //Unpaidwork outside households
gen housework=(chl7==1) //Housework inside households
gen otherfalilywork=(chl5==1) //Unpaid or paid work inside households related to family business
//gen fetchingwork=(chl3==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=chl2 if chl1==1 //The amount of time to engage in paid work
gen nonpaidworktime=chl2 if chl1==2 //The amount of time to engage in unpaid work
gen houseworktime=chl8 if chl7==1 //The amount of time to do hosework
gen otherfalilyworktime=chl6 if chl5==1 //The amount of time to engage in family business
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.


save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country1, replace


** ----Burundi----
use rawdata/DHSdata/BUPR61FL.DTA, clear

** Variables about child labor
gen paidwork = (sh21==1)
gen nonpaidwork= (sh21==2)
gen housework=(sh23==1)
gen otherfalilywork=(sh25==1)
//gen otherchore=(sh27==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh22 if sh21==1
gen nonpaidworktime=sh22 if sh21==2
gen houseworktime=sh24 if sh23==1
//gen otherchoretime=sh28 if sh27==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
//replace  otherchoretime=0 if otherchoretime==.

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country2, replace

** ----Cameroon----
use rawdata/DHSdata/cameroon2011_all, clear

** Variables about child labor
gen paidwork = (sh304==1)  
gen nonpaidwork= (sh304==2) 
gen housework = (sh307==1)
gen otherfalilywork=(sh309==1) 
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh305 if sh304==1 
gen nonpaidworktime=sh305 if sh304==2 
gen houseworktime=sh308 if sh307==1 
gen otherfalilyworktime=sh310 if sh309==1 
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country3, replace


** ----Gabon----
use rawdata/DHSdata/GAPR61FL.DTA, clear

** Variables about child labor
gen paidwork = (sh144==1)
gen nonpaidwork= (sh144==2)
gen housework=(sh147==1)
gen otherfalilywork=(sh149==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh145 if sh144==1
gen nonpaidworktime=sh145 if sh144==2
gen houseworktime=sh148 if sh147==1
gen otherfalilyworktime=sh150 if sh149==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country4, replace


** Liberia
use rawdata/DHSdata/LBPR51FL.dta, clear

** Variables about child labor
gen paidwork = (sh206==1)
gen nonpaidwork= (sh206==2)
gen housework=(sh209==1)
gen otherfalilywork=(sh211==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh207 if sh206==1
gen nonpaidworktime=sh207 if sh206==2
gen houseworktime=sh210 if sh209==1
gen otherfalilyworktime=sh212 if sh211==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country5, replace

** ----Sierra Leone (2013)----
use rawdata/DHSdata/SLPR61FL.DTA, clear

** Variables about child labor
gen paidwork = (chl1==1)
gen nonpaidwork= (chl1==2)
gen housework=(chl7==1)
gen otherfalilywork=(chl5==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=chl2 if chl1==1
gen nonpaidworktime=chl2 if chl1==2
gen houseworktime=chl8 if chl7==1
gen otherfalilyworktime=chl6 if chl5==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country6, replace


** ----Sierra Leone (2008)----
use rawdata/DHSdata/SLPR51FL.DTA, clear

** Variables about child labor
gen paidwork = (sh203==1)
gen nonpaidwork= (sh203==2)
gen housework=(sh206==1)
gen otherfalilywork=(sh208==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh204 if sh203==1
gen nonpaidworktime=sh204 if sh203==2
gen houseworktime=sh207 if sh206==1
gen otherfalilyworktime=sh209 if sh208==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country7, replace

** ----Uganda----
use rawdata/DHSdata/UGPR41FL.DTA, clear

** Variables about child labor and educational status
gen paidwork=(sh307==1 & sh305<=3) 
gen nonpaidwork= (sh307==1&sh305==4)
gen housework=(sh310==1)
gen otherfalilywork=(sh312==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh309 if sh307==1&sh305<=3
gen nonpaidworktime=sh309 if sh307==1&sh305==4
gen houseworktime=sh311 if sh310==1
gen otherfalilyworktime=sh313 if sh312==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country8, replace


**------------------------------------------------
**  Preparation for using World Bank's aid data
**------------------------------------------------
**World Bank's aid projects are separately storaged in different csv files by sections of information, so we change the csv file into dta files and merge them.
* Change all csv files into dta files
insheet using rawdata/WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data/level_1a.csv, clear
	
save intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_level_1a, replace

insheet using rawdata/WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data/locations.csv, clear
	
save intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_locations, replace
	
insheet using rawdata/WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data/projects.csv, clear
	
save intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_projects, replace
	
insheet using rawdata/WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data/projects_ancillary.csv, clear
	
rename projectid project_id
rename projectname project_name
	
egen a=min(exitfy), by(project_id)
bysort project_id: keep if a==exitfy //keep a project whose deactivationdate is earlier because some projects are counted more than once
	
sort project_id deactivationdate 
set seed 2345
by project_id:gen b=runiform()
by project_id:egen c=min(b)
keep if b==c // some programs include some projects allocated to the same targeted sector and located in the same location, so they are counted more than twice and we keep only one of them

save intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_projects_ancillary, replace

	
* merge all of the dta files of World Bank's aid
use intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_level_1a, clear

merge 1:1 project_location_id using "intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_locations.dta"
drop _merge

merge m:1 project_id using "intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_projects.dta"
drop _merge

merge m:1 project_id using "intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_projects_ancillary.dta"
drop _merge

save intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_allmerged, replace



**--------------------The end of preparation for constructing our datasets--------------------**



**------------------------------------------------
**		Create dataset of all countries
**------------------------------------------------
**From here, we start creating datasets for analysis 

**** Step 1: keep only Chinese and World Bank's aid projects within the sample countries****
** Chinese aid
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Benin" | recipients == "Burundi" | recipients == "Cameroon" | recipients == "Gabon" | recipients == "Liberia" | recipients == "Sierra Leone" | recipients == "Uganda"    
drop if latitude ==.

gen float recipients2=0
replace recipients2 = 1 if recipients=="Benin" //Benin
replace recipients2 = 2 if recipients=="Burundi" //Burundi
replace recipients2 = 3 if recipients=="Cameroon" //Cameroon
replace recipients2 = 4 if recipients=="Gabon" //Gabon
replace recipients2 = 5 if recipients=="Liberia" //Liberia
replace recipients2 = 6 if recipients=="Sierra Leone" //Sierra Leone
replace recipients2 = 8 if recipients=="Uganda" //Uganda
drop recipients
rename recipients2 recipients

bysort recipients: gen project_id_rev = _n

gen china=1

save intermediate/China/China_intermediate_results/0-Aid_Data/allcountry_chinese_aid, replace

** World Bank's aid
use intermediate/WB/WB_intermediate_results/0-Aid_Data/WB_allmerged, clear
keep if recipients == "Benin" | recipients == "Burundi" | recipients == "Cameroon" | recipients == "Gabon" | recipients == "Liberia" | recipients == "Sierra Leone" | recipients == "Uganda"    
drop if latitude ==.

gen float recipients2=0
replace recipients2 = 1 if recipients=="Benin" //Benin
replace recipients2 = 2 if recipients=="Burundi" //Burundi
replace recipients2 = 3 if recipients=="Cameroon" //Cameroon
replace recipients2 = 4 if recipients=="Gabon" //Gabon
replace recipients2 = 5 if recipients=="Liberia" //Liberia
replace recipients2 = 6 if recipients=="Sierra Leone" //Sierra Leone
replace recipients2 = 8 if recipients=="Uganda" //Uganda
drop recipients
rename recipients2 recipients

encode project_id, gen(project_id2)
drop project_id
rename project_id2 project_id

bysort recipients: gen project_id_rev = _n

gen china=0 

append using intermediate/China/China_intermediate_results/0-Aid_Data/allcountry_chinese_aid, force

*assign random values to uniquely and unarbitrarily keep one project for each household cluster later
set seed 2345
bysort china recipients project_id project_location_id:gen random_value2=runiform()

save intermediate/China/China_intermediate_results/0-Aid_Data/allcountry_chinese_WB_aid, replace


* Step 2: stack all gps data of DHS & joinby using country name
tempfile  gps hhdata
import dbase rawdata/DHSdata/BJGE61FL.dbf, clear
save `gps',replace 

local filelist BUGE61FL CMGE61FL GAGE61FL LBGE52FL SLGE61FL SLGE53FL UGGE43FL
foreach filename of local filelist {
import dbase rawdata/DHSdata/`filename'.dbf, clear
append using `gps'
save `gps',replace
}

gen float recipients=0
replace recipients = 1 if CCFIPS=="BN" //Benin
replace recipients = 2 if CCFIPS=="BY" //Burundi
replace recipients = 3 if CCFIPS=="CM" //Cameroon
replace recipients = 4 if CCFIPS=="GB" //Gabon
replace recipients = 5 if CCFIPS=="LI" //Liberia
replace recipients = 6 if CCFIPS=="SL" //Sierra Leone
replace recipients = 8 if CCFIPS=="UG" //Uganda


joinby recipients using intermediate/China/China_intermediate_results/0-Aid_Data/allcountry_chinese_WB_aid


*To separately identify hhs in Sierra Leone surveyed in 2013 and hhs in Sierra surveyed in 2008, we change definition of "recipients".
replace recipients=7 if CCFIPS=="SL" & DHSYEAR==2008



* Step 3: keep only relevant projects
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort recipients DHSCLUST china: egen temp_total = total(temp_treat)
bysort recipients DHSCLUST china: egen keeping = rank(transactions_start_year) if temp_treat==1
*if more than one projects connected with one HH are in the same highest place, they are randomly reassigned a unique rank to create one project with the unique highest place.
bysort recipients DHSCLUST china: egen min_keeping=min(keeping) if temp_treat==1
bysort recipients DHSCLUST china: gen e=runiform() if keeping==min_keeping &temp_treat==1
bysort recipients DHSCLUST china temp_treat: egen f=min(random_value) if keeping==min_keeping &temp_treat==1
bysort recipients DHSCLUST china: replace keeping=1 if f==random_value & keeping==min_keeping&temp_treat==1

*create a distance rank for projects whose connected households are not within 5km from any projects
bysort recipients DHSCLUST china: egen random_rank = rank(dist) if temp_total==0
* if some projects are in the same place, put high priority to the oldest project
bysort recipients DHSCLUST china: egen min_random_rank=min(random_rank) if temp_total==0
bysort recipients DHSCLUST china: egen year_rank=rank(transactions_start_year) if random_rank==min_random_rank &temp_total==0
bysort recipients DHSCLUST china: egen min_year_rank=min(year_rank) if random_rank==min_random_rank&temp_total==0 
bysort recipients DHSCLUST china: egen i=min(random_value) if  random_rank==min_random_rank&year_rank==min_year_rank&temp_total==0
bysort recipients DHSCLUST china: replace random_rank=1 if i==random_value &random_rank==min_random_rank& year_rank==min_year_rank


**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST china)
	  egen num_project=max(count_project), by(DHSCLUST recipients china)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST recipients china)
	  egen num_project2=max(count_project2), by(DHSCLUST recipients china)


** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
** ENG1 
** or ENG2
** or ENG3
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1))
keep if trim_flag==1 

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/DHS_GPS-Chinese_WB_Aid, replace


** Merge with main DHS survey data
use intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country1, clear

append using intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country2 intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country3 intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country4 intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country5 intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country6 intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country7 intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country8


* generate variables depending on countries
gen hv0241=hv024+100 if hv000=="CM6" // for indentifying regions of each country identically
replace hv0241=hv024+200 if hv000=="BU6"
replace hv0241=hv024+300 if hv000=="BJ6"
replace hv0241=hv024+400 if hv000=="GA6"
replace hv0241=hv024+500 if hv000=="LB5"
replace hv0241=hv024+600 if hv000=="SL5"|hv000=="SL6"
replace hv0241=hv024+700 if hv000=="UG4"
drop hv024 
rename hv0241 hv024

gen float recipients=0
replace recipients = 1 if hv000=="BJ6"
replace recipients = 2 if hv000=="BU6"
replace recipients = 3 if hv000=="CM6"
replace recipients = 4 if hv000=="GA6"
replace recipients = 5 if hv000=="LB5"
replace recipients = 6 if hv000=="SL6"
replace recipients = 7 if hv000=="SL5"
replace recipients = 8 if hv000=="UG4"

joinby hv001 recipients using intermediate/China/China_intermediate_results/1-DHS_Data/DHS_GPS-Chinese_WB_Aid

**Variables for the relative timing and treatment
gen treat_10km = (dist<=10)
gen treat_5km = (dist<=5)
gen urban = (URBAN_RURA=="U")

gen active_year = hv007 - transactions_start_year // hv007 is an interview year of DHS program (active_year==-1 --> a counterfactual)

save intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis,replace



**--------------------------------------------------
**		Arrange All Countries' Data for Analysis
**--------------------------------------------------
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear
encode hv000, gen(country_survey)

**Normalize the value of 6 years before the project implementation dates in active_year2 to 0
gen active_year2 = active_year + 6

**Create rougher definition of the relative timing
gen active_year3=.
replace active_year3 = 0 if active_year2==1|active_year2==2 | active_year2==3 | active_year2==4 // +2 years before construction
replace active_year3 = 1 if active_year2==5 // right before construction
replace active_year3 = 2 if active_year2==6 | active_year2==7 // during construction
replace active_year3 = 3 if active_year2>=8 // right after construction
replace active_year3 = 4 if active_year2>=10 // after construction




**Create variavles which denotes the project's implementation dates and end dates 
gen project_start_year=0 
replace project_start_year=2000 if start_actual_isodate=="2000-01-01"
replace project_start_year=2000 if start_actual_isodate=="2000-01-02"
replace project_start_year=2000 if start_actual_isodate=="2000-05-12"
replace project_start_year=2001 if start_actual_isodate=="2001-01-01"
replace project_start_year=2001 if start_actual_isodate=="2001-08-01"
replace project_start_year=2002 if start_actual_isodate=="2002-06-07"
replace project_start_year=2002 if start_actual_isodate=="2002-08-09"
replace project_start_year=2003 if start_actual_isodate=="2003-12-08"
replace project_start_year=2004 if start_actual_isodate=="2004-01-01"
replace project_start_year=2005 if start_actual_isodate=="2005-07-10"
replace project_start_year=2005 if start_actual_isodate=="2005-09-01"
replace project_start_year=2005 if start_actual_isodate=="2005-09-26"
replace project_start_year=2006 if start_actual_isodate=="2006-08-06"
replace project_start_year=2007 if start_actual_isodate=="2007-01-01"
replace project_start_year=2007 if start_actual_isodate=="2007-01-30"
replace project_start_year=2007 if start_actual_isodate=="2007-04-04"
replace project_start_year=2008 if start_actual_isodate=="2008-02-19"
replace project_start_year=2008 if start_actual_isodate=="2008-05-30"
replace project_start_year=2008 if start_actual_isodate=="2008-07-28"
replace project_start_year=2008 if start_actual_isodate=="2008-08-01"
replace project_start_year=2008 if start_actual_isodate=="2008-11-15"
replace project_start_year=2009 if start_actual_isodate=="2009-01-15"
replace project_start_year=2009 if start_actual_isodate=="2009-04-28"
replace project_start_year=2009 if start_actual_isodate=="2009-05-11"
replace project_start_year=2009 if start_actual_isodate=="2009-05-14"
replace project_start_year=2009 if start_actual_isodate=="2009-06-17"
replace project_start_year=2009 if start_actual_isodate=="2009-07-16"
replace project_start_year=2010 if start_actual_isodate=="2010-02-01"
replace project_start_year=2010 if start_actual_isodate=="2010-10-01"
replace project_start_year=2011 if start_actual_isodate=="2011-06-25"
replace project_start_year=2011 if start_actual_isodate=="2011-10-01"
replace project_start_year=2011 if start_actual_isodate=="2011-12-20"
replace project_start_year=2012 if start_actual_isodate=="2012-05-01"
replace project_start_year=2012 if start_actual_isodate=="2012-06-15"
replace project_start_year=2012 if start_actual_isodate=="2012-11-21"
replace project_start_year=2013 if start_actual_isodate=="2013-11-11"
replace project_start_year=. if project_start_year==0


gen project_end_year=0
replace project_end_year=2000 if end_actual=="2000-01-01"
replace project_end_year=2002 if end_actual=="2002-08-09"
replace project_end_year=2003 if end_actual=="2003-06-11"
replace project_end_year=2003 if end_actual=="2003-12-08"
replace project_end_year=2004 if end_actual=="2004-01-01"
replace project_end_year=2006 if end_actual=="2006-02-01"
replace project_end_year=2006 if end_actual=="2006-03-27"
replace project_end_year=2006 if end_actual=="2006-05-23"
replace project_end_year=2006 if end_actual=="2006-10-23"
replace project_end_year=2007 if end_actual=="2007-02-01"
replace project_end_year=2007 if end_actual=="2007-03-01"
replace project_end_year=2007 if end_actual=="2007-07-21"
replace project_end_year=2007 if end_actual=="2007-09-27"
replace project_end_year=2007 if end_actual=="2007-11-09"
replace project_end_year=2007 if end_actual=="2007-12-11"
replace project_end_year=2008 if end_actual=="2008-05-30"
replace project_end_year=2008 if end_actual=="2008-09-26"
replace project_end_year=2008 if end_actual=="2008-11-19"
replace project_end_year=2008 if end_actual=="2008-12-17"
replace project_end_year=2009 if end_actual=="2009-01-31"
replace project_end_year=2009 if end_actual=="2009-05-25"
replace project_end_year=2009 if end_actual=="2009-06-30"
replace project_end_year=2009 if end_actual=="2009-10-21"
replace project_end_year=2009 if end_actual=="2009-10-30"
replace project_end_year=2010 if end_actual=="2010-05-31"
replace project_end_year=2011 if end_actual=="2011-01-01"
replace project_end_year=2011 if end_actual=="2011-01-19"
replace project_end_year=2011 if end_actual=="2011-05-13"
replace project_end_year=2011 if end_actual=="2011-06-25"
replace project_end_year=2011 if end_actual=="2011-07-20"
replace project_end_year=2011 if end_actual=="2011-11-01"
replace project_end_year=2014 if end_actual=="2014-04-30"
replace project_end_year=. if project_end_year==0



**Create country id which denotes the same number in both Sierra(2008) and Sierra(2013)
egen country_id=group(hv000) 
gen country_id2=country_survey
replace country_id2=6 if country_id2==7
replace country_id2=7 if country_id2==8 

**Assign unique codes for each household cluster
egen hv001a=group(hv007 country_id2 hv001) 

**Change the value of female from 2 to 0
replace hv104=0 if hv104==2 

**Create a variable about the difference between project's implementation dates and transaction start year
gen year_diff=project_start_year-transactions_start_year 

**Create a variable about the ratio of children to all household's members
bysort hhid country_id china: egen num_allmember=max(hvidx)
bysort hhid country_id china: egen num_chi=seq() if hv105<=14 & hv105>=5
bysort hhid country_id china: egen num_child=max(num_chi) 
gen child_ratio=num_child/num_allmember 


**Create a treatment variable for cohort persistence analysis in Appendix
gen treatage=hv105-(hv007-transactions_start_year)
replace paidwork=. if hv105>=15 | hv105<=4

gen persist_treat=(dist<=5&(treatage>=7&treatage<=14))

**Create the same clasification of targeted sector in World Bank's aid as Chinese aid
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

encode sector1code, gen(sector1code1)

**Drop households interviewed more than 5 years before or after project implementation dates
drop if active_year2<=0|active_year2>=12 


save intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, replace


**------------------------------------------------
**		Merge Children with Parents
**------------------------------------------------

***Create using data of mothers
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear
rename hv105 mother_age
rename hv108 mother_edu 
drop hv112
rename hvidx hv112
keep country_id hhid hv112 mother_age mother_edu china

save intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Mother_for_merge, replace

***Create using data of fathers
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear

rename hv105 father_age
rename hv108 father_edu
drop hv114
rename hvidx hv114
keep country_id hhid hv114 father_age father_edu china

save intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Father_for_merge, replace

***Merge children with father and mother 
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear
merge m:1 country_id hhid china hv112 using "intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Mother_for_merge.dta"
drop if _merge==2
drop _merge

merge m:1 country_id hhid china hv114 using "intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Father_for_merge.dta"
drop if _merge==2
drop _merge

save intermediate/China/China_final_data/Withparents_Allcountries_for_analysis, replace






















**For each country, we combine project-level data of Chinese aid from AidData with child-level survey datasets from DHS Data by using GPS coordinates.
** ----------------------------------------
** 			Country 1: Benin
** ----------------------------------------
** survey: December 2011 - March 2012

** ----Chinese aid dataset----
**Keep only projects located in Benin
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Benin"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/benin_aid, replace


**----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/BJGE61FL.dbf, clear

* forvalues x=1(1)42 {
* 	gen temp_id`x' = 1
* }
* reshape long temp_id, i(DHSCLUST) j(project_id_rev)

* **Merge with Chinese aid data
* fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/benin_aid
* drop _merge

cross using intermediate/China/China_intermediate_results/0-Aid_Data/benin_aid

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
* if some projects are in the same place, put high priority to the latest project
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)


** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
** ENG1 
** or ENG2
** or ENG3
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Benin_GPS_data, replace

**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata/DHSdata/BJPR61FL.DTA, clear
gen hv0241=hv024+200 // for indentifying regions of each country identically
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Benin_GPS_data, assert(match master) keep(match)
save Benin2011_for_analysis, replace


** ----------------------------------------
** 			Country 2: Burundi
** ----------------------------------------
** survey: August 2010 - January 2011

** ----Chinese aid dataset----
** Keep only projects located in Burundi
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Burundi"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/burundi_aid, replace

** ----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/BUGE61FL.dbf, clear

forvalues x=1(1)34 {
	gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/burundi_aid
drop _merge

**--------------------------------------------------------------------------
** create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)

** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Burundi_GPS_data, replace

**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata/DHSdata/BUPR61FL.DTA, clear
gen hv0241=hv024+300
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Burundi_GPS_data, assert(match master) keep(match)
save Burundi2010_11_for_analysis, replace



** ----------------------------------------
** 			Country 3: Cameroon
** ----------------------------------------

** ----Chinese aid dataset----
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Cameroon"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/cameroon_aid, replace

** ----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/CMGE61FL.dbf, clear

forvalues x=1(1)90 { // max(project_id_rev)==90 in `cameroon_aid' data
	gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

**Merge with Chinese aid data
fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/cameroon_aid
drop _merge

**--------------------------------------------------------------------------
** create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)

** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Cameroon_GPS_data, replace
	
**--------------------------------------------------------------------------
** Merge with main DHS survey data
use rawdata/DHSdata/cameroon2011_all, clear
gen hv0241=hv024+100  
drop hv024 
rename hv0241 hv024
	
fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Cameroon_GPS_data, assert(match master) keep(match)	
save Cameroon2011_for_analysis, replace



** ----------------------------------------
** 			Country 4: Gabon
** ----------------------------------------
** survey: January 2012 - May 2012

** ----Chinese aid dataset----
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Gabon"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/gabon_aid, replace

** ----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/GAGE61FL.dbf, clear

forvalues x=1(1)22 {
	gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/gabon_aid
drop _merge

**--------------------------------------------------------------------------
** create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
  	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)

** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Gabon_GPS_data, replace

**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata/DHSdata/GAPR61FL.DTA, clear
gen hv0241=hv024+400
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Gabon_GPS_data, assert(match master) keep(match)
save Gabon2012_for_analysis, replace

** ----------------------------------------
** 			Country 5: Liberia
**			 revised version + dist<=100
** ----------------------------------------
** survey: December 2006 - April 2007

** ----Chinese aid dataset----
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Liberia"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/liberia_aid, replace

** ----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/LBGE52FL.dbf, clear

forvalues x=1(1)71 {
	gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/liberia_aid
drop _merge

**--------------------------------------------------------------------------
** create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)

** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Liberia_GPS_data, replace
**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata/DHSdata/LBPR51FL.dta, clear
gen hv0241=hv024+500
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Liberia_GPS_data, assert(match master) keep(match)
save Liberia2006_07_for_analysis, replace


** ----------------------------------------
** 		Country 6: Sierra Leone (2013)
**		revised version + dist<=100
** ----------------------------------------
** survey: June 2013 - October 2013

** ----Chinese aid dataset----
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Sierra Leone"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/siera2013_aid, replace


** ----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/SLGE61FL.dbf, clear

forvalues x=1(1)72 {
	gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

**Merge with Chinese aid data
fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/siera2013_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)

** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Siera2013_GPS_data, replace

**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata/DHSdata/SLPR61FL.DTA, clear
gen hv0241=hv024+600
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Siera2013_GPS_data, assert(match master) keep(match)
save Sierra2013_for_analysis, replace


** ----------------------------------------
** 	  Country 6: Sierra Leone (2008)
**		 revised version + dist<=100
** ----------------------------------------
** survey: April 2008 - June 2008

** ----Chinese aid dataset----
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Sierra Leone"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/siera2008_aid, replace

** ----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/SLGE53FL.dbf, clear

forvalues x=1(1)72 {
	gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/siera2008_aid
drop _merge

**--------------------------------------------------------------------------
** create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)

** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Siera2008_GPS_data, replace
**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata/DHSdata/SLPR51FL.DTA, clear
gen hv0241=hv024+600
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Siera2008_GPS_data, assert(match master) keep(match)
save Sierra2008_for_analysis, replace


** ----------------------------------------
** 			 Country 7: Uganda
**			 revised version + dist<=100
** ----------------------------------------
** survey: September 2000 - March 2001

** ----Chinese aid dataset----
insheet using rawdata/GeoCoded_China_Data_Merged_Files/all_flow_classes.csv, clear

keep if recipients == "Uganda"
drop if latitude ==.

gen project_id_rev = _n

save intermediate/China/China_intermediate_results/0-Aid_Data/uganda_aid, replace

** ----DHS program data (GPS datasets)----
import dbase rawdata/DHSdata/UGGE43FL.dbf, clear

forvalues x=1(1)75 {
	gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate/China/China_intermediate_results/0-Aid_Data/uganda_aid
drop _merge

**--------------------------------------------------------------------------
** create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep only projects located within 100km from each household 
drop if dist>100

gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(year), unique
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

**Create variables about the number of projects located near households to use in our robustness checks
	  egen count_project=seq(), by(DHSCLUST)
	  egen num_project=max(count_project), by(DHSCLUST)
	  egen count_project2=seq() if dist<=5, by(DHSCLUST)
	  egen num_project2=max(count_project2), by(DHSCLUST)

** Keep a project if dist<=5 in the earliest year
** If there is no project satisfying dist<=5, keep the nearest project
gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate/China/China_intermediate_results/1-DHS_Data/Uganda_GPS_data, replace

**--------------------------------------------------------------------------

** merge with main DHS data
use rawdata/DHSdata/UGPR41FL.DTA, clear
gen hv0241=hv024+700
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate/China/China_intermediate_results/1-DHS_Data/Uganda_GPS_data, assert(match master) keep(match)
save Uganda2000_01_for_analysis, replace



**------------------------------------------------
**		Create Variables for Analysis
**------------------------------------------------

** ----Benin----
use intermediate/China/China_intermediate_results/1-DHS_Data/Benin2011_for_analysis, clear

** Variables about child labor
gen paidwork = (chl1==1) // Paidwork outside households
gen nonpaidwork= (chl1==2) //Unpaidwork outside households
gen housework=(chl7==1) //Housework inside households
gen otherfalilywork=(chl5==1) //Unpaid or paid work inside households related to family business
//gen fetchingwork=(chl3==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=chl2 if chl1==1 //The amount of time to engage in paid work
gen nonpaidworktime=chl2 if chl1==2 //The amount of time to engage in unpaid work
gen houseworktime=chl8 if chl7==1 //The amount of time to do hosework
gen otherfalilyworktime=chl6 if chl5==1 //The amount of time to engage in family business
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

**Variables for the relative timing and treatment
gen active = (year<=2011)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year // hv007 is an interview year of DHS program (active_year==-1 --> a counterfactual)

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country1, replace


** ----Burundi----
use intermediate/China/China_intermediate_results/1-DHS_Data/Burundi2010_11_for_analysis, clear

** Variables about child labor
gen paidwork = (sh21==1)
gen nonpaidwork= (sh21==2)
gen housework=(sh23==1)
gen otherfalilywork=(sh25==1)
//gen otherchore=(sh27==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh22 if sh21==1
gen nonpaidworktime=sh22 if sh21==2
gen houseworktime=sh24 if sh23==1
//gen otherchoretime=sh28 if sh27==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
//replace  otherchoretime=0 if otherchoretime==.

**Variables for the relative timing and treatment
gen active = (year<=2010)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year 

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country2, replace


** ----Cameroon----
use intermediate/China/China_intermediate_results/1-DHS_Data/Cameroon2011_for_analysis, clear

** Variables about child labor
gen paidwork = (sh304==1)  
gen nonpaidwork= (sh304==2) 
gen housework = (sh307==1)
gen otherfalilywork=(sh309==1) 
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh305 if sh304==1 
gen nonpaidworktime=sh305 if sh304==2 
gen houseworktime=sh308 if sh307==1 
gen otherfalilyworktime=sh310 if sh309==1 
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

**Variables for the relative timing and treatment
gen active = (year<=2011)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen lastmonth = (hv006==8)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year 

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country3, replace


** ----Gabon----
use intermediate/China/China_intermediate_results/1-DHS_Data/Gabon2012_for_analysis, clear

** Variables about child labor
gen paidwork = (sh144==1)
gen nonpaidwork= (sh144==2)
gen housework=(sh147==1)
gen otherfalilywork=(sh149==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh145 if sh144==1
gen nonpaidworktime=sh145 if sh144==2
gen houseworktime=sh148 if sh147==1
gen otherfalilyworktime=sh150 if sh149==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

**Variables for the relative timing and treatment
gen active = (year<=2012)
gen active2 = (year<=2011)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year 

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country4, replace


** Liberia
use intermediate/China/China_intermediate_results/1-DHS_Data/Liberia2006_07_for_analysis, clear

** Variables about child labor
gen paidwork = (sh206==1)
gen nonpaidwork= (sh206==2)
gen housework=(sh209==1)
gen otherfalilywork=(sh211==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh207 if sh206==1
gen nonpaidworktime=sh207 if sh206==2
gen houseworktime=sh210 if sh209==1
gen otherfalilyworktime=sh212 if sh211==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

**Variables for the relative timing and treatment
gen active = (year<=2007)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year 

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country5, replace


** ----Sierra Leone (2013)----
use intermediate/China/China_intermediate_results/1-DHS_Data/Sierra2013_for_analysis, clear

** Variables about child labor
gen paidwork = (chl1==1)
gen nonpaidwork= (chl1==2)
gen housework=(chl7==1)
gen otherfalilywork=(chl5==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=chl2 if chl1==1
gen nonpaidworktime=chl2 if chl1==2
gen houseworktime=chl8 if chl7==1
gen otherfalilyworktime=chl6 if chl5==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

**Variables for the relative timing and treatment
gen active = (year<=2013)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year 

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country6, replace


** ----Sierra Leone (2008)----
use intermediate/China/China_intermediate_results/1-DHS_Data/Sierra2008_for_analysis, clear

** Variables about child labor
gen paidwork = (sh203==1)
gen nonpaidwork= (sh203==2)
gen housework=(sh206==1)
gen otherfalilywork=(sh208==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh204 if sh203==1
gen nonpaidworktime=sh204 if sh203==2
gen houseworktime=sh207 if sh206==1
gen otherfalilyworktime=sh209 if sh208==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

**Variables for the relative timing and treatment
gen active = (year<=2008)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year 

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country7, replace

** ----Uganda----
use intermediate/China/China_intermediate_results/1-DHS_Data/Uganda2000_01_for_analysis, clear

** Variables about child labor and educational status
gen paidwork=(sh307==1 & sh305<=3) 
gen nonpaidwork= (sh307==1&sh305==4)
gen housework=(sh310==1)
gen otherfalilywork=(sh312==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh309 if sh307==1&sh305<=3
gen nonpaidworktime=sh309 if sh307==1&sh305==4
gen houseworktime=sh311 if sh310==1
gen otherfalilyworktime=sh313 if sh312==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.
replace  otherfalilyworktime=0 if otherfalilyworktime==.

**Variables for the relative timing and treatment
gen active = (year<=2001)
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (year <= hv007)
gen active_year = hv007 - year // active_year==-1 --> a counterfactual

save intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country8, replace


**------------------------------------------------
**		Append Datasets of All Countries
**------------------------------------------------

use intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country1, clear

forvalues x=2(1)8{
	append using "intermediate/China/China_intermediate_results/2-Data_for_Final_Append/country`x'"
}

save intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, replace


**--------------------------------------------------
**		Arrange All Countries' Data for Analysis
**--------------------------------------------------
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear
encode hv000, gen(country_survey)

**Normalize the value of 6 years before the project implementation dates in active_year2 to 0
gen active_year2 = active_year + 6

**Create rougher definition of the relative timing
gen active_year3=.
replace active_year3 = 0 if active_year2==1|active_year2==2 | active_year2==3 | active_year2==4 // +2 years before construction
replace active_year3 = 1 if active_year2==5 // right before construction
replace active_year3 = 2 if active_year2==6 | active_year2==7 // during construction
replace active_year3 = 3 if active_year2>=8 // right after construction
replace active_year3 = 4 if active_year2>=10 // after construction




**Create variavles which denotes the project's implementation dates and end dates 
gen project_start_year=0 
replace project_start_year=2000 if start_actual_isodate=="2000-01-01"
replace project_start_year=2000 if start_actual_isodate=="2000-01-02"
replace project_start_year=2000 if start_actual_isodate=="2000-05-12"
replace project_start_year=2001 if start_actual_isodate=="2001-01-01"
replace project_start_year=2001 if start_actual_isodate=="2001-08-01"
replace project_start_year=2002 if start_actual_isodate=="2002-06-07"
replace project_start_year=2002 if start_actual_isodate=="2002-08-09"
replace project_start_year=2003 if start_actual_isodate=="2003-12-08"
replace project_start_year=2004 if start_actual_isodate=="2004-01-01"
replace project_start_year=2005 if start_actual_isodate=="2005-07-10"
replace project_start_year=2005 if start_actual_isodate=="2005-09-01"
replace project_start_year=2005 if start_actual_isodate=="2005-09-26"
replace project_start_year=2006 if start_actual_isodate=="2006-08-06"
replace project_start_year=2007 if start_actual_isodate=="2007-01-01"
replace project_start_year=2007 if start_actual_isodate=="2007-01-30"
replace project_start_year=2007 if start_actual_isodate=="2007-04-04"
replace project_start_year=2008 if start_actual_isodate=="2008-02-19"
replace project_start_year=2008 if start_actual_isodate=="2008-05-30"
replace project_start_year=2008 if start_actual_isodate=="2008-07-28"
replace project_start_year=2008 if start_actual_isodate=="2008-08-01"
replace project_start_year=2008 if start_actual_isodate=="2008-11-15"
replace project_start_year=2009 if start_actual_isodate=="2009-01-15"
replace project_start_year=2009 if start_actual_isodate=="2009-04-28"
replace project_start_year=2009 if start_actual_isodate=="2009-05-11"
replace project_start_year=2009 if start_actual_isodate=="2009-05-14"
replace project_start_year=2009 if start_actual_isodate=="2009-06-17"
replace project_start_year=2009 if start_actual_isodate=="2009-07-16"
replace project_start_year=2010 if start_actual_isodate=="2010-02-01"
replace project_start_year=2010 if start_actual_isodate=="2010-10-01"
replace project_start_year=2011 if start_actual_isodate=="2011-06-25"
replace project_start_year=2011 if start_actual_isodate=="2011-10-01"
replace project_start_year=2011 if start_actual_isodate=="2011-12-20"
replace project_start_year=2012 if start_actual_isodate=="2012-05-01"
replace project_start_year=2012 if start_actual_isodate=="2012-06-15"
replace project_start_year=2012 if start_actual_isodate=="2012-11-21"
replace project_start_year=2013 if start_actual_isodate=="2013-11-11"
replace project_start_year=. if project_start_year==0


gen project_end_year=0
replace project_end_year=2000 if end_actual=="2000-01-01"
replace project_end_year=2002 if end_actual=="2002-08-09"
replace project_end_year=2003 if end_actual=="2003-06-11"
replace project_end_year=2003 if end_actual=="2003-12-08"
replace project_end_year=2004 if end_actual=="2004-01-01"
replace project_end_year=2006 if end_actual=="2006-02-01"
replace project_end_year=2006 if end_actual=="2006-03-27"
replace project_end_year=2006 if end_actual=="2006-05-23"
replace project_end_year=2006 if end_actual=="2006-10-23"
replace project_end_year=2007 if end_actual=="2007-02-01"
replace project_end_year=2007 if end_actual=="2007-03-01"
replace project_end_year=2007 if end_actual=="2007-07-21"
replace project_end_year=2007 if end_actual=="2007-09-27"
replace project_end_year=2007 if end_actual=="2007-11-09"
replace project_end_year=2007 if end_actual=="2007-12-11"
replace project_end_year=2008 if end_actual=="2008-05-30"
replace project_end_year=2008 if end_actual=="2008-09-26"
replace project_end_year=2008 if end_actual=="2008-11-19"
replace project_end_year=2008 if end_actual=="2008-12-17"
replace project_end_year=2009 if end_actual=="2009-01-31"
replace project_end_year=2009 if end_actual=="2009-05-25"
replace project_end_year=2009 if end_actual=="2009-06-30"
replace project_end_year=2009 if end_actual=="2009-10-21"
replace project_end_year=2009 if end_actual=="2009-10-30"
replace project_end_year=2010 if end_actual=="2010-05-31"
replace project_end_year=2011 if end_actual=="2011-01-01"
replace project_end_year=2011 if end_actual=="2011-01-19"
replace project_end_year=2011 if end_actual=="2011-05-13"
replace project_end_year=2011 if end_actual=="2011-06-25"
replace project_end_year=2011 if end_actual=="2011-07-20"
replace project_end_year=2011 if end_actual=="2011-11-01"
replace project_end_year=2014 if end_actual=="2014-04-30"
replace project_end_year=. if project_end_year==0



**Create country id which denotes the same number in both Sierra(2008) and Sierra(2013)
egen country_id=group(hv000) 
gen country_id2=country_survey
replace country_id2=6 if country_id2==7
replace country_id2=7 if country_id2==8 

**Assign unique codes for each household cluster
egen hv001a=group(hv007 country_id2 hv001) 

**Change the value of female from 2 to 0
replace hv104=0 if hv104==2 

**Create a variable about the difference between project's implementation dates and transaction start year
gen year_diff=project_start_year-transactions_start_year 

**Create a variable about the ratio of children to all household's members
bysort hhid country_id: egen num_allmember=max(hvidx)
bysort hhid country_id: egen num_chi=seq() if hv105<=14 & hv105>=5
bysort hhid country_id: egen num_child=max(num_chi) 
gen child_ratio=num_child/num_allmember 


**Create a treatment variable for cohort persistence analysis in Appendix
gen treatage=hv105-(hv007-transactions_start_year)
replace paidwork=. if hv105>=15 | hv105<=4

gen persist_treat=(dist<=5&(treatage>=7&treatage<=14))

**Drop households interviewed more than 5 years before or after project implementation dates
drop if active_year2<=0|active_year2>=12 


save intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, replace


**------------------------------------------------
**		Merge Children with Parents
**------------------------------------------------

***Create using data of mothers
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear
rename hv105 mother_age
rename hv108 mother_edu 
//drop hv112
//rename hvidx hv112
keep country_id hhid hv112 mother_age mother_edu hvidx hv001

save intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Mother_for_merge, replace

***Create using data of fathers
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear

rename hv105 father_age
rename hv108 father_edu
//drop hv114
//rename hvidx hv114
keep country_id hhid hv114 father_age father_edu hvidx hv001

save intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Father_for_merge, replace

***Merge children with father and mother 
use intermediate/China/China_intermediate_results/3-Data_Allcountries/Allcountries_for_analysis, clear
 drop _merge
merge m:1 country_id hhid hv112 using "intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Mother_for_merge.dta"
drop if _merge==2
drop _merge

merge m:1 country_id hhid hv114 using "intermediate/China/China_intermediate_results/4-Data_for_Parents_Merge/Father_for_merge.dta"
drop if _merge==2

drop _merge

save intermediate/China/China_final_data/Withparents_Allcountries_for_analysis, replace
