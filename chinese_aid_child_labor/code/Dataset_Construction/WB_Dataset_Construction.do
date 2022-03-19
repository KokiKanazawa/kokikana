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
  

** ------------------------------------------
** 	Merge all separated files of WB's Aid
** ------------------------------------------

**Change all csv files into dta files
insheet using rawdata\WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data\level_1a.csv, clear
	
save intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_level_1a, replace

insheet using rawdata\WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data\locations.csv, clear
	
save intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_locations, replace
	
insheet using rawdata\WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data\projects.csv, clear
	
save intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_projects, replace
	
insheet using rawdata\WorldBank_GeocodedResearchRelease_Level1_v1.4.2/data\projects_ancillary.csv, clear
	
rename projectid project_id
rename projectname project_name
	
egen a=min(exitfy), by(project_id)
bysort project_id: keep if a==exitfy //keep a project whose deactivationdate is earlier
	
sort project_id deactivationdate	//drop a project whose deactivationdate is same
egen b=seq(), by(project_id)
keep if b==1
egen c=seq(), by(project_id)
egen d=max(c), by(project_id)
drop if d>=2

save intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_projects_ancillary, replace

	
**Merge all of the dta files
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_level_1a, clear

merge 1:1 project_location_id using "intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_locations.dta"
drop _merge

merge m:1 project_id using "intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_projects.dta"
drop _merge

merge m:1 project_id using "intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_projects_ancillary.dta"
drop _merge

save intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged, replace



**For each country, we combine project-level data of Chinese aid from AidData with child-level survey datasets from DHS Data by using GPS coordinates.
** ----------------------------------------
** 			Country 1: Benin
** ----------------------------------------
** survey: December 2011 - March 2012

** ----WB's aid dataset----
**Keep only projects located in Benin
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear

keep if recipients == "Benin"
drop if latitude ==.

gen project_id_rev = _n

save WB_benin_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\BJGE61FL.dbf, clear

