## This script does all the analysis to get the tidy data set as defined 
## in the Course Project "Getting and Cleaning Data"
## writes data set to a .txt file
## returns the tidy data set

## data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## it is expected that the data are downloaded and unzipped into a working directory with the path "./data/UCI HAR Dataset/"

library(dplyr)

run_analysis <- function(){
  ## read all and make one data set
  ## read test data set
  url <- "./data/UCI HAR Dataset/test"
   testX <- read.table(paste0(url, "/X_test.txt"))
   testy <- read.table(paste0(url,"/y_test.txt"))
   testsubject <- read.table(paste0(url,"/subject_test.txt"))
   test <- cbind(testsubject, testy, testX)
  
  ## read train data set
  url <- "./data/UCI HAR Dataset/train"
  trainX <- read.table(paste0(url, "/X_train.txt"))
  trainy <- read.table(paste0(url,"/y_train.txt"))
  trainsubject <- read.table(paste0(url,"/subject_train.txt"))
  train <- cbind(trainsubject, trainy, trainX)
  
  ##combine test and train data set
  rowset <- rbind(test, train)
  
  ## add headers to the rowset DF
  ## read feature names
  url <- "./data/UCI HAR Dataset"
  readfeatures <- read.table(paste0(url,"/features.txt"))
  featfac <- readfeatures[,2]
  featvec <- as.character.factor(featfac)
  
  ## add 2 additional feature names for the "subject" and "activity" features
  nn <- c("subject", "activity")
  newfeat <- c(nn, featvec)
  ## add feature names 
  colnames(rowset) <- newfeat
  
  
  
  ## remove columns with duplicated column names and choose only measurements with std and mean
  rowset_tbl <- tbl_df(rowset) # make table
  rowset_tbl_clear <- rowset_tbl[, !duplicated(colnames(rowset_tbl))]
  meanstd_tbl <- select(rowset_tbl_clear, subject, activity, contains("mean"), contains("std"))
  
  ## add descriptive activities names
  activity_tbl <- tbl_df(read.table(paste0(url, "/activity_labels.txt")))
  colnames(activity_tbl) <- c("activity", "activity_descr")
  merged <- merge(meanstd_tbl, activity_tbl, by.x = "activity", by.y = "activity")
  meanstd_tbl_descr <- select(merged, subject, activity_descr, c(3:length(merged)))
  
  ## compute mean for each subject and activitym
  tidy_output <- meanstd_tbl_descr %>% group_by(subject, activity_descr) %>% summarise_each(funs(mean))
  
  ## write tidy output into the file
  write.table(tidy_output, file = "./data/UCI HAR Dataset/tidy_output.txt", row.names = FALSE)
  
  tidy_output
}