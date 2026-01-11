# SQL_Data_Cleaning

## Overview

This project demonstrates the process of cleaning a messy dataset and transforming it into a structured, usable format. The data cleaning process involves identifying issues like missing values, duplicates, standardization and formatting errors, and resolving them to ensure the dataset is ready for analysis.

## Datasets

### Dirty Dataset (dirtydataset.csv)
The dataset is generated from ChatGPT for the Practise purpose. To check out the level, I took messiest dataset and tried to clean it. The dataset contains raw, unstructured data that includes various issues such as missing values, duplicates, and inconsistent formatting. The objective is to clean the data and ensure consistency across all records.

### Cleaned Dataset (Cleaned_Dataset.csv)
This is the cleaned version of the dataset, created after applying the following transformations:

  1 - Removing duplicates using Window Function
  
  2- Filling missing values
  
  3- Standardizing formats

#### The cleaned dataset is now ready for analysis and further processing.


### SQL Code (Cleaned_dataset.sql)

The file Cleaned_dataset.sql contains the SQL queries used to clean the dirty dataset. The steps executed by the queries include:

  1- Data Transformation: Ensuring data is in the correct format.
  
  2- Removing Duplicates: Identifying and eliminating duplicate records.
  
  3- Handling Missing Data: Filling in or removing missing values where necessary.
  
  4- Data Validation: Verifying that data meets required standards.
