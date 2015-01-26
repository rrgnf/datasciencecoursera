#run_analysis.R

#load libraries
library(tidyr)
library(dplyr)

#Step 1 (readme)
#loading features
features <- read.table(file = './UCI HAR Dataset/features.txt',header = F,)
l1 <- features[1,]
l1$V2 <- factor("empty")
features <- rbind(l1,features)
rm(l1)
#head(features)
names(features) <- c("idf","Description")
features <- mutate(features,d=paste(Description,idf))

#replace these character "( ) , - " by "_" 

features2 <- as.array(features$d)
features2 <- str_replace_all(features2,"[(), -]","_")
features2 <- str_replace_all(features2,"_+","_")

#Step 2 (readme)
#loAding activities
activities <- read.table(file = './UCI HAR Dataset/activity_labels.txt',header = F,)
names(activities) <- c("id","Activities")
activities <- select(activities,Activities)

#Step 3 (readme)
#function to 'say' 'activity name' by 'activity number'
nomeAtividade <- function(idAtividade){
  as.character(activities[idAtividade,1]);
}

#Step 4 (readme)
#reading test data from csv files
s_test <- read.csv(".\\UCI HAR Dataset\\test\\subject_test.txt")
x_test <- read.csv(".\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.csv(".\\UCI HAR Dataset\\test\\Y_test.txt")

#reading train data from csv files
s_train <- read.csv(".\\UCI HAR Dataset\\train\\subject_train.txt")
x_train <- read.csv(".\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.csv(".\\UCI HAR Dataset\\train\\Y_train.txt")

#setting column names
names(s_test) <- "subject"
names(x_test)  <- "data_set"
names(y_test)  <- "y"

names(s_train) <- "subject"
names(x_train)  <- "data_set"
names(y_train)  <- "y"

#merging columns on test data
subject_test   <- cbind(  s_test , y_test, x_test  )

subject_train   <- cbind(  s_train , y_train, x_train  )

rm(s_test)
rm(y_test)
rm(x_test)

rm(s_train)
rm(y_train)
rm(x_train)


subject <- rbind(subject_test,subject_train)
rm(subject_test,subject_train)
rm(features)

#Step 5 (readme)
x_tbl <- tbl_df(subject)

#Step 6 (readme)
x_tbl <- separate(x_tbl,data_set, features2, sep = "\\s+")
x_tbl <- select (x_tbl,-empty_1)

#Step 7 (readme)
x_tbl <- mutate(x_tbl, Activitie = nomeAtividade(x_tbl$y) )

#Step 8 (readme)
x_tbl2 <- select(x_tbl,contains("mean",ignore.case = T))
#Step 9 (readme)
x_tbl2 <- mutate_each(x_tbl2,funs(as.character))
x_tbl2 <- mutate_each(x_tbl2,funs(as.numeric))

#Step 8 (readme)
x_tbl3 <- select(x_tbl,contains("std",ignore.case = T))
#Step 9 (readme)
x_tbl3 <- mutate_each(x_tbl3,funs(as.character))
x_tbl3 <- mutate_each(x_tbl3,funs(as.numeric))

x_tbl4 <- select(x_tbl,subject)
x_tbl5 <- select(x_tbl,Activitie)

#Step 10 (readme)
x_tbl  <- cbind(x_tbl4,x_tbl5,x_tbl2,x_tbl3)

rm(x_tbl5,x_tbl4,x_tbl3,x_tbl2)

#Step 11 (readme)
x_tbl <- group_by(x_tbl,Activitie,subject)

#Step 12 (readme)
result <- summarise_each(x_tbl,funs(mean,sd),
                  (tBodyAcc_mean_X_1):(fBodyBodyGyroJerkMag_std_543))

#Step 13 (readme)
#writing csv result data
write.csv(result, "result.csv",row.names=F)
