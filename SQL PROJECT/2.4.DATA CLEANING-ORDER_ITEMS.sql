-- cleaning order_item table 
SET SQL_SAFE_UPDATES=0;
-- invalid numeric values
DELETE
FROM Order_Items
WHERE quantity <= 0
   OR item_price <= 0;
-- DELETE ORPHAN ID 
DELETE order_items
FROM order_items
LEFT JOIN orders
ON order_items.order_id = orders.order_id
WHERE orders.order_id IS NULL;

DELETE order_items
FROM order_items
LEFT JOIN products
ON order_items.product_id = products.product_id
WHERE products.product_id IS NULL;

DELETE
FROM order_items
WHERE order_id NOT IN (
    SELECT order_id FROM orders
);
DELETE
FROM order_items
WHERE product_id NOT IN (
    SELECT product_id FROM products
);







