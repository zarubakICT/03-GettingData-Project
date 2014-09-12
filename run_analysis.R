### 03. Getting data (Sep 2, 2014)
### course project
### KZaruba

# all necessary input files at the same directory

# read data
data.train <- read.table("./project/X_train.txt")
data.test <- read.table("./project/X_test.txt")

# put subjects as the first and activities as the second column
subject.train <- read.table("./project/subject_train.txt")
subject.test <- read.table("./project/subject_test.txt")

activity.train <- read.table("./project/y_train.txt")
activity.test <- read.table("./project/y_test.txt")

data.train <- cbind(subject.train,activity.train,data.train)
data.test <- cbind(subject.test,activity.test,data.test)

# merge both data sets
data <- rbind(data.train,data.test)

# get feature names from the file
col_lab <- read.table("./project/features.txt")
col_lab <- col_lab[,2]
col_lab <- as.character(col_lab)
col_lab <- c("subject","activity",col_lab)  # add two new labels

# set the feature names as column names of the data set
colnames(data) <- col_lab

# subset columns mean and std (i.e. columns including "mean()", "std()", )
nm <- names(data)
m <- grep("mean\\(", nm)
s <- grep("std\\(", nm)
x <- sort(c(1,2,m,s))   # numbers of columns to subset plus 1st column

data_sub <- subset(data, , x)

# melting data and calculating of means with factors activity and subject
library(reshape2)
data_sub_mel <- melt(data_sub,id=c("subject","activity"))
dc <- dcast(data_sub_mel,activity+subject~variable,mean)

# put activity labels instead of numbers
ac_lab <- read.table("./project/activity_labels.txt")
final <- dc
for (i in 1:dim(final)[1]) final[i,1]<-as.character(ac_lab[final[i,1],2])

# save the final on a disc
write.table(final, "project-result.txt",row.name=FALSE)

