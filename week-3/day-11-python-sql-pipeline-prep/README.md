# Day 11 - Python + SQL Pipeline Preparation

## Project Goal

The goal of this project is to simulate a simple data engineering pipeline using Python and SQL.

The pipeline reads raw (Bronze) CSV files, validates and cleans the data, creates trusted (Silver) datasets, and generates business-ready (Gold) reports. Finally, SQL is used to analyze the clean data and answer business questions.

---

# Bronze Data

## Raw Files Received

- orders_raw.csv
- customers_raw.csv
- products_raw.csv

## Problems Found

During inspection of the raw datasets, several data quality issues were identified:

- Missing quantity values
- Non-numeric quantity values
- Quantity equal to zero or negative
- Missing order dates
- Missing status values
- Different status formats (Completed, completed, done)
- Different cancelled spellings (cancelled, canceled)
- Missing sales channel
- Customer IDs not found in customers file
- Product IDs not found in products file
- Invalid product IDs
- Different city name formatting
- Cancelled and pending orders that should not count as completed revenue

---

# Silver Data

## Validation Rules Applied

The pipeline validates every order before it becomes trusted data.

Validation includes:

- Quantity must exist
- Quantity must be numeric
- Quantity must be greater than zero
- Status must exist
- Status must be one of:
  - completed
  - pending
  - cancelled
- Order date must exist
- Customer ID must exist in customers_raw.csv
- Product ID must exist in products_raw.csv
- Duplicate order IDs are rejected

---

## Records Marked as Invalid

Orders become invalid when they contain one or more of the following problems:

- Missing quantity
- Invalid quantity
- Quantity less than or equal to zero
- Missing status
- Unknown status
- Missing order date
- Customer not found
- Product not found
- Duplicate order ID

All invalid rows are written into:

```
data/silver/invalid_orders.csv
```

with an additional column:

```
invalid_reason
```

---

## Data Normalization

The pipeline standardizes inconsistent values before reporting.

### Status

Completed values become:

```
completed
```

Examples:

- Completed → completed
- completed → completed
- done → completed

Cancelled values become:

```
cancelled
```

Examples:

- cancelled → cancelled
- canceled → cancelled

---

### City

Cities are normalized into consistent formatting.

Examples:

- prishtina → Prishtina
- VUSHTRRI → Vushtrri
- ferizaj → Ferizaj

---

### Channel

Channels are normalized to:

- online
- store
- web
- bank
- unknown

---

# Gold Reports

The pipeline automatically generates:

- revenue_by_city.csv
- revenue_by_category.csv
- top_customers.csv
- executive_summary.txt

These reports contain only trusted Silver data.

---

## Most Useful Report

The most useful report for management is:

**Revenue by City**

This report quickly shows:

- which cities generate the most revenue
- where sales are strongest
- where additional marketing may be needed

---

# Python vs SQL

## What Python Helped Do

Python was responsible for:

- Reading CSV files
- Cleaning data
- Validating records
- Normalizing values
- Joining customer and product information
- Separating valid and invalid records
- Calculating total_amount
- Creating Silver datasets
- Generating Gold reports

---

## What SQL Helped Do

SQL was used to:

- Query trusted clean data
- Calculate completed revenue
- Count orders
- Group data by city
- Group data by category
- Find top customers
- Find highest revenue city
- Produce business reports

Python prepares the data.

SQL analyzes the data.

---

# Data Quality Notes

The pipeline improves data quality by:

- Removing invalid records
- Standardizing inconsistent values
- Keeping invalid data for auditing
- Preventing incorrect revenue calculations
- Using only trusted records for reporting

This follows the Bronze → Silver → Gold architecture used in modern data engineering.

---

# Business Insights

From the clean dataset, management can easily understand:

- Total completed revenue
- Revenue by city
- Revenue by product category
- Best customers
- Most common sales channels
- Order status distribution

These reports support better business decisions.

---

# What I Can Explain Live

I can explain:

- Bronze, Silver and Gold architecture
- Why validation is important
- How invalid orders are detected
- How normalization works
- Why completed revenue excludes pending and cancelled orders
- How Python prepares data
- How SQL creates business reports
- How the pipeline runs from start to finish

---

# What I Would Improve Next

Possible improvements include:

- Logging every pipeline step
- Better error handling
- Configuration file instead of hardcoded paths
- Automatic unit tests
- More business KPIs
- Data visualization dashboards
- Loading data directly into a database
- Running the pipeline automatically with scheduling tools
---

# Conclusion

This project demonstrates a complete mini data engineering workflow.

Starting from messy raw CSV files, Python cleans and validates the data into trusted Silver datasets. Gold reports summarize the business information, while SQL provides powerful reporting on clean data.

The project follows the same Bronze → Silver → Gold architecture commonly used in Databricks and modern data engineering environments.