## Readme

This project involved summarizing data from the Human Activity Recognition Using 
Smartphones Dataset.  The goal was to produce a tidy data set containing summary 
data (mean and standard deviation) for only those measurements which are means and
standard deviations of other measurements.

This analysis was conducted with the script run_analysis.R, whose function is described 
below:

Note:  The script requires the working directory ("./" ) to be a copy of the UCI HAR Dataset    
       directory downloaded from the Internet.  In particular, it requires sub-directories 
       train and test.
	
1.  The script reads in ./train/X_train.txt and ./test/X_test.txt, and combines them into a measurements data frame called 'dmeas'

2.  It the reads in features.txt and assigns those names to the column names of 'dmeas'.

3.  It extracts 'only the measurements on the mean and standard deviation for each measurement' from 'dmeas'.  This instruction was interpreted as only columns containing the patterns "-mean()" or "-std()".  Further discussion of this decision may be found in the codebook.
    	
5.  It reads and combines ./test/subject_test.txt and ./train/subject_train.txt into a subject member data frame 'dsub'.

6.  It reads and combines ./test/Y_test.txt and ./train/Y_train.txt into an activity number data frame 'dy'.  Then reads ./activity_tables.txt into the data frame 'actLab'.  It then performs a join on 'dy' and 'actLab' so that 'dy' has an activity column which maps  correctly to activity number.

7.  It combines 'dmeas', 'dsub' and the activity column of 'dy' into the final working data frame, 'df'.
	
8.  It attempts to give the measurement variables better names. A discussion of this is in codebook.md, but there were two main thrusts of these changes:
	
	a.  Removed the "()" from "_mean()" and  "_std()" 
		
	b.  Attempted to make variable names more 'self-describing'. 
		
9.  Calculates mean and standard deviation of the extracted measurements grouped by subject number, activity and measurement name.
	
10. Outputs a tidy data set to a file named "./projOutData.txt".  My version of tidy was narrow and tall.  Per the discussion in reference 3, I intepreted the measurements as a set of measurement variables.  A graphical example of this interpretation is table 3 of reference 2.  Thus I have a result data frame whose dimensions are 11,880x5.  The 5 colums are: subjectNumber, activity, measurement, mean and sd, with measurement containing the 66 mean and standard deviation features I extracted from the original data set.  Each mean and standard deviation observation is defined by the subjectNumber, activity, measurement tuple.

References:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012

[2]  http://vita.had.co.nz/papers/tidy-data.pdf

[3]  https://class.coursera.org/getdata-007/forum/thread?thread_id=214
