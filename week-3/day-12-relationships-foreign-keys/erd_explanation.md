# ERD Explanation

## 1. What are the main entities in this project?

The main entities in this project are:
- Customers
- Products
- Orders
- Order Items

These entities store information about customers, products, purchases, and the products included in each order.

---

## 2. Which table should store customers?

The customers table should store customer information such as:
- customer_id
- customer_name
- city
- segment

Each customer should appear only once in this table.

---

## 3. Which table should store products?

The products table should store product information such as:
- product_id
- product_name
- category
- price

Each product should be stored only once.

---

## 4. Which table should store orders?

The orders table should store information about each order, including:
- order_id
- customer_id
- order_date
- status
- channel

It connects every order to the customer who placed it.

---

## 5. Why should orders not repeat all customer and product details directly?

Orders should not repeat customer and product details because it creates duplicate data. If customer or product information changes, it would need to be updated in many places. Storing the data only once makes the database cleaner, easier to maintain, and reduces errors.

---

## 6. What is the relationship between customers and orders?

The relationship is **One-to-Many (1:N)**.

One customer can place many orders, but each order belongs to only one customer.

---

## 7. What is the relationship between orders and products?

The relationship is **Many-to-Many (N:M)**.

One order can contain many products, and one product can appear in many different orders.

---

## 8. Why do we need an order_items table?

The order_items table connects orders and products.

It stores:
- order_item_id
- order_id
- product_id
- quantity

Without this table, it would not be possible to store multiple products in one order or track the quantity of each product. It acts as a bridge between the **orders** and **products** tables.