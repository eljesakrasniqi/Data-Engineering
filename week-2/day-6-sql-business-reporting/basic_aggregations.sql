--Count all orders
SELECT COUNT(*) AS total_orders
FROM orders;

--Count only completed orders
SELECT COUNT(*) AS total_orders
FROM orders
WHERE status = 'completed';

--Count only pending orders
SELECT COUNT(*) AS total_orders
FROM orders
WHERE status = 'pending';

--Count only cancelled orders
SELECT COUNT(*) AS total_orders
FROM orders
WHERE status = 'cancelled';

--Calculate total quantity ordered across all statuses
SELECT SUM(quantity) AS total_items_ordered
FROM orders;

--Calculate total quantity ordered only from completed orders
SELECT SUM(quantity) AS total_items_ordered
FROM orders
WHERE status = 'completed';

--Find the average product price
SELECT AVG(price) AS average_product_price
FROM products;

--Find the cheapest product price
SELECT MIN(price) AS cheapest_product_price
FROM products;

--Find the most expensive product price
SELECT MAX(price) AS most_expensive_product_price
FROM products;

--Calculate completed revenue using quantity * price. This requires connecting orders with products
SELECT SUM(quantity * price) AS completed_revenue
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE status = 'completed';

--Calculate non-completed potential value from pending and cancelled orders. Explain why this should not be counted as real revenue
SELECT
    status,
    SUM(quantity * price) AS potential_value
FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE status IN ('pending', 'cancelled')
GROUP BY status;

--Why shouldn't this be counted as real revenue?
-- Pending and cancelled orders should not be counted as real revenue because they do not represent completed sales. Pending orders may still be cancelled or remain unpaid, while cancelled orders will never generate income. Only orders with the completed status represent actual revenue earned by the business.