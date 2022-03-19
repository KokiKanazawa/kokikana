Replication Files for 'The Impact of Foreign Aid on Child Labor' (Kanazawa, Goto, and Yamasaki)


There are two main folders:
rawdata
code
intermediate
output

These folders contain all data and do files needed to replicate data sets, Tables, and Figures of Chinese aid and World Bank's aid (both in the main text and in the appendix).


# rawdata
The folder 'rawdata' contains the project-level aid datasets and child-level DHS datasets. The following three subfolders are located within this folder:
DHSdata
GeoCoded_China_Data_Merged_Files
WorldBank_GeocodedResearxhRelease_Level1_v1.4.2

- DHSdata
This file includes raw datasets of DHS GPS and survey datasets for each country. The file '~~~country code~~.dta' contains both DHS GPS and survey datasets for each country.

- GeoCoded_China_Data_Merged_Files
This file includes raw datasets of project-level Chinese aid from AidData. The file '~~~~.dta' contains AidData's Global Chinese Official Finance Dataset, 2000-2014, Version 1.1.1.

- WorldBank_GeocodedResearxhRelease_Level1_v1.4.2
This file includes raw datasets of project-level World Bank's aid from AidData.

# code
This file includes following two do files for data replication of China and World Bank code:
China_code
WB_code

## China_code
This folder contains following three dofiles for the replication of the Chinese dataset and tables and figures:
0-Dataset_Construction.do
1-Main_analysis_code.do
2-Appendix_analysis_code.do

### 0- Dataset_Construction.do
This dofile includes the code for the replication of Chinese dataset.

### 1-Main_analysis_code.do
This dofile includes the code for all analysis in the main text.

### 2-Appendix_analysis_code.do
This dofile includes the code for all analysis in the appendix.

## WB_code
This folder contains following three dofiles for the replication of the World Bank's dataset and tables and figures:
0-Dataset_Construction.do
1-Main_analysis_code.do
2-Appendix_analysis_code.do

### 0- Dataset_Construction.do
This dofile includes the code for the replication of Chinese dataset.

### 1-Main_analysis_code.do
This dofile includes the code for all analysis in the main text.

### 2-Appendix_analysis_code.do
This dofile includes the code for all analysis in the appendix.

# intermediate
This file includes datasets used to construct the final data, which are divided into following subfiles:
China
WB

## China
This folder contains following two files about the intermediate datasets and final datasets of China:
China_intermediate_results
China_final_data

### China_intermediate_results
This file contains the following four files which contain the intermediate datasets produced in the procedure of the data replication.
0-Aid_Data
1-DHS_Data
2-Data_for_Final_Append
3-Data_Allcountries
4-Data_for_Parents_Merge

### 0-Aid_Data
This file includes all aid datasets of each country.

### 1-DHS_Data
This file includes interim datasets of DHS GPS and survey datasets for each country in the process of running do file.

### 2-Data_for_Final_Append
This file includes datasets after combining children and aid datasets for each country, which are datasets right before the final appending.

### 3-Data_Allcountries
This file includes auxiliary datasets of all countries used for merging parents' information with child-level datasets.

### 4-Data_for_Parents_Merge
This file includes auxiliary datasets used for merging child-level datasets with parents' information.

### China_final_data
This file contains the dataset used for all analysis of Chinese aid in the paper.


## WB_code
This folder contains following two files about the intermediate datasets and final datasets of World Bank:
WB_intermediate_results
WB_final_data

## WB_intermediate_results
This file contains the following four files which contain the intermediate datasets produced in the procedure of the data replication.
0-Aid_Data
1-DHS_Data
2-Data_for_Final_Append
3-Data_Allcountries
4-Data_for_Parents_Merge

### 0-Aid_Data
This file includes all aid datasets of each country.

### 1-DHS_Data
This file includes interim datasets of DHS GPS and survey datasets for each country in the process of running do file.

### 2-Data_for_Final_Append
This file includes datasets after combining children and aid datasets for each country, which are datasets right before the final appending.

### 3-Data_Allcountries
This file includes auxiliary datasets of all countries used for merging parents' information with child-level datasets.

### 4-Data_for_Parents_Merge
This file includes auxiliary datasets used for merging child-level datasets with parents' information.

## WB_final_results
This file contains the dataset used for all analysis of World Bank's aid in the paper.

# output
This file includes tables and figures shown in the main text and appendix.
