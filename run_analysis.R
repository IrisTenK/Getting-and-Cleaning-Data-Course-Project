# Load libraries
library(dplyr)

# First we download the data before we can follow the necessary steps for making the data tidy
filename <- "Coursera_Week4_FinalAssignment.zip"

# Checking if the file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# 1 Merges the training and the test sets to create one data set.
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("number", "label"))

# First we merge x_train and x_test and then assign the column names (stored in features.txt)
x_trainANDtest <- rbind(x_train, x_test)
columnNames <- read.table("UCI HAR Dataset/features.txt")
colnames(x_trainANDtest) <- columnNames[,2]

# Now we also merge the other dataframes with x_train and test
subject_trainANDtest <- rbind(subject_train, subject_test)
y_trainANDtest <- rbind(y_train, y_test)
trainANDtest <- cbind(subject_trainANDtest, y_trainANDtest, x_trainANDtest) 

# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
trainANDtest2 <-
  trainANDtest %>%
  select(subject, activity, contains("mean") | contains("std"))

# 3 Uses descriptive activity names to name the activities in the data set
trainANDtest3 <- 
  trainANDtest2 %>% mutate(activity = activity_labels[activity,2])

# 4 Appropriately labels the data set with descriptive variable names.
names(trainANDtest3) <- tolower(names(trainANDtest3)) # first we make all variable names lower case
names(trainANDtest3) <- gsub("acc", "accelerometer", names(trainANDtest3)) # replace acc with accelerometer
names(trainANDtest3) <- gsub("gyro", "gyroscope", names (trainANDtest3)) # replace gyro with gyroscope
names(trainANDtest3) <- gsub("bodybody", "body", names (trainANDtest3)) # replace bodybody with body
names(trainANDtest3) <- gsub("\\()", "", names(trainANDtest3)) # remover ()s from column names
names(trainANDtest3) <- sub("-", "_", names(trainANDtest3)) # replace the first - with underscores

# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
meansPerSubjectAndActivity <-
  trainANDtest3 %>%
  group_by(subject, activity) %>% # here we group by subject and activity
  summarize_all(mean) # here we calculate the means for all other variables

# write the data to data tables
write.table(trainANDtest3, file="tidyUCI_HAR_Dataset")
write.table(meansPerSubjectAndActivity, file="groupedUCI_HAR_Dataset")
