-- PROFILING THROUGH ORDER TABLE
USE shoply;
SELECT*FROM orders;
-- TOTAL RECORDS
SELECT COUNT(*)
FROM orders;
-- looking for types of text inconsistencies of order_status. 
SELECT order_status
FROM orders;
-- looking for distinct order_status
SELECT DISTINCT order_status
FROM orders;
-- looking for total_ammount having null values
SELECT *
FROM orders
WHERE total_amount IS NULL;
-- Check NULL total_amount distribution
SELECT order_status,COUNT(*)
FROM orders
WHERE total_amount IS NULL
GROUP BY order_status;
-- Check zero amount orders
SELECT order_status, COUNT(*) AS zero_amount_count
FROM Orders
WHERE total_amount = 0
GROUP BY order_status;
-- FK safety check (orphan orders)
SELECT o.order_id, o.customer_id
FROM Orders o
LEFT JOIN Customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- CHECK IF THERE IS ANY SPELLING MISTAKE IN ORDER_STATUS, IF FOUNF COULD BE CORRECTED
SELECT *
FROM orders
WHERE order_status NOT IN("COMPLETED","PENDING","CANCELLED","SHIPPED");

