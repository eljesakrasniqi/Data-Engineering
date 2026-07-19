# Layer Explanation - Day 10

## Bronze layer

### What files are stored here?
The Bronze layer stores the original raw files:
- orders_raw.csv
- customers_raw.csv
- products_raw.csv

### Why do we keep raw data unchanged?
Raw data is kept unchanged so it can always be used as the original source. This allows us to trace errors, repeat the pipeline if needed, and compare cleaned data with the original data.

### What data problems did you notice?
The raw data contained several issues, including:
- Inconsistent status values (Completed, complete, done).
- Different city name formats (prishtina, PRISHTINA, VUSHTRRI).
- Different channel values (online, Online, web).
- Missing values.
- Invalid customer IDs or product IDs.
- Invalid or negative quantities.
- Missing order dates.

---

## Silver layer

### What cleaning rules did you apply?
The following cleaning rules were applied:
- Normalized status values to completed, pending, or cancelled.
- Normalized city names.
- Normalized channel values.
- Replaced missing channels with unknown.
- Validated customer IDs and product IDs.
- Checked that quantity is a positive integer.
- Checked that order_date is not empty.

### Which records became invalid and why?
Records became invalid when they contained:
- Missing order_id.
- Missing order_date.
- Invalid customer_id.
- Invalid product_id.
- Missing quantity.
- Invalid or negative quantity.
- Invalid status.
- Invalid channel.

These records were saved in **invalid_orders.csv** together with the invalid_reason.

### What columns were added during enrichment?
The following columns were added:
- customer_name
- city
- product_name
- category
- price
- total_amount

### Why is Silver safer than Bronze?
The Silver layer contains only validated and cleaned data. Invalid records are removed, values are standardized, and additional business information is added, making the data reliable for reporting.

---

## Gold layer

### Which reports did you create?
The Gold layer includes:
- revenue_by_category.csv
- revenue_by_city.csv
- revenue_by_customer.csv
- top_products.csv
- business_summary.txt
- executive_summary.txt

### Which business questions do these reports answer?
These reports answer questions such as:
- What is the total completed revenue?
- Which product categories generate the most revenue?
- Which cities generate the highest sales?
- Which customers spend the most?
- Which products perform the best?

### Why should dashboards use Gold outputs instead of raw Bronze data?
Dashboards should use Gold outputs because the data has already been cleaned, validated, enriched, and aggregated. This ensures accurate business metrics, faster reporting, and reliable decision-making.