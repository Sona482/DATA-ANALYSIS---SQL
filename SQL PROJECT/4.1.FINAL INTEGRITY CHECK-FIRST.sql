-- 1.first integrity check
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

SELECT o.order_id, o.total_amount AS order_total,
       SUM(oi.quantity * oi.item_price) AS calculated_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount <> SUM(oi.quantity * oi.item_price);

-- check wether sum of total_amount in order table is equal to
-- sum of product of item_price and quantity , but the order_item id should found in order table is must.
SELECT 
    (SELECT SUM(total_amount) 
     FROM orders 
     WHERE order_status IN ('COMPLETED','SHIPPED')) AS total_order_amount,
     
    (SELECT SUM(oi.quantity * oi.item_price) 
     FROM order_items oi
     INNER JOIN orders o ON oi.order_id = o.order_id
     WHERE o.order_status IN ('COMPLETED','SHIPPED')) AS total_items_amount;

