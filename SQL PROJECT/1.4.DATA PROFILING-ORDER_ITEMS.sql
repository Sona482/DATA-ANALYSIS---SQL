-- profiling through order_item table 

SELECT*
FROM order_items;
SELECT COUNT(*) AS total
FROM order_items;
-- Quantity check
SELECT *
FROM order_items
WHERE quantity<=0;
-- Item price check
SELECT *
FROM order_items
WHERE item_price<=0;
-- Duplicate order–product rows
SELECT order_id ,product_id,COUNT(*)
FROM order_items
GROUP BY order_id ,product_id
HAVING COUNT(*)>1;
-- TO CHECK NON- ORPHAN ID
SELECT COUNT(*) AS total
FROM order_items
WHERE order_id IN (SELECT order_id FROM orders)
AND product_id IN (SELECT product_id FROM products);
-- TO CHECK ORPHAN ID
SELECT order_items.*
FROM order_items
LEFT JOIN orders
ON order_items.order_id = orders.order_id
WHERE orders.order_id IS NULL;

SELECT order_items.*
FROM order_items
LEFT JOIN products
ON order_items.product_id = products.product_id
WHERE products.product_id IS NULL;

-- item_price should match Products_price at order time NOTE WE WILL NOT TAKE IT IN CONSIDERATION 
-- AS WE HAVE DEACTIVATED THE PRODUCT WITH INVALID PRICES.
SELECT *
FROM order_items AS o
INNER JOIN products AS p
ON o.product_id=p.product_id
WHERE item_price != price;


