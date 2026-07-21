--Level 1 - Basic SELECT and Relationship Checks:

-- Show all customers
SELECT *
FROM customers;

--Show all products
SELECT *
FROM products;

--Show all orders
SELECT *
FROM orders;

--Show all order_items
SELECT *
FROM order_items;

--Show only completed orders
SELECT *
FROM orders
WHERE status = 'completed';

--Show only pending or cancelled orders
SELECT *
FROM orders
WHERE status IN ('pending', 'cancelled');

-- Level 2 - First INNER JOINs

--Show each order with customer_name, city, order_date, status, and channel
SELECT
   customers.customer_name,
   customers.city, 
   orders.order_date,
   orders.status,
   orders.channel
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

--Show each order_item with product_name, category, price, and quantity
SELECT
    products.product_name,
    products.category,
    products.price,
    order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.product_id;

--Show order_id, customer_name, product_name, quantity, price, and total_amount
SELECT
    orders.order_id,
    customers.customer_name,
    products.product_name,
    order_items.quantity,
    products.price,
    (order_items.quantity * products.price) AS total_amount
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON order_items.product_id = products.product_id
JOIN order_items ON orders.order_id = order_items.order_id;

--Show only completed orders with their customer and product details
SELECT
    orders.order_id,
    customers.customer_name,
    products.product_name,
    orders.status,
    order_items.quantity,
    products.price,
    (order_items.quantity * products.price) AS total_amount
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON order_items.product_id = products.product_id
JOIN order_items ON orders.order_id = order_items.order_id
WHERE orders.status = 'completed';

--Level 3 - Multi-table JOINs

--Join customers + orders + order_items + products in one query
SELECT
    customers.customer_name,
    orders.order_id,
    orders.order_date,
    orders.status,
    products.product_name,
    products.category,
    products.price,
    order_items.quantity,
    (order_items.quantity * products.price) AS total_amount
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id;

--Show customer_name, city, order_id, product_name, category, quantity, price, total_amount.
SELECT
    customers.customer_name,
    customers.city,
    orders.order_id,
    products.product_name,
    products.category,
    order_items.quantity,
    products.price,
    (order_items.quantity * products.price) AS total_amount
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id;

--Sort the result by order_id and then by product_name
SELECT
    customers.customer_name,
    customers.city,
    orders.order_id,
    products.product_name,
    products.category,
    order_items.quantity,
    products.price,
    (order_items.quantity * products.price) AS total_amount
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
ORDER BY
    orders.order_id,
    products.product_name;

--Filter the joined result to show only completed orders
SELECT
    customers.customer_name,
    customers.city,
    orders.order_id,
    products.product_name,
    products.category,
    orders.status,
    order_items.quantity,
    products.price,
    (order_items.quantity * products.price) AS total_amount
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE status = 'completed'
ORDER BY
    orders.order_id,
    products.product_name;


--Level 4 - Business Reports with Relationships

--Calculate completed revenue by city
SELECT
    customers.city,
    SUM(order_items.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.city;

--Calculate completed revenue by product category
SELECT 
   products.category,
   SUM(order_items.quantity * products.price) AS completed_revenue
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE status = 'completed'
GROUP BY products.category;

--Show top 5 customers by completed revenue
SELECT
    customers.customer_name,
    SUM(order_items.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.customer_name
ORDER BY completed_revenue DESC
LIMIT 5;

--Show top 5 products by completed revenue.
SELECT
    products.product_name,
    SUM(order_items.quantity * products.price) AS completed_revenue
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_revenue DESC
LIMIT 5;

--Count how many orders each customer has
SELECT
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name;

--Count how many items each order has
SELECT 
   orders.order_id,
   COUNT(order_items.order_id) AS total_items
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY orders.order_id;

--Find customers who have more than one order
SELECT
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_name
HAVING COUNT(orders.order_id) > 1;

--Find products that were sold more than once
SELECT
    products.product_name,
    COUNT(order_items.product_id) AS times_sold
FROM order_items
JOIN products ON order_items.product_id = products.product_id
GROUP BY products.product_name
HAVING COUNT(order_items.product_id) > 1;

--Level 5 - LEFT JOIN Thinking

-- Show all customers and their orders
SELECT
    customers.customer_name,
    customers.city,
    orders.order_id,
    orders.order_date,
    orders.status,
    orders.channel
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;

-- Show all products and number of times they appear in order_items
SELECT
    products.product_name,
    COUNT(order_items.product_id) AS times_sold
FROM products
LEFT JOIN order_items ON products.product_id = order_items.product_id
GROUP BY products.product_name;