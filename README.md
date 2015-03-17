# TidyDataAssignment
Codes and results of the tidy data assignment for JHU Getting and Cleaning Data


##Getting Started

The code is dependant on two distinct externalities: 
the plyr package and the actual data. First make sure that you have installed the package, 
if not use the following code: `install.packages("plyr")`.
Next, download the dataset and save it to a local folder which will be later used to run the codes.
I highly recommend that you fork this repository and that you work from that folder (download the data and run the code).

The data are available online and come as a zipped folder, which should priorly be unzipped before running the code.
* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ">UCI HAR Dataset</a> [62Mb]

It is also naively assumed that you have installed R. If not, it may be a good place to start.


##Making it work

* Once downloaded, unzip the file to your desired location. As previously mentioned, it is recommended to unzip it to the forked repository.

* Set the working directory to the local folder where you saved both the data and the code.
Once this is done, simply load the code using the `install.packages("run_analysis.R")` function.

* The function takes a single argument, `wd`, the string of the path to the local directory which will be set as working directory.
Since the default argument is “UCI HAR Dataset”, if the the run_analysis.R code is saved alongside the unzipped folder, it should all run smoothly.
Otherwise, you can always specify the main folder location containing the data.

* The computed results will be saved in the same folder that was specified by the argument `wd`.


##Understanding the results

The resulting data is, for every subject in the dataset, is summarized by activity. The mean for the “mean” and “std” labeled column is then averaged.