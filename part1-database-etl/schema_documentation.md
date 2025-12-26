# FlexiMart Database Schema Documentation

## 1. Entity–Relationship Description

### ENTITY: customers
**Purpose:**  
Stores customer master information for all users who place orders on the FlexiMart platform.

**Attributes:**  
- `customer_id` (PK): Unique surrogate identifier for each customer  
- `first_name`: Customer’s first name  
- `last_name`: Customer’s last name  
- `email`: Unique email address used for identification  
- `phone`: Contact phone number in standardized format  
- `city`: City of residence  
- `registration_date`: Date the customer registered  

**Relationships:**  
- One customer can place **many orders** (1:M relationship with `orders`)

---

### ENTITY: products
**Purpose:**  
Stores product catalog details available for sale.

**Attributes:**  
- `product_id` (PK): Unique surrogate identifier for each product  
- `product_name`: Name of the product  
- `category`: Product category  
- `price`: Unit selling price  
- `stock_quantity`: Available inventory quantity  

**Relationships:**  
- One product can appear in **many order_items** records (1:M)

---

### ENTITY: orders
**Purpose:**  
Stores order-level transactional data.

**Attributes:**  
- `order_id` (PK): Unique identifier for each order  
- `customer_id` (FK): References customers.customer_id  
- `order_date`: Date the order was placed  
- `total_amount`: Total order value  
- `status`: Order status (Pending, Completed, etc.)

**Relationships:**  
- Each order belongs to **one customer**  
- One order can contain **many order items**

---

### ENTITY: order_items
**Purpose:**  
Stores line-level details for each order.

**Attributes:**  
- `order_item_id` (PK): Unique identifier for each order line  
- `order_id` (FK): References orders.order_id  
- `product_id` (FK): References products.product_id  
- `quantity`: Quantity ordered  
- `unit_price`: Price per unit at order time  
- `subtotal`: Calculated line total  

---

## 2. Normalization Explanation (Third Normal Form)

The FlexiMart database design adheres to **Third Normal Form (3NF)** principles to ensure data integrity, consistency, and minimal redundancy.

Each table has a clearly defined **primary key**, and all non-key attributes are fully functionally dependent on that primary key. For example, in the `customers` table, attributes such as `first_name`, `email`, and `city` depend solely on `customer_id`. There are no partial dependencies, as surrogate keys are used instead of composite keys.

The design also eliminates **transitive dependencies**. In the `orders` table, customer details are not stored directly; instead, `customer_id` acts as a foreign key referencing the `customers` table. Similarly, product details such as `product_name` and `price` are stored only in the `products` table and referenced through `product_id` in `order_items`.

**Functional dependencies** include:
- customer_id → first_name, last_name, email, phone, city, registration_date  
- product_id → product_name, category, price, stock_quantity  
- order_id → customer_id, order_date, total_amount, status  
- order_item_id → order_id, product_id, quantity, unit_price, subtotal  

This structure prevents **update anomalies** (e.g., changing a product price in multiple places), **insert anomalies** (products or customers can exist without orders), and **delete anomalies** (removing an order does not delete customer or product data). Overall, the schema ensures high data quality and scalability.

---

## 3. Sample Data Representation

### customers
## 4. Sample SQL Query and Output

### Query: Retrieve all customers

### customers
SELECT * FROM customers limit 3;
| customer_id | first_name | last_name | email | phone | city | registration_date |
|------------|------------|-----------|-------|-------|------|-------------------|
| 1 | Rahul | Sharma | rahul.sharma@gmail.com | +91-9876543210 | Bangalore | 2023-01-15 |
| 2 | Priya | Patel | priya.patel@yahoo.com | +91-9988776655 | Mumbai | 2023-02-20 |
| 3 | Amit | Kumar | C003_unknown@dummy.com | +91-9765432109 | Delhi | 2023-03-10 |


---

### products
select * from products limit 3;

| product_id | product_name | category | price | stock_quantity |
|-----------|--------------|----------|-------|----------------|
| 1 | Samsung Galaxy S21 | Electronics | 45999.00 | 150 |
| 2 | Nike Running Shoes | Fashion | 3499.00 | 80 |
| 3 | Apple MacBook Pro | Electronics | 14141.53 | 45 |


---

### orders
select * from orders limit 3;

order_id | customer_id | order_date  | total_amount | status
-------------------------------------------------------------
1        | 1           | 2024-01-15  | 45999.00     | Completed
2        | 2           | 2024-01-16  | 5998.00      | Completed
3        | 3           | 2024-01-15  | 52999.00     | Completed


---

### order_items

select * from order_items limit 3;

order_item_id | order_id | product_id | quantity | unit_price | subtotal
----------------------------------------------------------------------------
1             | 1        | 1          | 1        | 45999.00   | 45999.00
2             | 2        | 4          | 2        | 2999.00    | 5998.00
3             | 3        | 6          | 1        | 52999.00   | 52999.00
