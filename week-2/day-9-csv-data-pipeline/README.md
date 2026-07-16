# Day 9 - CSV Data Pipeline: From Raw Data to Clean Reports

## Overview

This project is part of the **Unity Tech Hub x Agilyti – Data Engineering / Databricks Training**.

The goal of this practice is to build a complete **Python CSV Data Pipeline** that reads raw CSV files, validates and cleans the data, enriches records, and generates business-ready reports.

The project follows the **Bronze → Silver → Gold** data engineering approach, preparing raw data for trusted business reporting. :contentReference[oaicite:1]{index=1}

---

# Project Objectives

- Read raw CSV files using Python.
- Validate incoming data.
- Normalize inconsistent values.
- Detect and separate invalid records.
- Enrich orders with customer and product information.
- Generate clean datasets.
- Produce business reports from trusted data.
- Practice real-world data engineering concepts without using external libraries like Pandas.

---

# Bronze, Silver & Gold Layers

## Bronze Layer

The Bronze layer contains the original raw CSV files exactly as they were received.

Files:

- `orders_raw.csv`
- `customers_raw.csv`
- `products_raw.csv`

No modifications are made at this stage.

---

## Silver Layer

The Silver layer contains validated and cleaned data.

During this stage the pipeline:

- validates every order
- normalizes status values
- normalizes city names
- normalizes sales channels
- removes invalid records
- enriches data with customer and product information

Generated files:

- `orders_clean.csv`
- `invalid_orders.csv`

---

## Gold Layer

The Gold layer contains business-ready outputs created from the trusted Silver data.

Generated reports:

- `business_summary.txt`
- `data_quality_report.txt`

These reports contain metrics that can be trusted because they are calculated only from validated data.

---
# How to Run

1. Open the project in Visual Studio Code.

2. Open a terminal.

3. Navigate to the project folder.

4. Run the pipeline:

```bash
python csv_pipeline.py
```

After execution, the script automatically creates all output files inside the **output/** directory.

---

# Generated Output Files

The pipeline generates:

- **orders_clean.csv**  
  Contains validated and enriched orders.

- **invalid_orders.csv**  
  Contains rejected records together with the validation reason.

- **business_summary.txt**  
  Contains business metrics such as:

  - Completed revenue
  - Orders by status
  - Orders by city
  - Revenue by category
  - Revenue by channel
  - Top customers
  - Top products
  - Business recommendations

- **data_quality_report.txt**  
  Contains:

  - Total raw records
  - Valid records
  - Invalid records
  - Validation statistics
  - Data quality issues
  - Cleaning summary

---

# Technologies Used

- Python 3
- csv module (`csv.DictReader` & `csv.DictWriter`)
- Dictionaries
- Functions
- File Handling

---

# Why Pandas Was Not Used

This practice intentionally avoids **Pandas**.

The purpose is to understand how a real data pipeline works by implementing:

- CSV reading
- Validation
- Cleaning
- Transformation
- Enrichment
- Report generation

using only Python's built-in tools.

Building the logic manually provides a stronger understanding of data engineering fundamentals before using advanced libraries such as Pandas or Databricks.

---

# Learning Outcomes

After completing this project, I learned how to:

- Build a complete CSV pipeline
- Validate raw datasets
- Normalize inconsistent values
- Create lookup tables
- Simulate SQL JOIN operations using Python dictionaries
- Separate valid and invalid records
- Generate trusted business reports
- Apply Bronze, Silver, and Gold data engineering concepts

---

# Author

**Eljesa Krasniqi**

Unity Tech Hub x Agilyti  
Data Engineering / Databricks Training