import csv
import os

# Load CSV files
def load_csv(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)

# Load orders
def load_orders():
    return load_csv("data/bronze/orders_raw.csv")

# Load customers
def load_customers():
    return load_csv("data/bronze/customers_raw.csv")

# Load products
def load_products():
    return load_csv("data/bronze/products_raw.csv")

orders = load_orders()
customers = load_customers()
products = load_products()


#Silver layer: cleaned, validated, enriched data
cleaned_orders = []
def normalize_status(status):
    status = status.strip().lower()

    if status in ["completed", "complete", "done"]:
        return "completed"

    if status in ["cancelled", "canceled"]:
        return "cancelled"

    if status == "pending":
        return "pending"

    return status

def normalize_channel(channel):
    channel = channel.strip().lower()
    
    if channel in ["online", "web", "mobile"]:
        return "online"

    if channel == "store":
        return "store"

    if channel == "":
        return "unknown"
    return channel

def normalize_city(city):
    city = city.strip()

    if city == "":
        return "Unknown"

    return city.capitalize()

def is_positive_number(value):
    try:
        return float(value) > 0
    except ValueError:
        return False
    
def is_positive_integer(value):
    try:
        return int(value) > 0
    except ValueError:
        return False
    
def validate_order(order, customers_lookup, products_lookup, seen_order_ids):

    # Duplicate order
    if order["order_id"] in seen_order_ids:
        return False, "duplicate_order_id"

    seen_order_ids.add(order["order_id"])


    # Order date
    if order["order_date"].strip() == "":
        return False, "missing_order_date"


    # Quantity
    if not is_positive_integer(order["quantity"]):
        return False, "invalid_quantity"


    # Customer exists
    if order["customer_id"] not in customers_lookup:
        return False, "invalid_customer_id"


    # Product exists
    if order["product_id"] not in products_lookup:
        return False, "invalid_product_id"


    return True, ""

def build_lookup(rows, key_field):

    lookup = {}

    for row in rows:
        lookup[row[key_field]] = row

    return lookup

def clean_customers(raw_customers):

    cleaned = []

    for customer in raw_customers:

        customer["city"] = normalize_city(
            customer["city"]
        )

        cleaned.append(customer)

    return cleaned

def clean_products(raw_products):
    

    cleaned = []

    for product in raw_products:

        if not is_positive_number(product["price"]):
            continue

        if product["category"].strip() == "":
            product["category"] = "Unknown"


        product["price"] = float(product["price"])

        cleaned.append(product)


    return cleaned
def enrich_order(order, customers_lookup, products_lookup):

    customer = customers_lookup[order["customer_id"]]
    product = products_lookup[order["product_id"]]

    quantity = int(order["quantity"])
    price = float(product["price"])

    enriched_order = {
        "order_id": order["order_id"],
        "customer_id": order["customer_id"],

        "customer_name": customer["customer_name"],
        "city": customer["city"],

        "product_id": order["product_id"],
        "product_name": product["product_name"],
        "category": product["category"],
        "price": price,

        "quantity": quantity,
        "total_amount": quantity * price,

        "status": normalize_status(order["status"]),
        "channel": normalize_channel(order["channel"]),

        "order_date": order["order_date"]
    }

    return enriched_order

#Only valid orders should appear in orders_clean.csv.
def create_silver_orders(raw_orders, customers_lookup, products_lookup):
    clean_orders = []
    invalid_orders = []
    seen_order_ids = set()
    
    for order in raw_orders:
        valid, reason = validate_order(
            order,
            customers_lookup,
            products_lookup,
            seen_order_ids
        )
        if valid:
            clean_order = enrich_order(
                order,
                customers_lookup,
                products_lookup
            )
            clean_orders.append(clean_order)
        else:
            invalid_orders.append({
                "order_id": order["order_id"],
                "customer_id": order["customer_id"],
                "product_id": order["product_id"],
                "order_date": order["order_date"],
                "quantity": order["quantity"],
                "status": order["status"],
                "channel": order["channel"],
                "reason": reason
            })


    return clean_orders, invalid_orders

