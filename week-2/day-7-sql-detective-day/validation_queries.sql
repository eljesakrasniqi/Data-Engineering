-- V1 Count all orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- V2 Count completed orders
SELECT COUNT(*) AS completed_orders
FROM orders
WHERE status = 'completed';

-- V3 Count pending orders
SELECT COUNT(*) AS pending_orders
FROM orders
WHERE status = 'pending';

-- V4 Count cancelled orders
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE status = 'cancelled';

-- V5 Count all customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- V6 Count all products
SELECT COUNT(*) AS total_products
FROM products;

-- V7 Calculate completed revenue only. Pending and cancelled orders must not be included.
SELECT 
   SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed';

-- V8 Calculate completed revenue by product_name
SELECT 
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.product_name;

-- V9 Calculate completed revenue by category
SELECT 
    products.category,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category;

-- V10 Count orders by 
SELECT 
    customers.city,
    COUNT(*) AS order_count
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY order_count DESC;

-- V11 Find customers with more than one order
SELECT 
    customers.customer_id,
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.customer_name
HAVING COUNT(orders.order_id) > 1;

-- V12 Find top 3 completed orders by total_amount
SELECT 
    orders.order_id,
    customers.customer_name,
    products.product_name,
    (orders.quantity * products.price) AS total_amount
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
ORDER BY total_amount DESC
LIMIT 3;

-- V13 Find orders that should not count as real revenue
SELECT *
FROM orders
WHERE status IN ('pending', 'cancelled');

-- V14 Find category with highest completed revenue
SELECT 
    products.category,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY products.category
ORDER BY completed_revenue DESC
LIMIT 1;

--V15 Find which city has the highest order activity
SELECT 
    customers.city,
    COUNT(orders.order_id) AS order_activity
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.city
ORDER BY order_activity DESC
LIMIT 1;