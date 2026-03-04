-- Customer Analysis
-- TOTAL CUSTOMERS
SELECT COUNT(*) AS total_customers
FROM customers;
-- Active Customers (who placed ≥1 order)
SELECT COUNT(DISTINCT customer_id) AS active_customers
FROM orders;
-- New Customers per Month
SELECT DATE_FORMAT(signup_date,'%Y-%m') AS month,
       COUNT(*) AS new_customers
FROM customers
GROUP BY DATE_FORMAT(signup_date,'%Y-%m')
ORDER BY month;
-- Repeat Customers count (more than 1 order)
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) t;
-- Repeat Purchase Rate
SELECT 
(
    SELECT COUNT(DISTINCT customer_id)
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) /
COUNT(DISTINCT customer_id) * 100 AS repeat_rate
FROM orders;
-- Orders per Customer
SELECT customer_id,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;
-- Top Customers by Revenue
SELECT customer_id,
       SUM(total_amount) AS revenue
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED')
GROUP BY customer_id
ORDER BY revenue DESC;
-- Customer Lifetime Value (CLV)
SELECT customer_id,
       SUM(total_amount) AS clv
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED')
GROUP BY customer_id;
-- CITY WISE CUSTOMERS 
SELECT city,
       COUNT(*) AS customers
FROM customers
GROUP BY city;
-- CITYWISE REVENUE
SELECT customers.city,
       SUM(orders.total_amount) AS revenue
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.order_status IN ('COMPLETED','SHIPPED')
GROUP BY customers.city;
