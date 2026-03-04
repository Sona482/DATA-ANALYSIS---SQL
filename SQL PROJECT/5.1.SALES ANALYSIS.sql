-- sales analysis
-- TOTAL REVENUE
SELECT SUM(total_amount) AS TOTAL_REVENUE
FROM orders
WHERE order_status IN ("COMPLETED","SHIPPED"); -- --> '1442929.00'

-- total orders 
SELECT COUNT(*) AS total_orders
FROM orders
WHERE order_status IN ("COMPLETED","SHIPPED"); -- --> 54

-- AOV (AVERAGE ORDER VALUE)
SELECT AVG(total_amount)
FROM orders
WHERE order_status IN ("COMPLETED","SHIPPED"); -- ----> '26720.907407'

-- Monthly Sales Trend
SELECT
    DATE_FORMAT(order_date,'%Y-%m') AS month,
    SUM(total_amount) AS revenue
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED')
GROUP BY month
ORDER BY month;

-- TOP REVENUE DAYS 
SELECT day(order_date) as DAY_DATE,
SUM(total_amount) AS total_daily_sales
FROM orders;

-- Top Revenue Days
SELECT
    order_date,
    SUM(total_amount) AS revenue
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED')
GROUP BY order_date
ORDER BY revenue DESC;








