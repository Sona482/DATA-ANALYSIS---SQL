-- fifth integrity check.
-- CALCULATE TOTAL AMOUNT OF ORDER STATUS CANCELLED WHICH WILL SHOW REVENUE LOSS OF BUSINESS.
SELECT 
    COUNT(*) AS cancelled_orders,
    SUM(total_amount) AS revenue_lost
FROM orders
WHERE order_status = 'CANCELLED';

SELECT orders.order_id,orders.order_status,orders.total_amount,
	   order_items.quantity,order_items.item_price,
       payments.payment_method,payments.payment_status,payments.paid_amount
FROM orders
INNER JOIN order_items
ON orders.order_id=order_items.order_id
INNER JOIN payments
ON orders.order_id=payments.order_id
WHERE order_status="CANCELLED";

SET SQL_SAFE_UPDATES=0;

UPDATE orders
INNER JOIN order_items
ON orders.order_id=order_items.order_id
INNER JOIN payments
ON orders.order_id=payments.order_id
SET total_amount=(order_items.quantity*order_items.item_price);







    