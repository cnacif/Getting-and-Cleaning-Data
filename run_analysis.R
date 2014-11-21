########################################################################
## Claudio Nacif - Course Projetc - Coursera Getting and Cleaning Data #
########################################################################
## The files needed are in: C:\Users\Cnacif\Documents\DataSet (working directory)

## begin Part_1: Merges the training and the test sets to create one data set.

# training
x_train <- read.table("./DataSet/train/X_train.txt")
str(x_train) # Contain 7352 observations and 561 variables
y_train <- read.table("./DataSet/train/y_train.txt")
str(y_train) # Contain 7352 observations and 1 variable
subject_train <- read.table("./DataSet/train/subject_train.txt")
str(subject_train) # Contain 7352 observations and 1 variable

# test
x_test <- read.table("./DataSet/test/X_test.txt")
str(x_test) # Contain 2947 observations and 561 variables
y_test <- read.table("./DataSet/test/y_test.txt") 
str(y_test) # # Contain 2947 observations and 1 variable
subject_test <- read.table("./DataSet/test/subject_test.txt")
str(subject_test) # Contain 2947 observations and 1 variable

# join all together
all_x_train_test <- rbind(x_train, x_test)
str(all_x_train_test)  # Now Contain 10299 observations and 561 variables
all_y_train_test <- rbind(y_train, y_test)
str(all_y_train_test) #  Now Contain 10299 observations and 1 variable
all_subject_train_test <- rbind(subject_train, subject_test)
str(all_subject_train_test) #  Now Contain 10299 observations and 1 variable

#end of part_1
######################################################################


## begin Part_2: Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("./DataSet/features.txt")
str(features)  # Contain 2947 observations and 1 variable

meanStd_features <- grep("mean\\(\\)|std\\(\\)", features[, 2])
all_x_train_test <- all_x_train_test[, meanStd_features]

# remove some special carachaters
names(all_x_train_test) <- gsub("\\(\\)", "", features[meanStd_features, 2])
names(all_x_train_test) <- gsub("-", "", names(all_x_train_test))

#end of part_2
######################################################################





## begin Part_3: Uses descriptive activity names to name the activities in the data set
activity <- read.table("./DataSet/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[all_x_train_test[, 1], 2]
all_x_train_test[, 1] <- activityLabel
names(all_x_train_test) <- "activity"

#end of part_3
######################################################################


## begin Part_4: Appropriately labels the data set with descriptive activity names.

names(all_subject_train_test) <- "subject"
cleanedData <- cbind(all_subject_train_test, all_y_train_test, all_x_train_test)
dim(cleanedData) # 10299*68
write.table(cleanedData, "merged_data.txt") # write out the 1st dataset

#end of part_4
######################################################################

## begin Part_5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(all_subject_train_test)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(all_subject_train_test)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
head(result)
write.table(result, "data_means.txt")



#end of part_5
######################################################################
