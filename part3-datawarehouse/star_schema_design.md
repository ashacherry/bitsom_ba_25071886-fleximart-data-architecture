## Section 1: Schema Overview
FACT TABLE: fact_sales (ALREADY PROVIDED)
Grain: One row per product per order line item
Business Process: Sales transactions

Measures (Numeric Facts):
- quantity_sold: Number of units sold
- unit_price: Price per unit at time of sale
- discount_amount: Discount applied
- total_amount: Final amount (quantity × unit_price - discount)

Foreign Keys:
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

DIMENSION TABLE: dim_date  (ALREADY PROVIDED)
Purpose: Date dimension for time-based analysis
Type: Conformed dimension
Attributes:
- date_key (PK): Surrogate key (integer, format: YYYYMMDD)
- full_date: Actual date
- day_of_week: Monday, Tuesday, etc.
- month: 1-12
- month_name: January, February, etc.
- quarter: Q1, Q2, Q3, Q4
- year: 2023, 2024, etc.
- is_weekend: Boolean

### [Continued below for dim_product and dim_customer]


----------------- DIMENSION TABLE: dim_product------------------

DIMENSION TABLE: dim_product

Purpose
Stores descriptive information about products to enable product-level and category-level analysis.

Type
Slowly Changing Dimension (Type 1 – overwrite updates).

Attributes

product_key (PK): Surrogate key
product_id: Source system product identifier
product_name: Name of the product
category: Product category (e.g., Electronics, Clothing)
brand: Brand or manufacturer name
price: Standard listed price
is_active: Indicates whether the product is currently active

----------------------DIMENSION TABLE: dim_customer-----------

DIMENSION TABLE: dim_customer

Purpose
Stores customer-related attributes for customer segmentation and behavioral analysis.

Type
Slowly Changing Dimension (Type 1 – overwrite updates).

Attributes

customer_key (PK): Surrogate key
customer_id: Source system customer identifier
customer_name: Full name of the customer
email: Customer email address
phone : Customer phone number
city: City of residence
state: State or region
customer_type: New or Returning customer


## Section 2: Design Decisions

Granularity: Transaction Line-Item Level

1. Each row represents one product in one order
2. Allows accurate tracking of quantity, price, and discount per product
3. Supports detailed analysis like which product sold most in each order
4. Makes it easy to aggregate data later (daily, monthly, yearly sales)

Use of Surrogate Keys

1. Surrogate keys are simple system-generated numbers
2. Avoids problems if business IDs change in source systems
3. Improves query performance and join efficiency
4. Keeps dimensions stable even when source data changes

Support for Drill-Down and Roll-Up

1. Dimensions store descriptive attributes (date, product, customer)
2. Users can drill down (year → month → day, category → product)
3. Users can roll up data for summaries (daily → monthly → yearly)
4. Star schema structure enables fast and simple analytical queries


## Section 3: Sample Data Flow


Source Transaction (Operational System)

Order Number: 101
Customer Name: John Doe
Product: Laptop
Quantity: 2
Unit Price: 50000
Order Date: 15-Jan-2024


## Step 1: Dimension Lookup / Load
The order date 15-Jan-2024 is matched to dim_date
    date_key = 20240115

The product Laptop is matched to dim_product
     product_key = 5

The customer John Doe is matched to dim_customer
     customer_key = 12

## step 2: Fact Table Record Created
A new row is inserted into fact_sales:

    date_key = 20240115
    product_key = 5
    customer_key = 12
    quantity_sold = 2
    unit_price = 50000
    total_amount = 100000


## Step 3: Dimension Table Records Used
dim_date stores calendar details for reporting

    { date_key: 20240115, full_date: '2024-01-15', month: 1, quarter: 'Q1' }

dim_product stores product details

    { product_key: 5, product_name: 'Laptop', category: 'Electronics' }

dim_customer stores customer details

    { customer_key: 12, customer_name: 'John Doe', city: 'Mumbai' }


## Result:

One sales transaction is split into dimensions (descriptive data) and facts (numeric data)

Enables fast reporting by date, product, and customer