def write_csv(file_path, rows, fieldnames):

    with open(file_path, "w", newline="", encoding="utf-8") as file:

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames
        )

        writer.writeheader()
        writer.writerows(rows)

def create_revenue_by_category(clean_orders):
    revenue = {}
    for order in clean_orders:

        if order["status"] == "completed":

            category = order["category"]

            if category not in revenue:
                revenue[category] = {
                    "category": category,
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }


            revenue[category]["completed_revenue"] += float(
                order["total_amount"]
            )

            revenue[category]["total_completed_orders"] += 1


    return list(revenue.values())

def create_revenue_by_city(clean_orders):
    revenue = {}
    
    for order in clean_orders:
        if order["status"] == "completed":
            city = order["city"]
            if city not in revenue:
                revenue[city]={
                    "city": city,
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }
            revenue[city]["completed_revenue"] += float(
                order["total_amount"]
            )
            revenue[city]["total_completed_orders"] += 1
    return list(revenue.values())

def create_revenue_by_customer(clean_orders):

    revenue = {}

    for order in clean_orders:
        if order["status"] == "completed":
            customer_id = order["customer_id"]
            if customer_id not in revenue:
                revenue[customer_id] = {
                    "customer_id": customer_id,
                    "customer_name": order["customer_name"],
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }

            revenue[customer_id]["completed_revenue"] += float(
                order["total_amount"]
            )
            revenue[customer_id]["total_completed_orders"] += 1
    return list(revenue.values())

def create_top_products(clean_orders):

    products = {}

    for order in clean_orders:

        if order["status"] == "completed":

            product_name = order["product_name"]

            if product_name not in products:

                products[product_name] = {
                    "product_name": product_name,
                    "category": order["category"],
                    "total_quantity_sold": 0,
                    "completed_revenue": 0
                }


            products[product_name]["total_quantity_sold"] += int(
                order["quantity"]
            )

            products[product_name]["completed_revenue"] += float(
                order["total_amount"]
            )


    return sorted(
        products.values(),
        key=lambda x: x["completed_revenue"],
        reverse=True
    )
    
def create_executive_summary(clean_orders, invalid_orders, raw_orders):

    completed_orders = 0
    pending_orders = 0
    cancelled_orders = 0
    completed_revenue = 0


    for order in clean_orders:

        if order["status"] == "completed":
            completed_orders += 1
            completed_revenue += float(order["total_amount"])

        elif order["status"] == "pending":
            pending_orders += 1

        elif order["status"] == "cancelled":
            cancelled_orders += 1

    # Top category
    category_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            category = order["category"]

            category_revenue[category] = (
                category_revenue.get(category, 0)
                + float(order["total_amount"])
            )


    top_category = max(category_revenue, key=category_revenue.get)

    # Top city
    city_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            city = order["city"]

            city_revenue[city] = (
                city_revenue.get(city, 0)
                + float(order["total_amount"])
            )

    top_city = max(
        city_revenue,
        key=city_revenue.get
    )

    # Top customer
    customer_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            customer = order["customer_name"]

            customer_revenue[customer] = (
                customer_revenue.get(customer, 0)
                + float(order["total_amount"])
            )

    top_customer = max(
        customer_revenue,
        key=customer_revenue.get
    )

    # Top product
    product_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            product = order["product_name"]

            product_revenue[product] = (
                product_revenue.get(product, 0)
                + float(order["total_amount"])
            )

    top_product = max(
        product_revenue,
        key=product_revenue.get
    )

    # Most common invalid reason
    reasons = {}

    for order in invalid_orders:

        reason = order["reason"]

        reasons[reason] = reasons.get(reason, 0) + 1


    if reasons:
        most_common_invalid = max(
            reasons,
            key=reasons.get
        )
    else:
        most_common_invalid = "None"
        
    summary = f"""
Executive Summary - Day 10 Pipeline

Total raw orders: {len(raw_orders)}

Valid silver orders: {len(clean_orders)}

Invalid orders: {len(invalid_orders)}

Completed orders: {completed_orders}

Pending orders: {pending_orders}

Cancelled orders: {cancelled_orders}

Completed revenue: {completed_revenue}

Business recommendation:
Focus on improving sales performance and fixing data quality issues.
"""


    return summary   

