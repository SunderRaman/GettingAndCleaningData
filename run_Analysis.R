# Download the data file (.zip) 

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/MergedData.zip")

# Unzipping the data file
unzip(zipfile="./data/MergedData.zip",exdir="./data")

# Read the trainings tables:
x_training <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_training <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_training <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables:
x_testing <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_testing <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_testing <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading features vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Assignment of Column names
colnames(x_training) <- features[,2] 
colnames(y_training) <-"activityId"
colnames(subject_training) <- "subjectId"
      
colnames(x_testing) <- features[,2] 
colnames(y_testing) <- "activityId"
colnames(subject_testing) <- "subjectId"
      
colnames(activityLabels) <- c('activityId','activityType')

#Merging of Data into one Full Dataset
mrg_training <- cbind(y_training, subject_training, x_training)
mrg_testing <- cbind(y_testing, subject_testing, x_testing)
fullMergedData <- rbind(mrg_training, mrg_testing)

#Retrieving the column Names from the fully merged data
colNames <- colnames(fullMergedData)

#Vector of mean and standard deviation with activityID, SubjectID
meanAndStdDev <- (grepl("activityId" , colNames) | 
                 grepl("subjectId" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
                 )

#Creation of a subset for Mean and Standard Deviation
setForMeanAndStdDev <- fullMergedData[ , meanAndStdDev  == TRUE]

#Naming the activities in the data set
setWithActivityNames <- merge(setForMeanAndStdDev, activityLabels,
                              by='activityId',
                              all.x=TRUE)
#Create a Tidy Set for each variable for each activity and each Subject
tidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
tidySet <- tidySet[order(tidySet$subjectId, tidySet$activityId),]

#Write the Tidy Data Set to a file
write.table(tidySet, "tidySet.txt", row.name=FALSE)