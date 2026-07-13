# Business Report - Day 6 SQL Business Reporting Sprint

## 1. Total orders:
The database contains 14 total orders.
This represents all transactions recorded in the system, including completed, pending, and cancelled orders.

## 2. Completed orders:
There are 10 completed orders.
These orders represent successful sales and are the only orders that should contribute to real revenue calculations.

## 3. Pending orders:
There are 2 pending orders.
These orders are not completed yet, so they should not be included in current revenue reports.

## 4. Cancelled orders:
There are 2 cancelled orders.
These orders should not be counted as revenue because the sales were not completed.

## 5. Completed revenue:
The total completed revenue is 1639.
This value is calculated only from completed orders: `quantity × product price`
Pending and cancelled orders are excluded from this calculation.

## 6. Product with highest completed revenue:
The product with the highest completed revenue is Laptop with 700 revenue.
Laptop generates the largest amount of income and is the most valuable product based on completed sales.

## 7. Category with highest completed revenue:
The category with the highest completed revenue is Electronics with 1240.
Electronics products contribute the majority of the company's completed revenue.

## 8. City with most orders:
The city with the most orders is Prishtina with 5 orders.
This shows that Prishtina has the highest transaction activity among all cities.

## 9. City with highest completed revenue:
The city with the highest completed revenue is Vushtrri with 750.
Although Prishtina has more orders, Vushtrri generates more revenue because of higher-value purchases, especially the Laptop order.

## 10. Customer with highest completed revenue:
The customer with the highest completed revenue is Arta with 700.
Arta is currently the most valuable customer based on completed purchases.

## 11. Customers with more than one order:
Customers who placed more than one order are:
Arta - 2 orders
Blend - 2 orders
Dren - 2 orders
Elira - 2 orders
These customers may represent returning customers and could be targeted with loyalty offers.

## 12. Orders that should not count as real revenue:
The following orders should not count as real revenue:
Pending orders: Order ID 6 and 12
Cancelled orders: Order ID 3 and 11
Pending orders may become revenue in the future, but cancelled orders represent lost sales.

## 13. One business recommendation:
The company should focus on promoting high-performing products such as laptops and other electronics because they generate the highest revenue.
The company should also encourage repeat purchases from customers who already order multiple times.

## 14. One data quality or reporting risk:
A reporting risk is incorrect order status information.
If cancelled or pending orders are accidentally included in revenue calculations, the company may overestimate its actual income.

## 15. What this report would help a manager decide:
This report helps managers:
- understand overall sales performance,
- identify the most profitable products and categories,
- find valuable customers,
- compare business activity between cities,
- make better decisions about marketing, inventory, and sales strategies.
