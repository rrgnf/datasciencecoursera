#run_analysis.R

#reading test data from csv files
s_test <- read.csv(".\\UCI HAR Dataset\\test\\subject_test.txt")
y_test <- read.csv(".\\UCI HAR Dataset\\test\\Y_test.txt")

#setting column names
names(s_test) <- "subject"
names(y_test)  <- "y"

#merging columns on test data
subject_test   <- cbind(  s_test , y_test  )

#removing old var
rm(s_test)
rm(y_test)

#doing the same for train data

s_train  <- read.csv(".\\UCI HAR Dataset\\train\\subject_train.txt")
y_train  <- read.csv(".\\UCI HAR Dataset\\train\\Y_train.txt")

names(s_train) <- "subject"
names(y_train)  <- "y"

subject_train   <- cbind(  s_train ,  y_train  )

rm(s_train)
rm(y_train)

#merging test and train data
dados <- rbind(subject_test,subject_train)

rm(subject_test)
rm(subject_train)

#load required libraries
library(dplyr)
library(tidyr)

#creating tbl_df
dados_tbl <- tbl_df(dados) 

rm(dados)

#calc mean and sd
dados_resp <- summarise_each(dados_tbl,funs(mean,sd))

#writing csv result data
write.csv(dados_resp, "dados_resp.csv",row.names=F)

