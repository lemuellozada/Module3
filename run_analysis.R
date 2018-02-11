##load data.table
library(data.table)

## dwonload files and set working directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./UCI HAR Dataset.zip")){
   download.file(url, "./UCI HAR Dataset.zip", mode = "wb")
   unzip("UCI HAR Dataset.zip", exdir = getwd())
}

## set new directoy
setwd("./UCI HAR Dataset")

##read the datasets
subject_train <- read.table("./train/subject_train.txt", header = FALSE)
x_train <- read.table("./train/X_train.txt", header = FALSE)
y_train <- read.table("./train/Y_train.txt", header = FALSE)

subject_test <- read.table("./test/subject_test.txt", header = FALSE)
x_test <- read.table("./test/X_test.txt", header = FALSE)
y_test <- read.table("./test/Y_test.txt", header = FALSE)

features <- read.csv('./features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

data.train <- data.frame(subject_train,y_train ,x_train)
names(data.train) <- c(c("subject", "activity"), features)

data.test <- data.frame(subject_test, y_test, x_test)
names(data.test) <- c(c("subject", "activity"), features)

## merge the train and test data sets
datamerged <- rbind(data.train, data.test)

## extracts only the measurements on the mean 
## and standard deviation for each measurement

mean_std_select <- grep("mean|std", features)
data.sub <- datamerged[ , c(1,2,mean_std_select +2)]

# Uses descriptive activity names to name the activities in the data set

actLabels <- read.table("./activity_labels.txt", header = FALSE)
actLabels <- as.character(actLabels[ ,2])
data.sub$activity <- actLabels[data.sub$activity]

## appropriately label the data set with descriptive activity names

name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new 

## from the data set in step 4, create a second, independent
## tidy data set with the average of each variable
## for each activity and each subject

tidydata <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = tidydata, file = "tidy_data.txt", row.names = FALSE)