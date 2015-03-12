# "/Users/davegelinas/Documents/MOOCs/Data Science/Getting and Cleaning data/Course project/UCI HAR Dataset"

run_analysis <- function(wd="UCI HAR Dataset"){ #Path to UCI HAR Dataset folder
        library(plyr)
        setwd(wd)
        
        activity <- read.table("activity_labels.txt")
        features <- read.table("features.txt")
        setwd("test")
        xtest <- read.table("X_test.txt")
        ytest <- read.table("y_test.txt")
        subject_test <- read.table("subject_test.txt")
        
        setwd(wd)
        setwd("train")
        xtrain <- read.table("X_train.txt")
        ytrain <- read.table("y_train.txt")
        subject_train <- read.table("subject_train.txt")
       
        xbinding <- rbind(xtrain,xtest) #to bind the two X datasets
        ybinding <- rbind(ytrain,ytest) #to bind the two Y datasets
        ybinding[, 1] <- activity[ybinding[, 1], 2]
        subjectbinding <- rbind(subject_train,subject_test) #to bind the two subject datasets
        
        xbinding <- setNames(xbinding,features$V2) #to assign the labels to xtrain data
        ybinding <- setNames(ybinding,"Activity") #to assign the labels to ytrain data
        subjectbinding <- setNames(subjectbinding,"Subject") #to assign the labels to subject data
        
        fullout_binding <- cbind(xbinding,subjectbinding,ybinding)
        wrap <- ddply(fullout_binding,.(Subject,Activity),function(x) colMeans(x[,1:561]))
        
        setwd(wd)
        write.table(wrap, "mean_by_subject&activity.txt")
}