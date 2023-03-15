# Code Book for Programming Assignment

## Data

The data used in this project is contained in the "UCI HAR Dataset". It contains *labeled* training and test sets from body sensors worn by 30 test subjects. Each sensor reports three-dimensional numeric measurements (i.e., 3 measurements per sensor). The data set labels are string representations of activities that the test subjects were engaged in while the measurements were recorded. The string labels, variables, training data set, test data set used in the data analysis are in the files/folders
- UCI HAR Dataset/activity_labels.txt
- UCI HAR Dataset/features.txt
- UCI HAR Dataset/train
- UCI HAR Dataset/test
respectively.

The tabular data produced by the analysis when executing *run_analysis()* is in the file *activitiesDataAnalysis.txt* in this repository.

## Variables

The tabular data in *activitiesDataAnalysis.txt* contains the following variables:
- subject: the numeric identifier of the 30 test subjects
- activity_level: the string representation of an activity of the test subject (possible values are in the file *UCI HAR Dataset/activity_labels.txt*: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
- for each of the 86 variables in the original training/test data sets, as described in *UCI HAR Dataset/features.txt* whose name contains a "mean" or "std", the output data set in *activitiesDataAnalysis.txt* contains a variable by the same name. This means that each variable in the *activitiesDataAnalysis.txt* that is not the subject or activity_level represents a measurement of one of the body sensors worn by the test subjects. Specifically, each measurement in the output data set represents one of the three spacial dimensions X, Y, and Z.

## Transformations
