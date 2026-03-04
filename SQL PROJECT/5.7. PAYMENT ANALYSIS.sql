-- payment analysis
USE shoply;

-- 1. Total Payments
SELECT COUNT(*) AS total_payments
FROM payments;


-- 2. Total Paid Amount (only successful payments)
SELECT SUM(paid_amount) AS total_paid_amount
FROM payments
WHERE payment_status = 'PAID';


-- 3. Paid vs Pending vs Failed count
SELECT payment_status,
       COUNT(*) AS total_count
FROM payments
GROUP BY payment_status;


-- 4. Payment Success Rate (%)
SELECT 
SUM(payment_status = 'PAID') * 100 / COUNT(*) AS success_rate
FROM payments;


-- 5. Payment Failure Rate (%)
SELECT 
SUM(payment_status = 'FAILED') * 100 / COUNT(*) AS failure_rate
FROM payments;


-- 6. Payment Method Usage (%)
SELECT payment_method,
       COUNT(*) * 100 / (SELECT COUNT(*) FROM payments) AS usage_percen_*
