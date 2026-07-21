-- Foreign Key Test 1: Try to insert an order with a customer_id that does not exist.
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (999, '2026-07-10', 'completed', 'online');

-- Foreign key test 2: Try to insert an order_item with an order_id that does not exist
INSERT INTO order_items(order_id, product_id , quantity)
VALUES (999, 1, 1);

--Foreign Key Test 3: Try to insert an order_item with a product_id that does not exist
INSERT INTO order_items(order_id, product_id , quantity)
VALUES (1, 999, 1);

--CHECK test 1: Try to insert a product with price 0 or negative price
INSERT INTO products (product_name, category, price) 
VALUES('Laptop', 'Electronics', 0);

--CHECK test 2: Try to insert an order_item with quantity 0
INSERT INTO order_items(order_id, product_id, quantity)
VALUES(1,1,0);

--Status test: Try to insert an order with status done
INSERT INTO orders(customer_id, order_date, status, channel)
VALUES(1, '2026-07-10', 'done', 'online');