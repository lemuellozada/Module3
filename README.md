# Module3
Getting and Cleaning Data 

run_analysis.R does the following
1. load data.table R package
2. download the UCI HAR Dataset and puts the zip file in the working directory before unziping
3. sets the UCI HAR Dataset folder as the new directory 
4. read and merges the train and test data sets (subject, x, and y for both data sets)
5. extracts the mean and standard deviation for each measurement
6. use descriptive activity names to name the activities in the data set
7. appropirately label the data set with descriptive activity names (data set 1)
8. create a second, independent, tidy data set using the data set 1. the second data 
   set includes the average of each variable for each activity and each subject

Final ouput is stored as tidy_data.txt