def create_data_quality_report(raw_orders, clean_orders, invalid_orders):

    duplicate_order_ids = 0
    missing_dates = 0
    invalid_quantities = 0
    invalid_statuses = 0
    invalid_products = 0
    invalid_customers = 0
    invalid_product_prices = 0
    missing_customer_cities = 0

    invalid_reasons = {}


    for order in invalid_orders:

        reason = order["reason"]

        if reason not in invalid_reasons:
            invalid_reasons[reason] = 0

        invalid_reasons[reason] += 1


        if reason == "duplicate_order_id":
            duplicate_order_ids += 1

        elif reason == "missing_order_date":
            missing_dates += 1

        elif reason == "invalid_quantity":
            invalid_quantities += 1

        elif reason == "invalid_product_id":
            invalid_products += 1

        elif reason == "invalid_customer_id":
            invalid_customers += 1



    raw_customers = load_customers()

    for customer in raw_customers:

        if customer["city"].strip() == "":
            missing_customer_cities += 1



    report = f"""
Validation Checks

Raw orders count: {len(raw_orders)}

Silver clean orders count: {len(clean_orders)}

Invalid orders count: {len(invalid_orders)}

Raw = Silver + Invalid: {"YES" if len(raw_orders) == len(clean_orders) + len(invalid_orders) else "NO"}

Customer IDs checked: {len(set(order["customer_id"] for order in raw_orders))}

Product IDs checked: {len(set(order["product_id"] for order in raw_orders))}

Duplicate order IDs found: {duplicate_order_ids}

Missing dates found: {missing_dates}

Invalid quantities found: {invalid_quantities}

Invalid statuses found: {invalid_statuses}

Invalid products found: {invalid_products}

Invalid customers found: {invalid_customers}

Invalid product prices found: {invalid_product_prices}

Missing customer cities found: {missing_customer_cities}


Invalid records by reason:
"""


    for reason, count in invalid_reasons.items():

        report += f"- {reason}: {count}\n"


    return report  
    
import csv
import os

# Load CSV files
def load_csv(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)

# Load orders
def load_orders():
    return load_csv("data/bronze/orders_raw.csv")

# Load customers
def load_customers():
    return load_csv("data/bronze/customers_raw.csv")

# Load products
def load_products():
    return load_csv("data/bronze/products_raw.csv")

orders = load_orders()
customers = load_customers()
products = load_products()


#Silver layer: cleaned, validated, enriched data
cleaned_orders = []
def normalize_status(status):
    status = status.strip().lower()

    if status in ["completed", "complete", "done"]:
        return "completed"

    if status in ["cancelled", "canceled"]:
        return "cancelled"

    if status == "pending":
        return "pending"

    return status

def normalize_channel(channel):
    channel = channel.strip().lower()
    
    if channel in ["online", "web", "mobile"]:
        return "online"

    if channel == "store":
        return "store"

    if channel == "":
        return "unknown"
    return channel

def normalize_city(city):
    city = city.strip()

    if city == "":
        return "Unknown"

    return city.capitalize()

def is_positive_number(value):
    try:
        return float(value) > 0
    except ValueError:
        return False
    
def is_positive_integer(value):
    try:
        return int(value) > 0
    except ValueError:
        return False
    
