##CodeBook

###This is a markdown file

1.After downloading the data file and unzip the file,  for train and test data set, I first combined the data sets which contain the subject, the labels and the actual data; then train and test data sets were loaded into R and merge them into one data set.

2. Then per the requirement, only the measurements that are based on the mean and standard deviation for each measurement were extracted. in order to do this, we load the data set “features.txt” which contains the formulas to calculate each feature measurement. 


3. In order to use descriptive activity names to name the activities in the set, I first loaded “activity_labels.txt” file and then replaced the activity code in our data with the actual activity name accordingly.
4. To appropriately label the data set with descriptive variable names, we I utilized formulas that can edit text variables to make the variable names more readable. For example, I spelled out ‘time”, “frequency”, “mean”, “standard deviation” in the variable names using gsub() formula.

5. In the last step, in order to create a tidy data set with the average of each variable for each activity and each subject, we use formulas from the “dplyr” package to first group the data set by subject and activity and then summarize it.

6. The final data set is created by write.table() formula and saved as a “txt” file.