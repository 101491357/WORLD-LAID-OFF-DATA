# WORLD-LAID-OFF-DATA
DATA CLEANING AND EXPLORATION WITH SQL
This project focuses on cleaning, standardizing, and removing duplicates from the world_layoffs dataset, which tracks layoffs across various companies, industries, and countries. The goal is to ensure that the data is accurate, consistent.

#Steps and SQL Queries includes;
#Fetch all records from the world_layoffs.layoffs table.
#Create a Staging Table
#Create a staging table, layoffs_Staging, to prepare and clean the data before further processing
#Insert the original data into the staging table.
#Identify and Remove Duplicates
#Identify records where duplicates exist.
#Standardize Data(Remove extra spaces from company names,Standardize values in the industry column to avoid inconsistencies (e.g., "Crypto" vs. "crypto"),Ensure that country names are free from trailing periods.)
#Convert the date column from string format to MySQL date format.
#Fill Missing Industry Data Based on Company by updating rows with missing industry data by looking at other records from the same company
#Final Clean Up and Data Validation

