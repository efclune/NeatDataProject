# NeatDataProject
Final Project for Getting and Cleaning Data Course

The files you are receiving include an R file named run_analysis.R
which includes a function to read some supplied data and condense it
into a tidy data set for later use.  Following the instructions below
will produce an output file with 68 columns and 180 rows.  You can
look at this file as described below or generate it yourself

Prereqs:
1) Set up your working directory
2) download the data file as specified in the assignment
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

3) unzip the files/folders into a directory named data under your working directory
	Note: do NOT set your working directory into the data directory
4) In rstudio you need to install the following packages(in this order):
	a) plyr
	b) lazyeval
	b) dplyr
5) Load run_analysis.R into your environment
6) Run the function (into a variable) tempdata<-loadWalkData()
	Note: There are no parameters and it takes a while; let it run
	Although the results are written out, they also are returned to caller
7) Output is
	a) NeatDataEFC.txt - the condensed data
	b) NeadDataEFCVars.txt - list of the column names - not really used
8) You can read the data output file with the function
	tempdata<-read.table("data/NeatDataEFC.txt",heade r=TRUE)
	Although reduced, there are still many columns (68) and rows (180)

One final note on the number of columns, which the code goes into more specifically.
The final selected columns (ignoring Subject and Activity, were supposed to include
all variables with mean and std in the name.  Although mean appeared in several places
in several variable names, looking at the operations required and the description of
parameters, I took only those variable that had, in the original name "mean()" or "std()",
meaning that the variable stored a mean() or std() function result.  Although the discussion
boards have mentioned other numbers for the final set of columns (80 or 81), by my definition
I believe the number of columns that I ended up with (68) is correct.



