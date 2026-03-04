-- second integrity check 
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM orders;
-- SUM OF TOTAL AMOUNT IN ORDERS WITH STATUS COMPLETED OR SHIPPED SHOULD BE EQUAL TO SUM OF TOTAL PAID AMOUNT 
SELECT
    (SELECT SUM(total_amount)
     FROM orders
     WHERE order_status IN ('COMPLETED','SHIPPED')) AS orders_total,

    (SELECT SUM(paid_amount)
     FROM payments
     WHERE payment_status = 'PAID') AS payments_total;

UPDATE payments
JOIN orders
ON payments.order_id=orders.order_id
SET payments.payment_status="PAID"
WHERE orders.order_status="SHIPPED";

UPDATE payments
JOIN orders
ON payments.order_id=orders.order_id
SET payments.payment_status="PAID"
WHERE orders.order_status="COMPLETED";

UPDATE payments
JOIN orders
ON payments.order_id=orders.order_id
SET payments.payment_status="FAILED"
WHERE orders.order_status="CANCELLED";

UPDATE payments
JOIN orders
ON payments.order_id=orders.order_id
SET payments.payment_status="FAILED"
WHERE orders.order_status="PENDING";

UPDATE payments
SET paid_amount = 0
WHERE payment_status = 'FAILED';

SELECT*
FROM payments
JOIN orders
ON payments.order_id=orders.order_id
WHERE orders.order_status="PENDING";

UPDATE payments
JOIN orders
ON payments.order_id = orders.order_id
SET payments.paid_amount = orders.total_amount
WHERE payments.payment_status = 'PAID'
AND orders.order_status IN ('COMPLETED','SHIPPED');


