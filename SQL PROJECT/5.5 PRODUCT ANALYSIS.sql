-- product analysis 
-- Total Products
SELECT COUNT(*) AS total_products
FROM products;
-- Active Products
SELECT COUNT(*) AS active_products
FROM products
WHERE is_active = 1;

-- INACTIVE PRODUCTS 
SELECT COUNT(*) AS inactive_products
FROM products
WHERE is_active = 0;

-- Top Selling Products (by quantity)
SELECT product_id,
       SUM(quantity) AS total_units_sold
FROM order_items
GROUP BY product_id
ORDER BY total_units_sold DESC;
-- Top Revenue Products
SELECT order_items.product_id,
       SUM(order_items.quantity * order_items.item_price) AS revenue
FROM order_items
GROUP BY order_items.product_id
ORDER BY revenue DESC;
-- Low Performing Products (lowest revenue)
SELECT order_items.product_id,
       SUM(order_items.quantity * order_items.item_price) AS revenue
FROM order_items
GROUP BY order_items.product_id
ORDER BY revenue ASC;

-- Category-wise Revenue
SELECT products.category,
       SUM(order_items.quantity * order_items.item_price) AS revenue
FROM order_items
JOIN products
ON order_items.product_id = products.product_id
GROUP BY products.category;

-- Category-wise Quantity
SELECT products.category,
       SUM(order_items.quantity) AS total_quantity
FROM order_items
JOIN products
ON order_items.product_id = products.product_id
GROUP BY products.category;
-- Avg Price per Category
SELECT category,
       AVG(price) AS avg_price
FROM products
GROUP BY category;
-- Products Never Sold
SELECT products.product_id,
       products.product_name
FROM products
LEFT JOIN order_items
ON products.product_id = order_items.product_id
WHERE order_items.product_id IS NULL;




