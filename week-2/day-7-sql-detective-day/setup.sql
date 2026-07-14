-- Drop existing tables
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- Create customers table
CREATE TABLE customers (
customer_id INTEGER,
customer_name TEXT,
city TEXT
);

-- Create products table
CREATE TABLE products (
product_id INTEGER,
product_name TEXT,
category TEXT,
price INTEGER
);

-- Create orders table
CREATE TABLE orders (
order_id INTEGER,
customer_id INTEGER,
product_id INTEGER,
order_date TEXT,
quantity INTEGER,
status TEXT
);

-- Insert data into customers
INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Arta', 'Vushtrri'),
(2, 'Blend', 'Prishtina'),
(3, 'Dren', 'Mitrovica'),
(4, 'Elira', 'Prishtina'),
(5, 'Nora', 'Vushtrri'),
(6, 'Leart', 'Peja'),
(7, 'Faton', 'Prizren'),
(8, 'Rina', 'Vushtrri'),
(9, 'Arben', 'Ferizaj'),
(10, 'Gresa', 'Prishtina');

-- Insert data into products
INSERT INTO products (product_id, product_name, category, price) VALUES
(101, 'Laptop', 'Electronics', 700),
(102, 'Mouse', 'Accessories', 15),
(103, 'Keyboard', 'Accessories', 40),
(104, 'Monitor', 'Electronics', 180),
(105, 'Headphones', 'Accessories', 50),
(106, 'Desk Chair', 'Office', 120),
(107, 'USB Cable', 'Accessories', 8),
(108, 'Desk', 'Office', 220);

-- Insert data into orders
INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity, status) VALUES
(1, 1, 101, '2026-07-01', 1, 'completed'),
(2, 2, 102, '2026-07-01', 2, 'completed'),
(3, 1, 103, '2026-07-02', 1, 'cancelled'),
(4, 3, 104, '2026-07-02', 1, 'completed'),
(5, 4, 102, '2026-07-03', 1, 'completed'),
(6, 3, 101, '2026-07-03', 1, 'pending'),
(7, 5, 105, '2026-07-04', 1, 'completed'),
(8, 6, 104, '2026-07-04', 2, 'completed'),
(9, 7, 106, '2026-07-05', 1, 'completed'),
(10, 2, 107, '2026-07-05', 3, 'completed'),
(11, 8, 101, '2026-07-06', 1, 'cancelled'),
(12, 9, 108, '2026-07-06', 1, 'pending'),
(13, 10, 102, '2026-07-07', 4, 'completed'),
(14, 4, 105, '2026-07-07', 2, 'completed');


---Verification queries
SELECT * FROM orders;

SELECT * FROM customers;

SELECT * FROM products;