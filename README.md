# README
This repository contains the code used for developing assignment 1 of the course Bayesian Networks at the Radboud University. Below follows a brief description of each file in this repository.

**discretized_dataset.csv**: This contains our dataset after binning the continuous data in no_missingvalues_dataset.csv. <br>
**no_missingvalues_dataset.csv**: This file contains the original dataset with records having missing values removed. <br>
**original_dataset.csv**: This file contains the original dataset. The original dataset was the processed_cleveland.csv file downloaded from *https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/* <br>
**preprocess.ipynb**: This file contains the code we used to preprocess our dataset and to obtain some statistics on the dataset. <br>
**README.MD**: The file you are currently reading. <br>
**main.R**: This file contains the code we used to create our networks, and testing the conditional independencies of these networks. For a detailed description of our code see below.

### main.R
Although our code contains many lines, this is dominated by the definition of all the different graphs we used for testing. Our code consists of two parts: Defining the graphs, and testing the conditional independencies from these graphs. The graphs used for the chi-square method use the prefix simpleDag, the graphs used for the Hotelling's method use the prefix expDag. <br> <br>
Testing using the chi-square method was done by using the localTests function of the BayesianNetworks package. Testing using the Hotelling's method was done by looping over the conditional indpendencies manually, and using the BayesianNetworks ci_test method.