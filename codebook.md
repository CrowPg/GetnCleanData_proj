##Codebook

###Background

Summary (mean and standard deviation ) data was compiled from the Human Activity Recognition Using Smartphones Dataset. This data set comprises measurements derived from raw accelerometer and gyroscope signals received from a Samsung smart phone worn while 30 volunteers performed a series of six activities: walking, walking upstairs, walking downstairs, sitting, standing
and laying.

To avoid repetition, please see the file features_info.txt in the UCI HAR Dataset directory for
information on the transformations that were conducted on the raw signals.  The dataset is
available for download here: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/.

**One important note is that since all variables in this data set were normalized, they are
all unitless**.

###Data

Note that in what follows, a reference to the current/working directory "./" assumes that 
directory is a copy of UCI HAR Dataset directory.  In particular it assumes existence of
the train and test sub directories.

Three data frames was formed by binding together input from the following files in the UCI dataset: 

1. 'dmeas': ./train/X_train.txt and ./test/X_test.txt ( the measurements) 
2. 'dy':    ./train/Y_train.txt and ./test/Y_test.txt (the activity numbers) 
3. 'dsub':  ./train/sujbect_train.txt and ./test/subject_test.txt (the subject numbers) 

Additionally, ./features.txt (the variable names) was read in and its values assigned to
the column names of 'dmeas' and ./features_info.txt was read into the data frame 'actLab',
to allow an activity number to activity mapping.

Before the combination of the feature names and their measurements with the activity and subject number three adjustments were made.

1. From the measurements data frame, a data frame was extracted containing 'only the    measurements on the mean and standard deviation for each measurement'.  I interpreted this as column names containing only one of the following patterns:  "-mean()", "-std()". I took those patterns to indicate an explicit summary measurement on other measurements, as opposed to a measurement itself.  I excluded variables which contained the pattern          "-meanFreq()".  The lack of any variable names containing the pattern "-Freq" or the pattern "-stdFreq()" led me to believe that the "-meanFreq()" variables were measurements   themselves, and not summary calculations based on other measurements.
   
2. Activity numbers were mapped to activity.

3. The feature names from features.txt were replaced with (hopefully) better names.
   The changes were:
   
     A. removed "()" from the variable names. , which would have made subsequent
        variable access very difficult due to R interpreting the "()" as a function call.
      
     B. Made the variables more 'self describing'.  Thus '-X' became '-X_axis',  and
        'Mag' became 'Magnitude'.  Because 'Body' only served to differentiate 
        acceleration of the body from acceleration due to gravity,  I replaced 'Body' with
        'Linear'.  Likewise, I felt 'BodyGyro' was redundant and replaced with 'Angular', since 
        the measurements from the gyroscope were angular velocities.  One point to keep in mind is that both 'Body' and 'Gravity' accelerations are linear.
      
After these adjustments a final working data frame was constructed consisting of the 
measurements, the subject numbers and the activities.  The measurements column contained 66 
unique variables culled from the original data set.  The table below defines them in terms of their constituent parts.  For example, 'fBodyAccJerk-mean()-X' (original variable name), has four parts: 'f', 'BodyAccJerk', '-mean()' and  '-X'.  For ease of comparison I list both the original form of the part, e.g. '-X', the new form of the part '-X_axis' and a definition, regardless of how obvious the variable name may seem.

<table>
 <thead>
  <tr>
   <th align="left"> Type </th>
   <th align="left"> Orignal File(s) </th>
   <th align="left"> New File </th>
   <th align="left"> Definition </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td align="left"> Prefixes/Suffixes </td>
   <td align="left"> -X, -Y, -Z </td>
   <td align="left"> -X_axis, -Y_axis, -Z_axis </td>
   <td align="left"> what axis the measurement was along </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> t,f </td>
   <td align="left"> t,f </td>
   <td align="left"> indicates whether derived measurement is in time or frequency domain, respectively  </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> Mag </td>
   <td align="left"> Magnitude </td>
   <td align="left"> (directionless) Euclidean norm of measurement </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> mean(), std() </td>
   <td align="left"> mean,std </td>
   <td align="left"> mean and standard deviation, respectively of the measurement </td>
  </tr>
  <tr>
   <td align="left"> Core Variable Names </td>
   <td align="left"> activity </td>
   <td align="left"> activity </td>
   <td align="left"> what was performed, e.g. sitting </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> BodyAcc </td>
   <td align="left"> LinearAcceleration </td>
   <td align="left"> linear acceleration </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> BodyAccJerk </td>
   <td align="left"> LinearJerk </td>
   <td align="left"> linear jerk (rate of change of acceleration) </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> BodyGyro </td>
   <td align="left"> AngularVelocity </td>
   <td align="left"> angular velocity </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> BodyGyroJerk </td>
   <td align="left"> AngularJerk </td>
   <td align="left"> angular jerk </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> GravityAcc </td>
   <td align="left"> GravitationalAcceleration </td>
   <td align="left"> (linear) acceleration due to gravity </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> subjectNumber </td>
   <td align="left"> subjectNumber </td>
   <td align="left"> number of subject performing activity </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> BodyBodyAccJerkMag </td>
   <td align="left"> BodyLinearJerkMagnitude </td>
   <td align="left"> magnitude of linear jerk; not sure what second 'Body' in name means </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> BodyBodyGyroJerkMag </td>
   <td align="left"> BodyAngularJerkMagnitude </td>
   <td align="left"> magnitude of angular jerk; not sure what second 'Body' in name means </td>
  </tr>
  <tr>
   <td align="left">  </td>
   <td align="left"> BodyBodyGyroMag </td>
   <td align="left"> BodyAngularVelocityMagnitude </td>
   <td align="left"> magnitude of angular velocity; not sure what second 'Body' in name means </td>
  </tr>
  <tr>
   <td align="left">   </td>
   <td align="left">   </td>
   <td align="left">   </td>
   <td align="left">  </td>
  </tr>
</tbody>
</table>



Note that the features file contained three variables whose names contained the pattern 'BodyBody'.  I kept those variables, and renamed them per the table, but I am not sure
what they represent.  For example, we already had a '...BodyGyroMag' - the magnitude of
angular veloctiy; I am not sure what 'BodyBodyGyroMag' is a measurement of. There is no mention
of these variables in features_info.txt, thus they may be erroneous data.  I did check that,
for example, 'BodyBodyGyroMag' did not contain the same values as 'BodyGyroMag'.

The working data frame was grouped by subject number, activity and measurement (the 66 variable names discussed above), and means and standard deviations were then calculated. That output is written to a file called './projOutData.txt'.  This output data is an 11,880 (66\*30\*6) x 5 data frame with columns: subject number, activity, measurement, mean and standard deviation.  The README file contains a justification for why I consider this narrow and tall data frame to be tidy.

References:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012

[2]  http://vita.had.co.nz/papers/tidy-data.pdf

[3]  https://class.coursera.org/getdata-007/forum/thread?thread_id=214
