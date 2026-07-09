## Task 1: Show completed orders
   Python approach:
   - Go through each order in the list.
   - Check whether the status is "completed".
   - Display only the orders that match.  

   SQL approach:
   - Select the required columns.
   - Retrieve data from the orders table. 
   - Filter the results using WHERE status = 'completed'.

   What I understood:
   Python filters data by checking each order with a loop and an if statement. SQL performs the filtering inside the query using the WHERE clause, so only the matching rows are returned.

## Task 2: Show orders with price > 100
   Python approach:
   - Loop through each order.
   - Use an `if` statement to check if `price > 100`.
   - Print matching orders.  

   SQL approach:
   - Select the required columns.
   - Retrieve data from the orders table. 
   - Filter the results using WHERE price > 100.

   What I understood:
   Python checks every record one by one. SQL automatically returns only the rows that satisfy the condition.

## Task 3: Calculate total_amount
  Python approach:
  - Loop through the orders.
  - Multiply `quantity * price`.
  - Store or print the result as `total_amount`.

  SQL approach:
  - Select the quantity and price columns.
  - Create a new calculated column using quantity * price AS total_amount.
  
  What I understood:
  Both calculate the same value. Python performs the calculation inside a loop, while SQL calculates it directly in the query.

## Task 4: Sort by price descending
  Python approach:
  - Use the `sorted()` function.
  - Sort by the `price` field.
  - Set `reverse=True`.

  SQL approach:
  - Sort the results from the highest price to the lowest using: ORDER BY price DESC;


 What I understood:
 Both sort the data from highest price to lowest price. Python uses the `sorted()` function, while SQL uses `ORDER BY DESC`.

## Task 5: Show top 3 orders
   Python approach:
   - Sort the orders by price.
   - Use slicing `[:3]` to keep only the first three.

   SQL approach:
   - Sort the records from the highest price to the lowest.
   - Return only the first three rows using: ORDER BY price DESC and LIMIT 3;

  What I understood:
  Both return only the top three records after sorting. Python uses list slicing, while SQL uses the `LIMIT` keyword.
