--Count orders by status
SELECT
status,
COUNT(*) AS order_count
FROM orders
GROUP BY status;
ORDER BY order_count DESC;

--Count orders by order_date
SELECT
order_date,
COUNT(*) AS order_count
FROM orders
GROUP BY order_date;
ORDER BY order_count DESC;

--Count orders by customer_id
SELECT
customer_id,
COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
ORDER BY order_count DESC;

--Count orders by product_id
SELECT
product_id,
COUNT(*) AS order_count
FROM orders
GROUP BY product_id;
ORDER BY order_count DESC;

--Calculate total quantity by product_id for completed orders only
SELECT
product_id,
SUM(quantity) AS total_quantity
FROM orders
WHERE status = 'completed'
GROUP BY product_id
ORDER BY total_quantity DESC;

--Calculate completed revenue by product_id
SELECT
    orders.product_id,
    products.product_name,
    SUM(orders.quantity * products.price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE orders.status = 'completed'
GROUP BY orders.product_id, products.product_name
ORDER BY completed_revenue DESC;

--Calculate completed revenue by status and explain why the result is not always a good business report.
SELECT
    orders.status,
    SUM(orders.quantity * products.price) AS revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
GROUP BY orders.status
ORDER BY revenue DESC;

--Use HAVING to show only customer_id values with more than one order
SELECT
customer_id,
COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
ORDER BY order_count DESC;

--Use HAVING to show only product_id values where completed quantity is greater than 2
SELECT
    product_id,
    SUM(quantity) AS completed_quantity
FROM orders
WHERE status = 'completed'
GROUP BY product_id
HAVING SUM(quantity) > 2;
ORDER BY completed_quantity DESC;