-- third integrity check 
-- REVENUE LEAKAGE CHECK.
-- CHECK WETHER IS THERE ANY ORDER WHERE THE PAYMENTT IS NOT FULLY PAID

SELECT 
    orders.order_id,
    orders.total_amount,
    IFNULL(SUM(payments.paid_amount),0) AS total_paid,
    orders.total_amount - IFNULL(SUM(payments.paid_amount),0) AS missing_amount
FROM orders
LEFT JOIN payments
ON orders.order_id = payments.order_id
AND payments.payment_status = 'PAID'
WHERE orders.order_status IN ('COMPLETED','SHIPPED')
GROUP BY orders.order_id, orders.total_amount
HAVING total_paid < orders.total_amount;