forvalues x=1(1)394 {
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

**Merge with WB's aid data
fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_benin_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a project if dist<=5 in the earliest year
** If there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Benin_GPS_data, replace

**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata\DHSdata\BJPR61FL.DTA, clear
gen hv0241=hv024+200
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Benin_GPS_data, assert(match master) keep(match)

save WB_Benin2011_for_analysis,replace


** ----------------------------------------
** 			Country 2: Burundi
** ----------------------------------------
** survey: August 2010 - January 2011

** ----WB's aid dataset----
**Keep only projects located in Burundi
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear

keep if recipients == "Burundi"
drop if latitude ==.

gen project_id_rev = _n

save WB_burundi_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\BUGE61FL.dbf, clear

forvalues x=1(1)282 {
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

**Merge with WB's aid data
fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_burundi_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a project if dist<=5 in the earliest year
** If there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Burundi_GPS_data, replace

**--------------------------------------------------------------------------
** Merge with main DHS survey data
use rawdata\DHSdata\BUPR61FL.DTA, clear
gen hv0241=hv024+300
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Burundi_GPS_data, assert(match master) keep(match)
save WB_burundi2010_11_for_analysis, replace


** ----------------------------------------
** 			Country 3: Cameroon
** ----------------------------------------

** ----WB aid dataset----
**Keep only projects located in Cameroon
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear
	
keep if recipients == "Cameroon"
drop if latitude ==.

gen project_id_rev = _n

save WB_cameroon_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\CMGE61FL.dbf, clear

forvalues x=1(1)280 { // max(project_id_rev)==280 in `WB_cameroon_aid' data
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

**Merge with WB's aid data
fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_cameroon_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a project if dist<=5 in the earliest year
** if there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Cameroon_GPS_data, replace

	
**--------------------------------------------------------------------------
** Merge with main DHS survey data
use rawdata\DHSdata\cameroon2011_all, clear
gen hv0241=hv024+100
drop hv024 
rename hv0241 hv024
	
fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Cameroon_GPS_data, assert(match master) keep(match)
	
save WB_Cameroon2011_for_analysis, replace



** ----------------------------------------
** 			Country 4: Gabon
** ----------------------------------------
** survey: January 2012 - May 2012

** ----WB aid dataset----
**Keep only projects located in Gabon
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear

keep if recipients == "Gabon"
drop if latitude ==.

gen project_id_rev = _n

save WB_gabon_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\GAGE61FL.dbf, clear

forvalues x=1(1)22 {
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

**Merge with WB's aid data
fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_gabon_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a row (project) if dist<=5 in the earliest year
** If there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Gabon_GPS_data, replace

**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata\DHSdata\GAPR61FL.DTA, clear
gen hv0241=hv024+400
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Gabon_GPS_data, assert(match master) keep(match)
save WB_Gabon2012_for_analysis, replace


** ----------------------------------------
** 			Country 5: Liberia
**			 revised version + dist<=100
** ----------------------------------------
** survey: December 2006 - April 2007

** ----WB aid dataset----
**Keep only projects located in Liberia
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear

keep if recipients == "Liberia"
drop if latitude ==.

gen project_id_rev = _n

save WB_liberia_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\LBGE52FL.dbf, clear

forvalues x=1(1)203 {
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

**Merge with WB's aid data
fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_liberia_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a row (project) if dist<=5 in the earliest year
** If there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Liberia_GPS_data, replace

**--------------------------------------------------------------------------
** Merge with main DHS survey data
use rawdata\DHSdata\LBPR51FL.dta, clear
gen hv0241=hv024+500
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Liberia_GPS_data, assert(match master) keep(match)
save WB_Liberia2006_07_for_analysis, replace


** ----------------------------------------
** 		Country 6: Sierra Leone (2013)
**		revised version + dist<=100
** ----------------------------------------
** survey: June 2013 - October 2013

** ----WB aid dataset----
**Keep only projects located in Sierra Leone
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear

keep if recipients == "Sierra Leone"
drop if latitude ==.

gen project_id_rev = _n

save WB_Siera2013_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\SLGE61FL.dbf, clear

forvalues x=1(1)131 {
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_siera2013_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a row (project) if dist<=5 in the earliest year
** If there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Sierra_GPS_data, replace

**--------------------------------------------------------------------------

** Merge with main DHS survey data
use rawdata\DHSdata\SLPR61FL.DTA, clear
gen hv0241=hv024+600
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Sierra_GPS_data, assert(match master) keep(match)
save WB_Sierra2013_for_analysis, replace


** ----------------------------------------
** 			 Country 6: Sierra Leone (2008)
**			 revised version + dist<=100
** ----------------------------------------
** survey: April 2008 - June 2008

** ----WB aid dataset----
**Keep only projects located in Sierra Leone
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear

keep if recipients == "Sierra Leone"
drop if latitude ==.

gen project_id_rev = _n

save WB_Siera2008_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\SLGE53FL.dbf, clear

forvalues x=1(1)131 {
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_siera2008_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a row (project) if dist<=5 in the earliest year
** If there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Sierra_GPS_data, replace
**--------------------------------------------------------------------------
** Merge with main DHS survey data
use rawdata\DHSdata\SLPR51FL.DTA, clear
gen hv0241=hv024+600
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Sierra_GPS_data, assert(match master) keep(match)
save WB_Sierra2008_for_analysis, replace


** ----------------------------------------
** 			 Country 7: Uganda
**			 revised version + dist<=100
** ----------------------------------------
** survey: September 2000 - March 2001

** ----WB aid dataset----
**Keep only projects located in Uganda
use intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_allmerged.dta, clear

keep if recipients == "Uganda"
drop if latitude ==.

gen project_id_rev = _n

save WB_uganda_aid, replace

**----DHS program data (GPS datasets)----
import dbase rawdata\DHSdata\UGGE43FL.dbf, clear

forvalues x=1(1)734 {
 gen temp_id`x' = 1
}
reshape long temp_id, i(DHSCLUST) j(project_id_rev)

fmerge m:1 project_id_rev using intermediate\WB\WB_intermediate_results\0-Aid_Data\WB_uganda_aid
drop _merge

**--------------------------------------------------------------------------
** Create a variable for distance between PSU in DHS program and aid project
geodist LATNUM LONGNUM latitude longitude, gen(dist)

** Keep a row (project) if dist<=5 in the earliest year
** If there is no row satisfying dist <=5, keep the nearest project
drop if dist>100
gen temp_treat = (dist<=5)
bysort DHSCLUST: egen temp_total = total(temp_treat)
bysort DHSCLUST temp_treat: egen keeping = rank(transactions_start_year), unique 
bysort DHSCLUST: egen random_rank = rank(dist) if temp_total==0
bysort DHSCLUST: egen year_rank=rank(transactions_start_year) if random_rank==1.5

gen trim_flag = ((temp_treat==1 & keeping==1) | (temp_total==0 & random_rank==1) | (temp_total==0 & random_rank==1.5 &year_rank==1))
keep if trim_flag==1

rename DHSCLUST hv001

save intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Uganda_GPS_data, replace

**--------------------------------------------------------------------------
** Merge with main DHS survey data
use rawdata\DHSdata\UGPR41FL.DTA, clear
gen hv0241=hv024+700
drop hv024 
rename hv0241 hv024

fmerge m:1 hv001 using intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Uganda_GPS_data, assert(match master) keep(match)
save WB_Uganda2000_01_for_analysis, replace



**------------------------------------------------
**		Create Variables for Analysis
**------------------------------------------------

**----Benin----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Benin2011_for_analysis, clear

** Variables about child labor
gen paidwork = (chl1==1) // Paidwork outside households
gen nonpaidwork= (chl1==2) //Unpaidwork outside households
gen housework=(chl7==1) //Housework inside households
gen otherfalilywork=(chl5==1) //Unpaid or paid work inside households related to family business
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
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)

gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year // active_year==-1 --> a counterfactual

save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country2, replace


**----Burundi----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Burundi2010_11_for_analysis, clear

** Variables about child labor
gen paidwork = (sh21==1)
gen nonpaidwork= (sh21==2)
gen housework=(sh23==1)
gen otherfalilywork=(sh25==1)
gen dropout = (hv129==4) if hv129!=.
gen repeat=(hv129==3) if hv129!=.

gen paidworktime=sh22 if sh21==1
gen nonpaidworktime=sh22 if sh21==2
gen houseworktime=sh24 if sh23==1
replace  paidworktime=0 if paidworktime==.
replace  nonpaidworktime=0 if nonpaidworktime==.
replace  houseworktime=0 if houseworktime==.

**Variables for the relative timing and treatment
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)


gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year 

save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country3, replace


**----Cameroon----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Cameroon2011_for_analysis, clear

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
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen lastmonth = (hv006==8)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)


gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year 


save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country1, replace


**----Gabon----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Gabon2012_for_analysis, clear

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
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)


gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year 


save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country4, replace


** ----Liberia----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Liberia2006_07_for_analysis, clear

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
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)


gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year 


save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country5, replace

** ----Sierra Leone (2013)----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Sierra2013_for_analysis, clear

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
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)


gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year


save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country6, replace

** ----Sierra Leone (2008)----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Sierra2008_for_analysis, clear

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
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)


gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year


save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country7, replace

** ----Uganda----
use intermediate\WB\WB_intermediate_results\1-DHS_Data\WB_Uganda2000_01_for_analysis, clear

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
gen treat = (dist<=10)
gen treat_5km = (dist<=5)
gen treat2 = (dist<=5)
gen treat3 = (dist<=2)
gen urban = (URBAN_RURA=="U")
gen trimdist1 = (dist>=10 & dist<=50)
gen trimdist2 = (dist>=5 & dist<=20)


gen active_treated = (transactions_start_year <= hv007)
gen active_year = hv007 - transactions_start_year


save intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country8, replace



**------------------------------------------------
**		Append Datasets of All Countries
**------------------------------------------------
use intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country1, clear

forvalues x=2(1)8{
 append using intermediate\WB\WB_intermediate_results\2-Data_for_Final_Append\WB_country`x'
}

save intermediate\WB\WB_intermediate_results\3-Data_Allcountries\WB_Allcountries_for_analysis, replace


**--------------------------------------------------
**		Arrange All Countries' Data for Analysis
**--------------------------------------------------
use intermediate\WB\WB_intermediate_results\3-Data_Allcountries\WB_Allcountries_for_analysis, clear
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

**Create country id which denotes the same number in both Sierra(2008) and Sierra(2013)
egen country_id=group(hv000) 
gen country_id2=country_survey
replace country_id2=6 if country_id2==7
replace country_id2=7 if country_id2==8 

**Assign unique codes for each household cluster
egen hv001a=group(hv007 country_id2 hv001) 

**Change the value of female from 2 to 0
replace hv104=0 if hv104==2 

**Create a variable about the ratio of children to all household's members
bysort hhid country_id: egen num_allmember=max(hvidx)
bysort hhid country_id: egen num_chi=seq() if hv105<=14 & hv105>=5
bysort hhid country_id: egen num_child=max(num_chi) 
gen child_ratio=num_child/num_allmember


**Drop households interviewed more than 5 years before or after project implementation dates
drop if active_year2<=0|active_year2>=12 


**Create the same clasification of targeted sector as Chinese aid
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


save intermediate\WB\WB_intermediate_results\3-Data_Allcountries\WB_Allcountries_for_analysis, replace


**------------------------------------------------
**		Merge Children with Parents
**------------------------------------------------

***Create using data of mothers
use intermediate\WB\WB_intermediate_results\3-Data_Allcountries\WB_Allcountries_for_analysis, clear
rename hv105 mother_age
rename hv108 mother_edu 
drop hv112
rename hvidx hv112
keep country_id hhid hv112 mother_age mother_edu

save intermediate\WB\WB_intermediate_results\4-Data_for_Parents_Merge\WB_Mother_for_merge, replace

***Create using data of fathers
use intermediate\WB\WB_intermediate_results\3-Data_Allcountries\WB_Allcountries_for_analysis, clear

rename hv105 father_age
rename hv108 father_edu
drop hv114
rename hvidx hv114
keep country_id hhid hv114 father_age father_edu

save intermediate\WB\WB_intermediate_results\4-Data_for_Parents_Merge\WB_Father_for_merge, replace

***Merge children with father and mother 
use intermediate\WB\WB_intermediate_results\3-Data_Allcountries\WB_Allcountries_for_analysis, clear
 drop _merge
merge m:1 country_id hhid hv112 using "intermediate\WB\WB_intermediate_results\4-Data_for_Parents_Merge\WB_Mother_for_merge.dta"
drop if _merge==2
drop _merge

merge m:1 country_id hhid hv114 using "intermediate\WB\WB_intermediate_results\4-Data_for_Parents_Merge\WB_Father_for_merge.dta"
drop if _merge==2

drop _merge

save intermediate\WB\WB_final_data\Withparents_WB_Allcountries_for_analysis, replace
