-- 1. Show all clean orders
SELECT *
FROM clean_orders;


-- 2. Calculate completed revenue
SELECT 
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed';


-- 3. Count orders by status
SELECT 
    status,
    COUNT(*) AS order_count
FROM clean_orders
GROUP BY status;


-- 4. Count orders by city
SELECT 
    city,
    COUNT(*) AS order_count
FROM clean_orders
GROUP BY city;


-- 5. Calculate completed revenue by city
SELECT 
    city,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY city
ORDER BY completed_revenue DESC;


-- 6. Calculate completed revenue by category
SELECT 
    category,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY category
ORDER BY completed_revenue DESC;


-- 7. Show top 5 orders by total_amount
SELECT 
    order_id,
    customer_name,
    product_name,
    total_amount
FROM clean_orders
ORDER BY total_amount DESC
LIMIT 5;


-- 8. Show top customers by completed revenue
SELECT 
    customer_name,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY customer_name
ORDER BY completed_revenue DESC
LIMIT 5;


-- 9. Count orders by channel
SELECT 
    channel,
    COUNT(*) AS order_count
FROM clean_orders
GROUP BY channel;


-- 10. Find the city with the highest completed revenue
SELECT 
    city,
    SUM(total_amount) AS completed_revenue
FROM clean_orders
WHERE status = 'completed'
GROUP BY city
ORDER BY completed_revenue DESC
LIMIT 1;