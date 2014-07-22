#
# Main program developtment to clean dataset info
# 
#
library(data.table)

x_source_path = "01_Raw_Dataset"
x_tidy_basefilename = "02_Tidy_Dataset"
data_dir_basepath <- paste0( "./", x_source_path , sep = "" )


# read activities
#   Loads the metadata and preprocess the variable names to be most ealsily used in R
#   and give a descriptive name
read_activities <- function() {
  
  #   a. load data
  activities <- read.table( paste0( data_dir_basepath, "/" ,"activity_labels.txt", sep = ""), col.names= c("index","raw_name") ) 
  
  #   b. create a new column calculting a meaningful name & rename column
  activities[,3] = tolower( activities[,2] )          # use lowecase for activities
  #   c. rename column
  colnames(activities)[3] <- "name"
  #   d. create factor
  # activities$factor <- factor(activities$index,labels=activities$name)
  
  # e. return
  activities
  
  # use head(activities) to test
}

# Read features:
#   Loads the metadata and preprocess the variable names to be most ealsily used in R
#   and give a descriptive name
read_features <- function() {
  
  #    a. load data
  features <- read.table( paste0( data_dir_basepath, "/" ,"features.txt", sep = ""), col.names = c("index","raw_name") )  
  
  #    b. create a new column calculting a meaningful name
  features[,3] = features[,2]
  features[,3] = gsub('-mean', 'Mean', features[,3])   # capitalize Mean
  features[,3] = gsub('-std' , 'Std' , features[,3])   # capitalize Std
  features[,3] = gsub('[-()]', ''    , features[,3])   # strip squared parenthesis
  features[,3] = gsub(','    , ''    , features[,3])   # strip comma symbols
  
  #   c. rename column
  colnames(features)[3] <- "name"
  
  #   d . return 
  features
  
  # use head(features) to test
}


# reads the dataset raw data
read_dataset <- function( index_name, features, activities) {
  
  # _x is used to dawdata
  # _y is used to label
  # _s is used to subject
  
  # calculate filenames
  dataset_filename_x <- paste0(data_dir_basepath, '/', index_name, '/' , 'X_'      , index_name, '.txt' )
  dataset_filename_y <- paste0(data_dir_basepath, '/', index_name, '/' , 'y_'      , index_name, '.txt' )
  dataset_filename_s <- paste0(data_dir_basepath, '/', index_name, '/' , 'subject_', index_name, '.txt' )
  
  # load raw data
  dataset_x <- read.table(dataset_filename_x)
  dataset_y <- read.table(dataset_filename_y)
  dataset_s <- read.table(dataset_filename_s)
  
  # debug sizes
  # dim(dataset_x)  
  # dim(dataset_y)  
  # dim(dataset_s)  
  
  # x :: prepare labels
  names(dataset_x) <- features$name
  
  # y :: lookup for activity-name & name columns (try to assign activities[dataset_y[,1]])
  dataset_y[,2] <- NA 
  dataset_y[,2] <- factor(dataset_y[,1], levels = activities$index,labels=activities$name)  
  names(dataset_y) <- c("activityId","activityName")
  
  # s :: prepare_labels
  names(dataset_s) <- "subjectId"
  
  # concatenate subdatasets by column
  dataset_by_index <- cbind(dataset_x,dataset_y,dataset_s)
  
  # return
  dataset_by_index
}

log_debug <- function(...){
  cat("[exec]",...,"\n")
}

#
# Main program developtment to clean dataset info
# 
#

run_analysis <- function() {
  
  log_debug("(0.a) metadata load of {features,activities} (begin)")
  
  # Load the metadata: variable column names 
  features <- read_features()
  
  # Load the metadata: typeof activity domain
  activities <- read_activities()
  
  log_debug("(0.b) loading data to be processed (begin)")

  # loading test & train subselts
  # a. using descriptive activitynames
  # b. appropiately labels dataset
  
  ds_test  <- read_dataset("test" , features, activities)
  ds_train <- read_dataset("train", features, activities)
  
  log_debug("(1.a) merge training and test set (begin)")
  
  ds_all <- rbind(ds_test,ds_train)
  
  log_debug("(2.a) extract only mean & stddev foreach observation (begin)")
  
  
  # select columns with the word mean or std
  selected_column_measures_idx <- grep(".*Mean.*|.*Std.*", features[,3])
  selected_column_classes_idx  <- which(names(ds_all) %in% c("activityId","activityName","subjectId"))
  
  # select colums with subject or activity data
  selected_column_idx <- c(selected_column_measures_idx,selected_column_classes_idx) 
  
  # 

  log_debug("(5.a) create a 2nd dataset computing avg()(over partition by ( activity,subject)) - (begin)")
  
  dt<- data.table(ds_all[,selected_column_idx])  
  meanData<- dt[, lapply(.SD, mean), by=c("activityName", "subjectId")]
  meanData<- meanData[order(meanData$subjectId),]
  
  log_debug("(5.b) create a 2nd dataset with avg()(over partition by ( activity,subject)) - (begin)")
  
  # generate the dataset inside a .csv file:
  x_tidy_completefilename_dataset = paste0("./", x_tidy_basefilename, ".csv", sep="")
  write.table(meanData, file=x_tidy_completefilename_dataset, row.names=FALSE, quote=FALSE,col.names=FALSE,sep=",")
  
  # generate the header inside a .txt file:
  x_tidy_completefilename_header  = paste0("./", x_tidy_basefilename, "_head.txt", sep="")
  write.table(names(meanData),file=x_tidy_completefilename_header,row.names=FALSE,quote=FALSE,col.names=FALSE,sep=",")
  
  
  # return the avg
  invisible(meanData)
}


#
# downloads the file
# uncompress the file

prepare_raw_data <- function() {
  
  source_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  local_file <- paste0( "./", x_source_path, ".zip", sep="")
  download.file(source_url,destfile=local_file)
  unzip(local_file)
  
}
