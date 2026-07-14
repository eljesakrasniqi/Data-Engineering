# Verified Business Report - Day 7 SQL Detective Day

## 1. Total Order Activity

Insight: The database contains all recorded customer orders.
Verified result: [Total number of orders]
SQL query used: V1 – Count all orders
Business meaning: This confirms the total transaction activity stored in the system.

---

## 2. Completed Revenue

Insight: Only completed orders are included when calculating revenue.
Verified result:[Total completed revenue]
SQL query used: V7 – Calculate completed revenue only
Business meaning: Pending and cancelled orders are excluded because they do not represent completed sales.

---

## 3. Revenue by Product

Insight: Revenue is calculated separately for each product.
Verified result: [List each product with its completed revenue.]
SQL query used: V8 – Completed revenue by product_name
Business meaning: Shows which products generate the most revenue.

---

## 4. Revenue by Category

Insight: Revenue is grouped by product category.
Verified result: [List categories and revenue.]
SQL query used: V9 – Completed revenue by category
Business meaning: Helps identify the best-performing product categories.

---

## 5. Orders by City

Insight: Customer orders are grouped by city.
Verified result: [List cities with order counts.]
SQL query used: V10 – Count orders by city
Business meaning: Shows where customer activity is highest.

---

## 6. Customers with More Than One Order

Insight: Some customers have placed multiple orders.
Verified result: [List customers with more than one order.]
SQL query used: V11 – Customers with more than one order
Business meaning: These customers may represent loyal or repeat buyers.

---

## 7. Orders Not Counted as Revenue

Insight: Pending and cancelled orders are excluded from revenue calculations.
Verified result: [List pending/cancelled orders or total count.]
SQL query used: V13 – Orders that should not count as real revenue
Business meaning: This ensures reported revenue reflects only completed sales.

---

## 8. Final Recommendation

Based on the verified SQL results, I recommend focusing on the products and categories that generate the highest completed revenue while also monitoring cities with the highest order activity. Repeat customers should be targeted with loyalty programs, and pending or cancelled orders should be analyzed to improve order completion rates.