# GetAndCleanData
Get And Clean Data Course Project
Performed by Sam Mallisetti

Below are the instructions:
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Below is the reference from where the data files were obtained
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
Multiclass Hardware-Friendly Support Vector Machine. International Workshop 
of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The code performs the below tasks:

download all files from the above reference to local directory
set working directory in R to local directory

The data is from a study of 30 participants performing 6 different activities using a Samsung device. 561 Measurements were captured for each of the 10,299 observations. The data is split into multiple files. 70% used as training data and 30% used for testing.

Subject files contain just a subject id (numbers 1 to 30). Y files contain only the Activity id (numbers 1 to 6). X files contain the measurements for 561 variables. By combining the Subject, Y, and X files using cbind while preserving the order we will get a complete dataset. Also we need to combine the training and testing files using rbind to get the full dataset. 

Since we are interested in only mean or standard deviation measurements, we need to retain only those columns that contain either 'mean' or 'std' in the variable names. This leads to just 79 variables. 

Using Activity Labels file we can assign descriptive names for each activity. This means we need to replace Activity Id in column 2 of the final dataset with the Activity Label. 

Using Features file we can assign Variable names to the 79 columns with measurements. 

Finally, we can group by Subject Id and Activity and aggregate all the remaining measurement columns to find their average. Using DPLYR and DATASETS packages, this can be accomplished using group_by and summarise_all functions. And in the last step we need to write the dataset into a file in order to be able to export it to Git Hub Repository. 