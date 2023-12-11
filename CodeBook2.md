# Codebook for the UCI HAR Dataset

There were two datasets created from the UCI HAR Dataset: - Data in a
tidy format - Data that groups the variables per participant and
activities with the mean values

## 1. Data in a tidy format

The name of this data is ‘tidyUCI_HAR_Dataset’ that contains the data
from both the test and the training data from the UCI HAR Dataset. This
is an overview of the variables that are contained in the dataset: -
subject: an identifier for the subject that ranges from 1-30. -
activity: a description of the activity to which the observation belongs
to, and the possible values are WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING. - the other variables
contain the mean and standard deviation of the gyroscopes and
accelerometers.

## 2. Data that groups the variables per participant and activities with the mean values

This dataset contains the mean values of the means and standard
deviation of the gyroscope and accelerometer measurement grouped per
activity type and participant. So the variables are the same as the data
in the tidy format, but in the other dataset every observation of every
type of activity and per participant is given, whereas this dataset
gives the mean values for all these observations per participant and
activity.
