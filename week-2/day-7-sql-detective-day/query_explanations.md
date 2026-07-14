# Query Explanations - Day 7 SQL Detective Day

## Fixed Query 1

What the query does: Counts the number of orders for each city.
Tables used: orders, customers
Why JOIN is needed: The city column is stored in the customers table, not in the orders table. The JOIN connects each order with the correct customer.
What the result means: Shows how many orders were placed by customers from each city.

---

## Fixed Query 2

What the query does: Calculates completed revenue for each product.
Tables used: orders, products
Why JOIN is needed: The product name and price are stored in the products table.
What the result means: Shows which products generated the most completed revenue.

---

## Fixed Query 3

What the query does: Counts the number of orders for each order status.
Tables used: orders
Why JOIN is needed: No JOIN is required because all required columns are in the orders table.
What the result means: Displays how many orders are completed, pending, or cancelled.

---

## Fixed Query 4

What the query does: Calculates the total amount for each order using quantity × price.
Tables used: orders, products
Why JOIN is needed: The price column is stored in the products table.
What the result means: Shows the value of each order.

---

## Fixed Query 5

What the query does: Calculates the completed quantity sold for each product category.
Tables used: orders, products
Why JOIN is needed: Category belongs to the products table.
What the result means: Shows how many completed items were sold in each category.

---

## Fixed Query 6

What the query does: Calculates total completed revenue.
Tables used: orders, products
Why JOIN is needed: Price is stored in the products table.
What the result means: Displays the total revenue from completed orders only.

---

## Fixed Query 7

What the query does: Finds customers who have placed more than one order.
Tables used: orders
Why JOIN is needed: No JOIN is required because only customer IDs are needed.
What the result means: Identifies repeat customers.

---

## Fixed Query 8

What the query does: Displays each order together with the customer's name.
Tables used: orders, customers
Why JOIN is needed: Customer names are stored in the customers table.
What the result means: Links every order to the customer who placed it.

---

# Validation Query Explanations

## Validation Query 1 - Count All Orders

What the query does: Counts every order in the database.
Tables used: orders
Why JOIN is needed: No JOIN is required.
What the result means: Confirms the total number of recorded orders.

---

## Validation Query 2 - Completed Revenue

What the query does: Calculates revenue using only completed orders.
Tables used: orders, products
Why JOIN is needed: Price comes from the products table.
What the result means: Shows the actual revenue earned from completed sales.

---

## Validation Query 3 - Revenue by Product

What the query does: Calculates completed revenue for every product.
Tables used: orders, products
Why JOIN is needed: Product names and prices are stored in the products table.
What the result means: Shows which products contribute the most revenue.

---

## Validation Query 4 - Orders by City

What the query does: Counts orders for each customer city.
Tables used: orders, customers
Why JOIN is needed: The city column exists in the customers table.
What the result means: Shows where customer activity is highest.

---

## Validation Query 5 - Customers with More Than One Order

What the query does: Finds customers who placed multiple orders.
Tables used: orders
Why JOIN is needed: No JOIN is required because only customer IDs are counted.
What the result means: Identifies repeat customers who may be valuable for the business.