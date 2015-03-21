# GCD-Project
Submission for the course project for "Getting and Cleaning Data"
## How the script works
### Overview, Assumptions and Usage
- The run_analysis function begins by calling a createTable function, and then it binds the resulting tables and calculates the required tidy data.
- the run_analysis function presumes that data will be organized in the manner given by the course-defined data download.
- the run_analysis function takes an optional parameter, which allows the calling function to specificy a path to the data. The path given should be to the parent of the test and train folders.

### run_analysis Algorithm Description
1. create test data table (via call to createTable)
2. create training data table (via call to createTable)
3. join the test and training data tables
4. write the joined table to a file called "tidy4.txt"
  + This line satisfies step 4 of the project.
5. Create the averages per activity
  + initialize tidy5.data with a NULL
  + create the averages for every feature grouped by activity ID (result is a single row)
  + append the newly calculated row to tidy5.data
6. Set the column names for tidy5.data by reading the names from the previously joined data table
7. Attach the activity information to the summarized data
8. write the summarised table to a file called "tidy5.txt"
  + this line satisifes step 5 of the project
  
### createTable Algorithm Description
1. save the working directory and update the working directory to the relative path as passed by the calling function.
2. read the x.datafile, y.datafile and subject.datafile as passed by the calling function.
3. set the names for y.data and subject.data
4. recurse the directory by one level
5. load the names for x.data from the features.txt file
6. read the activity codes and descriptions from the activity_labels.txt file
7. restore the saved working directory
8. use grep to extract any column names that partial match "mean" or "std"
9. join the extracted columns
10. associate the activity id with the activity name previously read
11. bind the subject, activity and x data together.

## Codebook
- The code book describing the source of the data is features_info.txt, which you can find [here](https://github.com/Diceman01/GCD-Project/blob/master/features_info.txt).   
- The full list of features is found in t4features.txt, located [here](https://github.com/Diceman01/GCD-Project/blob/master/t4features.txt).
