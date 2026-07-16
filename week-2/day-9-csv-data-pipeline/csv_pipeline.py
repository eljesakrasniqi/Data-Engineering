import csv
import os

# Load CSV files
def load_csv(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)

# Load orders
def load_orders():
    return load_csv("data/orders_raw.csv")

# Load customers
def load_customers():
    return load_csv("data/customers_raw.csv")

# Load products
def load_products():
    return load_csv("data/products_raw.csv")


# Load all data
orders = load_orders()
customers = load_customers()
products = load_products()


#Part 3: Build lookup table
def build_lookup_table(rows, key_field):
    lookup = {}

    for row in rows:
        key = row[key_field].strip()
        lookup[key] = row

    return lookup


# Create lookup dictionaries
customers_lookup = build_lookup_table(customers, "customer_id")
products_lookup = build_lookup_table(products, "product_id")


        
#Part 4 - Normalize messy values
cleaned_orders = []
# Normalize status values
def normalize_status(status):
    status = status.lower()

    if status in ["complete", "completed", "done"]:
        return "completed"
    
    if status == "":
        return "unknown"
    
    if status in ["cancelled", "canceled"]:
        return "cancelled"

    if status == "pending":
        return "pending"
    return status

def normalize_city(city):
    city = city.capitalize()    
    return city

def normalize_channel(channel):
    channel = channel.lower()
    if channel in ["online", "Online", "web"]:
        return "online"
    if channel == "":
        return "unknown"
    return channel

# Clean orders
for order in orders:
    cleaned_order = order.copy()

    customer_id = order["customer_id"].strip()

    customer = customers_lookup.get(customer_id)

    cleaned_order["status"] = normalize_status(order["status"])
    
    if customer:
        cleaned_order["city"] = normalize_city(customer["city"])
    else:
        cleaned_order["city"] = "unknown"

    cleaned_order["channel"] = normalize_channel(order["channel"])

    cleaned_orders.append(cleaned_order)

#Part 5 - Validate orders
def is_positive_integer(value):
    try:
        number = int(value)

        if number > 0:
            return True

        return False

    except ValueError:
        return False


def validate_order(order, customers_lookup, products_lookup):

    # Check order_id
    if not order["order_id"].strip():
        return False, "missing_order_id"

    # Check customer_id
    customer_id = order["customer_id"].strip()

    if not customer_id:
        return False, "missing_customer_id"

    if customer_id not in customers_lookup:
        return False, "invalid_customer_id"


    # Check product_id
    product_id = order["product_id"].strip()

    if not product_id:
        return False, "missing_product_id"

    if product_id not in products_lookup:
        return False, "invalid_product_id"


    # Check order_date
    if not order["order_date"].strip():
        return False, "missing_order_date"


    # Check quantity
    quantity = order["quantity"].strip()

    if not quantity:
        return False, "missing_quantity"

    if quantity.startswith("-"):
        return False, "negative_quantity"

    if not is_positive_integer(quantity):
        return False, "invalid_quantity"


    # Check status
    status = normalize_status(order["status"])

    if not order["status"].strip():
        return False, "missing_status"

    if status not in ["completed", "pending", "cancelled"]:
        return False, "invalid_status"


    # Check channel
    channel = normalize_channel(order["channel"])

    if channel not in ["online", "store", "unknown"]:
        return False, "invalid_channel"


    return True, None

# Validate all cleaned orders

valid_orders = []
invalid_orders = []

for order in cleaned_orders:

    is_valid, reason = validate_order(
        order,
        customers_lookup,
        products_lookup
    )


    if is_valid:
        valid_orders.append(order)

    else:
        invalid_order = order.copy()
        invalid_order["invalid_reason"] = reason

        invalid_orders.append(invalid_order)

# Save invalid orders
def save_invalid_orders(invalid_orders):

    if len(invalid_orders) == 0:
        print("No invalid orders found")
        return

    with open("output/invalid_orders.csv","w", newline="", encoding="utf-8") as file:

        fieldnames = invalid_orders[0].keys()

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames
        )
        writer.writeheader()
        writer.writerows(invalid_orders)
save_invalid_orders(invalid_orders)

# Part 6 - Enrich valid orders
def calculate_total_amount(order):
    quantity = int(order["quantity"])
    price = float(order["price"])

    return quantity * price

