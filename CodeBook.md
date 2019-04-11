# CodeBook for Course Project: Getting and Cleaning Data

##Introduction
The raw data obtained represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The README file contains additional information on the data, and a full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The actual raw data can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Data

tidy_data.txt is a text file that contains the tidy data of the average of each variable for each activity and subject from raw data collected from the accelerometers from the Samsung Galaxy S smartphone. 
 
The first row contains the variables (see variables section of this document), and the following rows contain the values of these variables. 

##Variables
Each row contains, for a given subject and activity, 86 averaged signal measurements.

###Identifiers
```subject```
integer, ranges from 1 to 30

```activity```

factor, string with 6 possible values:
        + WALKING
        + WALKING_UPSTAIRS
        + WALKING_DOWNSTAIRS
        + SITTING
        + STANDING
        + LAYING

Measurements:
all measurements are either Mean or Standard Deviation values.

Accerelation measurements are variables containg ```Accelerometer```

The acceleration signal was then separated into ```body``` and ```gravity```  signals 

Gyroscope measurements are variables containg ```Gyroscope```

The body linear acceleration and angular velocity are marked by variables containing ```Jerk```, and magnitudes of these three-dimensional signals were calculated using the Euclidean norm and are variables containing ```Magnitude```

Time-domain signals (```Time```) are variables resulting from the capture of accelerometer and gyroscope raw signals

Frequency-domain signals (```Frequency```) are variables resulting from the application of a Fast Fourier Transform (FFT) to some fo the time-domain signals.

```X```, ```Y```, ```Z``` in variable names are used to denote 3-axial signals in the X, Y and Z directions.

##Transformations

The raw data can be found in the following ZIP file:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following transformations were applied to the source data:

1. the subjects, activity and feature data were merged into one data set for both the training and test sets (ie. for test: subject_test, y_test and X_test were merged into one data frame)
2. the training and test sets (consisting of subjects, activity and feature data) were merged into one data set
3. All measurements containing mean or standard deviation values were extracted to create a new data set 
4. The activity identifiers were replaced with descriptive activity names from the activity_labels.txt file 
5. the variable names were replaced with descriptive variable names using the following substitutions: Acc to Accelerometer, Gyro to Gyroscope, BodyBody to Body, Mag to Magnitude,f to Frequency, t to Time, tBody to TimeBody, mean() to Mean, std() to StandardDeviation, -freq() to Frequency, angle to Angle, gravity to Gravity.
6. The final data set was created by taking the average of each variable for each activity and each subject. 

More information on transformation of the dataset can be found in the run_analysis.R script. 




