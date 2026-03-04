-- BUSINESS QUESTIONS ANSWERS 
-- 1. Which products generate most revenue?   
SELECT products.product_name,
       SUM(order_items.quantity*order_items.item_price) as revenue
FROM products
JOIN order_items
ON products.product_id=order_items.product_id
JOIN orders
ON order_items.order_id=orders.order_id
WHERE orders.order_status IN ("COMPLETED","SHIPPED")
GROUP BY products.product_name 
ORDER BY revenue DESC;

-- 2. Which categories generate most revenue?
SELECT products.category,
       SUM(order_items.quantity*order_items.item_price) as revenue
FROM products
JOIN order_items
ON products.product_id=order_items.product_id
JOIN orders
ON order_items.order_id=orders.order_id
WHERE orders.order_status IN ("COMPLETED","SHIPPED")
GROUP BY products.category 
ORDER BY revenue DESC;

-- 3. Which customers bring most revenue?
SELECT customers.customer_name,
       SUM(orders.total_amount) AS revenue
FROM customers
JOIN orders
ON customers.customer_id=orders.customer_id
WHERE orders.order_status IN ("COMPLETED","SHIPPED")
GROUP BY customers.customer_name
ORDER BY revenue DESC;

-- 4. Which cities give highest sales?
SELECT customers.city,
	   SUM(orders.total_amount) AS revenue
FROM customers
JOIN orders
ON customers.customer_id=orders.customer_id
WHERE orders.order_status IN ("COMPLETED","SHIPPED")
GROUP BY customers.city
ORDER BY revenue DESC;

-- 5.Which payment method is most reliable?
SELECT payment_method,
       SUM(payment_status='PAID') * 100 / COUNT(*) AS success_rate
FROM payments
GROUP BY payment_method
ORDER BY success_rate DESC;

-- 6.Which products should be discontinued? (low sales)
SELECT products.product_name,
       SUM(order_items.quantity) AS qty
FROM products
LEFT JOIN order_items
ON products.product_id = order_items.product_id
GROUP BY products.product_name
ORDER BY qty ASC;

-- 7. HOW MANY CUSTOMERS ARE REPEAT CUSTOMERS 
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 8.Which customers stopped ordering in last 3 months? (churn detection)
SELECT customer_id,
       MAX(order_date) AS last_order_date
FROM orders
GROUP BY customer_id
HAVING MAX(order_date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 9.What is average money spent per order(AOV)?
SELECT AVG(total_amount) AS avg_order_value
FROM orders
WHERE order_status IN ('COMPLETED','SHIPPED');

-- 10.Payment Failure Rate
SELECT 
    SUM(CASE WHEN payment_status = 'FAILED' THEN 1 ELSE 0 END) * 100.0 
    / COUNT(*) AS failure_percentage
FROM payments;




















