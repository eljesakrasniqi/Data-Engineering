# Day 7 - SQL Detective Day

## Overview

The goal of this practice was to improve SQL debugging skills, validate business metrics, and create a verified business report using SQL queries. During this practice, I identified and fixed broken SQL queries, verified business numbers using validation queries, and ensured that every reported result could be proven with a working SQL query.

---

## Project Files

This project contains the following files:

- `setup.sql` – Creates the database, tables, and inserts sample data.
- `table_inspection.sql` – Displays table contents and verifies row counts.
- `broken_queries.sql` – Contains the original broken SQL queries.
- `fixed_queries.sql` – Contains corrected SQL queries with explanations.
- `validation_queries.sql` – SQL queries used to verify all business metrics.
- `verified_business_report.md` – Final verified business report based on SQL results.
- `query_explanations.md` – Explanation of fixed and validation queries.
- `daily_report.txt` – Summary of the day's work and learning.
- `README.md` – Project documentation.
- `screenshots/` – Screenshots showing successful query execution and verification.

---

## How to Run the Project

Run the SQL files in the following order:

1. `setup.sql`
2. `table_inspection.sql`
3. `fixed_queries.sql`
4. `validation_queries.sql`
5. Review `verified_business_report.md`

Running the files in this order ensures the database is created correctly, all queries execute successfully, and the business report is based on verified SQL results.

---

## What I Learned About Debugging SQL

- How to identify and fix syntax errors.
- How to correct missing JOIN conditions.
- Why the correct table must be used for each column.
- The importance of using GROUP BY correctly.
- The difference between WHERE and HAVING.
- How to read SQL error messages and use them to find mistakes.
- Why every SQL query should be tested before using its results.

---

## What I Learned About Verifying Business Reports

- Every business number should be supported by a working SQL query.
- Revenue should include only completed orders.
- JOIN statements are necessary when retrieving customer, product, or category information.
- Validation queries help ensure reported metrics are accurate.
- A business report is trustworthy only when every result can be verified using SQL.

---

## Conclusion

This practice strengthened my SQL debugging, validation, and reporting skills. I learned how to fix incorrect queries, verify business metrics, and create reliable reports supported by accurate SQL queries.