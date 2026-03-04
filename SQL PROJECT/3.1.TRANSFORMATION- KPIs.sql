-- transformation 
select*from customers;
-- sales kpi
-- TOTAL SALES OF COMPLETED ORDERS IN YEAR.
SELECT SUM(total_amount) AS total_sales
FROM orders
WHERE order_status="COMPLETED";
-- TOTAL SALES PER MONTH 
SELECT MONTH(order_date) AS monthly,SUM(total_amount) AS tspm
FROM orders
WHERE order_status="COMPLETED"
GROUP BY monthly;
-- AVERAGE ORDER VALUE (AOV)
SELECT AVG(total_amount) AS AOV
FROM Orders
WHERE order_status='COMPLETED';
-- PRODUCT LEVEL SALES
SELECT products.product_id,products.product_name,
       SUM(order_items.quantity * order_items.item_price) AS product_sales
FROM order_items
INNER JOIN orders
ON orders.order_id=order_items.order_id
INNER JOIN products
ON order_items.product_id=products.product_id
WHERE orders.order_status="COMPLETED"
GROUP BY products.product_id,products.product_name
ORDER BY product_sales DESC;

-- CATEGORY LEVEL SALES
SELECT products.category,SUM(order_items.quantity * order_items.item_price) AS category_sales
FROM order_items
INNER JOIN orders
ON orders.order_id=order_items.order_id
INNER JOIN products
ON order_items.product_id=products.product_id
WHERE orders.order_status="COMPLETED"
GROUP BY products.category
ORDER BY category_sales DESC;

-- customers kpi
-- COMBINE TABLES TO SHOW WHICH CUSTOMER HAS PLACED WHICH ORDER
SELECT customers.customer_id,customers.customer_name,orders.order_id,
orders.order_date,orders.order_status,orders.total_amount
FROM customers
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;
-- TOTAL COUNT OF CUSTOMER
SELECT COUNT(*) AS total_customers
FROM customers;
-- ACTIVE CUSTOMERS
SELECT COUNT(DISTINCT customer_id) AS ACTIVE_CUST
FROM customers;
-- Orders per customer
SELECT customer_id,COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;
-- REVENUE PER CUSTOMER
SELECT customer_id,SUM(total_amount) AS lifetime_value
FROM orders
WHERE order_status = 'COMPLETED'
GROUP BY customer_id;
-- Average order value per customer
SELECT customer_id,AVG(total_amount) AS avg_order_value
FROM orders
WHERE order_status = 'COMPLETED'
GROUP BY customer_id;
-- First order date (new customer identification)
SELECT customer_id,MIN(order_date) AS first_order_date
FROM orders
GROUP BY customer_id;
-- LAST ORDER DATE PER CUSTOMER 
SELECT customer_id,MAX(order_date) AS last_order_date
FROM orders
GROUP BY customer_id;
-- CUSTOMER BY CITY
SELECT city,COUNT(*) AS total_customers
FROM customers
GROUP BY city;

-- product kpi
-- TOTAL PRODUCTS
SELECT COUNT(*)
FROM products;
-- ACTIVE PRODUCTS
SELECT COUNT(*) AS active_products
FROM Products
WHERE is_active = 1;
-- INACTIVE PRODUCTS
SELECT COUNT(*) AS inactive_products
FROM Products
WHERE is_active = 0;
-- product per category
SELECT category, COUNT(*) AS product_count
FROM Products
GROUP BY category;
-- unit sold per product
SELECT product_id, SUM(quantity) AS units_sold
FROM Order_Items
GROUP BY product_id;
-- Revenue per product
SELECT product_id, SUM(quantity * item_price) AS revenue
FROM Order_Items
GROUP BY product_id;
-- Top selling products (by revenue)
SELECT product_id, SUM(quantity * item_price) AS revenue
FROM Order_Items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;
-- top selling product by quantity
SELECT product_id, SUM(quantity) AS units_sold
FROM Order_Items
GROUP BY product_id
ORDER BY units_sold DESC
LIMIT 10;
-- product never sold 
SELECT product_id
FROM Products
WHERE product_id NOT IN (
    SELECT product_id FROM Order_Items
);
-- category wise revenue
SELECT Products.category,
       SUM(Order_Items.quantity * Order_Items.item_price) AS revenue
FROM Order_Items
JOIN Products
ON Order_Items.product_id = Products.product_id
GROUP BY Products.category;

-- order kpi 
-- 1 Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2 Orders by Status
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status;

-- 3 Completed Orders
SELECT COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'COMPLETED';

-- 4 Cancelled Orders
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'CANCELLED';

-- 5 Pending Orders
SELECT COUNT(*) AS pending_orders
FROM orders
WHERE order_status = 'PENDING';

-- 6 Shipped Orders
SELECT COUNT(*) AS shipped_orders
FROM orders
WHERE order_status = 'SHIPPED';

-- 7 Completion Rate %
SELECT 
ROUND(
    SUM(order_status='COMPLETED') * 100.0 / COUNT(*),
2) AS completion_rate_percent
FROM orders;

-- 8 Cancellation Rate %
SELECT 
ROUND(
    SUM(order_status='CANCELLED') * 100.0 / COUNT(*),
2) AS cancellation_rate_percent
FROM orders;

-- 9 Average Order Value (only completed)
SELECT 
ROUND(AVG(total_amount),2) AS avg_order_value
FROM orders
WHERE order_status = 'COMPLETED';

-- 10 Orders per Day
SELECT order_date, COUNT(*) AS orders_count
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 11 Monthly Orders
SELECT 
YEAR(order_date) AS year,
MONTH(order_date) AS month,
COUNT(*) AS orders_count
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- 12 Orders with NULL amount (data issue check)
SELECT *
FROM orders
WHERE total_amount IS NULL
AND order_status = 'COMPLETED';

-- PAYMENT KPI
-- Total Payments
SELECT COUNT(*) AS total_payments
FROM payments;
-- Total Paid Amount
SELECT SUM(paid_amount) AS total_paid_amount
FROM payments
WHERE payment_status = 'PAID';
-- PENDING AMMOUNT
SELECT SUM(paid_amount) AS pending_amount
FROM payments
WHERE payment_status = 'PENDING';
-- FAILED AMMOUNT
SELECT SUM(paid_amount) AS failed_amount
FROM payments
WHERE payment_status = 'FAILED';
-- PAYMENT SUCCESS RATE
SELECT 
ROUND(SUM(payment_status='PAID') * 100.0 / COUNT(*),2) AS payment_success_rate
FROM payments;
-- PAYMENT METHOD USES
SELECT payment_method, COUNT(*) AS usage_count
FROM payments
GROUP BY payment_method;









