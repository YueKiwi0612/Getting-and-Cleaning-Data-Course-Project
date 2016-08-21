setwd("/Users/Eva/Documents/Coursera Courses")
#####Merge Data#####
#1. download zip file
if(!file.exists("./data")) dir.crate("./data")
fileurl1 <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl1,destfile="./data/projectdata.zip")

#2. unzip the file
datazip <- unzip("./data/projectdata.zip",exdir = "./data")

#3. load datasets into R
train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#merge train data and test data into one dataset
trainData <- cbind(train.subject,train.y,train.x)
testData <- cbind(test.subject,test.y,test.x)
allData <- rbind(trainData,testData)

####Extract only the measurements on the mean and the std for each measurement####
#1. load feature name
featureName <- read.table("./data/UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)[,2]

#2. extract mean and std
featureIndex <- grep(("mean\\(\\)|std\\(\\)"),featureName)
featureData <- allData[,c(1,2,featureIndex+2)]
colnames(featureData) <- c("Subject","Activity",featureName[featureIndex])

####Use descriptive activity names to name the activities in the data set####
#1. laod activity name
activityName <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#2. replace the activity code with names
featureData$Activity <- factor(featureData$Activ,loity, levels = activityName[,1],labels=activityName[,1])

####Appropriately labels the data set with descriptive variable names####
names(featureData) <- gsub("\\()","",names(featureData))
names(featureData) <- gsub("^t","time",names(featureData))
names(featureData) <- gsub("^f","frequence",names(featureData))
names(featureData) <- gsub("-mean","Mean",names(featureData))
names(featureData) <- gsub("-std","Std",names(featureData))

####From the data set in step 4, creates a second, independent tidy data set with the average of each vars for each activity and each subject####
library(dplyr)
groupData <- featureData %>%
                group_by(Subject,Activity) %>%
                summarize_each(funs(mean))

write.table(groupData,"./data/MeanData.txt",row.names = FALSE)
