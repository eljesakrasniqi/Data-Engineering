# Day 10 - Bronze / Silver / Gold Pipeline with Python

## Project Goal

The goal of this project is to simulate a real-world data engineering pipeline using the Bronze, Silver, and Gold architecture.

The pipeline reads raw CSV files, cleans and validates the data, enriches records with additional information, and produces business-ready reports that can be used for dashboards and decision-making.

---

## Bronze Layer

The Bronze layer stores the raw source data exactly as received.

### Input files

- orders_raw.csv
- customers_raw.csv
- products_raw.csv

No manual modifications are made to these files.

This layer represents the original data and preserves it for traceability and auditing purposes.

---

## Silver Layer

The Silver layer cleans, validates, and enriches the Bronze data.

### Cleaning performed

- Normalized order statuses
- Normalized sales channels
- Normalized city names
- Validated customer IDs
- Validated product IDs
- Removed duplicate Order IDs
- Checked missing dates
- Checked positive quantities
- Checked valid product prices
- Replaced missing values where appropriate

### Generated files

- customers_clean.csv
- products_clean.csv
- orders_clean.csv
- invalid_orders.csv

Each invalid order is stored together with the reason why it failed validation.

---

## Gold Layer

The Gold layer contains business-ready reports created only from valid Silver data.

### Reports generated

- revenue_by_category.csv
- revenue_by_city.csv
- revenue_by_customer.csv
- top_products.csv
- executive_summary.txt

These reports can be used directly in dashboards, analytics, or business presentations.

---

## How to Run the Pipeline

1. Open the project folder.
2. Open a terminal.
3. Run:

```bash
python pipeline.py
```
---
## Data Quality Checks

The pipeline validates:

- Duplicate Order IDs
- Missing order dates
- Invalid quantities
- Invalid product prices
- Missing customers
- Missing products
- Invalid statuses
- Invalid channels
- Missing cities

Invalid records are automatically separated into **invalid_orders.csv**.

---

## Business Insights

The Gold reports allow users to answer questions such as:

- Which category generates the most revenue?
- Which city generates the highest sales?
- Who are the top customers?
- Which products sell the most?
- How much completed revenue has been generated?

These reports are designed for business users rather than developers.

---

## What I Can Explain and Defend

I can clearly explain:

- the purpose of the Bronze, Silver, and Gold architecture
- why raw data should never be modified
- how data validation improves data quality
- how lookup tables are used to enrich orders
- why only valid Silver data is used to generate Gold reports
- how the business reports are calculated

The result I can confidently defend is that all Gold reports are generated only from validated Silver records, ensuring reliable business metrics.

---

## What Was Difficult

The most challenging part was implementing the validation logic while keeping the code organized into reusable functions.

Another challenge was connecting customers, products, and orders correctly during data enrichment.

---

## What I Would Improve Next

If I continued improving this project, I would:

- add revenue by channel reports
- generate dashboard-ready summary files
- add timestamps to the pipeline log
- improve date validation
- add automated unit tests
- improve error handling and logging

---

## Technologies Used

- Python 3
- csv module
- os module
- collections module
- Databricks Bronze/Silver/Gold architecture concepts

---

## Learning Outcome

This project helped me understand how professional data engineering pipelines transform raw data into clean, trusted, and business-ready information through multiple processing layers.