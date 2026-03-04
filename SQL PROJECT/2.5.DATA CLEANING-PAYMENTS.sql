-- cleaning payment table 
SET SQL_SAFE_UPDATES=0;
-- DELETE order_id NOT PRESENT in ORDER AND PRESENT IN PAYMENTS table.
DELETE FROM payments
WHERE order_id NOT IN (SELECT order_id FROM orders);
-- check for invalid paid ammount AND SET THEM 0
UPDATE Payments
SET paid_amount = 0
WHERE paid_amount IS NULL OR paid_amount < 0;
-- UPDATE PAYMENT STATUS
UPDATE Payments
SET payment_status = UPPER(payment_status)
WHERE payment_status IS NOT NULL;
UPDATE Payments
SET payment_status = 'PAID'
WHERE payment_status IN ('PAIED', 'paid');
UPDATE Payments
SET payment_status = 'PENDING'
WHERE payment_status IN ('PENDNG', 'Pending');
UPDATE Payments
SET payment_status = 'FAILED'
WHERE payment_status IN ('Failed', 'failed');

-- UPADTE PAYMENT METHOD
UPDATE Payments
SET payment_method = CONCAT(UCASE(LEFT(payment_method,1)), LCASE(SUBSTRING(payment_method,2)));
