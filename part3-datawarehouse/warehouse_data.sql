USE fleximart_dw;
-- =====================================================
-- 1. DIM_DATE (30 rows: Jan–Feb 2024, weekdays + weekends)
-- =====================================================

INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,FALSE),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,FALSE),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,FALSE),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,FALSE),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,TRUE),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,TRUE),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,FALSE),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,TRUE),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,TRUE),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,FALSE),
(20240118,'2024-01-18','Thursday',18,1,'January','Q1',2024,FALSE),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,TRUE),
(20240121,'2024-01-21','Sunday',21,1,'January','Q1',2024,TRUE),
(20240125,'2024-01-25','Thursday',25,1,'January','Q1',2024,FALSE),
(20240127,'2024-01-27','Saturday',27,1,'January','Q1',2024,TRUE),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,FALSE),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,FALSE),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,TRUE),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,TRUE),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,FALSE),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,FALSE),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,TRUE),
(20240211,'2024-02-11','Sunday',11,2,'February','Q1',2024,TRUE),
(20240214,'2024-02-14','Wednesday',14,2,'February','Q1',2024,FALSE),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,FALSE),
(20240217,'2024-02-17','Saturday',17,2,'February','Q1',2024,TRUE),
(20240218,'2024-02-18','Sunday',18,2,'February','Q1',2024,TRUE),
(20240220,'2024-02-20','Tuesday',20,2,'February','Q1',2024,FALSE),
(20240225,'2024-02-25','Sunday',25,2,'February','Q1',2024,TRUE);

-- =====================================================
-- 2. DIM_PRODUCT (15 products, 3 categories)
-- =====================================================

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop','Electronics','Computers',55000),
('P002','Smartphone','Electronics','Mobiles',32000),
('P003','Tablet','Electronics','Devices',22000),
('P004','Headphones','Electronics','Accessories',2500),
('P005','Smartwatch','Electronics','Wearables',12000),

('P006','T-Shirt','Clothing','Men',800),
('P007','Jeans','Clothing','Men',2200),
('P008','Dress','Clothing','Women',3500),
('P009','Jacket','Clothing','Outerwear',6000),
('P010','Shoes','Clothing','Footwear',4500),

('P011','Sofa','Home','Furniture',40000),
('P012','Dining Table','Home','Furniture',30000),
('P013','Mixer Grinder','Home','Appliances',6000),
('P014','Microwave','Home','Appliances',18000),
('P015','Bedsheet','Home','Furnishing',1200);

-- =====================================================
-- 3. DIM_CUSTOMER (12 customers, 4 cities)
-- =====================================================

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','John Doe','Mumbai','Maharashtra','Retail'),
('C002','Anita Sharma','Delhi','Delhi','Retail'),
('C003','Rahul Verma','Bengaluru','Karnataka','Corporate'),
('C004','Priya Iyer','Chennai','Tamil Nadu','Retail'),
('C005','Amit Patel','Ahmedabad','Gujarat','Retail'),
('C006','Neha Gupta','Delhi','Delhi','Corporate'),
('C007','Suresh Rao','Bengaluru','Karnataka','Retail'),
('C008','Meena Nair','Kochi','Kerala','Retail'),
('C009','Vikram Singh','Jaipur','Rajasthan','Retail'),
('C010','Pooja Mehta','Mumbai','Maharashtra','Corporate'),
('C011','Arjun Malhotra','Delhi','Delhi','Retail'),
('C012','Kavita Kulkarni','Pune','Maharashtra','Retail');

-- =====================================================
-- 4. FACT_SALES (40 transactions, realistic patterns)
-- =====================================================

INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
-- Weekdays
(20240102,1,1,1,55000,0,55000),
(20240103,6,2,2,800,0,1600),
(20240104,7,3,1,2200,0,2200),
(20240105,13,4,1,6000,500,5500),

-- Weekends (higher volume)
(20240106,2,5,2,32000,2000,62000),
(20240106,4,6,3,2500,0,7500),
(20240107,10,7,2,4500,500,8500),

(20240110,6,7,2,800,0,1600),
(20240113,1,8,1,55000,3000,52000),
(20240114,11,9,1,40000,2000,38000),

(20240114,14,8,1,18000,2000,16000),
(20240115,3,10,2,22000,0,44000),
(20240118,8,11,1,3500,0,3500),

(20240118,2,4,1,32000,1000,31000),
(20240120,5,12,2,12000,1000,23000),
(20240121,12,1,1,30000,0,30000),

(20240121,6,5,3,800,0,2400),
(20240125,9,2,1,6000,0,6000),
(20240127,14,3,1,18000,2000,16000),

(20240201,15,4,3,1200,0,3600),
(20240202,6,5,2,800,0,1600),
(20240203,2,6,1,32000,2000,30000),

(20240203,1,7,1,55000,0,55000),
(20240204,10,8,2,4500,500,8500),
(20240204,2,9,1,32000,2000,30000),

(20240205,7,9,1,2200,0,2200),
(20240208,4,10,3,2500,0,7500),
(20240210,11,11,1,40000,3000,37000),

(20240210,9,6,1,6000,500,5500),
(20240211,3,12,2,22000,2000,42000),
(20240211,10,10,2,4500,500,8500),

(20240214,8,1,1,3500,0,3500),
(20240215,5,2,1,12000,0,12000),
(20240217,12,3,1,30000,2000,28000),

(20240217,11,11,1,40000,3000,37000),
(20240218,9,4,2,6000,0,12000),
(20240218,15,7,2,1200,0,2400),

(20240220,13,5,1,6000,500,5500),
(20240225,1,6,1,55000,3000,52000),
(20240225,3,12,2,22000,0,44000);


 commit;
 
 SELECT COUNT(*) FROM dim_date;      -- 30
SELECT COUNT(*) FROM dim_product;   -- 15
SELECT COUNT(*) FROM dim_customer;  -- 12
SELECT COUNT(*) FROM fact_sales;    -- 40
