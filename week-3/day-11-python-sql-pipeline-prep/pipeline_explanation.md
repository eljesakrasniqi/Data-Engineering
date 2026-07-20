# Pipeline Explanation

## Data Understanding

### How many raw orders exist?
There are **[number of records]** raw orders in `orders_raw.csv`.

### Which columns are used to join orders with customers and products?
- `customer_id` is used to join orders with customers.
- `product_id` is used to join orders with products.

### Which values look inconsistent?
Some inconsistent values found in the raw data include:
- Different status values such as `Completed`, `complete`, `done`, and `completed`.
- Different city formats such as `prishtina`, `PRISHTINA`, and `VUSHTRRI`.
- Different channel values such as `web`, `online`, `Online`, and `mobile`.
- Missing values in some fields.
- Invalid quantities or prices.

### Which records should not be trusted for revenue?
The following records should not be used for revenue calculations:
- Orders with invalid or missing `customer_id`.
- Orders with invalid or missing `product_id`.
- Orders with missing `order_id`.
- Orders with missing `order_date`.
- Orders with invalid quantities (zero, negative, or non-numeric).
- Duplicate `order_id` values.
- Products with invalid prices.
- Orders that are not in **completed** status.

### Which file is Bronze, which output should be Silver, and which output should be Gold?

**Bronze Layer**
- `orders_raw.csv`
- `customers_raw.csv`
- `products_raw.csv`

**Silver Layer**
- `orders_clean.csv`
- `customers_clean.csv`
- `products_clean.csv`
- `invalid_orders.csv`

**Gold Layer**
- `revenue_by_category.csv`
- `revenue_by_city.csv`
- `revenue_by_customer.csv`
- `top_products.csv`
- `data_quality_report.txt`
- `executive_summary.txt`