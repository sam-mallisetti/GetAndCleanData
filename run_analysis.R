#Getting and Cleaning Data - Week 4 - Course Project
#Performed by Sam Mallisetti

#Below is the reference from where the data files were obtained
#[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
#Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
#Multiclass Hardware-Friendly Support Vector Machine. International Workshop 
#of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

#download files to local directory
#set working directory in R to local directory

#Following are the course project instructions:
#Step 1: Merges the training and the test sets to create one data set.
#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#Step 3: Uses descriptive activity names to name the activities in the data set
#Step 4: Appropriately labels the data set with descriptive variable names.
#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#we will need dplyr and datasets packages
library(dplyr)
library(datasets)

#read into data frames using read.table traindata, testdata
#X_train and X_test contain the core data for measurements on 561 variables (but without subject or activity)
traindata <- read.table("X_train.txt")
testdata <- read.table("X_test.txt")

#combine into alldata using rbind; this preserves the order of the data; total 10,299 rows by 561 columns
alldata <- rbind(traindata, testdata)

#read features in using read.table; this contains 561 variable names 
fdata <- read.table("features.txt")

#using grep get only mean or std variables indexes - 79 of them; also get the variable names for these 79 variables
findex <- grep("*mean*|*std*", fdata[,2])
fvalue <- grep("*mean*|*std*", fdata[,2], value=TRUE)

#THIS ESSENTIALLY PERFORMS STEP 2 (PLEASE NOTE STEP 1 IS DONE LATER)
#using select extract only the above 79 into dataset; contains 10,299 by 79; 
dataset <- select(alldata, findex)

#read y_train, y_test into df; these are activity numbers; 
ytrain <- read.table("y_train.txt")
ytest <- read.table("y_test.txt")

#read the Labels for 6 Activities
alables <- read.table("activity_labels.txt")

#combine y_train and y_test using rbind into ydata; total 10,299 rows containing only activity numbers
ydata <- rbind(ytrain, ytest)

#THIS PERFORMS STEP 3
#assign Activity Labels instead of Activity Numbers for each row in ydata;
for (i in 1:10299) {
if( ydata[i,1] == "1") { ydata[i,1] <- "WALKING" }
else if( ydata[i,1] == "2") { ydata[i,1] <- "WALKING_UPSTAIRS" }
else if( ydata[i,1] == "3") { ydata[i,1] <- "WALKING_DOWNSTAIRS" }
else if( ydata[i,1] == "4") { ydata[i,1] <- "SITTING" }
else if( ydata[i,1] == "5") { ydata[i,1] <- "STANDING" }
else if( ydata[i,1] == "6") { ydata[i,1] <- "LAYING" }
}


#read subject_train, subject_test into df; these contain subject numbers
strain <- read.table("subject_train.txt")
stest <- read.table("subject_test.txt")

#combine subject_train and subject_test using rbind into sdata; contains 10,299 rows
sdata <- rbind(strain, stest)

#THIS PERFORMS STEP 4
#assign Variable names from fvalue to column names of dataset;
names(dataset) <- fvalue

#assign column names to sdata and ydata
names(sdata) <- "subject-id"
names(ydata) <- "activity"

#THIS PERFORMS STEP 1 AFTER ASSEMBLING ALL PIECES OF DATA
#combine sdata, ydata, and dataset using cbind into udata
#udata is the data set containing subject, activity, and mean/std variables;
udata <- cbind(sdata, ydata, dataset)

#THIS PERFORMS STEP 5 TO CREATE A NARROW TIDY DATASET
#find mean of each variable for each subject and activity;
sumdata <- udata %>% group_by(subjectid, activity) %>% summarise_all(mean)

#write the summary data to a file in local directory; this may be used to push to Git Repo
write.table(sumdata, "tidydata.txt")

## End of the coding for Course Project