def validate_order(order, customers_lookup, products_lookup, seen_order_ids):

    # Duplicate order
    if order["order_id"] in seen_order_ids:
        return False, "duplicate_order_id"

    seen_order_ids.add(order["order_id"])


    # Order date
    if order["order_date"].strip() == "":
        return False, "missing_order_date"


    # Quantity
    if not is_positive_integer(order["quantity"]):
        return False, "invalid_quantity"


    # Customer exists
    if order["customer_id"] not in customers_lookup:
        return False, "invalid_customer_id"


    # Product exists
    if order["product_id"] not in products_lookup:
        return False, "invalid_product_id"


    return True, ""

def build_lookup(rows, key_field):

    lookup = {}

    for row in rows:
        lookup[row[key_field]] = row

    return lookup

def clean_customers(raw_customers):

    cleaned = []

    for customer in raw_customers:

        customer["city"] = normalize_city(
            customer["city"]
        )

        cleaned.append(customer)

    return cleaned

def clean_products(raw_products):
    

    cleaned = []

    for product in raw_products:

        if not is_positive_number(product["price"]):
            continue

        if product["category"].strip() == "":
            product["category"] = "Unknown"


        product["price"] = float(product["price"])

        cleaned.append(product)


    return cleaned
def enrich_order(order, customers_lookup, products_lookup):

    customer = customers_lookup[order["customer_id"]]
    product = products_lookup[order["product_id"]]

    quantity = int(order["quantity"])
    price = float(product["price"])

    enriched_order = {
        "order_id": order["order_id"],
        "customer_id": order["customer_id"],

        "customer_name": customer["customer_name"],
        "city": customer["city"],

        "product_id": order["product_id"],
        "product_name": product["product_name"],
        "category": product["category"],
        "price": price,

        "quantity": quantity,
        "total_amount": quantity * price,

        "status": normalize_status(order["status"]),
        "channel": normalize_channel(order["channel"]),

        "order_date": order["order_date"]
    }

    return enriched_order

#Only valid orders should appear in orders_clean.csv.
def create_silver_orders(raw_orders, customers_lookup, products_lookup):
    clean_orders = []
    invalid_orders = []
    seen_order_ids = set()
    
    for order in raw_orders:
        valid, reason = validate_order(
            order,
            customers_lookup,
            products_lookup,
            seen_order_ids
        )
        if valid:
            clean_order = enrich_order(
                order,
                customers_lookup,
                products_lookup
            )
            clean_orders.append(clean_order)
        else:
            invalid_orders.append({
                "order_id": order["order_id"],
                "customer_id": order["customer_id"],
                "product_id": order["product_id"],
                "order_date": order["order_date"],
                "quantity": order["quantity"],
                "status": order["status"],
                "channel": order["channel"],
                "reason": reason
            })


    return clean_orders, invalid_orders

def write_csv(file_path, rows, fieldnames):

    with open(file_path, "w", newline="", encoding="utf-8") as file:

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames
        )

        writer.writeheader()
        writer.writerows(rows)

def create_revenue_by_category(clean_orders):
    revenue = {}
    for order in clean_orders:

        if order["status"] == "completed":

            category = order["category"]

            if category not in revenue:
                revenue[category] = {
                    "category": category,
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }


            revenue[category]["completed_revenue"] += float(
                order["total_amount"]
            )

            revenue[category]["total_completed_orders"] += 1


    return list(revenue.values())

def create_revenue_by_city(clean_orders):
    revenue = {}
    
    for order in clean_orders:
        if order["status"] == "completed":
            city = order["city"]
            if city not in revenue:
                revenue[city]={
                    "city": city,
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }
            revenue[city]["completed_revenue"] += float(
                order["total_amount"]
            )
            revenue[city]["total_completed_orders"] += 1
    return list(revenue.values())

