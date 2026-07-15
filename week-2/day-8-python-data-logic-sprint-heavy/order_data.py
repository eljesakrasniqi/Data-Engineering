from python_data_analysis import orders

print("Raw records number:", len(orders))

print()
print("First 3 raw records:")
for order in orders[:3]:
    print(order)


print()

# Unique values before cleaning
print("Raw statuses:", {order["status"] for order in orders})
print("Raw cities:", {order["city"] for order in orders})
print("Raw categories:", {order["category"] for order in orders})
print("Raw channels:", {order["channel"] for order in orders})


print()

# Records with empty customer name
print("Detect records with empty customer_name")
for order in orders:
    if order["customer_name"] == "":
        print("Order ID:", order["order_id"], "has an empty customer name.")


print()

# Detect records with quantity <= 0
print("Records with quantity less than or equal to 0")
for order in orders:
    if order["quantity"] <= 0:
        print("Order ID:", order["order_id"], "has quantity", order["quantity"])


print()

# Detect records with price <= 0
print("Records with price less than or equal to 0:")
for order in orders:
    if order["price"] <= 0:
        print("Order ID:", order["order_id"], "has invalid price:", order["price"])


print()

# Normalization functions

cleaned_orders = []
# Normalize status values
def normalize_status(status):
    status = status.lower()

    if status in ["complete", "completed"]:
        return "completed"

    return status


# Normalize city values
def normalize_city(city):
    if city == "Prishtine":
        return "Prishtina"

    return city


# Normalize category values
def normalize_category(category):
    if category.lower() == "accessories":
        return "Accessories"

    return category


# Normalize channel values
def normalize_channel(channel):
    return channel.lower()


# Add total_amount field
def calculate_total_amount(order):
    order["total_amount"] = order["quantity"] * order["price"]
    return order



# Create cleaned valid orders
for order in orders:

    if order["customer_name"] != "" and order["quantity"] > 0 and order["price"] > 0:

        cleaned_order = order.copy()

        cleaned_order["status"] = normalize_status(cleaned_order["status"])
        cleaned_order["city"] = normalize_city(cleaned_order["city"])
        cleaned_order["category"] = normalize_category(cleaned_order["category"])
        cleaned_order["channel"] = normalize_channel(cleaned_order["channel"])

        cleaned_order = calculate_total_amount(cleaned_order)

        cleaned_orders.append(cleaned_order)



# Total number of records before validation
raw_records = len(orders)


# Total number of valid records after validation
def valid_records_number(valid_orders):
    return len(valid_orders)


valid_count = valid_records_number(cleaned_orders)

# Total number of invalid records and reasons
invalid_records = []

for order in orders:
    reasons = []

    if order["customer_name"] == "":
        reasons.append("Empty customer name")

    if order["quantity"] <= 0:
        reasons.append(f"Invalid quantity ({order['quantity']})")

    if order["price"] <= 0:
        reasons.append(f"Invalid price ({order['price']})")

    if reasons:
        invalid_records.append({
            "order_id": order["order_id"],
            "reasons": reasons
        })

# Count only valid completed orders
completed_orders = []

for order in cleaned_orders:
    if order["status"] == "completed":
        completed_orders.append(order)

#Count valid pending, cancelled, and returned orders.
non_revenue_orders = []

for order in cleaned_orders:
    if order["status"] in ["pending", "cancelled", "returned"]:
        non_revenue_orders.append(order)
        
# Sum total_amount only for valid completed orders

completed_revenue = 0

for order in cleaned_orders:
    if order["status"] == "completed":
        completed_revenue += order["total_amount"]


# Average completed order value
completed_orders_count = len(completed_orders)

if completed_orders_count > 0:
    average_completed_order_value = completed_revenue / completed_orders_count
else:
    average_completed_order_value = 0


#Highest total_amount among valid completed orders
highest_order = 0

for order in completed_orders:
    if order["total_amount"] > highest_order:
        highest_order = order["total_amount"]

#Count orders by status
status_count = {}

for order in cleaned_orders:
    status = order["status"]

    if status in status_count:
        status_count[status] += 1
    else:
        status_count[status] = 1

#Count orders by city
city_count = {}
for order in orders:
    city = order["city"]
    if city in city_count:
        city_count[city] +=1
    else:
        city_count[city] = 1

#Count orders by category
category_count = {}
for order in orders:
    category = order["category"]
    if category in category_count:
        category_count[category] +=1
    else:
        category_count[category] = 1  
        
#Count orders by channel
channel_count = {}
for order in orders:
    channel = order["channel"]
    if channel in channel_count:
        channel_count[channel] +=1
    else:
        channel_count[channel] = 1
        
#Calculate completed revenue by city
revenue_by_city = {}

