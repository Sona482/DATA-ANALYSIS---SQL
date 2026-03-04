-- CLEANING ORDER TABLE
UPDATE orders
SET order_status=UPPER(order_status);
-- Set total_amount = NULL for CANCELLED orders
UPDATE Orders
SET total_amount = NULL
WHERE order_status = 'CANCELLED';
-- Set total_amount = NULL for PENDING orders
UPDATE Orders
SET total_amount = NULL
WHERE order_status = 'PENDING';
-- FK issue handling (if any found) 
DELETE FROM orders
WHERE customer_id NOT IN (
    SELECT customer_id FROM Customers
);
-- Safety enforcement 
UPDATE Orders
SET order_status = 'UNKNOWN'
WHERE order_status NOT IN ('COMPLETED','PENDING','SHIPPED','CANCELLED');

SET SQL_SAFE_UPDATES=0;
UPDATE Orders
SET total_amount = null
WHERE order_status ='PENDING';

UPDATE orders
JOIN order_items
ON orders.order_id = order_items.order_id
SET orders.total_amount = quantity * item_price
WHERE orders.order_status = 'COMPLETED';

UPDATE orders
JOIN order_items
ON orders.order_id = order_items.order_id
SET orders.total_amount = quantity * item_price
WHERE orders.order_status = 'shipped';

UPDATE orders
JOIN order_items
ON orders.order_id = order_items.order_id
SET orders.total_amount = quantity * item_price
WHERE orders.order_status = 'PENDING';
