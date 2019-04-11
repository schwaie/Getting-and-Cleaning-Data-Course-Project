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
colnames(subject) <- "Subject"
colnames(activity) <-"Activity"
names(data) <- features$V2

#bind test and train data
mergedData <- cbind(subject, activity, data)

##Extract the column indices that have either mean or std in them.
mergedDataMeanStd <-grep(".*Mean.*|.*Std.*")

##add activity and subject columns to the list
requiredColumns <- c(mergedDataMeanStd, 1, 2)

##extract the data using the requiredColumns vector
extractedData <- mergedData[ ,requiredColumns]

##change class of Activity column to character
extractedData$Activity <- as.character(extractdData$Activity)

##change numbers in Activity to the labels in activityLabels
for (i in 1:6) {
        extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

##now change class of $Activity to factor
> extractedData$Activity <- as.factor(extractedData$Activity)

##make data tidy:
##Acc to Accelerometer, 
##Gyro to Gyroscope, 
##BodyBody to Body, 
##Mag to Magnitude,
##f to Frequency, 
##t to Time
##tBody to TimeBody
##mean() to Mean
##std() to StandardDeviation
##-freq() to Frequency
##angle to Angle
##gravity to Gravity

##change column names
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

##set $subject as a factor
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

#Create tidy data set with the average of each activity and subject,write it into data file
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidydata.txt", row.names = FALSE)
