USE shoply;
-- 1.PROFILING CUSTOMER TABLE
SELECT*FROM customers;
SELECT COUNT(*) -- -----------> TOTAL COUNT OF RECORDS
FROM customers;
-- CHECK FOR NULLS IN CITIES ----->CHECK NULLS
SELECT customer_id, city
FROM customers
WHERE city IS NULL;
-- CHECK IF THERE ANY ID HAVING DUPLICATE EMAILS FOUNDS. ------->CHECK DUPLICATES
SELECT customer_id,email,COUNT(email)
FROM customers
GROUP BY customer_id
HAVING COUNT(email)>1;
-- CHECK IF THERE ANY DUPLICATE RECORD FOUNDS FOR ANY CUSTOMER_ID
SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*)>1;
-- CHECKING FOR INCONSISTENT DATA----------> CHECK INCONSISTENCY
SELECT DISTINCT city FROM customers;
-- check if emails following the emails standard pattern
SELECT customer_id, email
FROM customers
WHERE email LIKE "%@%.%" OR "%@%.__.%";
-- Check for negative or zero IDs
SELECT * 
FROM Customers
WHERE customer_id <= 0;
