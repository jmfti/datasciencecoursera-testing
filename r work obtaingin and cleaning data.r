
## course project for cleaning data

#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.

library(dplyr)


activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
# make union of x_test and x_train data sets
xtrain <- rbind(xtrain, xtest)
# make sure that last rows of xtrain and xtest are equal
print(all(xtrain[nrow(xtrain),] == xtest[nrow(xtest),]) )

# let's name xtrain columns 
names(xtrain) <- features[,2]
# let's get only the columns we need for our purposes : mean and standard deviation
fl <- names(xtrain)[grep("(mean|std)[(][)]", names(xtrain))]
# now we make our subset with just the columns we need
xtrain <- xtrain[,fl]

# now let's read activities and subjects for both test and train and merge them
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
ytrain <- rbind(ytrain, ytest)

subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectsy <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjects <- rbind(subjects, subjectsy)


# now let's join subjects and activities and add to our data set
xtrain$activity <- left_join(ytrain, activities, by.x=V1, by.y=V1)[,2]
# now subjects
xtrain$subject <- subjects$V1

# now we have our full data set stored in xtrain
# and we have to get a new data set with the average of each variable
# for each activity and each subject
# we will use dplyr group_by and summarize to get this data

# to get all the column means grouped by activity and subject we will use summarise_each
newtidy <- xtrain %>% group_by(activity,subject) %>% summarise_each(funs(mean))

write.csv(newtidy, file="./data/tidydata.csv")
