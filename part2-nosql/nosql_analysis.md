NoSQL Database Analysis – FlexiMart

## **Section A: Limitations of RDBMS (Relational Databases)**

Products with different attributes
In a relational database, all products must follow the same table structure.
Example: A products table must contain columns like ram, processor, size, and color. Laptops use RAM and processor, while shoes use size and color, leaving many unused (NULL) values or requiring multiple tables and JOINs.

Frequent schema changes
Adding new product types or attributes requires modifying the table structure.
Example: Introducing a new attribute like battery_life requires an ALTER TABLE operation, which is costly on large datasets and may cause downtime.

Nested customer reviews
Customer reviews are hierarchical in nature.
Example: In an RDBMS, products, reviews, and review replies must be stored in separate tables linked by foreign keys. Fetching a product with its reviews requires multiple JOIN operations, making queries complex and slower.

## **Section B: Benefits of MongoDB (NoSQL)**

MongoDB addresses these limitations through its document-oriented architecture.

MongoDB uses a flexible schema, allowing each product to be stored as a JSON-like document with only relevant attributes. Different product types can have different structures without requiring schema changes.

{
  "name": "Dell Inspiron",
  "category": "Laptop",
  "ram": "16GB",
  "processor": "Intel i7"
}

{
  "name": "Nike Air Max",
  "category": "Shoes",
  "size": 9,
  "color": "Black"
}


MongoDB supports embedded documents, enabling customer reviews to be stored directly inside the product document. This eliminates complex JOIN operations and improves read performance.

{
  "name": "Dell Inspiron",
  "reviews": [
    { "user": "Asha", "rating": 5, "comment": "Excellent performance" },
    { "user": "Rahul", "rating": 4, "comment": "Good value for money" }
  ]
}


MongoDB also supports horizontal scalability through sharding, allowing data to be distributed across multiple servers and enabling efficient handling of large and growing product catalogs.

## **Section C: Trade-offs of Using MongoDB**
- MongoDB has some disadvantages when compared to relational databases like MySQL.
- MongoDB provides weaker support for complex transactions.
- Although MongoDB supports multi-document transactions, they are harder to implement and may not perform as efficiently as traditional ACID transactions in MySQL.
- MongoDB can cause data duplication due to the use of embedded documents.
- For example, storing seller or category details inside multiple product documents requires updating many records when changes occur.
- This increases application-level complexity and raises the risk of data inconsistency.
- As a result, MongoDB trades strict structure and strong consistency for greater flexibility and scalability.
