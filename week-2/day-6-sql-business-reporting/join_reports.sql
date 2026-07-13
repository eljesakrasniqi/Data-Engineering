--Join orders with customers and show order_id, customer_name, city, order_date, and status
SELECT
    orders.order_id,
    customers.customer_name,
    customers.city,
    orders.order_date,
    orders.status
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

-- Join orders with products and show order_id, product_name, category, quantity, price, total_amount, and status
SELECT
    orders.order_id,
    products.product_name,
    products.category,
    orders.quantity,
    products.price,
    orders.quantity * products.price AS total_amount,
    orders.status
FROM orders
JOIN products ON orders.product_id = products.product_id;

--Join all three tables and create a complete order report with customer_name, city, product_name, category, quantity, price, total_amount, status, and order_date.
SELECT
    customers.customer_name,
    customers.city,
    products.product_name,
    products.category,
    orders.quantity,
    products.price,
    orders.quantity * products.price AS total_amount,
    orders.status
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id;

--Create completed revenue by product_name
SELECT
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_revenue DESC;

--Create completed revenue by category
SELECT
   products.category,
   SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY completed_revenue DESC;

--Create order count by city
SELECT
   customers.city,
   COUNT(*) AS order_count
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY order_count DESC;

--Create completed revenue by city
SELECT
   customers.city,
   SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.city
ORDER BY completed_revenue DESC;

--Create completed revenue by customer_name
SELECT
   customers.customer_name,
   SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.customer_name
ORDER BY completed_revenue DESC;

--Show customers with more than one order using GROUP BY and HAVING
SELECT
   customers.customer_name,
   COUNT(*) AS order_count
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_name
HAVING COUNT(*) > 1
ORDER BY order_count DESC;

--Show top 3 customers by completed revenue
SELECT
    customers.customer_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY customers.customer_name
ORDER BY completed_revenue DESC
LIMIT 3;

--Show top 3 products by completed revenue
SELECT
   products.product_name,
   SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name
ORDER BY completed_revenue DESC
LIMIT 3;

-- Show all pending or cancelled orders with customer_name, city, product_name, and potential_amount
SELECT
    customers.customer_name,
    customers.city,
    products.product_name,
    (orders.quantity * products.price) AS potential_amount
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id
WHERE orders.status IN ('pending', 'cancelled')
ORDER BY potential_amount DESC;