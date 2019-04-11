##get the data
if(!file.exists(./data)) {dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/datazet.zip", mode = "wb")

##unzip the file
unzip(zipfile="./data/dataset.zip", exdir="./data")

##read the data
activityTest <- read.table("./test/y_test.txt")
subjectTest <- read.table("./test/subject_test.txt")
dataTest <- read.table("./test/X_test.txt")
activityTrain <- read.table("./train/y_train.txt")
subjectTrain <- read.table("./train/subject_train.txt")
dataTrain <- read.table("./train/X_train.txt")
activityLabels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

#bind the data
subject <- rbind(subjectTest, subjectTrain)
activity <- rbind(activityTest, activityTrain)
data <- rbind(dataTest, dataTrain)

#set names
names(subject) <-c("subject")
names(activity) <-c("activity")
names(data) <- features$V2

#bind test and train data
dataCombine <- cbind(subject, activity)
mergedData <- cbind(dataCombine, data)

##select data with only mean and std values
namesMeanStd <-features$V2[grep("mean|std", features$V2)]

##subset data frame by selected features
selectedNames <- c("subject", "activity", as.character(namesMeanStd))
subsetData <- subset(mergedData, select = selectedNames)

##turn activity labels into descriptive factors
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], 
                           labels = activityLabels[,2])

##turn subject column into factor
mergedData$subject <- as.factor(mergedData$subject)

##Appropriately labels the data set with descriptive variable names
##get column names
mergedDataCols <- colnames(mergedData)

##remove special characters
mergedDataCols <- gsub("[\\(\\)-]", "", mergedDataCols)

##change column names
mergedDataCols <- gsub("^f", "frequency", mergedDataCols)
mergedDataCols <- gsub("^t", "time", mergedDataCols)
mergedDataCols <- gsub("Acc", "Accelerometer", mergedDataCols)
mergedDataCols <- gsub("Gyro", "Gyroscope", mergedDataCols)
mergedDataCols <- gsub("Mag", "Magnitude", mergedDataCols)
mergedDataCols <- gsub("Acc", "Accelerometer", mergedDataCols)
mergedDataCols <- gsub("Freq", "Frequency", mergedDataCols)
mergedDataCols <- gsub("BodyBody", "Body", mergedDataCols)

#add new column names to merged data 
colnames(mergedData) <- mergedDataCols


##create a second, independent tidy data set with the average of each variable 
##for each activity and each subject.

##group by subject and activity
library(plyr)
finalData <- aggregate(. ~subject + activity, mergedData, mean)
finalData <- finalData[order(finalData$subject, finalData$activity), ]

##write table
write.table(finalData, file = "tidydata.txt", row.name = FALSE)


