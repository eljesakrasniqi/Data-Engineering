<<<<<<< HEAD
# Data-Engineering
=======
Student Data Processing Project

## Project Description

This project processes student data from a CSV file and performs data quality checks, data cleaning, and basic analysis.

The program:
 Loads student records from a CSV file.
 Checks for missing values, invalid numeric values, and inconsistent text values.
 Cleans the dataset using predefined rules.
 Calculates student performance status and risk flags.
 Generates a final student report with statistics and analysis.


## Input File

The program uses the following input file: data/students_raw.csv
This file contains raw student information such as:
 Student ID
 Name
 City
 Course
 Age
 Attendance
 Homework score
 Registered date


## Output Files

The program generates the following files: output/data_quality_report.txt
Contains detected data issues:
 Missing values
 Invalid numeric values
 Inconsistent text values


### Final Student Report
Contains:
 Total records
 Average attendance
 Average homework score
 Students by city and course
 Performance status
 Risk analysis
 Top 3 students by total score

## How to Run
Run the program from the terminal:

```bash
python csv_pipeline.py
>>>>>>> 780af27 (data-pipeline)