def create_revenue_by_customer(clean_orders):

    revenue = {}

    for order in clean_orders:
        if order["status"] == "completed":
            customer_id = order["customer_id"]
            if customer_id not in revenue:
                revenue[customer_id] = {
                    "customer_id": customer_id,
                    "customer_name": order["customer_name"],
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }

            revenue[customer_id]["completed_revenue"] += float(
                order["total_amount"]
            )
            revenue[customer_id]["total_completed_orders"] += 1
    return list(revenue.values())

def create_top_products(clean_orders):

    products = {}

    for order in clean_orders:

        if order["status"] == "completed":

            product_name = order["product_name"]

            if product_name not in products:

                products[product_name] = {
                    "product_name": product_name,
                    "category": order["category"],
                    "total_quantity_sold": 0,
                    "completed_revenue": 0
                }


            products[product_name]["total_quantity_sold"] += int(
                order["quantity"]
            )

            products[product_name]["completed_revenue"] += float(
                order["total_amount"]
            )


    return sorted(
        products.values(),
        key=lambda x: x["completed_revenue"],
        reverse=True
    )
    
def create_executive_summary(clean_orders, invalid_orders, raw_orders):

    completed_orders = 0
    pending_orders = 0
    cancelled_orders = 0
    completed_revenue = 0


    for order in clean_orders:

        if order["status"] == "completed":
            completed_orders += 1
            completed_revenue += float(order["total_amount"])

        elif order["status"] == "pending":
            pending_orders += 1

        elif order["status"] == "cancelled":
            cancelled_orders += 1

    # Top category
    category_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            category = order["category"]

            category_revenue[category] = (
                category_revenue.get(category, 0)
                + float(order["total_amount"])
            )


    top_category = max(category_revenue, key=category_revenue.get)

    # Top city
    city_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            city = order["city"]

            city_revenue[city] = (
                city_revenue.get(city, 0)
                + float(order["total_amount"])
            )

    top_city = max(
        city_revenue,
        key=city_revenue.get
    )

    # Top customer
    customer_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            customer = order["customer_name"]

            customer_revenue[customer] = (
                customer_revenue.get(customer, 0)
                + float(order["total_amount"])
            )

    top_customer = max(
        customer_revenue,
        key=customer_revenue.get
    )

    # Top product
    product_revenue = {}

    for order in clean_orders:

        if order["status"] == "completed":

            product = order["product_name"]

            product_revenue[product] = (
                product_revenue.get(product, 0)
                + float(order["total_amount"])
            )

    top_product = max(
        product_revenue,
        key=product_revenue.get
    )

    # Most common invalid reason
    reasons = {}

    for order in invalid_orders:

        reason = order["reason"]

        reasons[reason] = reasons.get(reason, 0) + 1


    if reasons:
        most_common_invalid = max(
            reasons,
            key=reasons.get
        )
    else:
        most_common_invalid = "None"
        
    summary = f"""
Executive Summary - Day 10 Pipeline

Total raw orders: {len(raw_orders)}

Valid silver orders: {len(clean_orders)}

Invalid orders: {len(invalid_orders)}

Completed orders: {completed_orders}

Pending orders: {pending_orders}

Cancelled orders: {cancelled_orders}

Completed revenue: {completed_revenue}

Business recommendation:
Focus on improving sales performance and fixing data quality issues.
"""


    return summary   

