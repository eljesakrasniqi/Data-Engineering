# INNER JOIN vs LEFT JOIN

## INNER JOIN
INNER JOIN returns only records that have matching values in both tables.

Example:
If a customer has orders, the customer will appear in the result.
If a customer has no orders, that customer will not appear.


## LEFT JOIN
LEFT JOIN returns all records from the left table and matching records from the right table. If there is no match, the columns from the right table will contain NULL values.


## Main Difference

INNER JOIN:
- Shows only matching records from both tables.
- Removes records without relationships.

LEFT JOIN:
- Shows everything from the left table.
- Keeps records even when there is no match.



# Part 6 - Auto Increment Understanding

## 34. What happened when you inserted a customer without specifying customer_id?

When I inserted a customer without providing `customer_id`, the database automatically generated a unique ID value for that customer. The AUTOINCREMENT feature handled the ID creation automatically.

---

## 35. Why is AUTOINCREMENT useful?

AUTOINCREMENT is useful because it creates unique IDs automatically for each new record. It prevents duplicate IDs and saves time because we do not need to manually create IDs.

---

## 36. Should we manually choose IDs in a real database? Why or why not?

No, we should not manually choose IDs in a real database. The database should generate them because manual IDs can create duplicates, mistakes, and conflicts when many users are adding data.

---

## 37. What happens if we delete a row? Does AUTOINCREMENT reuse the old ID?

No, AUTOINCREMENT does not reuse old IDs. If a row is deleted, the next inserted record receives a new higher ID value.

Example:

Customer IDs:
1, 2, 3

If customer 3 is deleted, the next customer will get ID 4, not ID 3.

---

## 38. Why is a stable unique ID better than using customer_name as the identifier?

A stable unique ID is better because names are not always unique and can change. Multiple customers can have the same name, but each customer_id is always unique and remains the same.




# Day 12 - Relationships, Foreign Keys, and JOINs

## Project Goal

The goal of this project was to learn how to build a relational database using SQLite. I created related tables, used primary keys, foreign keys, auto increment IDs, and wrote JOIN queries to generate business reports.

---

## Database Tables

The database contains four tables:

- **customers** – stores customer information.
- **products** – stores product information.
- **orders** – stores order details.
- **order_items** – connects orders and products and stores the quantity of each product.

---

## Primary Keys

Each table has a primary key that uniquely identifies every record.

- customers → customer_id
- products → product_id
- orders → order_id
- order_items → order_item_id

Primary keys make every row unique.

---

## Foreign Keys

Foreign keys create relationships between tables.

- orders.customer_id → customers.customer_id
- order_items.order_id → orders.order_id
- order_items.product_id → products.product_id

They help keep the data valid and prevent invalid relationships.

---

## Auto Increment

Each primary key uses AUTOINCREMENT.

When a new record is inserted, SQLite automatically creates the next available ID.

This prevents duplicate IDs and makes inserting data easier.

---

## Relationships

The database has these relationships:

- One customer → Many orders
- One order → Many order items
- One product → Many order items

The **order_items** table creates the many-to-many relationship between orders and products.

---

## Valid and Invalid Insert Tests

I tested the database by inserting both valid and invalid data.

Invalid tests included:
- Order with a customer_id that does not exist.
- Order item with an invalid order_id.
- Order item with an invalid product_id.
- Product with price equal to 0.
- Order item with quantity equal to 0.
- Order with an invalid status.

SQLite rejected these inserts because of FOREIGN KEY and CHECK constraints.

---

## INNER JOIN vs LEFT JOIN

INNER JOIN returns only matching rows from both tables.

LEFT JOIN returns all rows from the left table and matching rows from the right table. If no match exists, NULL values are returned for the right table.

---

## Business Reports

I created SQL queries to generate business reports such as:

- Orders with customer information.
- Orders with product details.
- Revenue by city.
- Revenue by product category.
- Top customers by completed revenue.
- Top products by completed revenue.
- Orders per customer.
- Products sold more than once.
- Customers with multiple orders.

---

## What I Can Explain Live

I can explain:

- Primary Keys
- Foreign Keys
- AUTOINCREMENT
- One-to-Many and Many-to-Many relationships
- Why order_items is needed
- INNER JOIN and LEFT JOIN
- GROUP BY, COUNT, SUM, ORDER BY, HAVING
- How business reports are created using JOINs

---

## What I Would Improve Next

If I continue improving this project, I would:

- Add more sample data.
- Create more business reports.
- Use indexes to improve query performance.
- Add more validation rules.
- Learn advanced JOINs and SQL functions.