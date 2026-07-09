orders = [
    {
        "order_id": 1,
        "customer_name": "Arta",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "completed",
        "order_date": "2026-07-01"
    },
    {
        "order_id": 2,
        "customer_name": "Blend",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 2,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-01"
    },
    {
        "order_id": 3,
        "customer_name": "Arta",
        "city": "Vushtrri",
        "product": "Keyboard",
        "category": "Accessories",
        "quantity": 1,
        "price": 40,
        "status": "cancelled",
        "order_date": "2026-07-02"
    },
    {
        "order_id": 4,
        "customer_name": "Dren",
        "city": "Mitrovica",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 1,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-02"
    },
    {
        "order_id": 5,
        "customer_name": "Elira",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 1,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-03"
    },
    {
        "order_id": 6,
        "customer_name": "Dren",
        "city": "Mitrovica",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "pending",
        "order_date": "2026-07-03"
    },
    {
        "order_id": 7,
        "customer_name": "Nora",
        "city": "Vushtrri",
        "product": "Headphones",
        "category": "Accessories",
        "quantity": 1,
        "price": 50,
        "status": "completed",
        "order_date": "2026-07-04"
    },
    {
        "order_id": 8,
        "customer_name": "Leart",
        "city": "Peja",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 2,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-04"
    },
    {
        "order_id": 9,
        "customer_name": "Faton",
        "city": "Prizren",
        "product": "Desk Chair",
        "category": "Office",
        "quantity": 1,
        "price": 120,
        "status": "completed",
        "order_date": "2026-07-05"
    },
    {
        "order_id": 10,
        "customer_name": "Gresa",
        "city": "Prishtina",
        "product": "USB Cable",
        "category": "Accessories",
        "quantity": 3,
        "price": 8,
        "status": "completed",
        "order_date": "2026-07-05"
    },
    {
        "order_id": 11,
        "customer_name": "Rina",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 650,
        "status": "cancelled",
        "order_date": "2026-07-06"
    },
    {
        "order_id": 12,
        "customer_name": "Arben",
        "city": "Ferizaj",
        "product": "Desk",
        "category": "Office",
        "quantity": 1,
        "price": 220,
        "status": "pending",
        "order_date": "2026-07-06"
    }
]

#Print total number of orders:
print("Total orders:", len(orders));

#Print all customer names.
print("Customer names:");
for order in orders:
    print(order["customer_name"])

print()
#Print one readable sentence for each order: customer, product, city, status:
print("Order details:")
for order in orders:
    print(order["customer_name"], "ordered", order["product"], "from", order["city"], "and the status is", order["status"])
    
print();
#Task P2 - Filter records

#Print only completed orders:
print("Completed orders:") 
completed_orders = [order for order in orders if order["status"] == "completed"]

if len(completed_orders) == 0:
    print("No completed orders.")
else:
    for order in completed_orders: 
        print(order['order_id'], "-", order['customer_name'], "-", order['product'])
print()

#Print only pending orders:
print("Pending orders:") 
pending_orders = [order for order in orders if order["status"] == "pending"]

if len(pending_orders) == 0:
    print("No pending orders.")
else:
    for order in pending_orders: 
        print(order['order_id'], "-", order['customer_name'], "-", order['product'])
print()

#Print only cenelled orders:
print("Cancelled orders:") 
canelled_orders = [order for order in orders if order["status"] == "cancelled"]

if len(canelled_orders) == 0:
    print("No canelled orders.")
else:
    for order in canelled_orders: 
        print(order['order_id'], "-", order['customer_name'], "-", order['product'])
print()

#Print orders where price is greater than 100:
print("Price greater than 100:") 
greater_price = [order for order in orders if order["price"] > 100]

if len(greater_price) == 0:
    print("No orders with price greater than 100")
else:
    for order in greater_price: 
        print(order['order_id'], "-", order['customer_name'], "-", order['product'],"-", order['price'])
print()

#Print orders where category is Accessories:
print("Orders with category accessories:") 
category_accessories = [order for order in orders if order["category"] == "Accessories"]

if len(category_accessories) == 0:
    print("No orders with category accessories")
else:
    for order in category_accessories: 
        print(order['order_id'], "-", order['customer_name'], "-", order['product'], "-", order['category'])
print()


#Task P3 - Calculated values
#For each order, calculate total_amount = quantity * price:
for order in orders:
    order['total_amount'] = order['quantity'] * order['price']

print("Orders with Total Amount:")
for order in orders:
    print(order['customer_name'], "-", order['customer_name'], "-", order['price'],"x", order['quantity'], "=", order['total_amount'])
  
print()
    
#Print customer_name, product, quantity, price, and total_amount:
for order in orders:
    order['total_amount'] = order['quantity'] * order['price']

print("Orders with Total Amount:")
for order in orders:
    print(order['customer_name'], "-", order['customer_name'], "-", order['quantity'],"-", order['price'], "-", order['total_amount'])
    
print()
#Task P4 - Sorting and top records:
def get_price(order):
    return order['price']
orders.sort(key=get_price, reverse=True)

print("Orders sorted from most expensive to cheapest:")
for order in orders:
    print(order['customer_name'], "-", order['product'], "-", order['price'])
    
    
print()   
#Sort orders by total_amount from highest to lowest
def get_total_amount(order):
    return order['total_amount']

orders.sort(key=get_total_amount, reverse=True)

print("Top 3 orders with the highest total amount:")

for order in orders[:3]:
    print(order['customer_name'], "-", order['product'], "-", order['total_amount'])
    
print()

#Task P5 - Simple summary without GROUP BY
completed = 0
pending = 0
cancelled = 0

# Calculate completed revenue
completed_revenue = 0

# Count orders per customer
customer_orders = {}

for order in orders:
    if order["status"] == "completed":
        completed += 1
        completed_revenue += order["total_amount"]
    elif order["status"] == "pending":
        pending += 1
    elif order["status"] == "cancelled":
        cancelled += 1

    # Customer order count
    customer = order["customer_name"]

    if customer in customer_orders:
        customer_orders[customer] += 1
    else:
        customer_orders[customer] = 1

print("Status counts:")
print(f"customer: {completed}")
print(f"pending: {pending}")
print(f"cancelled: {cancelled}")

print()
print(f"Completed revenue: {completed_revenue}")

print()
print("Customers with more than one order:")
for customer, count in customer_orders.items():
    if count > 1:
        print(f"{customer}: {count} orders")
        
print()

##Part 4 - Mini business challenge
# Find the most expensive single order

def get_total_amount(order):
    return order["total_amount"]

orders.sort(key=get_total_amount, reverse=True)

most_expensive = orders[0]

print("Most expensive single order:")
print(most_expensive["customer_name"], "-", most_expensive["product"], "-", most_expensive["total_amount"])