def create_data_quality_report(raw_orders, clean_orders, invalid_orders):

    duplicate_order_ids = 0
    missing_dates = 0
    invalid_quantities = 0
    invalid_statuses = 0
    invalid_products = 0
    invalid_customers = 0
    invalid_product_prices = 0
    missing_customer_cities = 0

    invalid_reasons = {}


    for order in invalid_orders:

        reason = order["reason"]

        if reason not in invalid_reasons:
            invalid_reasons[reason] = 0

        invalid_reasons[reason] += 1


        if reason == "duplicate_order_id":
            duplicate_order_ids += 1

        elif reason == "missing_order_date":
            missing_dates += 1

        elif reason == "invalid_quantity":
            invalid_quantities += 1

        elif reason == "invalid_product_id":
            invalid_products += 1

        elif reason == "invalid_customer_id":
            invalid_customers += 1



    raw_customers = load_customers()

    for customer in raw_customers:

        if customer["city"].strip() == "":
            missing_customer_cities += 1



    report = f"""
Validation Checks

Raw orders count: {len(raw_orders)}

Silver clean orders count: {len(clean_orders)}

Invalid orders count: {len(invalid_orders)}

Raw = Silver + Invalid: {"YES" if len(raw_orders) == len(clean_orders) + len(invalid_orders) else "NO"}

Customer IDs checked: {len(set(order["customer_id"] for order in raw_orders))}

Product IDs checked: {len(set(order["product_id"] for order in raw_orders))}

Duplicate order IDs found: {duplicate_order_ids}

Missing dates found: {missing_dates}

Invalid quantities found: {invalid_quantities}

Invalid statuses found: {invalid_statuses}

Invalid products found: {invalid_products}

Invalid customers found: {invalid_customers}

Invalid product prices found: {invalid_product_prices}

Missing customer cities found: {missing_customer_cities}


Invalid records by reason:
"""
    for reason, count in invalid_reasons.items():

        report += f"- {reason}: {count}\n"


    return report  
    
def create_pipeline_log():

    os.makedirs("output", exist_ok=True)

    with open("output/pipeline_log.txt", "w", encoding="utf-8") as file:

        file.write("Pipeline Log - Day 10\n\n")

    file.write("Step 1: Loaded Bronze files.\n")
    file.write(f"Result: {len(orders)} orders, {len(customers)} customers, {len(products)} products loaded.\n\n")

    file.write("Step 2: Cleaned customers.\n")
    file.write(f"Result: {len(customers)} customers cleaned.\n\n")

    file.write("Step 3: Cleaned products.\n")
    file.write(f"Result: {len(products)} products cleaned.\n\n")

    print("Pipeline log created successfully.")
