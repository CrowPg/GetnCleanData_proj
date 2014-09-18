library(data.table)
library(plyr)
library(xtable)
library(reshape2)
library(tidyr)
library(dplyr)

#This sript assumes you run it in a directory that is a copy
#of the UCI HAR Dataset directory downladed from the web.
#In particular, it assumes sub-directories train and test.

#Steps 1, 2 and 3
#variable measures
xtest <- read.table("./test/X_test.txt", sep = "", header = FALSE)
xtrn  <- read.table("./train/X_train.txt", sep = "", header = FALSE)
dmeas = rbind(xtest, xtrn)

#feature names
ft <- read.table("./features.txt", sep = "", header = FALSE)
colnames(dmeas) = as.character(ft$V2)

#Extract all mean and std dev measurments, that is columns ending in -mean(), -std():
#explicit measures of mean and std.  Excludes '...-meanFreq()' variables.
newCol = grep("-mean\\(\\)|-std\\(\\)", colnames(dmeas), value=TRUE)
extrData = data.table(dmeas[,colnames(dmeas) %in% newCol])

#subject numbers
stest <- read.table("./test/subject_test.txt", sep = "", header = FALSE)
strn  <- read.table("./train/subject_train.txt", sep = "", header = FALSE)
dsub = rbind(stest, strn)
setnames(dsub, "V1", "subjectNumber")

#act numbers
ytest <- read.table("./test/Y_test.txt", sep = "", header = FALSE)
ytrn  <- read.table("./train/Y_train.txt", sep = "", header = FALSE)
dy = rbind(ytest, ytrn)
setnames(dy, "V1", "actNum")
#map activity numbers to descriptions
actLab <- read.table("./activity_labels.txt", sep = "", header = FALSE)
setnames(actLab, "V1", "actNum")
setnames(actLab, "V2", "activity")
dy2 <- join(dy, actLab, by = "actNum")

#combine; only activity not numbers (redundant)
sa = cbind( dsub, dy2$activity)
setnames( sa, "dy2$activity", "activity")
#final extracted data set
df = cbind( extrData, sa)

#give (more) desriptive names to the variables 
oldNames = colnames(df)
newNames = gsub( "\\(\\)","",oldNames)
newNames = gsub("Mag", "Magnitude", newNames)
#Body is redundant, only serves to seperate linear vs. gravitaional acceleration
newNames = gsub("-X", "-X_axis", newNames)
newNames = gsub("-Y", "-Y_axis", newNames)
newNames = gsub("-Z", "-Z_axis", newNames)
newNames = gsub("BodyAccJerk",   "LinearJerk", newNames)
newNames = gsub("BodyAcc",       "LinearAcceleration", newNames)
newNames = gsub("BodyGyroJerk",  "AngularJerk", newNames)
newNames = gsub("BodyGyro",      "AngularVelocity", newNames)
newNames = gsub("GravityAcc",    "GravitationalAcceleration", newNames)
setnames(df, oldNames, newNames)
#to check
#foo = cbind( oldNames, newNames)
#write.table( foo, "./nameChk.csv", sep=",")

#Part 5: Calc mean and std of the variables grouped by subject and activity
summdf<-df %>%
      melt( id.vars=c("subjectNumber", "activity")) %>%
      group_by( subjectNumber, activity, variable) %>%
      summarize( mean=mean(value), sd=sd(value)) 
#summdf is tidy: every row is an observation, every column a variable...
#further discussion in readme and/or codebook
setnames(summdf, "variable", "measurement")
write.table( summdf, "./projOutData.txt", row.name = FALSE)



