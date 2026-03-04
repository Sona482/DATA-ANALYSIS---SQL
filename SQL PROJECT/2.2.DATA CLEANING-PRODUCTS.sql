-- data cleaning through product table .

SET SQL_SAFE_UPDATES=0;
-- CLEANING AND CORRECTING CATEGORY INCONSISTENCIES IN TEXT
UPDATE Products
SET category = CASE
    WHEN LOWER(category) = 'electronics' THEN 'Electronics'
    WHEN LOWER(category) = 'accessories' THEN 'Accessories'
    WHEN LOWER(category) = 'footwear' THEN 'Footwear'
    WHEN LOWER(category) = 'clothing' THEN 'Clothing'
    WHEN LOWER(category) = 'home appliances' THEN 'Home Appliances'
    WHEN LOWER(category) = 'stationery' THEN 'Stationery'
    WHEN LOWER(category) = 'furniture' THEN 'Furniture'
    WHEN LOWER(category) = 'personal care' THEN 'Personal Care'
    ELSE category
END;
    select*from products;
-- DEACTIVATE PRODUCT INVALID PRICES.
UPDATE products
SET is_active=0
WHERE price<=0;
-- update null category  as unknown
UPDATE products
SET category="unknown"
WHERE category IS NULL;
