# Pipeline Explanation - Day 9

## Source Data
The source data comes from CSV files containing raw business order information. The data includes customer details, product information, order status, quantity, price, city, category, and sales channel.

## Ingestion
The raw CSV files are loaded into Python using the csv module. During ingestion, all records are read exactly as they exist without making any changes.

## Bronze Layer
The Bronze layer stores the original raw data. This layer preserves the source information so that no original records are lost and the data can always be traced back to its source.

## Cleaning Rules
The following cleaning rules are applied:
- Remove leading and trailing spaces.
- Convert text values to a consistent format.
- Normalize status values (Completed, Pending, Cancelled).
- Standardize city names.
- Standardize category names.
- Standardize sales channel names.
- Convert quantity and price to numeric values.
- Replace missing values where appropriate.

## Validation Rules
The data is validated to ensure:
- Order ID is not missing.
- Customer ID exists.
- Product ID exists.
- Quantity is greater than zero.
- Price is greater than zero.
- Status contains only valid values.
- Required fields are not empty.
- Invalid records are separated from valid records.

## Silver Layer
The Silver layer contains cleaned and validated data. Only records that pass all validation rules are stored in this layer, making it suitable for analysis.

## Transformation Rules
Business metrics are calculated using the Silver data:
- Calculate order amount (quantity × price).
- Calculate completed revenue only.
- Count orders by status.
- Calculate revenue by product.
- Calculate revenue by category.
- Calculate revenue by city.
- Calculate revenue by sales channel.

## Gold Layer
The Gold layer contains aggregated business-ready information. This layer includes reports and summary metrics that support business decision-making.

## Business Output
The final outputs include:
- Cleaned dataset
- Validation report
- Invalid records report
- Business report
- Revenue summaries
- Order statistics
- Product, category, city, and channel analysis

## What Makes This Data Trusted
The data is trusted because:
- Original raw data is preserved in the Bronze layer.
- Cleaning rules standardize inconsistent values.
- Validation removes incorrect or incomplete records.
- Only validated data is used for business calculations.
- Revenue is calculated only from completed orders.
- Every business result is based on verified and consistent data.