#   Code Book
The following file contains description of the variables, the data, and all transformations or work performed make it cleaner.


##  Package Dependencies
    plyr
Must be installed prior to running the code.

##  Parameters

    wd  =  path to working directory. "UCI HAR Dataset" as default

##  Variables Description
### Largely inspired by `features_info.txt`

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag


##  Modifications and transformations

### Getting the Data

As previously mentioned in README.md, the zipped data must first be downloaded to the local drive, and then unzipped. It is also recommended to save it in the forked repository.
This way, the `run_analysis.R` will run by itself once executed. Else, simply pass the file path as argument to the code.
Afterwards, the code will navigate and retrieve the files in the UCI HAR Dataset folder by itself.

Navigation through the folder use the `setwd()` function.

### Loading the Data in the Global Environment

The program will load the text files in three separate steps, which can be summed up by folders in the zipped file.

* UCI HAR Dataset main folder
        activity <- read.table("activity_labels.txt")
        features <- read.table("features.txt")
    Loads the Activity labels and stores them in object `activity`
    Loads the features labels and stores them in object `features`

* test folder
        xtest <- read.table("X_test.txt")
        ytest <- read.table("y_test.txt")
        subject_test <- read.table("subject_test.txt")
    Loads the X, Y and Subject test datasets and saves them accordingly.

* train folder
        xtrain <- read.table("X_train.txt")
        ytrain <- read.table("y_train.txt")
        subject_test <- read.table("subject_train.txt")
    Loads the X, Y and Subject train datasets and saves them accordingly.

### Sticking the Data Together
To build a complete data frame object containing all the train and test data, a combination of row bind (`rbind()`) and column bind (`cbind()`) were used.

        xbinding <- rbind(xtrain,xtest)
        ybinding <- rbind(ytrain,ytest)
        

        subjectbinding <- rbind(subject_train,subject_test)
        
        xbinding <- setNames(xbinding,features$V2)
        ybinding <- setNames(ybinding,"Activity")


        subjectbinding <- setNames(subjectbinding,"Subject")


### Labeling Activities

This step happens right after the creation of the `ybinding` object to avoid redundancy. It replaces all the activity codes in `ybinding` by their corresponding activity label.
        ybinding[, 1] <- activity[ybinding[, 1], 2]