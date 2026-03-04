-- REVENUE ANALYSIS.
SELECT 
SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED'); -- '1442929.00'
-- Orders contributing to revenue
SELECT 
COUNT(*) AS revenue_orders
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED'); -- 54

-- Average Order Value (AOV)
SELECT 
SUM(total_amount)/COUNT(*) AS avg_order_value
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED');

-- Monthly revenue trend
SELECT 
DATE_FORMAT(order_date,'%Y-%m') AS month,
SUM(total_amount) AS revenue
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED')
GROUP BY month
ORDER BY month;
