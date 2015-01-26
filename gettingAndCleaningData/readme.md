
---
title: readme.md
author: rrgnf
---
This repository stores the course projet to getting and cleaning date.  (https://class.coursera.org/getdata-010/human_grading)

##Coments
#how script works
#code book describing the variables

### Data

The data used is available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and a full description is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Script
A R script (run_analysis) is available in this repository. This script consider that the data have been download and saved in the same diretory of the script. That means the data files are inside "UCI HAR Dataset" directory.

what the Script do:
1. load features names from 'features.txt', process it, and create the 'features2' variable.
2. load actitivies from 'activity_labels.txt' and results the 'activities' variable
3. create a function 'nomeAtividade' to convert Activity ID in activity name.
4. load test and train. After bind the data by columns, after, bind by rows, results the  'subject' variable.
5. Create a tbl_df (x_tbl) from 'subject'
6. Separete the measuments using 'tidyr::separate', and also uses variable 'features2' to name the columns.
7. Replace Activity number by activity name.
8. Select Columns only if contains 'mean' or 'std' in the name.
9. Convert the contents of mean and std columns to numeric
10. Bind selected columns (mean and sd) to 'subject' and 'activity'
11. Group the data using dplyr::group_by by subject and actitivy
12. Summarize the data
13. write to csv