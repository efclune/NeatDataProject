loadWalkData<-function()
{
  #### Required
  # library(dplyr) which requires library(lazyeval)
  # library(plyr)
  # works from your working directory and assumes the data files are in 
  # subfolder data
  
  #### Read files

	#1) Read variable name file: features.txt
  tempNames<-read.table("data/features.txt")
  varNames<-tempNames[,2]
  
	#2) Read train data: train/x_train.txt
	trainData<-read.table("data/train/x_train.txt",col.names=varNames)	

	#3) Read test data: test/x_test.txt
	testData<- read.table("data/test/x_test.txt",col.names=varNames)	

	#4) Read train activities: train/y_train.txt
  trainActiv<-read.table("data/train/y_train.txt")
  
	#5) Read test activities: test/y_test.txt
  testActiv<- read.table("data/test/y_test.txt")

	#6) Read train subjects: train/subject_train.txt
  trainSubject<-read.table("data/train/subject_train.txt")

	#7) Read test subjects: test/subject_test.txt
  testSubject <-read.table("data/test/subject_test.txt")

	#8) Read activity labels: activity_labels.txt
  activityTab<-read.table("data/activity_labels.txt")
  activityVec<-activityTab[,2]

#### Combine files

  #9) Add subjects to train data
  #10) Add activities to train data
  trainData<-cbind(Subject=trainSubject,Activity=trainActiv,trainData)
  #I don't understand cbind well enough to add the new columns with the
  #correct column names so I added them after the fact
  colnames(trainData)[1]<-"Subject"
  colnames(trainData)[2]<-"Activity"

  #11) Add subjects to test data
  #12) Add activities to test data
  testData<-cbind(Subject=testSubject,Activity=testActiv,testData)
  #same issue as above
  colnames(testData)[1]<-"Subject"
  colnames(testData)[2]<-"Activity"

	#13) Merge train & test data
  totalData<-rbind(trainData,testData)

  #Attempted minor fix to one column name (error in feature.txt feature name)
  #Does not really change anything other than that column name
  #Doesn't work yet; "." chars in the column name mess things up
  #totalData<-rename(totalData,angle(tBodyAccJerkMean,gravityMean)=
  #                            angle(tBodyAccJerkMean),gravityMean))

	#14) Convert Activity values from numbers to names usinging information
  #from the activity_lables.txt file
  totalData<-mutate(totalData,Activity=activityVec[totalData$Activity])

#### Final steps

	#15) Pull out mean(), std(), Activity and Subject columns
  #Although "mean" shows up in other parts of the column names, I interpretted
  #the assignment to be after only columns where mean() and std() appeared in
  #the name.  Also, note that "()" were actually read in as ".." from the column
  #name file, but can still be uniquely identified
  #Create a vector of the column names.  Match each element against four
  #possible substring matches and save to a binary vectory.
  #Use simple column operation to create a new table with just the required cols.
  neatCol<-colnames(totalData)
  neatColMatch<-grepl("Subject|Activity|mean\\.\\.|std\\.\\.", neatCol)
  totalData2<-totalData[,neatColMatch]

	#16) Generate table of mean over activity and subject
  #Listing the two dimensions to make the final table was directly from my
  #lecture notes, but kept running into issues on how to generate mean for all
  #columns.  All examples I understood required an explicit list of fields
  #and operations.  Then I ran into a the keyword numcolwise which simplied
  #everything.
  #found on stackoverflow.com - http://stackoverflow.com/questions/10787640/
  #ddply-summarize-for-repeating-same-statistical-function-across-large-number-of
  totalData3<-ddply(totalData2,.(Subject,Activity), numcolwise(mean))

	#17) Write out data with column headings but no row names
  write.table(totalData3,"data/NeatDataEFC.txt",row.name=FALSE)

  #18) Write out the final column headings - convenient for codebook
  finalCol<-colnames(totalData3)
  write.table(finalCol,"data/NeatDataEFCVars.txt")

  #Return final data for user to review
  totalData3
}