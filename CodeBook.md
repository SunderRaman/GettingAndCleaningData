The script run_analysis.R performs the 5 steps described of the "Getting And Cleaning Data" course's project definition as follow.

1. Download and unzips the file to the current working directory
2. Read the Training ,Testing Tables, Features and Activity labels
3. Assign appropriate column names 
4. column binding of Training and Testing tables
5. Merge the data using row bind 
6. Create a Vector with ActivityId, SubjectID, all columns with Mean and all columns with std
7. Create a subset for Maan And Standard Deviation
8. Merge the data with Activity Labels
9. Generate a tidySet of data for each variable, activity and Subject
10. Order the tidySet based on subjectId and ActivityID

Variables Used:

1. x_training, y_training, x_testing, y_testing, subject_training and subject_testing contain the data from the downloaded files.
2. features and activityLabels contain the feature set and labels for various activities
3. mrg_training, mrg_testing merge the training and testing data respectively for further data analysis.
4. fullMergeData merges the merged Training and Testing data as a row bind 
4. colNames contains the list of columnNames
5. meanAndStdDev is a vector used to extract the desired data.
6. setForMeanAndStdDev  is a subset of the fullMergeData, where the meanAndStdDev is true
7. setWithActivityNames  is a subset wich merges the activityLabels with setForMeanAndStdDev
8. tidySet  is a set which aggregaates the data based on subject and activityID
9. tidySet.txt is the file, which is written based on data from tidySet
