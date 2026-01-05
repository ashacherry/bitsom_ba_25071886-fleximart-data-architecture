# FlexiMart Data Architecture Project

**Student Name:** Asha Cherian
**Student ID:** bitsom_ba_25071886
**Email:** ashacherry@gmail.com
**Date:** 27-Dec-2025

## Project Overview

I designed and implemented an end-to-end FlexiMart data architecture that ingests raw CSV data, performs robust data cleaning and transformations, and loads it into a MySQL star-schema warehouse using a Python-based ETL pipeline. I also built a MongoDB product catalog to handle flexible product attributes and embedded reviews, and version-controlled the entire solution on GitHub with clear documentation and reproducible scripts.

## Repository Structure
```
├── part1-database-etl/
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   └── data_quality_report.txt
├── part2-nosql/
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
├── part3-datawarehouse/
│   ├── star_schema_design.md
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   └── analytics_queries.sql
└── README.md
```


## Technologies Used

- Python 3.x, pandas, mysql-connector-python
- MySQL 8.0 
- MongoDB 2.5.10

## Setup Instructions

### Database Setup

```bash
# Create databases (if does not exist already in your MySQL)
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# create tables (if not already created)
#go to MySQL and run the following:
#-- Database: fleximart_dw
use fleximart;

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_of_week VARCHAR(10),
    day_of_month INT,
    month INT,
    month_name VARCHAR(10),
    quarter VARCHAR(2),
    year INT,
    is_weekend BOOLEAN
);

CREATE TABLE dim_product (
    product_key INT PRIMARY KEY AUTO_INCREMENT,
    product_id VARCHAR(20),
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE dim_customer (
    customer_key INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_segment VARCHAR(20)
);

CREATE TABLE fact_sales (
    sale_key INT PRIMARY KEY AUTO_INCREMENT,
    date_key INT NOT NULL,
    product_key INT NOT NULL,
    customer_key INT NOT NULL,
    quantity_sold INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key)
);



# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
# > Note: If you run as is, MySQL commands prompt for a password (`-p`).  
# > Please Use your local MySQL credentials when executing the scripts.
# If using bash
mysql -u root -p fleximart < part1-database-etl/business_queries.sql 
# if using Powershell
mysql -u root -p fleximart -e "source part1-database-etl/business_queries.sql"


# Run Part 3 - Data Warehouse
# > Note: If you run as is, MySQL commands prompt for a password (`-p`).  
# > Please Use your local MySQL credentials when executing the scripts.

mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql


### MongoDB Setup

mongosh < part2-nosql/mongodb_operations.js

## Key Learnings
1. From the part 1 
- I learnt the process of transformation and little bit of pythom programming.
- I learnt, how to handle missing values depending on the situation - whether to fill with 0/mean/median.
- On the whole, I understood how the entire ETL process works
2. From part 2
- how a JSON file is structured and unstructured 
- how NoSQl process these information
3. From part 3
- Learned how to design a star schema by separating transactional data into fact tables and descriptive data into dimension tables.
- Understood the importance of defining the correct grain at the transaction line-item level for accurate analysis.
- Learned why surrogate keys are used in data warehouses to improve performance and handle changes in source systems.
- Gained clarity on how dimensions enable drill-down and roll-up analysis across date, product, and customer attributes.
- Understood how data warehouse design differs from operational databases, focusing on analytics rather than transactions. 

## Challenges Faced

Part 1: Database & ETL Pipeline

1. Challenge: This was my first experience building an end-to-end ETL pipeline, and initially it was difficult to understand how raw data, transformation logic, and database loading fit together as a single flow.
Solution: Broke the pipeline into clear Extract, Transform, and Load stages and implemented them step by step, which helped in understanding data movement and dependencies.

2. Challenge: Debugging the pipeline was challenging because the script often ran without visible terminal output, making it hard to know whether each step executed successfully.
Solution: Added structured logging to record key pipeline stages and errors, which made it easier to track execution progress and identify failures.

Part 2: NoSQL (MongoDB)

1.Challenge: As this was my first exposure to a NoSQL database, it was initially difficult to understand how document-based data modeling differs from relational table design.
Solution: Studied MongoDB’s document structure and implemented embedded documents for product reviews, which clarified how NoSQL supports flexible schemas.

2. Challenge: Executing MongoDB scripts varied across environments, especially when using PowerShell instead of Bash, leading to command execution errors.
Solution: Learned the correct PowerShell-compatible commands and updated documentation to include environment-specific execution instructions.

Part 3: Data Warehouse & Star Schema

Challenge: Ensuring stable joins and consistent analytics while source system identifiers could change over time.
Solution: Used surrogate keys in dimension tables to decouple analytical relationships from operational identifiers and improve query performance.