for order in cleaned_orders:
    if order["status"] == "completed":

        city = order["city"]
        if city in revenue_by_city:
            revenue_by_city[city] += order["total_amount"]
        else:
            revenue_by_city[city] = order["total_amount"]

#Calculate completed revenue by category
revenue_by_category = {}

for order in cleaned_orders:
    if order["status"] == "completed":

        category = order["category"]
        if category in revenue_by_category:
            revenue_by_category[category] += order["total_amount"]
        else:
            revenue_by_category[category] = order["total_amount"]
    
#Calculate completed revenue by channel
revenue_by_channel = {}

for order in cleaned_orders:
    if order["status"] == "completed":

        channel = order["channel"]
        if channel in revenue_by_channel:
            revenue_by_channel[channel] += order["total_amount"]
        else:
            revenue_by_channel[channel] = order["total_amount"]
            
#Calculate completed revenue by customer
revenue_by_customer = {}

for order in cleaned_orders:
    if order["status"] == "completed":

        customer = order["customer_name"]
        if customer in revenue_by_customer:
            revenue_by_customer[customer] += order["total_amount"]
        else:
            revenue_by_customer[customer] = order["total_amount"]   

# Find customers with more than one valid order
customer_orders = {}

for order in cleaned_orders:
    customer = order["customer_name"]

    if customer in customer_orders:
        customer_orders[customer] += 1
    else:
        customer_orders[customer] = 1

# Find products ordered more than once
product_orders = {}

for order in cleaned_orders:
    product = order["product"]

    if product in product_orders:
        product_orders[product] += 1
    else:
        product_orders[product] = 1

#Show top 5 valid completed orders by total_amount
def get_top_orders_by_total_amount(records, limit):
    top_orders = sorted(
        records,
        key=lambda order: order["total_amount"],
        reverse=True
    )

    return top_orders[:limit]
top_5_orders = get_top_orders_by_total_amount(
    completed_orders, 5
)  

#Show top 3 customers by completed revenue
revenue_by_customer = {}

for order in cleaned_orders:
    if order["status"] == "completed":

        customer = order["customer_name"]

        if customer in revenue_by_customer:
            revenue_by_customer[customer] += order["total_amount"]
        else:
            revenue_by_customer[customer] = order["total_amount"]
            
    top_3_customers = sorted(
        revenue_by_customer.items(),
        key=lambda customer: customer[1],
        reverse=True
    )[:3]
    
#Show top 3 products by completed revenue
revenue_by_product = {}
for order in cleaned_orders:
    if order["status"] == "completed":
        product = order["product"]
        
        if product in revenue_by_product:
            revenue_by_product[product] += order["total_amount"]
        else:
            revenue_by_product[product] = order["total_amount"]

    top_3_products = sorted(
        revenue_by_product.items(),
        key=lambda product: product[1],
        reverse=True
    )[:3]
    
#Show top 3 cities by completed revenue
revenue_by_city = {}
for order in cleaned_orders:
    if order["status"] == "completed":
        city = order["city"]
        
        if city in revenue_by_city:
            revenue_by_city[city] += order["total_amount"]
        else:
            revenue_by_city[city] = order["total_amount"]

    top_3_cities = sorted(
        revenue_by_city.items(),
        key=lambda city: city[1],
        reverse=True
    )[:3]
    
# Show categories sorted from highest completed revenue to lowest
revenue_by_category = {}

for order in cleaned_orders:
    if order["status"] == "completed":

        category = order["category"]

        if category in revenue_by_category:
            revenue_by_category[category] += order["total_amount"]
        else:
            revenue_by_category[category] = order["total_amount"]


sorted_categories = sorted(
    revenue_by_category.items(),
    key=lambda category: category[1],
    reverse=True
)

#Show channels sorted from highest completed revenue to lowest
revenue_by_channel = {}
for order in cleaned_orders:
    if order["status"] == "completed":

        channel = order["channel"]

        if channel in revenue_by_channel:
            revenue_by_channel[channel] += order["total_amount"]
        else:
            revenue_by_channel[channel] = order["total_amount"]
sorted_channels = sorted(
    revenue_by_channel.items(),
    key=lambda channel: channel[1],
    reverse=True
)


