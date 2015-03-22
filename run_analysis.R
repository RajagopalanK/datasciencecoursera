#--------------------------------------------------------------------------
#
#      R Program to read the smartphone data and create a tidy data set
#
#--------------------------------------------------------------------------

#   Set the working directory
setwd("C:/r/data/UCI/Dataset")
getwd()

#--------------------------------------------------------
# 1. Read Test & Training data set, and Merging the data set
#--------------------------------------------------------
x_test=read.table("./test/X_test.txt",header=FALSE, fill=TRUE)
nrow(x_test)  ## 2947 rows
ncol(x_test)  ## 561 columns

y_test=read.table("./test/y_test.txt",header=FALSE,sep=" ",fill=TRUE)
nrow(y_test)  ## 2947 rows
ncol(y_test)  ## 1 column

test_subj = read.table("./test/subject_test.txt",header=FALSE,sep=" ")
nrow(test_subj) ##2947 rows
ncol(test_subj) ## 1 column

test_data = cbind(test_subj,y_test,x_test)
ncol(test_data)

x_train=read.table("./train/X_train.txt",header=FALSE,fill=TRUE)
nrow(x_train) #7352 rows
ncol(x_train)  ## 561 columns

y_train=read.table("./train/y_train.txt",header=FALSE,sep=" ",fill=TRUE)
nrow(y_train)  ##7352 rows
ncol(y_train)  ##1 col

train_subj=read.table("./train/subject_train.txt",header=FALSE,sep=" ")
nrow(train_subj) ##7352 rows
ncol(train_subj) ## 1 column


train_data = cbind(train_subj,y_train, x_train)
ncol(train_data)


# Merge dataset

merge_data = rbind(test_data,train_data)
nrow(merge_data) #10299
ncol(merge_data) #563
View(head(merge_data))
unique(merge_data$V1) # 1 to 30

# Add Header

Features_Data=read.table("features.txt",header=FALSE,sep=" ")
View(Features_Data)

Features_Data$V2 = as.character(Features_Data$V2)

colnames(merge_data)= c("Subject","Activity_Label",Features_Data$V2)
View(colnames(merge_data))
ncol(merge_data)
nrow(merge_data)
View(head(merge_data))

(mean_vector = grep("mean()",colnames(merge_data)))
(std_vector = grep("std()",colnames(merge_data)))
  

# Add Activity Label

activity_label = read.table("activity_labels.txt",header=FALSE,sep=" ")
activity_label = as.matrix(activity_label)
View(activity_label)
ncol(activity_label)
colnames(activity_label)

for(i in 1:nrow(merge_data))
{
  for (j in 1:nrow(activity_label))
  {
    if(merge_data[i,2] == activity_label[j,1])
    {            
      merge_data[i,2]=activity_label[j,2]
    }
  }
}

View(head(merge_data))

#--------------------------------------------------------------------------------------
# 2. Mean & Std dev measurement
#--------------------------------------------------------------------------------------

(mean_vector = grep("mean()",colnames(merge_data)))
(std_vector = grep("std()",colnames(merge_data)))
length(mean_vector)  ## 46 mean columns
length(std_vector)  ## 33 std dev columns

  
  
mean_dataset=merge_data[,mean_vector]

View(head(mean_dataset))      
nrow(mean_dataset)  #10299 measurements
ncol(mean_dataset)  #46 mean variables

std_dataset=merge_data[,std_vector]
View(head(std_dataset))      
nrow(std_dataset)  #10299 measurements
ncol(std_dataset)  #33 std variables

#--------------------------------------------------------------------------------------
# 3. create tidy dataset
#--------------------------------------------------------------------------------------

tidy_dataset=cbind(merge_data$Subject,merge_data$Activity_Label,mean_dataset,std_dataset)
nrow(tidy_dataset)
ncol(tidy_dataset)
View(head(tidy_dataset))
colnames(tidy_dataset)[1] = "Subject"
colnames(tidy_dataset)[2] = "Activity"


library("plyr")
library("data.table")
td=data.frame(tidy_dataset)
View(head(td))

tidy_set=aggregate(.~Subject + Activity, data=td,FUN="mean", na.rm=TRUE)
nrow(tidy_set)
View(tidy_set)


#--------------------------------------------------------------------------------------
# 4. create tidy dataset
#--------------------------------------------------------------------------------------
write.table(tidy_set, "C:/r/tidy_data.txt", row.names=FALSE)
tidydata=read.table("c:/r/tidy_data.txt",header=TRUE,sep= " ")
View(tidydata)