# courseraJhuGettingCleaningData
## Coursera Johns Hopkins Data Science Class, Programming Assignment Week 4 of "Data Gathering and Cleaning"

This is a multistep analysis of downloaded Samsung activity monitor training + test data collected for 30 test subjects. The labeled activity data contains a training and a test set for body sensors worn by the test subjects, with multiple measurements from each sensor. The test data is part of this repository as well, stored in the folder "UCI HAR Dataset".

The run_analysis() function performs the entire analysis, in three stages:

## Data retrieval:

1. Retrieves the string representations of different activities that the subjects are engaged in (activity labels)
2. Reads the downloaded training data into a data frame trainingData
3. Reads numeric labels for the training data into a data frame trainingActivityLabels (i.e., what was the activity for each sample in the training data)
4. Relabels the training data labels using the string representations of activities gathered in Step 1
5. Reads the (numeric) subject identifiers for all activities in the training data into data frame trainingSubjects
6. Reads the downloaded test data into a data frame testData
7. Reads numeric labels for the tst data into a data frame testActivityLabels (i.e., what was the activity for each sample in the test data)
8. Relabels the test data labels using the string representations of activities gathered in Step 1
9. Reads the (numeric) subject identifiers for all activities in the test data into data frame testSubjects
10. Reads string variable names for the two data sets above (= human-readable column names) into a data frame variables

## Data reshaping:

1. Adds columns "subject" and "activity_label" to the left and right of the training data frame, using the subjects and activity labels gathered in Steps 4 and 5
2. Drops all variables from trainingData that are not "means" or "standard deviations"
3. Adds columns "subject" and "activity_label" to the left and right of the test data frame, using the subjects and activity labels gathered in Steps 8 and 9
4. Drops all variables from testData that are not "means" or "standard deviations"
5. Merges trainingData and testData row-wise resulting in a combined data frame

## Data summarization

1. Groups the combined data frame by subject and activity_label
2. Summarizes the combined data frame using the "mean" function to compute the average for each mean/std measurement,
   resulting in one row per subject + activity_label combination. This is the return value of the run_analysis() function.
