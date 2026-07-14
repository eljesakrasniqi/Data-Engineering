--Show all rows from the orders table
SELECT * from orders;

--Show all rows from the customers table
SELECT * from customers;

--Show all rows from the products table
SELECT * from products;

--Check how many order records exist in the orders table
SELECT COUNT(*) AS total_orders
FROM orders;

--Check how many customers records exist in the customers table
SELECT COUNT (*) AS total_customers
FROM customers;

--Check how many products records exist in the products table
SELECT COUNT(*) AS total_products
FROM products;