def print_business_report():

    print(f"Raw orders: {len(orders)}")
    print(f"Raw customers: {len(customers)}")
    print(f"Raw products: {len(products)}")


    clean_customer_data = clean_customers(customers)

    customer_fields = [
    "customer_id",
    "customer_name",
    "city"
    ]

    write_csv(
    "data/silver/customers_clean.csv",
    clean_customer_data,
    customer_fields
    )

    clean_product_data = clean_products(products)
    product_fields = [
    "product_id",
    "product_name",
    "category",
    "price"
    ]

    write_csv(
    "data/silver/products_clean.csv",
    clean_product_data,
    product_fields
    )

    customers_lookup = build_lookup(
        clean_customer_data,
        "customer_id"
    )


    products_lookup = build_lookup(
        clean_product_data,
        "product_id"
    )


    clean_orders, invalid_orders = create_silver_orders(
        orders,
        customers_lookup,
        products_lookup
    )


    print()
    print("Silver Layer")
    print("----------------")
    print("Clean orders:", len(clean_orders))
    print("Invalid orders:", len(invalid_orders))


    # Save invalid orders
    invalid_fields = [
        "order_id",
        "customer_id",
        "product_id",
        "order_date",
        "quantity",
        "status",
        "channel",
        "reason"
    ]


    write_csv(
        "data/silver/invalid_orders.csv",
        invalid_orders,
        invalid_fields
    )


    # Save clean orders
    clean_fields = [
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
    
    write_csv(
        "data/silver/orders_clean.csv",
        clean_orders,
        clean_fields
    )
    
    category_report = create_revenue_by_category(clean_orders)
    write_csv(
    "data/gold/revenue_by_category.csv",
    category_report,
    [
        "category",
        "completed_revenue",
        "total_completed_orders"
    ])
    city_report = create_revenue_by_city(clean_orders)
    write_csv( 
    "data/gold/revenue_by_city.csv",
    city_report,
    [
        "city",
        "completed_revenue",
        "total_completed_orders"
    ])
    customer_report = create_revenue_by_customer(clean_orders)
    write_csv(
    "data/gold/revenue_by_customer.csv",
    customer_report,
    [
        "customer_id",
        "customer_name",
        "completed_revenue",
        "total_completed_orders"
    ])
    
    
    top_products = create_top_products(clean_orders)
    write_csv(
    "data/gold/top_products.csv",
    top_products,
    [
        "product_name",
        "category",
        "total_quantity_sold",
        "completed_revenue"
    ])
    
    summary = create_executive_summary(
    clean_orders,
    invalid_orders,
    orders)
    
    with open("data/gold/executive_summary.txt", "w", encoding="utf-8") as file:
        file.write(summary)
     
       
    quality_report = create_data_quality_report(
    orders,
    clean_orders,
    invalid_orders
)

    print(f"Raw orders: {len(orders)}")
    print(f"Raw customers: {len(customers)}")
    print(f"Raw products: {len(products)}")


    clean_customer_data = clean_customers(customers)

    customer_fields = [
    "customer_id",
    "customer_name",
    "city"
    ]

    write_csv(
    "data/silver/customers_clean.csv",
    clean_customer_data,
    customer_fields
    )

    clean_product_data = clean_products(products)
    product_fields = [
    "product_id",
    "product_name",
    "category",
    "price"
    ]

    write_csv(
    "data/silver/products_clean.csv",
    clean_product_data,
    product_fields
    )

    customers_lookup = build_lookup(
        clean_customer_data,
        "customer_id"
    )


    products_lookup = build_lookup(
        clean_product_data,
        "product_id"
    )


    clean_orders, invalid_orders = create_silver_orders(
        orders,
        customers_lookup,
        products_lookup
    )


    print()
    print("Silver Layer")
    print("----------------")
    print("Clean orders:", len(clean_orders))
    print("Invalid orders:", len(invalid_orders))


    # Save invalid orders
    invalid_fields = [
        "order_id",
        "customer_id",
        "product_id",
        "order_date",
        "quantity",
        "status",
        "channel",
        "reason"
    ]


    write_csv(
        "data/silver/invalid_orders.csv",
        invalid_orders,
        invalid_fields
    )


    # Save clean orders
    clean_fields = [
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
    
    write_csv(
        "data/silver/orders_clean.csv",
        clean_orders,
        clean_fields
    )
    
    category_report = create_revenue_by_category(clean_orders)
    write_csv(
    "data/gold/revenue_by_category.csv",
    category_report,
    [
        "category",
        "completed_revenue",
        "total_completed_orders"
    ])
    city_report = create_revenue_by_city(clean_orders)
    write_csv( 
    "data/gold/revenue_by_city.csv",
    city_report,
    [
        "city",
        "completed_revenue",
        "total_completed_orders"
    ])
    customer_report = create_revenue_by_customer(clean_orders)
    write_csv(
    "data/gold/revenue_by_customer.csv",
    customer_report,
    [
        "customer_id",
        "customer_name",
        "completed_revenue",
        "total_completed_orders"
    ])
    
    
    top_products = create_top_products(clean_orders)
    write_csv(
    "data/gold/top_products.csv",
    top_products,
    [
        "product_name",
        "category",
        "total_quantity_sold",
        "completed_revenue"
    ])
    
    summary = create_executive_summary(
    clean_orders,
    invalid_orders,
    orders)
    
    with open("data/gold/executive_summary.txt", "w", encoding="utf-8") as file:
        file.write(summary)
     
       
    quality_report = create_data_quality_report(
    orders,
    clean_orders,
    invalid_orders
    )
    with open("data_quality_report.txt", "w", encoding="utf-8") as file:
        file.write(quality_report)

   
def main():
    print_business_report()

if __name__ == "__main__":
    main()