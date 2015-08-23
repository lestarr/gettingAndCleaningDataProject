---
title: "ReadMe"
author: "lestarr"
date: "August 23, 2015"
output: html_document
---


This project represents the analysis and cleaning of the UCI HAR Dataset.
The source for the data is: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

It is supposed that the data are downloaded and unzipped into the working directory with the path "./data/UCI HAR Dataset"


The script code is here: run_analysis.R

To run the script the library dplyr is needed. 

The script produces a tidy data set which is saved into a file, named "tidy_output.txt".

The variables and their transformations are described in the CodeBook.md

