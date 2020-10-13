#Merges the datasets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
mergeddata <- cbind(Subject, Y, X)
#Get only the measurements on the mean & SD 
tidydata <- mergeddata %>% select(subject, code, contains("mean"), contains("std"))
#name the activities
tidydata$code <- activities[tidydata$code, 2]
#labels the dataset
names(tidydata)[2] = "activity"
names(tidydata)<-gsub("Acc", "Accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata)<-gsub("BodyBody", "Body", names(tidydata))
names(tidydata)<-gsub("Mag", "Magnitude", names(tidydata))
names(tidydata)<-gsub("^t", "Time", names(tidydata))
names(tidydata)<-gsub("^f", "Frequency", names(tidydata))
names(tidydata)<-gsub("tBody", "TimeBody", names(tidydata))
names(tidydata)<-gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-std()", "STD", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("angle", "Angle", names(tidydata))
names(tidydata)<-gsub("gravity", "Gravity", names(tidydata))
#create a independent tidy dataset with the average of each variable for each activity and subject.
finaldata <- tidydata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(finaldata, "finaldata.txt", row.name=FALSE)