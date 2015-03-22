---
title: "Codebook.md"
author: "RajagopalanK"
date: "Sunday, March 22, 2015"
output: html_document
---

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

I have created a "run_analysis.R" R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


This R script does the below steps to clean the data:

1. Set working directory to setwd("./data/UCI/Dataset")

2. Read X_test.txt, y_test.txt and subject_test.txt from the "./test" folder and store them in x_test, y_test and test_subj variables respectively.

3. Combine test_subj,y_test and x_test data set using cbind to create test_data data set.

4. Read X_train.txt, y_train.txt and subject_train.txt from the "./train" folder and store them in x_train, y_train and train_subj variables respectively.

5. Combine train_subj,y_train and x_train data set using cbind to create train_data data set.

6. Merge test_data and train_data to create a merge_data data frame which will have 10299 rows and 563 columns.

7. Read the features.txt file from the current working folder and store the data in a variable called Features_data.

8. Read the activity_labels.txt file from the working folder and store the data in a variable called activity_label.

9. Read Merge_data set and assign the activity label by looping both merge_data and activity_label data set

10. Read measurements of only mean and std in a merge_data and save them in a mean_dataset and std_dataset respectively.

11. Create a tidy_dataset by combining mean_dataset, std_dataset using cbind and then aggregate by subject + activity name. This will have a data set with the average of each measurement for each activity and each subject.

12. Write the tidy_dataset to "tidy_data.txt" file in current working directory.