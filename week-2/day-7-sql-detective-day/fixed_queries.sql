--Fixed Query 1
SELECT
    customers.city,
    COUNT(*) AS order_count
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.city;
-- Mistake explanation: The city column is not in the orders table. It is in the customers table, so a JOIN with customers is required before grouping by city.
-- Business meaning: This query shows how many orders come from each city. A business user can use this information to understand which cities have the highest customer activity and where sales demand is stronger.

--Fiexed Query 2
SELECT 
    product_name,
    SUM(quantity * price) AS revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE status = 'completed'
GROUP BY product_name;
--Mistake explanation: This query was missing a comma after product_name in the SELECT statement. SQL requires commas to separate selected columns.
--Business meaning: This query shows how much revenue each product generated from completed orders only. A business user can identify the best-selling products and understand which products contribute the most to total income.

--Fixed Query 3
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;
--Mistake explanation: The semicolon is placed too early. ORDER BY must come before the final semicolon.
--Business meaning: This query shows the number of orders in each status (completed, pending, cancelled) and sorts them from highest to lowest. A business user can monitor order performance and understand the current order situation.

--Fixed query 4
SELECT
   orders.order_id,
   orders.quantity,
   products.price,
   orders.quantity * products.price AS total_amount
FROM orders
JOIN products ON orders.product_id = products.product_id;
--Mistake explanation: The orders table does not contain a price column. The price is stored in the products table, so a JOIN with products is needed to calculate the total amount.
--Business meaning: This query calculates the total amount for each order by multiplying the ordered quantity by the product price. A business user can see the value of each order and analyze individual sales transactions.

--Fixed query 5
SELECT
  products.category,
  SUM(orders.quantity) AS total_quantity
FROM orders
JOIN products ON orders.product_id = products.product_id 
WHERE status = 'completed'
GROUP BY products.category;
--Mistake explanation: The orders table does not contain a category column. The category is stored in the products table, so a JOIN with products is required before grouping by category.
--Business meaning: This query shows the total quantity of products sold in each category from completed orders. A business user can understand which product categories are most popular among customers.

--Fiexd Query 6
SELECT SUM(quantity * price) AS total_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id;
--Mistake explanation: The query calculates revenue for all orders. It should filter only completed orders using WHERE status = 'completed'
--Business meaning: This query calculates the total revenue generated only from completed orders. A business user can use this number to measure actual sales income and exclude orders that were not successfully completed.

--Fixed Query 7
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
--Mistake explanation: The HAVING clause was placed before GROUP BY. In SQL, GROUP BY must come before HAVING because HAVING filters the grouped results.
--Business meaning: This query identifies customers who have placed more than one order. A business user can use this information to find returning customers and analyze customer loyalty.

--Fiexed Query 8
SELECT 
  orders.order_id, 
  customers.customer_name
FROM orders
JOIN customers ON orders.customer_id = orders.order_id;
--Mistake explanation: The JOIN condition is incorrect. The tables should be connected using the matching customer_id column.
--Business meaning: This query shows each order together with the customer's name. A business user can connect sales transactions with customers to better understand who is purchasing products.

--Fiexed Query 9
SELECT 
 customers.customer_id, 
 products.product_id, 
 products.price
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id;
--Mistake explanation: The query only joins orders with products, but it selects customer_id which belongs to the customers table. A JOIN with customers is required to access customer information.
--Business meaning: This query combines order data with customer and product information. A business user can see which customers bought which products and analyze purchasing behavior.

--Fixed Query 10
SELECT *
FROM orders
WHERE status IN ('pending', 'cancelled');
--Mistake explanation: The query selects completed orders, but it should show orders that do not count as revenue. Pending and cancelled orders should be filtered instead.
--Business meaning: This query shows orders that are pending or cancelled. A business user can identify orders that do not generate revenue and monitor unfinished or unsuccessful sales.