# Logic Explanations

## 1. Why did I validate orders before calculating revenue?

Validation ensures that only correct and trustworthy data is used in the analysis. Orders with an empty customer name, a quantity less than or equal to zero, or a price less than or equal to zero are considered invalid. If these records were included, the revenue and business metrics would be incorrect.

---

## 2. How does status normalization work?

The `normalize_status()` function converts all status values to lowercase and replaces different versions of completed orders with a single value.

Examples:
- Completed - completed
- complete - completed
- completed - completed

This creates consistent data for filtering and reporting.

---

## 3. Why do only completed orders count as revenue?

Only completed orders represent successful sales. Pending orders have not been finished, cancelled orders were never completed, and returned orders were refunded. Including these orders would overestimate the company's actual revenue.

---

## 4. How does `count_by_field()` work?

The `count_by_field()` function receives a list of records and a field name.

Steps:
1. Create an empty dictionary.
2. Loop through every record.
3. Read the value of the selected field.
4. If the value already exists in the dictionary, increase its count.
5. Otherwise, add it with a count of 1.
6. Return the completed dictionary.

This function works dynamically for any field, such as city, category, status, or channel.

---

## 5. How does `sum_revenue_by_field()` work?

The function groups completed revenue by a selected field.

Steps:
1. Create an empty dictionary.
2. Loop through completed orders.
3. Read the selected field value.
4. Add the order's `total_amount` to that field's total.
5. Return the revenue dictionary.

This allows revenue to be calculated by city, customer, category, or channel without hardcoding values.

---

## 6. How is sorting used to find top records?

The records are sorted using Python's `sorted()` function with the `total_amount` value as the sorting key. The records are sorted in descending order (`reverse=True`), and the first records are selected as the top orders, customers, products, or cities.

---

## 7. What does `main()` do and why is it useful?

The `main()` function controls the entire program.

It:
- loads the raw data,
- validates the records,
- cleans and normalizes the data,
- calculates business metrics,
- prints the results,
- generates the output files.

Using `main()` keeps the code organized, easier to read, easier to test, and prevents functions from running automatically when the file is imported.

---

## 8. Example metric: Completed Revenue

The completed revenue is calculated by:
1. Validating all orders.
2. Removing invalid records.
3. Selecting only orders whose status is `completed`.
4. Calculating `total_amount = quantity × price` for each completed order.
5. Adding all completed order totals together.

The final result represents the company's real revenue from valid completed sales only.