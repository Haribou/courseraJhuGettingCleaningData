# 
# Multistep analysis of downloaded Samsung activity monitor training + test data collected for 30 test subjects:
# 
# Data retrieval:
# 1. Retrieves the string representations of different activities that the subjects are engaged in (activity labels)
#
# 2. Reads the downloaded training data into a data frame trainingData
# 3. Reads numeric labels for the training data into a data frame trainingActivityLabels (i.e., what was the activity for each sample 
#    in the training data)
# 4. Relabels the training data labels using the string representations of activities gathered in Step 1
# 5. Reads the (numeric) subject identifiers for all activities in the training data into data frame trainingSubjects
#
# 6. Reads the downloaded test data into a data frame testData
# 7. Reads numeric labels for the tst data into a data frame testActivityLabels (i.e., what was the activity for each sample 
#    in the test data)
# 8. Relabels the test data labels using the string representations of activities gathered in Step 1
# 9. Reads the (numeric) subject identifiers for all activities in the test data into data frame testSubjects
#
# 10. Reads string variable names for the two data sets above (= human-readable column names) into a data frame variables
#
# Data reshaping:
# 
# 1. Adds columns "subject" and "activity_label" to the left and right of the training data frame, using the subjects and
#    activity labels gathered in Steps 4 and 5
# 2. Drops all variables from trainingData that are not "means" or "standard deviations"
# 3. Adds columns "subject" and "activity_label" to the left and right of the test data frame, using the subjects and
#    activity labels gathered in Steps 8 and 9
# 4. Drops all variables from testData that are not "means" or "standard deviations"
# 5. Merges trainingData and testData row-wise resulting in a combined data frame
#
# Data summarization
#
# 1. Groups the combined data frame by subject and activity_label
# 2. Summarizes the combined data frame using the "mean" function to compute the average for each mean/std measurement,
#    resulting in one row per subject + activity_label combination. This is the return value of the run_analysis() function.


run_analysis <- function()
{
  library(dplyr)
  
  activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt', header = F, sep = '')
  
  # Retrieve training data as data frames:
  trainingData <- read.table('UCI HAR Dataset/train/X_train.txt', header = F, sep = '', colClasses = 'numeric')
  trainingActivityLabels <- read.table('UCI HAR Dataset/train/y_train.txt', header = F, sep = '', colClasses = 'numeric')
  # Relabel the numeric activity labels with the string labels provided in activity_labels.txt:
  trainingActivityLabels <- factor(trainingActivityLabels[, 1], levels = 1:6, labels = activityLabels[, 2])
  trainingSubjects <- read.table('UCI HAR Dataset/train/subject_train.txt', header = F, sep = '')
  
  # Retrieve test data as data frames:
  testData <- read.table('UCI HAR Dataset/test/x_test.txt', header = F, sep = '', colClasses = 'numeric')
  testActivityLabels <- read.table('UCI HAR Dataset/test/y_test.txt', header = F, sep = '')
  # Relabel the numeric activity labels with the string labels provided in activity_labels.txt:
  testActivityLabels <- factor(testActivityLabels[, 1], levels = 1:6, labels = activityLabels[, 2])
  testSubjects <- read.table('UCI HAR Dataset/test/subject_test.txt', header = F, sep = '')
  
  variables <- read.table('UCI HAR Dataset/features.txt', header = F, sep = '')
  
  # Add new columns to the trainingData data frame: (1) subject identifiers, (2) activity labels:
  trainingData <- cbind(trainingSubjects, trainingData, trainingActivityLabels)
  names(trainingData) <- c('subject', variables[, 2], 'activity_label')
  # Drop all measurement variables that do not contain 'mean' or 'std':
  trainingData <- select(trainingData, matches('^subject$|mean|std|^activity_label$'))
  
  # Add new columns to the testData data frame: (1) subject identifiers, (2) activity labels:
  testData <- cbind(testSubjects, testData, testActivityLabels) 
  # Replace testData data frame column names with variables:
  names(testData) <- c('subject', variables[, 2], 'activity_label')
  # Drop all measurement variables that do not contain 'mean' or 'std':
  testData <- select(testData, matches('^subject$|mean|std|^activity_label$'))
  
  # Merge the trainingData and testData data frames:
  # combined <- merge(trainingData, testData, by = 'subject', suffixes = c('_train', '_test'), all = T)
  combined <- rbind(trainingData, testData)
  
  # Compute the average of all mean/std variables grouped by subject and activity_level:
  combined <- group_by(combined, subject, activity_label)
  summarize_all(combined, mean, rm.na = T)
}