-- order analysis 
USE shoply;
-- 1. Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Completed Orders count
SELECT COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'COMPLETED';

-- 3. Pending Orders count
SELECT COUNT(*) AS pending_orders
FROM orders
WHERE order_status = 'PENDING';

-- 4. Cancelled Orders count
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'CANCELLED';

-- 5. Shipped Orders count
SELECT COUNT(*) AS shipped_orders
FROM orders
WHERE order_status = 'SHIPPED';

-- 6. Order Success Rate (%)
SELECT 
SUM(order_status IN ('COMPLETED','SHIPPED')) * 100 / COUNT(*) AS success_rate
FROM orders;

-- 7. Cancellation Rate (%)
SELECT 
SUM(order_status = 'CANCELLED') * 100 / COUNT(*) AS cancellation_rate
FROM orders;

-- 8. Pending Rate (%)
SELECT 
SUM(order_status = 'PENDING') * 100 / COUNT(*) AS pending_rate
FROM orders;

-- 9. Orders per Day
SELECT order_date,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- 10. Orders per Month
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date,'%Y-%m')
ORDER BY month;

-- 11. Revenue lost due to cancellations
SELECT SUM(total_amount) AS revenue_lost
FROM orders
WHERE order_status = 'CANCELLED';

-- 12. Average Order Value (AOV)
SELECT AVG(total_amount) AS avg_order_value
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED');
