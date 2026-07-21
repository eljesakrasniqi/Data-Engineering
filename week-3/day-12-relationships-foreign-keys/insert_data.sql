INSERT INTO customers (customer_name, city, segment) VALUES
('Arta', 'Vushtrri', 'Individual'),
('Blend', 'Prishtina', 'Individual'),
('Dren', 'Mitrovica', 'Business'),
('Elira', 'Peja', 'Individual'),
('Leart', 'Ferizaj', 'Business'),
('Gresa', 'Gjakova', 'Individual');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 700.00),
('Mouse', 'Accessories', 15.00),
('Monitor', 'Electronics', 180.00),
('Keyboard', 'Accessories', 35.00),
('Desk', 'Furniture', 150.00),
('Headphones', 'Accessories', 50.00);

INSERT INTO orders (customer_id, order_date, status, channel) VALUES
(1, '2026-07-01', 'completed', 'online'),
(2, '2026-07-02', 'completed', 'store'),
(3, '2026-07-03', 'pending', 'online'),
(1, '2026-07-04', 'completed', 'store'),
(4, '2026-07-05', 'cancelled', 'online'),
(5, '2026-07-06', 'completed', 'online'),
(6, '2026-07-07', 'completed', 'store'),
(2, '2026-07-08', 'completed', 'online');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),

(2, 3, 1),

(3, 4, 1),

(4, 1, 1),
(4, 6, 2),

(5, 5, 1),

(6, 2, 3),
(6, 4, 1),

(7, 3, 2),

(8, 1, 1),
(8, 5, 1);