# Coursera: GettingAndCleanningData Project

## STEPS TO RUN THE PROGRAM

To use the program:

0. install prerrequisites. It's needed to run this program to install the following R packages
* data.table
Use the following directives to install
```r
install.packages("data.table")
```

1. go to the directory where the source code resides and set the working directory using the following function
```r
setwd()
```
2. Execute the following sentences to download the raw data to be processed
```r
source('./run_analysis.R')
prepare_raw_data()
```
This script downloads the associated Samsung's data raw dataset package files available on the internet with the url indicated below as parameter RAW_DATASET_URL, and puts a copy into the current directory. After that it decompreses the 
file. As alternative of this step you can download the raw dataset zip file, put it beside the source files and decompress the file in a directory with 
the name indicated below as parameter RAW_FOLDER_NAME:
 
a. Tne associated RAW_DATASET_URL is: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
b. Unzipped RAW_FOLDER_NAME is: 01_Raw_Dataset 

3. execute the following sentences
```r
source('./run_analysis.R')
run_analysis()
```


## EXPLANATION OF SCRIPTS

This is the description of how scripts work and how are connected: 

The function prepare_raw_data does the following steps
* 1. downloads the raw dataset package file
* 2. uncompresses the file and creates a local directory inside the working directory

The function run_analysis does the following set of steps:
* 1. merge training and test set
* 2. extract only mean & stddev foreach measurement
* 3. descriptive activitynames
* 4. appropiately labels dataset
* 5. create a 2nd dataset with avg()(over partition by ( activity,subject))




## MOTIVATION
Explore the student capabilities to (1)	collect, (2) work with and, (3) clean datasets.

The data for the experiment were captured by sampling a population of 30 people within 19 to 48 years, performing several activities (walking,walking_upstairs,walking_downstairs,sitting,standing,laying) 
and wearing a smartphone used as capturer. The devide used was Samsung Galaxy S II, but however could be applied to another set of cellphones [ pressing *#0*# and going to sensors link we can give us an ide of how it works](http://youtu.be/F1vqmzDsjGc).
The phone's [accelerometer](http://youtu.be/KZVgKu6v808) gives us 3 (x,y,z) measures relatives to the person doing activities while cellphone is moving, and simultaneously the phone's [gyro](http://youtu.be/zwe6LEYF0j8) capturing 3 measures too.
Those 6 measures taken at a speed of 50 Mhz are preprocessed with filters and complemented with fast-fourier-transformation that implies to compute fixed-width-window-frames to estimate some related calculus of time and frequency.


## ARTIFACTS

 i  |     fileName                  | description
---	| ----------------------------- | ----------------------------------------
1.a | 02_Tidy_Dataset (00).csv      | the generated tidy dataset data
1.b | 02_Tidy_Dataset (00)_head.txt | the generated tidy dataset column-names
2.  | run_analysis.R                | script that performs the data-cleaning preprocessing step
3.  | CodeBook.md                   | the codebook file	with	
    |	                            | * variables
    |	                            | * data
4.  | 01_Raw_Dataset                | getdata_projectfiles_UCI HAR Dataset.zip file extracted in folder called "01_Raw_Dataset"

## GIT INFORMATION
Commit is made according the following instructions
touch README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/andhdo/coursera_ds_getclndata_project.git
git push -u origin master

	
	