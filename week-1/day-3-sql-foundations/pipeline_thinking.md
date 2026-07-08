# Data Pipeline Thinking - Day 3

## Chosen business:
School - Student Payment Management System

## Source Data:
The source data comes from student payment records.
It includes information such as student name, course, payment amount, payment status, and payment date.

## Ingestion:
Data is collected from school systems, payment forms, or CSV files and ingested into the data pipeline for processing and analysis.

## Storage:
The collected data is stored in a database table called `student_payments`.
The table keeps structured information about students and their payments.

## Cleaning:
The data is checked and cleaned by:
 Removing duplicate payment records.
 Handling missing student names or course information.
 Checking that payment amounts are valid numbers.
 Standardizing payment statuses (paid, unpaid, completed).

## Transformation:
The data is transformed by:
 Calculating total payment values.
 Grouping payments by course.
 Sorting students by payment amount.
 Creating reports for completed and unpaid payments.

## Business Output:
The final output can be used to create reports that show:
 Total payments received.
 Students with unpaid payments.
 Revenue by course.
 Payment history for each student.

## Business questions we can answer:
 How much money has the school received from student payments?
 Which courses have the highest number of students and payments?
 Which students still have unpaid payments?

## Possible data problems:
 Missing or incorrect payment information.
 Duplicate student payment records.
 Incorrect status values (for example, "payd" instead of "paid").