Getting and Cleaning Data Course Project

This file describes how run_analysis.R script works to generated the files that the project asks.

Step 1 , you have to unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder with "DataSet".
You must have both files "DataSet" and the run_analysis.R script in the current working directory by GIt.

Step 2, run the script("run_analysis.R") into RStudio. 

Step 3, you will find two output files are generated in the current working directory:
merged_data.txt: (7.85 Mb): it contains a data frame called cleanedData with Contain 10299 observations and 68 variables.
data_means.txt :(39 Kb): it contains a data frame called result with 180*68 dimension.

Step 5, use data <- read.table("data_means.txt") command in RStudio to read the file. 
