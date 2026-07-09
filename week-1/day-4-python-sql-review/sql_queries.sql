--Show all orders:
SELECT * 
FROM orders;

--Show only customer_name and product
SELECT customer_name, product
FROM orders;

--Show order_id, customer_name, city, and status
SELECT order_id, customer_name, city, status
FROM orders;

--Show product, category, quantity, and price:
SELECT product, category, quantity, price
FROM orders;

--Show only completed orders
SELECT *
FROM orders
WHERE status = 'completed';

--Show only completed orders
SELECT *
FROM orders
WHERE status = 'pending';

--Show only cancelled orders
SELECT *
FROM orders
WHERE status = 'cancelled';

--Show orders where price is greater than 100
SELECT *
FROM orders
WHERE price > 100;

--Show orders from Vushtrri
SELECT *
FROM orders
WHERE city = 'Vushtrri';

--Show orders where category is Accessories
SELECT *
FROM orders
WHERE category = 'Accessories';

--Show completed orders where price is greater than 100
SELECT *
FROM orders
WHERE status = 'completed'
AND price > 100;

--Show completed orders from Prishtina
SELECT *
FROM orders
WHERE status = 'completed'
AND city = 'Prishtina';

--Show orders where status is pending OR cancelled
SELECT *
FROM orders
WHERE status = 'pending'
OR status = 'cancelled';

--Show Accessories orders where price is less than 50
SELECT *
FROM orders
WHERE category = 'Accessories'
AND price < 50;

--Show orders from cheapest to most expensive
SELECT *
FROM orders
ORDER BY price ASC;

--Show orders from most expensive to cheapest
SELECT *
FROM orders
ORDER BY price DESC;

--Show top 3 most expensive orders by price
SELECT *
FROM orders
ORDER BY price DESC
LIMIT 3;

--Show top 3 orders by total_amount
SELECT
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
LIMIT 3;

--Show only completed orders with total_amount
SELECT
    customer_name,
    product,
    status,
    quantity,
    price,
    quantity * price AS total_amount
FROM orders
WHERE status = 'completed';


--Part 4 - Mini business challenge

--Find the customer with the most expensive single order
SELECT customer_name, product, price
FROM orders
ORDER BY price DESC
LIMIT 1;

--Find the highest total_amount order.
SELECT 
    customer_name, 
    product, 
    price * quantity AS total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 1;

--Find all orders that should NOT be counted as real revenue because they are pending or cancelled
SELECT 
    customer_name,
    product,
    status,
    price * quantity AS total_amount
FROM orders
WHERE status IN ('pending', 'cancelled');

--Calculate completed revenue only. Cancelled and pending orders should not be included.
SELECT 
    SUM(price * quantity) AS completed_revenue
FROM orders
WHERE status = 'completed';

--Create a short business answer: Which order looks most valuable and why?
-- Answer: The most valuable order is the one with the highest total_amount because it generates the highest revenue from a single transaction. 

-- Business answer: Why should cancelled orders not be counted as revenue?
-- Answer: Cancelled orders should not be counted as revenue because the business did not successfully complete the sale and did not receive actual payment.