-- fourth integrity check 
-- CHECK IF WE HAVE SOLD INACTIVE PRODUCT HAVING INVALID PRICE.
-- IF RETURNS 0 ROWS THEN NO ERROR
SELECT 
    orders.order_id,
    order_items.product_id,
    products.product_name,
    products.is_active,
    products.price
FROM order_items
JOIN products
ON order_items.product_id = products.product_id
JOIN orders
ON order_items.order_id = orders.order_id
WHERE orders.order_status IN ('COMPLETED','SHIPPED')
AND (products.is_active = 0 OR products.price <= 0);
