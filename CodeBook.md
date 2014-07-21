
# VARIABLES IN RAW-DATASET
Variables in original Samsung dataset are preprocessed to preserve the name but doing some transformation to make it more usable in R.
Those transformations are:
 1. Remove parenthesis characters `-()`
 2. change -mean by Mean (capitalized)
 3. change -std  by Std  (capitalized)
 4. strip squared parenthesis
 5. strip comma symbols

Some samples of variable names are shown below: 
 
 index|            raw_name |  tidy_name
------|---------------------|------------------ 
     1|   tBodyAcc-mean()-X |  tBodyAccMeanX
     2|   tBodyAcc-mean()-Y |  tBodyAccMeanY
     3|   tBodyAcc-mean()-Z |  tBodyAccMeanZ
     4|    tBodyAcc-std()-X |   tBodyAccStdX
     5|    tBodyAcc-std()-Y |   tBodyAccStdY
     6|    tBodyAcc-std()-Z |   tBodyAccStdZ
     7|    tBodyAcc-mad()-X |   tBodyAccmadX
     8|    tBodyAcc-mad()-Y |   tBodyAccmadY
     9|    tBodyAcc-mad()-Z |    tBodyAccmadZ
    10|    tBodyAcc-max()-X |   tBodyAccmaxX
    11|    tBodyAcc-max()-Y |   tBodyAccmaxY
    12|    tBodyAcc-max()-Z |   tBodyAccmaxZ
    13|    tBodyAcc-min()-X |   tBodyAccminX
    14|    tBodyAcc-min()-Y |   tBodyAccminY
    15|    tBodyAcc-min()-Z |   tBodyAccminZ
    16|      tBodyAcc-sma() |    tBodyAccsma
    17| tBodyAcc-energy()-X |tBodyAccenergyX
    18| tBodyAcc-energy()-Y |tBodyAccenergyY
    19| tBodyAcc-energy()-Z |tBodyAccenergyZ
    20|    tBodyAcc-iqr()-X |   tBodyAcciqrX


# VARIABLES IN TIDY-DATASET
For tidy dataset is made a selection of variables according its name. In this case are only
considered variables that contains "Mean" or "Std" values inside its name. Following the sample
shown above, the selection is some like that:

 index|  tidy_name       | selected  | extra-description
------|------------------|-----------|------------------------------------------------------------------------
     0|  activityName    | *         | name of the activity. See the file 01_Raw_Dataset/activity_labels.txt for description 
     0|  subjectId       | *         | subject id  
     1|  tBodyAccMeanX   | *         |
     2|  tBodyAccMeanY   | *         |
     3|  tBodyAccMeanZ   | *         |
     4|   tBodyAccStdX   | *         |
     5|   tBodyAccStdY   | *         |
     6|   tBodyAccStdZ   | *         |
     7|   tBodyAccmadX   |           |
     8|   tBodyAccmadY   |           |
     9|    tBodyAccmadZ  |           |
    10|   tBodyAccmaxX   |           |
    11|   tBodyAccmaxY   |           |
    12|   tBodyAccmaxZ   |           |
    13|   tBodyAccminX   |           |
    14|   tBodyAccminY   |           |
    15|   tBodyAccminZ   |           |
    16|    tBodyAccsma   |           |
    17|tBodyAccenergyX   |           |
    18|tBodyAccenergyY   |           |
    19|tBodyAccenergyZ   |           |
    20|   tBodyAcciqrX   |           |

# SUMMARIES
For the purposes of the exercise, the data for tidy dataset is calculated computing average of each column 
using a partition by activityName and subjectId