def enrich_order(order, customers_lookup, products_lookup):

    customer = customers_lookup[order["customer_id"]]
    product = products_lookup[order["product_id"]]


    enriched_order = {

        "order_id": order["order_id"],

        "customer_id": order["customer_id"],
        "customer_name": customer["customer_name"],
        "city": normalize_city(customer["city"]),

        "product_id": order["product_id"],
        "product_name": product["product_name"],
        "category": product["category"],

        "quantity": order["quantity"],
        "price": product["price"],

        "total_amount": calculate_total_amount({
            "quantity": order["quantity"],
            "price": product["price"]
        }),

        "status": normalize_status(order["status"]),
        "channel": normalize_channel(order["channel"]),

        "order_date": order["order_date"]
    }


    return enriched_order



# Create enriched clean orders
orders_clean = []

for order in valid_orders:

    enriched = enrich_order(
        order,
        customers_lookup,
        products_lookup
    )

    orders_clean.append(enriched)

# Part 7 - Write output files

def write_csv(file_path, rows, fieldnames):

    with open(file_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames
        )

        writer.writeheader()
        writer.writerows(rows)



# Write orders_clean.csv

orders_clean_fields = [
    "order_id",
    "customer_id",
    "customer_name",
    "city",
    "product_id",
    "product_name",
    "category",
    "quantity",
    "price",
    "total_amount",
    "status",
    "channel",
    "order_date"
]


write_csv("output/orders_clean.csv", orders_clean, orders_clean_fields)

# Write invalid_orders.csv
invalid_orders_fields = list(invalid_orders[0].keys())
write_csv("output/invalid_orders.csv", invalid_orders, invalid_orders_fields)

# Part 8 - Create data quality report
def create_data_quality_report(raw_orders, clean_orders, invalid_orders):

    # Create output folder if it does not exist
    os.makedirs("output", exist_ok=True)

    with open("output/data_quality_report.txt", "w", encoding="utf-8") as file:

        file.write("Data Quality Report - Day 9\n\n")

        file.write(f"Total raw orders: {len(raw_orders)}\n")
        file.write(f"Valid orders: {len(clean_orders)}\n")
        file.write(f"Invalid orders: {len(invalid_orders)}\n\n")


        file.write("Invalid records by reason:\n")

        reasons = {}

        for order in invalid_orders:
            reason = order["invalid_reason"]

            if reason in reasons:
                reasons[reason] += 1
            else:
                reasons[reason] = 1


        for reason, count in reasons.items():
            file.write(f"- {reason}: {count}\n")


        file.write("\nStatus values after cleaning:\n")

        statuses = set()

        for order in clean_orders:
            statuses.add(order["status"])

        for status in statuses:
            file.write(f"- {status}\n")


        file.write("\nChannel values after cleaning:\n")

        channels = set()

        for order in clean_orders:
            channels.add(order["channel"])

        for channel in channels:
            file.write(f"- {channel}\n")


        file.write("\nCity values after cleaning:\n")

        cities = set()

        for order in clean_orders:
            cities.add(order["city"])

        for city in cities:
            file.write(f"- {city}\n")


        file.write("\nBronze input files checked:\n")
        file.write("- orders_raw.csv\n")
        file.write("- customers_raw.csv\n")
        file.write("- products_raw.csv\n")


        file.write("\nSilver output files created:\n")
        file.write("- orders_clean.csv\n")
        file.write("- invalid_orders.csv\n")


        file.write("\nMain data quality problems found:\n")

        if reasons:
            for reason, count in reasons.items():
                file.write(f"- {reason}: {count} records\n")
        else:
            file.write("- No problems found\n")
            
#Part 9:
def count_by_field(rows, field_name):

    result = {}

    for row in rows:

        value = row[field_name]

        if value in result:
            result[value] += 1
        else:
            result[value] = 1

    return result

def sum_by_field(rows, group_field, amount_field):

    result = {}

    for row in rows:

        group_value = row[group_field]
        amount = float(row[amount_field])

        if group_value in result:
            result[group_value] += amount
        else:
            result[group_value] = amount

    return result

def get_completed_orders(rows):

    completed = []

    for row in rows:

        if row["status"] == "completed":
            completed.append(row)

    return completed
def get_top_n_by_field(rows, field_name, n):

    sorted_rows = sorted(rows, key=lambda x: float(x[field_name]), reverse=True)

    return sorted_rows[:n]   

