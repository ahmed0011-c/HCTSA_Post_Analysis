## Fly_HCTSA_Post_Analysis

(1) flies LFP data could be found on the shared google folder only for granted users 
 link: https://drive.google.com/drive/folders/1xbMLpIV0GTMXEKWEqEadFVVSASdw9nO7?usp=sharing 

(2) pre-processing and analysis functions could be found in the project functions folder 

## Core functions for data pre-processing

Pre-processing steps was carried out in accordance to our previous study (Cohen et al.,2016)
DOI:http://dx.doi.org/10.1523/ENEURO.0116-16.2016

- batchPreprocess responsiple for carrying out full pre-proccessing steps including:-
(1) linenoise removal and applying tapers
(2) data detrending
(3) Normalizing data using Z-score
(4) obtaining power spectrum values

- Lastly visualize timeseries one at a time using line plot and constructing a power spectrum
plot for different frequencies


## Core functions SVM analysis
(requires libsvm installation)

responsible for carrying out linear svm classification on the HCTSA output using leave-one out cross-validation including:

(1) calculating the classification accuracy on predicting training data
(2) obtaining svm Thresholds
(3) knowing the dirction of the HCTSA features between conditions
(3) predict validation data

-Lastly visualize the classifcation accuracies of HCTSA operations in form of histogram