# Part 7 - Data quality investigation
def data_quality_investigation(orders, cleaned_orders):

    print()
    print("Data Quality Investigation")

    # Which invalid records were removed and why?
    print()
    print("1. Invalid records removed:")

    for order in orders:

        reasons = []

        if order["customer_name"] == "":
            reasons.append("Empty customer name")

        if order["quantity"] <= 0:
            reasons.append(f"Invalid quantity ({order['quantity']})")

        if order["price"] <= 0:
            reasons.append(f"Invalid price ({order['price']})")


        if reasons:
            print(
                f"Order ID {order['order_id']}: {', '.join(reasons)}"
            )


    # How many valid orders do not count as revenue?
    print()
    print("2. Valid orders that do not count as revenue:")

    non_revenue_count = 0

    for order in cleaned_orders:
        if order["status"] in ["pending", "cancelled", "returned"]:
            non_revenue_count += 1

    print(non_revenue_count)


    # Which status values existed before normalization?
    print()
    print("3. Status values before normalization:")

    raw_statuses = set()

    for order in orders:
        raw_statuses.add(order["status"])

    print(raw_statuses)


    # Which values changed after normalization?
    print()
    print("4. Values changed after normalization:")

    for order in orders:

        if order["city"] == "Prishtine":
            print("City: Prishtine -> Prishtina")

        if order["category"] == "accessories":
            print("Category: accessories -> Accessories")

        if order["channel"] == "Online":
            print("Channel: Online -> online")


    # Revenue before validation
    print()
    print("5. Problem if revenue was calculated before validation:")

    print(
        "Invalid records could be included, such as "
        "empty customer names, zero/negative quantity, "
        "or invalid prices."
    )


    # Non-revenue orders counted as revenue
    print()
    print("6. Problem if pending, cancelled, and returned counted as revenue:")

    print(
        "Revenue would be overstated because these orders "
        "are not completed sales."
    )
        
def print_business_report():
    print()

    print("Normalized status values:")
    for order in cleaned_orders:
        print(order["order_id"], "-", order["status"])


    print()

    print("Normalized city values:")
    for order in cleaned_orders:
        print(order["order_id"], "-", order["city"])


    print()

    print("Normalized category values:")
    for order in cleaned_orders:
        print(order["order_id"], "-", order["category"])


    print()

    print("Normalized channel values:")
    for order in cleaned_orders:
        print(order["order_id"], "-", order["channel"])


    print()

    print("Calculated total_amount field")
    for order in cleaned_orders:
        print(order["customer_name"], "-", order["total_amount"])


    print()

    # Print unique cleaned values
    print("Unique cleaned statuses:")
    print({order["status"] for order in cleaned_orders})


    print("\nUnique cleaned cities:")
    print({order["city"] for order in cleaned_orders})


    print("\nUnique cleaned categories:")
    print({order["category"] for order in cleaned_orders})


    print("\nUnique cleaned channels:")
    print({order["channel"] for order in cleaned_orders})


    print()

    print("Raw records:", raw_records)

    print("Valid records:", valid_count)
    
    print()
    print("Invalid records:", len(invalid_records))

    for record in invalid_records:
        print(
            f"Order ID {record['order_id']}: {', '.join(record['reasons'])}"
        )

    print()
    print("Completed orders:", len(completed_orders))
    
    print()
    print("Non-revenue orders:", len(non_revenue_orders))
    
    print()
    print("Completed revenue:", completed_revenue)     
    
    print()
    print("Average completed order value:", average_completed_order_value)
    
    print()
    print("Highest order:", highest_order)
    
    print()
    print("Orders by status:", status_count)

    print()
    print("Orders by city:", city_count)
    
    print()
    print("Orders by category", category_count)
    
    print()
    print("Orders by channel", channel_count)
    
    print()
    print("Completed revenue by city:", revenue_by_city)
    
    print()
    print("Completed revenue by category:", revenue_by_category)
    
    print()
    print("Completed revenue by channel:", revenue_by_channel)
    
    print()
    print("Completed revenue by customer:", revenue_by_customer)
    
    print()
    print("Customers with more than one valid order:")
    for customer, count in customer_orders.items():
        if count > 1:
           print(customer, "-", count, "orders")
           
    print()
    print("Products ordered more than once:")
    for product, count in product_orders.items():
        if count > 1:
           print(product, "-", count, "orders")
           
    print()
    print("Top 5 valid completed orders:")
    for order in top_5_orders:
        print(
        "Order ID:", order["order_id"],
        "- Customer:", order["customer_name"],
        "- Total amount:", order["total_amount"]
    )
        
    print()
    print("Top 3 customers by completed revenue:")
    for customer, revenue in top_3_customers:
        print(customer, "-", revenue)
        
    print()
    print("Top 3 products by completed revenue:")
    for product, revenue in top_3_products:
        print(product, "-", revenue)
        
    print()
    print("Top 3 cities by completed revenue:")
    for city, revenue in top_3_cities:
        print(city, "-", revenue)
      
    print()  
    print("Categories sorted by completed revenue:")
    for category, revenue in sorted_categories:
        print(category, "-", revenue)
        
    print()  
    print("Channels sorted by completed revenue:")
    for channel, revenue in sorted_channels:
        print(channel, "-", revenue)
        
  
    data_quality_investigation(
        orders,
        cleaned_orders
    )


def main():
    print_business_report()

if __name__ == "__main__":
    main()