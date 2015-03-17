run_analysis <- function(wd="UCI HAR Dataset"){ #Path to UCI HAR Dataset folder
        library(plyr) #Loading the plyr package
        setwd(wd) #Initial setting of working directory
        
        #Loading the activity and features data in the global environment
        #from the parent folder UCI HAR Dataset
        activity <- read.table("activity_labels.txt")
        features <- read.table("features.txt")
        
        
        # Regular expressions used to select solely the mean and standard deviation for each feature
        feat_list <- c(grep("-mean",features$V2),grep("-std",features$V2))
        
        setwd("test") #Setting the working directory to the 'test' folder
        
        #Loading the 'test' datasets in the global environment from their subfolder
        xtest <- read.table("X_test.txt")
        ytest <- read.table("y_test.txt")
        subject_test <- read.table("subject_test.txt")
        
        setwd(wd) #Going back to the parent folder
        
        setwd("train") #Setting the working directory to the 'test' folder
        
        #Loading the 'train' datasets in the global environment from their subfolder
        xtrain <- read.table("X_train.txt")
        ytrain <- read.table("y_train.txt")
        subject_train <- read.table("subject_train.txt")
        
        
        # The following "binding" line of codes either row or column bind the datasets to create
        # a complete dataset from the different segments.
       
        xbinding <- rbind(xtrain,xtest) #to bind the two X datasets
        ybinding <- rbind(ytrain,ytest) #to bind the two Y datasets
        

        ybinding[, 1] <- activity[ybinding[, 1], 2]  # Replacing the activity data with their corresponding labels

        subjectbinding <- rbind(subject_train,subject_test) #to bind the two subject datasets
        
        xbinding <- setNames(xbinding,features$V2) #to assign the labels to xtrain data
        ybinding <- setNames(ybinding,"Activity") #to assign the labels to ytrain data
        subjectbinding <- setNames(subjectbinding,"Subject") #to assign the labels to subject data
        
        
        # Bringing it all together
        full_binding <- cbind(xbinding,subjectbinding,ybinding)
        
        # Applying the ddply function to summarize the data in the full_binding table by Subject and Activity respectively
        # The function applied by ddply is colMeans
        wrap <- ddply(full_binding,.(Subject,Activity),function(x) colMeans(x[,feat_list]))
        
        # coming back to the UCI HAR Dataset folder...
        setwd(wd)
        
        # And voilà! creating the tidy data table
        write.table(wrap, "mean&std_summary.txt",row.name=FALSE)
}