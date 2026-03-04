-- profiling through payment table 

SELECT COUNT(*)
FROM payments;
SELECT*
FROM payments;
-- order_id in payment must be present in orders table
SELECT order_id
FROM payments
WHERE order_id NOT IN (SELECT order_id FROM orders);
-- check for invalid paid ammount
SELECT *
FROM payments
WHERE paid_amount<=0 OR NULL;
-- CHECK FOR TEXT INCONSISTENCIES IN PANYMENT STATUS 
SELECT payment_status
FROM payments;
-- check for distant payment status in table 
SELECT DISTINCT payment_status
FROM payments;
-- CHECK FOR TEXT INCONSISTENCIES IN PANYMENT METHOD
SELECT DISTINCT payment_method
FROM payments;
-- CHECK FOR MISSING PAYMENT_DATE
SELECT*
FROM payments
WHERE payment_date IS NULL;
-- FIND OUT DUPLICATE PAYMENT RECORD
SELECT order_id,payment_date,payment_method,COUNT(*)
FROM payments 
GROUP BY order_id,payment_date,payment_method 
HAVING COUNT(*)>1;
-- CHECK FOR FUTURE DATE IF ANY.
SELECT *
FROM Payments
WHERE payment_date > current_date();