def create_business_summary_report(rows):
    os.makedirs("output", exist_ok=True)
    completed_orders = get_completed_orders(rows)
    completed_revenue = sum(
        float(order["total_amount"])
        for order in completed_orders
    )

    with open("output/business_summary.txt", "w", encoding="utf-8") as file:
        file.write("Business Summary - Day 9\n")

        file.write("Completed revenue:\n")
        file.write(f"{completed_revenue}\n\n")


        file.write("Orders by status:\n")

        orders_status = count_by_field(
            rows,
            "status"
        )

        for status, count in orders_status.items():
            file.write(
                f"- {status}: {count}\n"
            )
        file.write("\nOrders by city:\n")

        orders_city = count_by_field(
            rows,
            "city"
        )
        for city, count in orders_city.items():
            file.write(
                f"- {city}: {count}\n"
            )


        file.write("\nRevenue by category:\n")

        revenue_category = sum_by_field(
            completed_orders,
            "category",
            "total_amount"
        )

        for category, revenue in revenue_category.items():
            file.write(
                f"- {category}: {revenue}\n"
            )


        file.write("\nRevenue by channel:\n")

        revenue_channel = sum_by_field(
            completed_orders,
            "channel",
            "total_amount"
        )

        for channel, revenue in revenue_channel.items():
            file.write(
                f"- {channel}: {revenue}\n"
            )


        file.write("\nTop 3 customers by completed revenue:\n")

        customer_revenue = sum_by_field(
            completed_orders,
            "customer_name",
            "total_amount"
        )


        top_customers = sorted(
            customer_revenue.items(),
            key=lambda x: x[1],
            reverse=True
        )[:3]


        for customer, revenue in top_customers:
            file.write(
                f"- {customer}: {revenue}\n"
            )


        file.write("\nTop 3 products by completed revenue:\n")

        product_revenue = sum_by_field(
            completed_orders,
            "product_name",
            "total_amount"
        )

        top_products = sorted(product_revenue.items(), key=lambda x: x[1],
            reverse=True
        )[:3]


        for product, revenue in top_products:
            file.write(
                f"- {product}: {revenue}\n"
            )


        file.write("\nMost valuable completed order:\n")

        best_order = max(
            completed_orders,
            key=lambda x: float(x["total_amount"])
        )


        file.write(
            f"- Order ID: {best_order['order_id']}\n"
        )

        file.write(
            f"- Amount: {best_order['total_amount']}\n"
        )


        file.write("\nOrders that should not count as revenue:\n")

        for order in rows:

            if order["status"] in ["pending", "cancelled"]:
                file.write(
                    f"- Order {order['order_id']} ({order['status']})\n"
                )


        file.write("\nBusiness recommendation:\n")
        file.write(
            "- Focus on completed orders because they represent real revenue.\n"
        )


        file.write("\nWhy this Gold output can be trusted:\n")
        file.write(
            "- Only clean Silver data was used.\n"
        )
        file.write(
            "- Pending and cancelled orders were excluded from revenue.\n"
        )
        file.write(
            "- All calculations were generated from validated records.\n"
        )
print("Business summary created successfully!")         

def print_business_report():
    # Print number of records loaded
    print("Raw orders loaded:", len(orders))
    print("Raw customers loaded:", len(customers))
    print("Raw products loaded:", len(products))

    # Print lookup sizes
    print()
    print("Customers in lookup:", len(customers_lookup))
    print("Products in lookup:", len(products_lookup))

    for order in orders:
      if order["customer_id"] in customers_lookup:
        print("Customer found")

      if order["product_id"] in products_lookup:
        print("Product found")
        
    
    print("Cleaned orders:")
    for order in cleaned_orders:
        print(order["order_id"], "-", order["status"], "-", order["channel"], "-", order["city"])
        
    print()
    print("Validation results:")
    print("Valid orders:", len(valid_orders))
    print("Invalid orders:", len(invalid_orders))    
    
    print()
    print("Enriched clean orders:", len(orders_clean))
    
    print()
    print("Output files created successfully")
    
    create_data_quality_report(
        orders,
        orders_clean,
        invalid_orders
    )
    create_business_summary_report(
        orders_clean
    )


def main():
    print_business_report()

if __name__ == "__main__":
    main()