# Day 6 - SQL Business Reporting Sprint

## Project Overview

This project is part of the **Unity Tech Hub x Agilyti Data Engineering / Databricks Training**.

The goal of this practice is to develop SQL business reporting skills by working with multiple related tables. The project demonstrates how SQL can be used not only to retrieve data but also to generate meaningful business reports through aggregations, grouping, filtering, and table relationships.

The project uses three tables:

- orders
- customers
- products

and focuses on creating business insights using SQL.

---

## Files Description

### setup.sql
- Creates the database tables.
- Inserts all required data.
- Drops existing tables before recreation.
- Includes verification queries to display all records.

### basic_aggregations.sql
Contains SQL queries using:

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

These queries calculate important business metrics such as total orders, completed orders, product prices, and revenue.

### group_by_reports.sql

Creates summary reports using:

- GROUP BY
- HAVING
- ORDER BY

Examples include:

- Orders by status
- Orders by customer
- Revenue by product
- Revenue by category
- Reports filtered using HAVING

### join_reports.sql

Combines information from multiple tables using SQL JOINs.

Reports include:

- Customer order reports
- Product sales reports
- Revenue by city
- Revenue by category
- Revenue by customer
- Top products
- Top customers

### business_report.md

Contains business insights generated from the SQL reports, including:

- Total orders
- Completed revenue
- Best-performing products
- Best-performing categories
- Revenue by city
- Business recommendations
- Reporting risks

### query_explanations.md

Explains the purpose and logic of important SQL queries, including:

- Business question
- Tables used
- Why JOIN was required
- Why WHERE was used
- Why GROUP BY was used
- Personal understanding

### daily_report.txt

A short reflection describing:

- Work completed
- Challenges
- Learning outcomes
- Topics for future practice

---

## How to Run

Open SQLiteOnline.com and execute the SQL files in the following order:

1. `setup.sql`
2. `basic_aggregations.sql`
3. `group_by_reports.sql`
4. `join_reports.sql`

After running the SQL scripts, review the generated reports and complete:

- business_report.md
- query_explanations.md
- daily_report.txt

---

## Tools Used

- SQLiteOnline.com
- SQL
- GitHub

---

## SQL Concepts Used

### Basic Aggregations

Aggregation functions summarize data into single values.

Examples:

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

These functions answer questions like:

- How many orders exist?
- What is the total revenue?
- What is the average product price?

---

### GROUP BY

`GROUP BY` combines rows with the same value into one group.

Instead of showing every order individually, it creates summaries such as:

- Revenue by product
- Orders by city
- Orders by customer
- Revenue by category

---

### HAVING

`HAVING` filters grouped results after aggregation.

Unlike `WHERE`, which filters individual rows, `HAVING` filters entire groups.

Example:

- Show customers with more than one order.
- Show products with completed quantity greater than two.

---

### JOIN

`JOIN` connects related tables using matching IDs.

This allows reports to display meaningful information instead of only IDs.

For example:

- Customer names instead of customer IDs
- Product names instead of product IDs
- Cities and product categories in reports

JOINs make business reports much easier to understand.

---

## Main Business Insight

The most valuable insight from this project is that **only completed orders should be included when calculating revenue**. Pending and cancelled orders represent potential sales but should not be counted as actual business revenue. By combining data from the `orders`, `customers`, and `products` tables, it becomes possible to identify top-performing products, customers, and cities, enabling more informed business decisions.

---

## Learning Outcomes

By completing this project, I learned how to:

- Create and populate SQL tables.
- Generate business metrics using aggregate functions.
- Build grouped reports with GROUP BY.
- Filter grouped data using HAVING.
- Combine multiple tables using JOINs.
- Calculate business revenue accurately.
- Interpret SQL query results and explain their business value.
- Organize a professional SQL project using GitHub.

---

## Author

Eljesa Krasniqi

Unity Tech Hub x Agilyti  
Data Engineering / Databricks Training  
Day 6 – SQL Business Reporting Sprint