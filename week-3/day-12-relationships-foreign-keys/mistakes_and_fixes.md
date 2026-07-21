## Foreign Key Test 1
- Mistake in sql:
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (999, '2026-07-10', 'completed', 'online');

Error: FOREIGN KEY constraint failed

- Correct Insert in sql:
INSERT INTO orders (customer_id, order_date, status, channel)
VALUES (1, '2026-07-10', 'completed', 'online');

## Foreign Key Test 2
- Mistake in sql:
INSERT INTO order_items(order_id, product_id , quantity)
VALUES (999, 1, 1)

Error: FOREIGN KEY constraint failed

- Correct Insert in sql:
INSERT INTO order_items(order_id, product_id , quantity)
VALUES (1,1,1)

## Foreign Key Test 3:
- Mistake in sql:
INSERT INTO order_items(order_id, product_id , quantity)
VALUES (1, 999, 1)

Error: FOREIGN KEY constraint failed

-Correct Insert in sql:
INSERT INTO order_items(order_id, product_id , quantity)
VALUES (1, 1, 1)

## --CHECK test 1:
- Mistake in sql:
INSERT INTO products (product_name, category, price) 
VALUES('Laptop', 'Electronics', 0)

Error: CHECK constraint failed: price > 0 

- Correct Insert in sql:
INSERT INTO products (product_name, category, price)
VALUES ('Tablet', 'Electronics', 450);

## --CHECK test 2:
- Mistake in sql:
INSERT INTO order_items(order_id, product_id, quantity)
VALUES(1,1,0);

Error: CHECK constraint failed: quantity > 0 

- Correct Insert in sql:
INSERT INTO order_items(order_id, product_id, quantity)
VALUES(1,1,1);

## --Status check:
- Mistake in sql:
INSERT INTO orders(customer_id, order_date, status, channel)
VALUES(1, '2026-07-10', 'done', 'online');

Error: CHECK constraint failed: status IN ('completed', 'pending', 'cancelled')

- Correct Insert in sql:
INSERT INTO orders(customer_id, order_date, status, channel)
VALUES(1, '2026-07-10', 'completed', 'online');